function [summaryTable, sigmaSummaryTable, RRSummaryTable, event_table] = ...
    compute_peak_RR_summary_from_files_w_sigma(dataDirectory, chr2, yfp, sec_after, delay)
% COMPUTE_PEAK_RR_SUMMARY_FROM_FILES_W_SIGMA (with revised ampl definitions)
% Outputs:
%   summaryTable       – per‐laser & group mean±SEM of RR_peak, sigmaAtPeak,
%                        RR_ampl (8–10 s baseline), sigma_ampl (2–3 s baseline)
%   sigmaSummaryTable  – ±10 s sigma windows ± 20 samples, mean±SEM
%   RRSummaryTable     – ±20 s RR windows, mean±SEM
%   event_table        – one row per trial with SubjectID, LaserLevel, 
%                        RR_peak, sigmaAtPeak, RR_ampl, sigma_ampl

    %% PARAMETERS
    fs_RR            = 64;        % Hz
    fs_sigma         = 2;         % Hz
    sigmaHalfSamples = fs_sigma * 10;     % 10 s window half‐length
    sigmaSegLen      = sigmaHalfSamples*2 + 1;
    halfRRsec        = 20;        % ±20 s RR window
    halfRRsamp       = halfRRsec * fs_RR;
    rrSegLen         = halfRRsamp*2 + 1;

    %% PREALLOCATE
    obsRows       = {};
    groups        = {'chr2','yfp'};
    for lvl = 1:5
      for g = 1:2
        fld = groups{g};
        results(lvl).(fld).RR_peak     = [];
        results(lvl).(fld).sigmaAtPeak = [];
        results(lvl).(fld).RR_ampl     = [];
        results(lvl).(fld).sigma_ampl  = [];
      end
    end

    sigmaSegments = cell(1,5);
    rrSegments    = cell(1,5);
    for lvl = 1:5
      sigmaSegments{lvl} = zeros(0, sigmaSegLen);
      rrSegments{lvl}    = zeros(0, rrSegLen);
    end

    allGroups   = [chr2, yfp];
    groupLabels = [repmat({'chr2'},1,numel(chr2)), repmat({'yfp'},1,numel(yfp))];

    %% MAIN LOOP
    for laserLevel = 1:5
      for i = 1:numel(allGroups)
        subj = allGroups{i};
        grp  = groupLabels{i};

        fn_RR    = fullfile(dataDirectory, sprintf('RR_laser_%d_NREM_%s.mat', laserLevel, subj));
        fn_sigma = fullfile(dataDirectory, sprintf('Sigma_laser_%d_NREM_%s.mat', laserLevel, subj));
        if ~(exist(fn_RR,'file') && exist(fn_sigma,'file')), continue, end

        %--- load RR & Sigma ---
        D      = load(fn_RR);      fn = fieldnames(D);
        RR     = D.(fn{1});        % [nTrials × nRRsamples]
        [nTrials, nRR] = size(RR);

        S      = load(fn_sigma);   fs = fieldnames(S);
        Sigma  = S.(fs{1});        % [nTrials × nSig]
        [~, nSig] = size(Sigma);

        rrCenter    = ceil(nRR/2);
        midpoint    = rrCenter + round(delay * fs_RR);
        winSamps    = sec_after * fs_RR;
        sigmaCenter = floor((nSig+1)/2);

        for tr = 1:nTrials
          if midpoint + winSamps - 1 > nRR, continue, end

          % 1) RR peak & global idx
          segRR = RR(tr, midpoint:midpoint+winSamps-1);
          [RRpk, idxLoc] = max(segRR);
          idxGlobal      = midpoint + idxLoc - 1;

          % 2) corresponding Sigma index
          t_rel    = (idxGlobal - rrCenter)/fs_RR;
          idxSigma = sigmaCenter + round(t_rel * fs_sigma);
          if idxSigma<1 || idxSigma>nSig
            sigmaAtPeak = NaN;
          else
            sigmaAtPeak = Sigma(tr, idxSigma);
          end

          % 3) NEW RR_ampl: baseline = mean RR 8–10 s pre-peak
          b1 = max(1, idxGlobal - 10*fs_RR);
          b2 = idxGlobal - 8*fs_RR;
          RR_base = mean(RR(tr, b1:b2));
          RR_ampl = RRpk - RR_base;

          % 4) NEW sigma_ampl: baseline = mean Sigma 2–3 s pre-peak
          if idxSigma>=1 && idxSigma<=nSig
            s1 = max(1, idxSigma - 3*fs_sigma);
            s2 = idxSigma - 2*fs_sigma;
            sigma_base  = mean(Sigma(tr, s1:s2));
            sigma_ampl  = sigmaAtPeak - sigma_base;
          else
            sigma_ampl = NaN;
          end

          % 5) collect ±20 s windows
          % 5a) RR
          r1 = idxGlobal - halfRRsamp;
          r2 = idxGlobal + halfRRsamp;
          if r1>=1 && r2<=nRR
            rrSegments{laserLevel}(end+1,:) = RR(tr, r1:r2);
          end
          % 5b) Sigma
          s1 = idxSigma - sigmaHalfSamples;
          s2 = idxSigma + sigmaHalfSamples;
          if s1>=1 && s2<=nSig
            sigmaSegments{laserLevel}(end+1,:) = Sigma(tr, s1:s2);
          end

          % 6) store in results struct
          r = results(laserLevel).(grp);
          r.RR_peak     (end+1,1) = RRpk;
          r.sigmaAtPeak (end+1,1) = sigmaAtPeak;
          r.RR_ampl     (end+1,1) = RR_ampl;
          r.sigma_ampl  (end+1,1) = sigma_ampl;
          results(laserLevel).(grp) = r;

          % 7) build event row
          obsRows(end+1,:) = { ...
            subj, laserLevel, ...
            RRpk, sigmaAtPeak, ...
            RR_ampl, sigma_ampl ...
          };
        end
      end
    end

    %% BUILD event_table
    event_table = cell2table(obsRows, ...
      'VariableNames',{'SubjectID','LaserLevel', ...
                       'RR_peak','Sigma_atPeak', ...
                       'RR_ampl','Sigma_ampl'});

    %% BUILD summaryTable
    vars = {'LaserLevel','Group', ...
            'MeanRR_peak','SEMRR_peak', ...
            'MeanSigma_atPeak','SEMSigma_atPeak', ...
            'MeanRR_ampl','SEMRR_ampl', ...
            'MeanSigma_ampl','SEMSigma_ampl', ...
            'DataCount'};
    summaryData = cell(0, numel(vars));
    for lvl = 1:5
      for g = 1:2
        grpName = groups{g};
        v       = results(lvl).(grpName);
        X1 = v.RR_peak;      X2 = v.sigmaAtPeak;
        X3 = v.RR_ampl;      X4 = v.sigma_ampl;
        n  = numel(X1);
        if n==0
          vals = num2cell(nan(1,8)); cnt=0;
        else
          vals = { ...
            mean(X1), std(X1)/sqrt(n), ...
            mean(X2), std(X2)/sqrt(n), ...
            mean(X3), std(X3)/sqrt(n), ...
            mean(X4), std(X4)/sqrt(n) };
          cnt = n;
        end
        summaryData(end+1,:) = [{lvl,grpName}, vals, cnt];
      end
    end
    summaryTable = cell2table(summaryData, 'VariableNames',vars);

    %% BUILD sigmaSummaryTable (41‑sample windows)
    timeVec = (-sigmaHalfSamples : sigmaHalfSamples).' / fs_sigma;
    sigmaSummaryTable = table(timeVec,'VariableNames',{'Time'});
    for lvl = 1:5
      X = sigmaSegments{lvl};
      if isempty(X)
        mS = nan(1,sigmaSegLen); sS = nan(1,sigmaSegLen);
      else
        mS = mean(X,1); sS = std(X,0,1)/sqrt(size(X,1));
      end
      sigmaSummaryTable.(['MeanSigma_L',num2str(lvl)])    = mS.';
      sigmaSummaryTable.(['SEMSigma_L',num2str(lvl)])     = sS.';
    end

    %% BUILD RRSummaryTable (±20 s RR windows)
    timeRR = (-halfRRsamp : halfRRsamp).' / fs_RR;
    RRSummaryTable = table(timeRR,'VariableNames',{'Time'});
    for lvl = 1:5
      X = rrSegments{lvl};
      if isempty(X)
        mR = nan(1,rrSegLen); sR = nan(1,rrSegLen);
      else
        mR = mean(X,1); sR = std(X,0,1)/sqrt(size(X,1));
      end
      RRSummaryTable.(['MeanRR_L',num2str(lvl)])  = mR.';
      RRSummaryTable.(['SEMRR_L',num2str(lvl)]) = sR.';
    end
end
