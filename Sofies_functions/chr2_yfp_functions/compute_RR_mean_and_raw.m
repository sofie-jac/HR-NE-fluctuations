function [rrMeanTable, rawRR_L1, rawRR_L2, rawRR_L3, rawRR_L4, rawRR_L5] = ...
    compute_RR_mean_and_raw(dataDirectory, chr2, yfp)
% COMPUTE_RR_MEAN_AND_RAW
%   [rrMeanTable, rawRR_L1, ..., rawRR_L5] =
%   For each laser level (1–5) and for chr2 subjects only:
%     • rawRR_L#: [Ntrials × 7681] matrix of full RR traces
%     • rrMeanTable: table with Time (–30→+30 s) and MeanRR_L1…MeanRR_L5

    fs_RR = 64;                        % sampling rate (Hz)
    nLevels = 5;
    
    % prepare containers
    rawRR = cell(nLevels,1);
    for L = 1:nLevels
        rawRR{L} = []; 
    end
    
    % subject lists (we'll skip yfp inside loop)
    allSubs   = [chr2, yfp];
    grpLabels = [repmat({"chr2"},1,numel(chr2)), repmat({"yfp"},1,numel(yfp))];

    % loop & collect
    for L = 1:nLevels
        for i = 1:numel(allSubs)
            if ~strcmp(grpLabels{i},"chr2"), continue, end
            subj = allSubs{i};
            fn   = fullfile(dataDirectory, sprintf('RR_laser_%d_NREM_%s.mat', L, subj));
            if ~exist(fn,'file')
                warning('Missing file: %s', fn);
                continue
            end
            D    = load(fn);
            f    = fieldnames(D);
            RRm  = D.(f{1});              % [nTrials × 7681]
            rawRR{L} = [rawRR{L}; RRm];    % append all trials
        end
    end

    % sanity check & assign outputs
    rawRR_L1 = rawRR{1};
    rawRR_L2 = rawRR{2};
    rawRR_L3 = rawRR{3};
    rawRR_L4 = rawRR{4};
    rawRR_L5 = rawRR{5};

    % compute mean traces
    nSamples = size(rawRR_L1,2); 
    meanMat  = nan(nSamples, nLevels);
    for L = 1:nLevels
        if ~isempty(rawRR{L})
            meanMat(:,L) = mean(rawRR{L},1);
        end
    end

    % build time vector −30→+30 s over nSamples points
    timeVec = linspace(-30,30,nSamples).';

    % pack into table
    varNames = ['Time', arrayfun(@(L) sprintf('MeanRR_L%d',L), 1:nLevels, 'uni',false)];
    rrMeanTable = array2table([timeVec, meanMat], 'VariableNames', varNames);

    rawRR_L1 = rawRR_L1';
    rawRR_L2 = rawRR_L2';
    rawRR_L3 = rawRR_L3';
    rawRR_L4 = rawRR_L4';
    rawRR_L5 = rawRR_L5';
end
