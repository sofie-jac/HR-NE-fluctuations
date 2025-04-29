function [summaryTable, NESummaryTable, RRSummaryTable, event_table] = ...
    compute_peak_RR_summary_from_files_w_NE(dataDirectory, chr2, yfp, sec_after, delay)
% COMPUTE_PEAK_RR_SUMMARY_FROM_FILES_W_NE
%   [summaryTable, NESummaryTable, RRSummaryTable, event_table] =
%   Loads NE_laser_<L>_NREM_<ID>.mat (fs=1017 Hz) and RR, finds RR peaks,
%   then for each trial builds:
%     • event_table: MeanNE, MeanNE_pre_10, NE_ampl, RR_peak, RR_amp
%     • summaryTable: mean±SEM of those
%     • NESummaryTable: downsampled ±20 s NE windows
%     • RRSummaryTable: ±20 s RR windows

    %% PARAMETERS
    fs_RR   = 64;
    fs_NE   = 1017;
    halfNEs = 20 * fs_NE;
    segNE   = halfNEs*2 + 1;
    ds      = 100;

    %% PREALLOCATE
    obsRows    = {};
    groups     = {'chr2','yfp'};
    % results struct for summaryTable
    for lvl = 1:5
      for g = groups
        f = g{1};
        results(lvl).(f).MeanNE        = [];
        results(lvl).(f).MeanNE_pre_10 = [];
        results(lvl).(f).NE_ampl       = [];
        results(lvl).(f).RR_peak       = [];
        results(lvl).(f).RR_amp        = [];
        results(lvl).(f).BPM_peak      = [];
      end
    end

    % buffers for windowed segments
    NESegments = cell(1,5);
    halfRRsamp = 20*fs_RR;
    rrSegLen   = halfRRsamp*2 + 1;
    rrSegments = cell(1,5);
    for lvl = 1:5
      NESegments{lvl} = zeros(0, segNE);
      rrSegments{lvl} = zeros(0, rrSegLen);
    end

    % subject lists
    allSubs   = [chr2, yfp];
    grpLabels = [repmat({'chr2'},1,numel(chr2)), repmat({'yfp'},1,numel(yfp))];

    %% MAIN LOOP
    for lvl = 1:5
      for i = 1:numel(allSubs)
        subj = allSubs{i};
        grp  = grpLabels{i};

        fn_RR = fullfile(dataDirectory, sprintf('RR_laser_%d_NREM_%s.mat', lvl, subj));
        fn_NE = fullfile(dataDirectory, sprintf('NE_laser_%d_NREM_%s.mat', lvl, subj));
        if ~(exist(fn_RR,'file') && exist(fn_NE,'file')), continue, end

        % load RR
        D      = load(fn_RR);  fnames = fieldnames(D);
        RR     = D.(fnames{1});          
        [nTrials, nRR] = size(RR);

        % load NE
        N      = load(fn_NE);  nfnames = fieldnames(N);
        NE     = N.(nfnames{1});        
        [~, nNE] = size(NE);

        % RR‐peak window
        rrCenter = ceil(nRR/2);
        midRR    = rrCenter + round(delay*fs_RR);
        winSamps = sec_after * fs_RR;

        for tr = 1:nTrials
          if midRR+winSamps-1 > nRR, continue, end

          % 1) RR_peak
          segRR = RR(tr, midRR:midRR+winSamps-1);
          [RRpk, idxLoc] = max(segRR);
          idxG  = midRR + idxLoc - 1;

          % 2) NE index
          t_rel    = (idxG - rrCenter)/fs_RR;
          neCenter = floor((nNE+1)/2);
          idxNE    = neCenter + round(t_rel*fs_NE);

          % --- compute your five metrics ---
          MeanNE        = mean(NE(tr,:));
          start10       = max(1, idxNE-10*fs_NE);
          end10         = idxNE-1;
          MeanNE_pre_10 = mean(NE(tr, start10:end10));

          if idxNE>=1 && idxNE<=nNE
            a5      = max(1, idxNE-10*fs_NE);
            a10     = idxNE-5*fs_NE;
            NE_ampl = NE(tr, idxNE) - min(NE(tr, a5:a10));
          else
            NE_ampl = NaN;
          end

          RR_peak = RRpk;
          r8       = max(1, idxG-10*fs_RR);
          r10      = idxG-8*fs_RR;
          RR_amp   = RRpk - mean(RR(tr, r8:r10));

          BPM_peak = 60 / RR_peak;

          % store for summaryTable
          r = results(lvl).(grp);
          r.MeanNE        (end+1,1) = MeanNE;
          r.MeanNE_pre_10 (end+1,1) = MeanNE_pre_10;
          r.NE_ampl       (end+1,1) = NE_ampl;
          r.RR_peak       (end+1,1) = RR_peak;
          r.RR_amp        (end+1,1) = RR_amp;
          r.BPM_peak        (end+1,1) = BPM_peak;
          results(lvl).(grp)       = r;

          % --- RE‑ADD the NE window extraction here ---
          startNE = idxNE - halfNEs;
          endNE   = idxNE + halfNEs;
          if startNE>=1 && endNE<=nNE
            segNEraw = NE(tr, startNE:endNE);
            NESegments{lvl}(end+1,:) = segNEraw;
          end

          % RR window extraction (unchanged)
          startRR = idxG - halfRRsamp;
          endRR   = idxG + halfRRsamp;
          if startRR>=1 && endRR<=nRR
            segRRraw = RR(tr, startRR:endRR);
            rrSegments{lvl}(end+1,:) = segRRraw;
          end

          % collect event row
          obsRows(end+1,:) = { ...
            subj, lvl, ...
            MeanNE, MeanNE_pre_10, NE_ampl, ...
            RR_peak, RR_amp, BPM_peak };
        end
      end
    end

    %% BUILD event_table
    event_table = cell2table(obsRows, ...
      'VariableNames',{'SubjectID','LaserLevel', ...
                       'MeanNE','MeanNE_pre_10','NE_ampl', ...
                       'RR_peak','RR_ampl', 'BPM_peak'});

    %% BUILD summaryTable (mean±SEM of the 5 metrics)
    vars = { ...
      'LaserLevel','Group', ...
      'MeanNE','SEMNE', ...
      'MeanNE_pre_10','SEMNE_pre_10', ...
      'MeanNE_ampl','SEMNE_ampl', ...
      'MeanRR_peak','SEMRR_peak', ...
      'MeanRR_amp','SEMRR_amp', ...
      'DataCount'};
    summaryData = cell(0, numel(vars));
    for lvl = 1:5
      for g = 1:numel(groups)
        grpName = groups{g};
        v       = results(lvl).(grpName);
        X1 = v.MeanNE;        X2 = v.MeanNE_pre_10;
        X3 = v.NE_ampl;       X4 = v.RR_peak;
        X5 = v.RR_amp;        n = numel(X1);

        if n==0
          vals = num2cell(nan(1,10)); cnt = 0;
        else
          vals = { ...
            mean(X1), std(X1)/sqrt(n), ...
            mean(X2), std(X2)/sqrt(n), ...
            mean(X3), std(X3)/sqrt(n), ...
            mean(X4), std(X4)/sqrt(n), ...
            mean(X5), std(X5)/sqrt(n) };
          cnt = n;
        end

        summaryData(end+1,:) = [{lvl,grpName}, vals, cnt];
      end
    end
    summaryTable = cell2table(summaryData, 'VariableNames',vars);

    %% BUILD NESummaryTable (downsampled ±20 s NE windows)
    tFull = (-halfNEs:halfNEs).' / fs_NE;
    tDS   = tFull(1:ds:end);
    NESummaryTable = table(tDS,'VariableNames',{'Time'});
    for lvl = 1:5
      Xraw = NESegments{lvl};
      if isempty(Xraw)
        Mds = nan(numel(tDS),1);
        Sds = nan(numel(tDS),1);
      else
        Xds = Xraw(:,1:ds:end);
        Mds = mean(Xds,1).';
        Sds = std(Xds,0,1)'./sqrt(size(Xds,1));
      end
      NESummaryTable.(['MeanNE_L',num2str(lvl)]) = Mds;
      NESummaryTable.(['SEMNE_L', num2str(lvl)])  = Sds;
    end

    %% BUILD RRSummaryTable (±20 s RR windows)
    timeRR = (-halfRRsamp:halfRRsamp).' / fs_RR;
    RRSummaryTable = table(timeRR, 'VariableNames',{'Time'});
    for lvl = 1:5
      X = rrSegments{lvl};
      if isempty(X)
        mRR = nan(1,rrSegLen);
        sRR = nan(1,rrSegLen);
      else
        mRR = mean(X,1);
        sRR = std(X,0,1)./sqrt(size(X,1));
      end
      RRSummaryTable.(['MeanRR_L',num2str(lvl)])  = mRR.';
      RRSummaryTable.(['SEMRR_L', num2str(lvl)]) = sRR.';
    end

    %% PLOT Mean±SEM NE
    figure; hold on;
    cols = lines(5);
    for lvl = 1:5
      m = NESummaryTable.(['MeanNE_L',num2str(lvl)]);
      s = NESummaryTable.(['SEMNE_L', num2str(lvl)]);
      fill([tDS; flipud(tDS)], [m+s; flipud(m-s)], cols(lvl,:),'FaceAlpha',0.2,'EdgeColor','none');
      plot(tDS, m, 'Color',cols(lvl,:),'LineWidth',1.5);
    end
    xlabel('Time (s)'); ylabel('NE');
    title('Mean ± SEM NE Traces by Laser Level');
    legend({'L1','L2','L3','L4','L5'},'Location','Best');
    grid on; hold off;
end
