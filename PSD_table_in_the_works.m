% Initialization
min_period_dur = 120; % Minimum period duration in seconds
max_freq = 30; % Maximum frequency for PSD analysis
sample_pr_sec = 0.5; % Frequency resolution for PSD, adjust based on your requirements

% Initialize the PSD_NE_table with predefined columns for clarity
% PSD_NE_table = cell(0, 14); % Adjust the number of columns based on the metrics you plan to store
% PSD_NE_table_headers = {'MouseNumber', 'Hour', 'SleepStage', 'WeightedMeanPSD', 'PeakPowerValue', 'PeakFrequency', 'MinFrequency', 'MaxFrequency', 'Freq25Quartile', 'MedianFrequency', 'Freq75Quartile', 'Freq95Quartile', 'AUC', 'TotalPower'};
% PSD_NE_table = [PSD_NE_table_headers; PSD_NE_table];

PSD_NE_table_new = [];
% Finalizing the structure for PSD_NE_table_new to include the headers for the new metrics
PSD_NE_table_new = [{'MouseNumber', 'Hour', 'SleepStage', 'PeakPower', 'PeakPowerFreq', 'Freq25Quartile', 'MedianFrequency', 'Freq75Quartile', 'Freq95Quartile', 'AUC', 'TotalPower'}; PSD_NE_table_new];
% Assuming signal_trace and sec_signal are available for each segment

uniqueMouseNumbers = unique(cell2mat(updated_mice_data_hours(:, 1)));
uniqueHours = unique(cell2mat(updated_mice_data_hours(:, 2)));

% Loop through each hour
for hourIdx = 1:length(uniqueHours)
    uHour = uniqueHours(hourIdx);

    % Find all entries for this hour
    hourEntriesIdx = find(cell2mat(updated_mice_data_hours(:, 2)) == uHour);
    hourEntries = updated_mice_data_hours(hourEntriesIdx, :);

    % Structure to hold combined PSD data for each sleep stage, per hour
    combinedPSDData = struct();

    fs = [];

    % Loop through each mouse for the current hour
    for mouseIdx = 1:length(uniqueMouseNumbers)
        uMouseNumber = uniqueMouseNumbers(mouseIdx);
        mouseEntriesIdx = find(cell2mat(hourEntries(:, 1)) == uMouseNumber);
        mouseEntries = hourEntries(mouseEntriesIdx, :);

                % Extract fs for the current mouse using its identifier
        fs_varName = sprintf('signal_fs_%d', uMouseNumber);
        fs = eval(fs_varName); % Assuming fs is defined in the workspace

        % Loop through each sleep stage for the current mouse and hour
        for stageIdx = 1:length(sleepStages)
            uSleepStage = sleepStages{stageIdx}(1:end-8);
            stageEntriesIdx = find(strcmp(mouseEntries(:, 3), uSleepStage));
            stageEntries = mouseEntries(stageEntriesIdx, :);

            % Initialize variables for accumulating PSD data
            totalDataPoints = 0;
            weightedPSD = zeros(1, floor(max_freq/sample_pr_sec) + 1); % Adjust based on your freq. resolution

            % Process each sleep bout within the stage
            for entryIdx = 1:size(stageEntries, 1)
                secSignalData = stageEntries{entryIdx, 5};
                deltaSignalData = stageEntries{entryIdx, 7};

                % Process each signal segment to calculate PSD
                [segmentPSD, freqs, segmentDataPoints] = processSignalSegment(secSignalData, deltaSignalData, fs, max_freq, sample_pr_sec);

                % Accumulate weighted PSD
                weightedPSD = weightedPSD + segmentPSD * segmentDataPoints;
                totalDataPoints = totalDataPoints + segmentDataPoints;
            end

            % Calculate average PSD for this stage
            if totalDataPoints > 0
                avgPSD = weightedPSD / totalDataPoints;
                % Store avgPSD and freqs in combinedPSDData
                combinedPSDData.(uSleepStage).avgPSD = avgPSD;
                combinedPSDData.(uSleepStage).freqs = freqs;
                combinedPSDData.(uSleepStage).totalDataPoints = totalDataPoints;
            end
        end
    end

    % Placeholder for the structure that will hold the final averaged PSD data for the table
    finalPSDDataForHour = struct();
    
    % Loop through each sleep stage stored in combinedPSDData
    for stageName = fieldnames(combinedPSDData).'
        stage = stageName{1}; % Current sleep stage being processed
    
        % Initialize variables for weighted averaging
        totalWeightedPSD = 0;
        totalDataPoints = 0;
    
        % Retrieve the data for the current sleep stage across all mice for the current hour
        stageData = combinedPSDData.(stage);
    
        % Assuming stageData is structured with .avgPSD, .freqs, and .totalDataPoints
        % Check if there's data to process
        if ~isempty(stageData) && isfield(stageData, 'avgPSD') && ~isempty(stageData.avgPSD)
            % Extract frequency vector - assuming it's the same for all entries
            freqs = stageData.freqs;
    
            % Calculate the total weighted PSD and sum of all data points for averaging
            for i = 1:length(stageData.avgPSD)
                avgPSD = stageData.avgPSD{i};
                dataPoints = stageData.totalDataPoints(i);
                
                totalWeightedPSD = totalWeightedPSD + avgPSD * dataPoints;
                totalDataPoints = totalDataPoints + dataPoints;
            end
    
            % Compute the weighted mean PSD for the current stage
            weightedMeanPSD = totalWeightedPSD / totalDataPoints;
    
            % Store or update the final PSD data for this hour and sleep stage
            finalPSDDataForHour.(stage) = struct('weightedMeanPSD', weightedMeanPSD, 'freqs', freqs);

                        % Check if any data has been processed for this sleep stage
            if totalDataPoints > 0
                % Normalize the weighted PSD by total data points to get the average PSD
                averagedPSD = weightedPSD / totalDataPoints;
                
                % Calculate peak power and its frequency
                [peakPower, peakIdx] = max(averagedPSD);
                peakPowerFreq = freqs(peakIdx);
                
                % Calculate the area under the curve (AUC) and total power
                auc = trapz(freqs, averagedPSD);
                totalPower = sum(averagedPSD);
                
                % Calculate power distribution quartiles
                cumDist = cumtrapz(freqs, averagedPSD) / auc; % Cumulative distribution of power
                Freq25Quartile = interp1(cumDist, freqs, 0.25);
                MedianFrequency = interp1(cumDist, freqs, 0.5);
                Freq75Quartile = interp1(cumDist, freqs, 0.75);
                Freq95Quartile = interp1(cumDist, freqs, 0.95);
                
                % Append the calculated metrics for this mouse, hour, and sleep stage to PSD_NE_table_new
                newEntry = {uMouseNumber, uHour, uSleepStage, peakPower, peakPowerFreq, Freq25Quartile, MedianFrequency, Freq75Quartile, Freq95Quartile, auc, totalPower};
                PSD_NE_table_new = [PSD_NE_table_new; newEntry];
            end
        end
    end
end


