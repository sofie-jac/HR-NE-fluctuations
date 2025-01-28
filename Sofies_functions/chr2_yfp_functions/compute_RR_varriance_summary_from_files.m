function summaryTable = compute_RR_varriance_summary_from_files(dataDirectory, chr2, yfp)
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

            % Check if the file exists
            if exist(fileName, 'file')
                % Load the file
                data = load(fileName);

                % Extract the content of the first field dynamically
                fieldName = fieldnames(data); % Get the field name
                RR_values = data.(fieldName{1}); % Extract the content of the field

                % Calculate the standard deviation for each row
                rowSDs = std(RR_values, 0, 2); % Compute SD across columns (dimension 2)

                % Append rowSDs to the corresponding group and laser level
                results(laserLevel).(groupLabel) = [results(laserLevel).(groupLabel); rowSDs];
            else
                warning('File not found: %s', fileName);
            end
        end
    end

    % Compute mean, SD, and SEM of SDs for each group and laser level
    laserLevels = 1:5;
    groupNames = {"chr2", "yfp"};
    summaryData = [];

    for laserLevel = laserLevels
        for groupIdx = 1:length(groupNames)
            groupName = groupNames{groupIdx};
            SD_data = results(laserLevel).(groupName);

            if isempty(SD_data)
                meanSD = NaN;
                sdSD = NaN;
                semSD = NaN;
                dataCount = 0;
            else
                meanSD = mean(SD_data);
                sdSD = std(SD_data); % Compute SD of SDs
                semSD = sdSD / sqrt(length(SD_data)); % Compute SEM of SDs
                dataCount = length(SD_data);
            end

            % Store results in a summary array
            summaryData = [summaryData; {laserLevel, groupName, meanSD, sdSD, semSD, dataCount}];
        end
    end

    % Convert summary data to a table
    summaryTable = cell2table(summaryData, 'VariableNames', {'LaserLevel', 'Group', 'MeanSD', 'SDofSD', 'SEMSD', 'DataCount'});
end