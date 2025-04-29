function [summaryTable_individual_blCorr, event_table_individual_blCorr] = ...
    compute_peak_RR_with_individual_bl(dataDirectory, chr2, yfp, sec_after, delay)
% Same as compute_peak_RR_summary_with_individual_bl but baseline = mean RR 8–10 s before each peak

    %% PARAMETERS
    fs_RR   = 64;      % Hz
    fs_sig  = 2;       % Hz
    winLong = 10*fs_RR;  % 10 s window in samples
    winShort= 8*fs_RR;   %  8 s in samples

    %% PREALLOCATE
    corrRR_by_lvl = cell(5,1);
    for L = 1:5
        corrRR_by_lvl{L} = [];
    end
    rows = {};  % for event table

    %% LOOP
    allSubs   = [chr2, yfp];
    grpLabels = [repmat({'chr2'},1,numel(chr2)), repmat({'yfp'},1,numel(yfp))];

    for lvl = 1:5
      for i = 1:numel(allSubs)
        subj = allSubs{i};
        grp  = grpLabels{i};
        if ~strcmp(grp,'chr2'), continue, end

        % filenames
        fnRR    = fullfile(dataDirectory, sprintf('RR_laser_%d_NREM_%s.mat', lvl, subj));
        fnSig   = fullfile(dataDirectory, sprintf('Sigma_laser_%d_NREM_%s.mat',lvl, subj));
        if ~(exist(fnRR,'file')&&exist(fnSig,'file')), warning('Missing %s L%d',subj,lvl); continue, end

        % load RR
        D      = load(fnRR);
        fnames = fieldnames(D);
        RR     = D.(fnames{1});    % [nTrials × nRRsamples]
        [nTrials, nRR] = size(RR);

        % load Sigma
        S      = load(fnSig);
        snames = fieldnames(S);
        Sigma  = S.(snames{1});    % [nTrials × nSigsamples]
        [~, nSig] = size(Sigma);

        % centers & windows
        centerRR = ceil(nRR/2);
        centerSig= floor((nSig+1)/2);
        midRR    = centerRR + round(delay*fs_RR);
        sampWin  = sec_after * fs_RR;

        for tr = 1:nTrials
          if midRR + sampWin -1 > nRR, continue, end

          % 1) find peak
          segRR = RR(tr, midRR:midRR+sampWin-1);
          [RR_peak, idxLoc] = max(segRR);
          idxG = midRR + idxLoc -1;

          % 2) compute baseline 8–10 s before
          startB = idxG - winLong;
          endB   = idxG - winShort;
          if startB<1 || endB>nRR
            baselineRR = NaN;
          else
            baselineRR = mean(RR(tr, startB:endB));
          end
          CorrRR = RR_peak - baselineRR;

          % 3) sigma at peak
          t_rel = (idxG - centerRR)/fs_RR;
          idxS  = centerSig + round(t_rel*fs_sig);
          if idxS<1||idxS>nSig, sigAt=NaN;
          else sigAt = Sigma(tr, idxS); end

          % 4) amplitudes
          pre5 = max(1, idxG - 5*fs_RR);
          RR_ampl = RR_peak - min(RR(tr, pre5:idxG));
          preSig = max(1, idxS - 5*fs_sig);
          sigAmpl = max(Sigma(tr, preSig:idxS)) - sigAt;

          % 5) compute MeanBPM for this trial
          MeanBPM = mean( 60 ./ RR(tr,:) );

          MeanRR = mean(RR(tr,:));

          RR_SD = std(RR(tr,:));

          % 5) collect for summary
          corrRR_by_lvl{lvl}(end+1,1) = CorrRR;

          % 6) collect for event table
          rows(end+1,:) = { subj, lvl, CorrRR, sigAt, RR_ampl, sigAmpl, baselineRR, MeanBPM, MeanRR, RR_SD};
        end
      end
    end

    %% BUILD event_table
    event_table_individual_blCorr = cell2table(rows, ...
      'VariableNames',{'SubjectID','LaserLevel',    ...
                       'CorrRR_peak','Sigma_at_RR_peak',...
                       'RR_ampl','Sigma_ampl','BaselineRR', 'MeanBPM', 'MeanRR', 'RR_SD'});

    %% BUILD summaryTable
    vars = {'LaserLevel','MeanCorrRRpeak','SEMCorrRRpeak','DataCount'};
    sumData = cell(0,numel(vars));
    for lvl = 1:5
      X = corrRR_by_lvl{lvl};
      n = numel(X);
      if n==0
        mn = NaN; sem = NaN;
      else
        mn  = mean(X);
        sem = std(X)/sqrt(n);
      end
      sumData(end+1,:) = { lvl, mn, sem, n };
    end
    summaryTable_individual_blCorr = cell2table(sumData,'VariableNames',vars);
end
