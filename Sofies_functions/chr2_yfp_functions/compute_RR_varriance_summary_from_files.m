function [summaryTable, chr2EventVarTable] = compute_RR_varriance_summary_from_files(dataDirectory, chr2, yfp)
% COMPUTE_RR_VARIANCE_SUMMARY_FROM_FILES
%   [summaryTable, chr2EventVarTable] =
%     – summaryTable: mean/SD/SEM of the per-row SDs by group & laser level
%     – chr2EventVarTable: one row per chr2 trial with SD & SEMSD of that trial

    %% SETUP
    results = struct();
    chr2Rows = {};  % for event‐level stats

    % groups
    allGroups   = [chr2, yfp];
    groupLabels = [repmat({"chr2"},1,numel(chr2)), repmat({"yfp"},1,numel(yfp))];

    % init containers for summary
    for lvl = 1:5
        results(lvl).chr2 = [];
        results(lvl).yfp  = [];
    end

    %% LOOP FILES
    for laserLevel = 1:5
        for i = 1:numel(allGroups)
            subjectID  = allGroups{i};
            groupLabel = groupLabels{i};

            fn = fullfile(dataDirectory, ...
                sprintf('RR_laser_%d_NREM_%s.mat', laserLevel, subjectID));
            if ~exist(fn,'file')
                warning('File not found: %s', fn);
                continue
            end

            % load RR: can be vector or matrix [nTrials × nSamples]
            D     = load(fn);
            f     = fieldnames(D);
            RRm   = D.(f{1});              % trials×samples

            % compute per‐trial SDs
            rowSDs = std(RRm, 0, 2);       % one SD per row

            % aggregate for group‑level summary
            results(laserLevel).(groupLabel) = ...
                [ results(laserLevel).(groupLabel); rowSDs ];

            % for chr2, build event table rows
            if strcmp(groupLabel,'chr2')
                nSamples = size(RRm,2);
                % SEM of SD ≈ SD / sqrt(2*(N-1))
                semFactor = 1 / sqrt(2*(nSamples-1));
                for tr = 1:numel(rowSDs)
                    sd_rr    = rowSDs(tr);
                    semsd_rr = sd_rr * semFactor;
                    chr2Rows(end+1,:) = { subjectID, laserLevel, sd_rr, semsd_rr };
                end
            end
        end
    end

    %% BUILD GROUP SUMMARY TABLE
    laserLevels = (1:5).';
    groups      = {'chr2','yfp'};
    summaryData = cell(0,6);

    for lvl = laserLevels.'
        for g = 1:2
            sd_data = results(lvl).(groups{g});
            if isempty(sd_data)
                mSD   = NaN;
                sdSD  = NaN;
                semSD = NaN;
                cnt   = 0;
            else
                mSD   = mean(sd_data);
                sdSD  = std(sd_data);
                semSD = sdSD / sqrt(numel(sd_data));
                cnt   = numel(sd_data);
            end
            summaryData(end+1,:) = { ...
                lvl, groups{g}, mSD, sdSD, semSD, cnt };
        end
    end

    summaryTable = cell2table(summaryData, ...
      'VariableNames',{'LaserLevel','Group','MeanSD','SDofSD','SEMSD','DataCount'});

    %% BUILD CHR2 EVENT‐LEVEL VARIANCE TABLE
    chr2EventVarTable = cell2table(chr2Rows, ...
        'VariableNames',{'SubjectID','LaserLevel','SD_RR','SEMSD_RR'});
end
