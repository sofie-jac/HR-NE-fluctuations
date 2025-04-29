function [summaryTable, chr2EventTable] = compute_RR_summary_from_files(dataDirectory, chr2, yfp)
% COMPUTE_RR_SUMMARY_FROM_FILES
%   [summaryTable, chr2EventTable] =
%   – summaryTable: as before, mean/SD/SEM/count by group & laser
%   – chr2EventTable: for each chr2 trial, mean & SEM of that trial’s RR

    % Initialize
    results    = struct();
    chr2Rows   = {};  % for event‐level stats

    % Combine groups
    allGroups   = [chr2, yfp];
    groupLabels = [repmat({"chr2"},1,numel(chr2)), repmat({"yfp"},1,numel(yfp))];

    % Pre‐alloc containers for summaryTable
    for laserLevel = 1:5
        results(laserLevel).chr2 = [];
        results(laserLevel).yfp  = [];
    end

    % Loop over laser levels and subjects
    for laserLevel = 1:5
        for i = 1:numel(allGroups)
            subjectID  = allGroups{i};
            groupLabel = groupLabels{i};

            fn = fullfile(dataDirectory, sprintf('RR_laser_%d_NREM_%s.mat', ...
                                                  laserLevel, subjectID));
            if ~exist(fn,'file')
                warning('File not found: %s', fn);
                continue
            end

            % Load RR; maybe a row vector or nTrials×nSamples matrix
            D   = load(fn);
            f   = fieldnames(D);
            RRm = D.(f{1});         % [nTrials×nSamples] or [1×nSamples]

            % 1) for summaryTable, flatten all RR values
            RR_all = RRm(:);
            results(laserLevel).(groupLabel) = [ results(laserLevel).(groupLabel); RR_all ];

            % 2) if chr2, compute mean & SEM per trial (each row = event)
            if strcmp(groupLabel,'chr2')
                nSamps = size(RRm,2);
                for tr = 1:size(RRm,1)
                    thisRR = RRm(tr,:);
                    m_rr   = mean(thisRR);
                    sem_rr = std(thisRR)/sqrt(nSamps);
                    chr2Rows(end+1,:) = { subjectID, laserLevel, m_rr, sem_rr };
                end
            end
        end
    end

    % Build summaryTable (unchanged)
    laserLevels = (1:5).';
    groupNames  = {'chr2','yfp'};
    summaryData = cell(0,6);
    for lvl = laserLevels.'
        for g = 1:2
            dat = results(lvl).(groupNames{g});
            if isempty(dat)
                m=NaN; sd=NaN; sem=NaN; cnt=0;
            else
                m   = mean(dat);
                sd  = std(dat);
                sem = sd/sqrt(numel(dat));
                cnt = numel(dat);
            end
            summaryData(end+1,:) = {lvl, groupNames{g}, m, sd, sem, cnt};
        end
    end
    summaryTable = cell2table(summaryData, ...
        'VariableNames',{'LaserLevel','Group','MeanRR','SDRR','SEMRR','DataCount'});

    % Build chr2EventTable (one row per trial/event)
    chr2EventTable = cell2table(chr2Rows, ...
        'VariableNames',{'SubjectID','LaserLevel','MeanRR','SEMRR'});
end
