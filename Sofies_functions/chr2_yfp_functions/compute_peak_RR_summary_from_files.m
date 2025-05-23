function summaryTable = compute_peak_RR_summary_from_files(dataDirectory, chr2, yfp, sec_after, delay)
%outputs the top RR value from time 0-10 eafter the laser stimulation
    % Initialize containers for results
    results = struct();

    % Combine groups and add group label to the data
    allGroups = [chr2, yfp];
    groupLabels = [repmat({"chr2"}, 1, length(chr2)), repmat({"yfp"}, 1, length(yfp))];

    % Prepare a structure to store data
    for laserLevel = 1:5
        results(laserLevel).chr2 = [];
        results(laserLevel).yfp = [];
    end

    % Iterate through files in the directory
    for laserLevel = 1:5
        for i = 1:length(allGroups)
            subjectID = allGroups{i};
            groupLabel = groupLabels{i};

            % Construct the file name
            fileName = fullfile(dataDirectory, sprintf('RR_laser_%d_NREM_%s.mat', laserLevel, subjectID));
            fileName_sigma = fullfile(dataDirectory, sprintf('RR_laser_%d_NREM_%s.mat', laserLevel, subjectID));


            % Check if the file exists
            if exist(fileName, 'file') && exist(fileName_sigma, 'file')
                % Load the file
                data = load(fileName);
                data_sigma = load(fileName_sigma);

                % Extract the content of the first field dynamically
                fieldName = fieldnames(data); % Get the field name
                RR_values = data.(fieldName{1}); % Extract the content of the field

                fieldName_sigma = fieldnames(data_sigma); % Get the field name
                Sigma_values = data.(fieldName_sigma{1}); % Extract the content of the field

                % Identify the midpoint and extract 640 observations
                numCols = size(RR_values, 2);
                midpoint = ceil((numCols / 2)+(64*delay));
                intervalLength = 64 * sec_after; % 640 observations

                for rowIdx = 1:size(RR_values, 1)
                    if midpoint + intervalLength - 1 <= numCols
                        interval = RR_values(rowIdx, midpoint:(midpoint + intervalLength - 1));
                        maxRR = max(interval); % Find the highest RR value in the interval
                        results(laserLevel).(groupLabel) = [results(laserLevel).(groupLabel); maxRR];
                    end
                end
            else
                warning('File not found: %s', fileName);
            end
        end
    end

    % Compute mean, SD, SEM, and count for each group and laser level
    laserLevels = 1:5;
    groupNames = {"chr2", "yfp"};
    summaryData = [];

    for laserLevel = laserLevels
        for groupIdx = 1:length(groupNames)
            groupName = groupNames{groupIdx};
            peakRR_data = results(laserLevel).(groupName);

            if isempty(peakRR_data)
                meanPeakRR = NaN;
                sdPeakRR = NaN;
                semPeakRR = NaN;
                dataCount = 0;
            else
                meanPeakRR = mean(peakRR_data);
                sdPeakRR = std(peakRR_data);
                semPeakRR = sdPeakRR / sqrt(length(peakRR_data)); % Compute SEM
                dataCount = length(peakRR_data);
            end

            % Store results in a summary array
            summaryData = [summaryData; {laserLevel, groupName, meanPeakRR, sdPeakRR, semPeakRR, dataCount}];
        end
    end

    % Convert summary data to a table
    summaryTable = cell2table(summaryData, 'VariableNames', {'LaserLevel', 'Group', 'MeanPeakRR', 'SDPeakRR', 'SEMPeakRR', 'DataCount'});
end
