function summaryTable = compute_RR_summary(RR_intervals, chr2, yfp)
    % Initialize containers for results
    results = struct();

    % Combine groups and add group label to the data
    allGroups = [chr2, yfp];
    groupLabels = [repmat({"chr2"}, 1, length(chr2)), repmat({"yfp"}, 1, length(yfp))];

    % Prepare a structure to store data
    for laserLevel = 0:5
        results(laserLevel + 1).chr2 = [];
        results(laserLevel + 1).yfp = [];
    end

    % Iterate through the RR_intervals and assign data to groups and laser levels
    for i = 1:size(RR_intervals, 1)
        RR_values = RR_intervals{i, 1};
        subjectID = RR_intervals{i, 2};
        laserLevel = RR_intervals{i, 3};

        % Ensure RR_values is a column vector
        if isrow(RR_values)
            RR_values = RR_values'; % Transpose to column vector if needed
        end

        % Identify the group of the subject
        groupIdx = find(strcmp(subjectID, allGroups));
        if isempty(groupIdx)
            continue; % Skip if the subject is not in the defined groups
        end
        groupLabel = groupLabels{groupIdx};

        % Append RR values to the corresponding group and laser level
        results(laserLevel + 1).(groupLabel) = [results(laserLevel + 1).(groupLabel); RR_values];
    end

    % Compute mean, SD, and count for each group and laser level
    laserLevels = 0:5;
    groupNames = {"chr2", "yfp"};
    summaryData = [];

    for laserLevel = laserLevels
        for groupIdx = 1:length(groupNames)
            groupName = groupNames{groupIdx};
            RR_data = results(laserLevel + 1).(groupName);

            if isempty(RR_data)
                meanRR = NaN;
                sdRR = NaN;
                dataCount = 0;
            else
                meanRR = mean(RR_data);
                sdRR = std(RR_data);
                dataCount = length(RR_data);
            end

            % Store results in a summary array
            summaryData = [summaryData; {laserLevel, groupName, meanRR, sdRR, dataCount}];
        end
    end

    % Convert summary data to a table
    summaryTable = cell2table(summaryData, 'VariableNames', {'LaserLevel', 'Group', 'MeanRR', 'SDRR', 'DataCount'});
end
