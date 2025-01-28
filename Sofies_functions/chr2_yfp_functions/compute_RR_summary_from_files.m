function summaryTable = compute_RR_summary_from_files(dataDirectory, chr2, yfp)
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
                
                % Ensure RR_values is in the correct format (vector)
                if size(RR_values, 1) > 1
                    RR_values = RR_values(:); % Flatten the matrix to a vector
                end
            
                % Append RR values to the corresponding group and laser level
                results(laserLevel).(groupLabel) = [results(laserLevel).(groupLabel); RR_values];
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
            RR_data = results(laserLevel).(groupName);

            if isempty(RR_data)
                meanRR = NaN;
                sdRR = NaN;
                semRR = NaN;
                dataCount = 0;
            else
                meanRR = mean(RR_data);
                sdRR = std(RR_data);
                semRR = sdRR / sqrt(length(RR_data)); % Compute SEM
                dataCount = length(RR_data);
            end

            % Store results in a summary array
            summaryData = [summaryData; {laserLevel, groupName, meanRR, sdRR, semRR, dataCount}];
        end
    end

    % Convert summary data to a table
    summaryTable = cell2table(summaryData, 'VariableNames', {'LaserLevel', 'Group', 'MeanRR', 'SDRR', 'SEMRR', 'DataCount'});
end
