function [summaryEntropyTable, eventEntropyTable] = ...
    compute_RR_sample_entropy(dataDirectory, chr2, yfp)
% COMPUTE_RR_SAMPLE_ENTROPY_FROM_FILES (15 s post‐midpoint + RR_SD & MeanBPM)
%   [summaryEntropyTable, eventEntropyTable] =
%   For each laser level (1–5) and chr2 subjects only:
%     • Extracts the 15 s segment after midpoint, computes Sample Entropy
%     • Computes full‐trace SD and mean BPM (60./RR) over the full 60 s
%     • eventEntropyTable: per‐trial {SubjectID, LaserLevel, SampleEntropy, RR_SD, MeanBPM}
%     • summaryEntropyTable: per‐level {LaserLevel, MeanSampleEntropy, SEMSampleEntropy, DataCount}
%
% Requires Brian Lord’s SampEn.m on the MATLAB path.

    %% PARAMETERS
    fs_RR = 64;                 % RR sampling rate (Hz)
    m     = 2;                  % SampEn embedding dimension
    winS  = 10 * fs_RR;         % 15 s window length in samples

    rows = {};  % will collect event‐level rows

    allSubs   = [chr2, yfp];
    grpLabels = [repmat({"chr2"},1,numel(chr2)), repmat({"yfp"},1,numel(yfp))];

    %% MAIN LOOP
    for lvl = 1:5
      for i = 1:numel(allSubs)
        subj = allSubs{i};
        if ~strcmp(grpLabels{i},'chr2'), continue, end

        fn = fullfile(dataDirectory, sprintf('RR_laser_%d_NREM_%s.mat', lvl, subj));
        if ~exist(fn,'file')
          warning('Missing RR file: %s', fn);
          continue
        end

        D    = load(fn);
        fnms = fieldnames(D);
        RRm  = D.(fnms{1});        % [nTrials × nSamples]
        [nTrials,nSamples] = size(RRm);
        mid = ceil(nSamples/2);

        segStart = mid + 1;
        segEnd   = min(mid + winS, nSamples);

        for tr = 1:nTrials
          rrFull = RRm(tr,:);      % full 60 s trace

          % 1) compute full-trace SD and mean BPM
          RR_SD   = std(rrFull);
          MeanBPM = mean( 60 ./ rrFull );

          % 2) isolate the 15 s post-midpoint
          if segEnd > nSamples
            warning('Not enough data for 15s segment in %s L%d trial %d', subj,lvl,tr);
            continue
          end
          rrSeg = rrFull(segStart:segEnd);

          % 3) sample entropy on that segment
          rTol      = 0.2 * std(rrSeg);     
          SampEnVal = SampEn(rrSeg, rTol, m);  

          % 4) collect this trial’s row
          rows(end+1,:) = { ...
            subj, lvl, SampEnVal, RR_SD, MeanBPM ...
          };
        end
      end
    end

    %% BUILD eventEntropyTable
    eventEntropyTable = cell2table(rows, ...
      'VariableNames',{'SubjectID','LaserLevel','SampleEntropy','RR_SD','MeanBPM'});

    %% BUILD summaryEntropyTable
    LaserLevels       = (1:5).';
    MeanSampleEntropy = nan(5,1);
    SEMSampleEntropy  = nan(5,1);
    DataCount         = zeros(5,1);

    for L = 1:5
      sel  = eventEntropyTable.LaserLevel == L;
      vals = eventEntropyTable.SampleEntropy(sel);
      vals = vals(~isnan(vals));  % drop any NaNs
      n    = numel(vals);
      if n>0
        MeanSampleEntropy(L) = mean(vals);
        SEMSampleEntropy(L)  = std(vals)/sqrt(n);
        DataCount(L)         = n;
      end
    end

    summaryEntropyTable = table( ...
      LaserLevels, MeanSampleEntropy, SEMSampleEntropy, DataCount, ...
      'VariableNames',{'LaserLevel','MeanSampleEntropy','SEMSampleEntropy','DataCount'});
end
