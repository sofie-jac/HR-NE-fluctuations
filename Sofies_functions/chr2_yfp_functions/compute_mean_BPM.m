function [summaryTable_BPM, chr2EventTable_BPM] = compute_mean_BPM(dataDirectory, chr2, yfp)
% COMPUTE_MEAN_BPM
%   [summaryTable_BPM, chr2EventTable_BPM] =
%   Reads RR_laser_<L>_NREM_<ID>.mat for chr2 & yfp and outputs:
%     • summaryTable_BPM: per‐laser & group MeanBPM, SEMBPM, DataCount
%     • chr2EventTable_BPM: per‐trial (chr2 only) MeanBPM, SEMBPM

    %% PREP
    results = struct();
    chr2Rows = {};  % for event‐level table

    allGroups   = [chr2, yfp];
    groupLabels = [repmat({"chr2"},1,numel(chr2)), repmat({"yfp"},1,numel(yfp))];

    % initialize accumulator
    for lvl = 1:5
        results(lvl).chr2 = [];
        results(lvl).yfp  = [];
    end

    %% LOAD & CONVERT
    for laserLevel = 1:5
        for i = 1:numel(allGroups)
            subj      = allGroups{i};
            grp       = groupLabels{i};
            fn        = fullfile(dataDirectory, sprintf('RR_laser_%d_NREM_%s.mat', laserLevel, subj));
            if ~exist(fn,'file')
                warning('Missing file: %s', fn);
                continue
            end

            D   = load(fn);
            f   = fieldnames(D);
            RRm = D.(f{1});            % [nTrials × nSamples] or [1×nSamples]

            % flatten for group‐level
            BPM_all = 60 ./ RRm(:);
            results(laserLevel).(grp) = [results(laserLevel).(grp); BPM_all];

            % per‐trial (event) for chr2
            if strcmp(grp,'chr2')
                nSamples = size(RRm,2);
                for tr = 1:size(RRm,1)
                    bpmTrial = 60 ./ RRm(tr,:);
                    mBPM     = mean(bpmTrial);
                    semBPM   = std(bpmTrial)/sqrt(nSamples);
                    chr2Rows(end+1,:) = {subj, laserLevel, mBPM, semBPM};
                end
            end
        end
    end

    %% BUILD GROUP SUMMARY TABLE
    vars = {'LaserLevel','Group','MeanBPM','SEMBPM','DataCount'};
    summaryData = cell(0,numel(vars));
    for lvl = 1:5
        for g = {'chr2','yfp'}
            col = results(lvl).(g{1});
            if isempty(col)
                m=NaN; sem=NaN; cnt=0;
            else
                m   = mean(col);
                sem = std(col)/sqrt(numel(col));
                cnt = numel(col);
            end
            summaryData(end+1,:) = {lvl, g{1}, m, sem, cnt};
        end
    end
    summaryTable_BPM = cell2table(summaryData,'VariableNames',vars);

    %% BUILD CHR2 EVENT‐LEVEL TABLE
    chr2EventTable_BPM = cell2table(chr2Rows, ...
        'VariableNames',{'SubjectID','LaserLevel','MeanBPM','SEMBPM'});
end
