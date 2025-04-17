function [summaryTable, sigmaSummaryTable, event_table] = compute_peak_RR_summary_from_files_w_sigma(dataDirectory, chr2, yfp, sec_after, delay)
% COMPUTE_PEAK_RR_SUMMARY_FROM_FILES_W_SIGMA
%  [summaryTable, sigmaSummaryTable] = …
%
% Extracts peak RR (in delay→delay+sec_after window) and around each RR peak
% pulls ±10 s of sigma trace (2 Hz→40 samples), handling both 240/241 lengths.

    obsRows = {};    % will hold {SubjectID, LaserLevel, RR_peak, Sigma_at_RR_peak, RR_ampl, Sigma_ampl}


    % PARAMETERS
    fs_RR            = 64;                  % RR sampling rate (Hz)
    fs_sigma         = 2;                   % sigma sampling rate (Hz)
    sigmaWindowSec   = 10;                  % ± window (s)
    sigmaHalfSamples = sigmaWindowSec * fs_sigma;    % 20 samples
    sigmaSegLen      = sigmaHalfSamples * 2;         % 40 samples total

    % INIT
    for lvl = 1:5
        results(lvl).chr2 = [];
        results(lvl).yfp  = [];
        sigmaSegments{lvl} = zeros(0, sigmaSegLen);
    end
    allGroups   = [chr2, yfp];
    groupLabels = [repmat({'chr2'},1,numel(chr2)), repmat({'yfp'},1,numel(yfp))];

    % MAIN LOOP
    for laserLevel = 1:5
      for i = 1:numel(allGroups)
        subj = allGroups{i};
        grp  = groupLabels{i};

        fn_RR    = fullfile(dataDirectory, sprintf('RR_laser_%d_NREM_%s.mat',    laserLevel, subj));
        fn_sigma = fullfile(dataDirectory, sprintf('Sigma_laser_%d_NREM_%s.mat', laserLevel, subj));
        if ~(exist(fn_RR,'file') && exist(fn_sigma,'file'))
          warning('Missing RR or Sigma for %s @ level %d', subj, laserLevel);
          continue
        end

        %— load RR —%
        D     = load(fn_RR);
        f_RR  = fieldnames(D);
        RR    = D.(f_RR{1});         % nTrials×nRRsamples

        %— load Sigma —%
        S        = load(fn_sigma);
        f_sigma  = fieldnames(S);
        Sigma    = S.(f_sigma{1});   % nTrials×(240 or 241)
        [~, nSig] = size(Sigma);
        if ~ismember(nSig,[240,241])
          warning('Sigma length=%d (expect 240 or 241)', nSig);
        end

        % RR window mapping
        nRR      = size(RR,2);
        rrCenter = ceil(nRR/2);
        midpoint = rrCenter + round(delay * fs_RR);
        winSamps = sec_after * fs_RR;

        for tr = 1:size(RR,1)
          if midpoint + winSamps - 1 <= nRR
            interval = RR(tr, midpoint:midpoint+winSamps-1);
            [~, idxLocal] = max(interval);
            maxRR = interval(idxLocal);
            results(laserLevel).(grp)(end+1,1) = interval(idxLocal);

            % global RR-peak index → time relative to center
            idxGlobal = midpoint + idxLocal - 1;
            t_rel     = (idxGlobal - rrCenter) / fs_RR;

            % map to Sigma index
            sigmaCenter = floor((nSig+1)/2);
            idxSigma    = sigmaCenter + round(t_rel * fs_sigma);

            %--- sigma at the RR‐peak time
            sigmaAtPeak = Sigma(tr, idxSigma);
            
            %--- RR amplitude: peak minus min RR in 5 s before
            preRRstart = max(1, idxGlobal - 5*fs_RR);
            minRRpre   = min( RR(tr, preRRstart:idxGlobal) );
            RR_ampl    = maxRR - minRRpre;
            
            %--- sigma amplitude: max sigma in 5 s before minus sigma at peak
            preSigStart = max(1, idxSigma - 5*fs_sigma);
            maxSigPre   = max( Sigma(tr, preSigStart:idxSigma) );
            sigma_ampl  = maxSigPre - sigmaAtPeak;
            
            %--- collect this trial’s row
            obsRows(end+1,:) = { subj, laserLevel, maxRR, sigmaAtPeak, RR_ampl, sigma_ampl };


            %— NEW SLICE: exactly 40 samples —%
            startIdx = idxSigma - sigmaHalfSamples;
            endIdx   = idxSigma + sigmaHalfSamples - 1;
            if startIdx>=1 && endIdx<=nSig
              seg = Sigma(tr, startIdx:endIdx);   % 1×40
              sigmaSegments{laserLevel}(end+1,:) = seg;
            else
              warning('Sigma window [%d:%d] oob (nSig=%d)', startIdx, endIdx, nSig);
            end
          end
        end
      end
    end

    % BUILD RR SUMMARY TABLE
    groups      = {'chr2','yfp'};
    rows = {};
    for lvl = 1:5
      for g = 1:2
        dat = results(lvl).(groups{g});
        if isempty(dat)
          mn=NaN; sd=NaN; sem=NaN; cnt=0;
        else
          mn  = mean(dat);
          sd  = std(dat);
          sem = sd/sqrt(numel(dat));
          cnt = numel(dat);
        end
        rows(end+1,:) = {lvl, groups{g}, mn, sd, sem, cnt};
      end
    end
    summaryTable = cell2table(rows, ...
      'VariableNames',{'LaserLevel','Group','MeanPeakRR','SDPeakRR','SEMPeakRR','DataCount'});

    event_table = cell2table( obsRows, ...
  'VariableNames', { ...
    'SubjectID', 'LaserLevel', ...
    'RR_peak', 'Sigma_at_RR_peak', ...
    'RR_ampl', 'Sigma_ampl' } );

    % BUILD SIGMA SUMMARY TABLE
    timeVec = (-sigmaHalfSamples : sigmaHalfSamples-1).' / fs_sigma;
    sigmaSummaryTable = table(timeVec,'VariableNames',{'Time'});
    for lvl = 1:5
      X = sigmaSegments{lvl};
      if isempty(X)
        meanSig = nan(1,sigmaSegLen);
        semSig  = nan(1,sigmaSegLen);
      else
        meanSig = mean(X,1);
        semSig  = std(X,0,1)/sqrt(size(X,1));
      end
      sigmaSummaryTable.(['MeanSigma_L', num2str(lvl)]) = meanSig.';
      sigmaSummaryTable.(['SEMSigma_L', num2str(lvl)])  = semSig.';
    end

    time = sigmaSummaryTable.Time;         % time vector (‑10 → +9.5 s)

    figure; hold on;
    cols = lines(5);                       % 5 distinct colors
    
    for lvl = 1:5
        meanCol = sigmaSummaryTable.(['MeanSigma_L',num2str(lvl)]);
        semCol  = sigmaSummaryTable.(['SEMSigma_L', num2str(lvl)]);
        
        upper = meanCol + semCol;
        lower = meanCol - semCol;
        
        % shaded SEM band
        fill([time; flipud(time)], ...
             [upper; flipud(lower)], ...
             cols(lvl,:), ...
             'FaceAlpha', 0.2, ...
             'EdgeColor','none');
        
        % mean trace
        plot(time, meanCol, ...
             'Color', cols(lvl,:), ...
             'LineWidth', 1.5);
    end
    
    xlabel('Time (s)');
    ylabel('Sigma');
    title('Mean \pm SEM Sigma Traces by Laser Level');
    legend({'L1','L2','L3','L4','L5'}, 'Location','Best');
    grid on;
    hold off;
end
