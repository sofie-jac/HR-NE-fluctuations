% Initialization
min_period_dur = 120; % Minimum period duration in seconds
max_freq = 1; % Maximum frequency for PSD analysis
sample_pr_sec = 0.005; % Frequency resolution for PSD, adjust based on your requirements

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
        %mouseNumber_value = uMouseNumber{1, 1}; % Assuming this is a numeric value

                % Extract fs for the current mouse using its identifier
        fs_varName = sprintf('signal_fs_%d', uMouseNumber);
        fs = eval(fs_varName); % Assuming fs is defined in the workspace

        % Loop through each sleep stage for the current mouse and hour
        for stageIdx = 1:length(sleepStages)
            uSleepStage = sleepStages{stageIdx}(1:end-8);
            %sleepStage_value = uSleepStage{1, 1}; % Assuming this is also a numeric value
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
                [detrendedSignal, segmentPSD, freqs, segmentDataPoints] = processSignalSegment(secSignalData, deltaSignalData, fs, max_freq, sample_pr_sec);
                
                % figure
                % set(gcf, 'Position',  [100, 300, 1500, 250])
                % titleStr = sprintf('Sleep Stage: %s, Mouse: %d', uSleepStage, uMouseNumber);
                % sgtitle(titleStr); 
                % a = subplot(1,2,1);
                %     %a.Position = [0.1300 0.1100 0.6200 0.8150];
                %     plot(secSignalData,deltaSignalData);
                %     hold on
                %     plot(secSignalData,detrendedSignal);
                %     legend({'raw','fitted'})
                %     hold off
                % b = subplot(1,2,2);
                %     %b.Position = [0.8140 0.1100 0.1533 0.8150];
                %     plot(freqs,segmentPSD);
                
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
        
        % Loop through each sleep stage stored in combinedPSDData
        for stageName = fieldnames(combinedPSDData).'
            stage = stageName{1}; % Current sleep stage being processed
        
            % Retrieve the data for the current sleep stage across all mice for the current hour
            stageData = combinedPSDData.(stage);
        
            % Assuming stageData is structured with .avgPSD, .freqs, and .totalDataPoints
            % Check if there's data to process
            if ~isempty(stageData) && isfield(stageData, 'avgPSD') && ~isempty(stageData.avgPSD)
                % Extract frequency vector - assuming it's the same for all entries
                freqs = stageData.freqs;
                avgPSD = stageData.avgPSD;
                dataPoints = stageData.totalDataPoints;
                averagedPSD = weightedPSD / totalDataPoints;
                
                % Calculate peak power and its frequency
                [peakPower, peakIdx] = max(avgPSD);
                peakPowerFreq = freqs(peakIdx);
                
                % Calculate the area under the curve (AUC) and total power
                auc = trapz(freqs, avgPSD);
                totalPower = sum(avgPSD);
                
                % Calculate power distribution quartiles
                cumDist = cumtrapz(freqs, avgPSD) / auc; % Cumulative distribution of power
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

%% 
% Assuming updated_mice_data_hours and sleepStages are already defined

% Initialization
max_freq = 0.1; % Maximum frequency for PSD analysis
sample_pr_sec = 0.002; % Frequency resolution for PSD

% Initialize the PSD_NE_table_new with headers
PSD_NE_table_new = [{'MouseNumber', 'Hour', 'SleepStage', 'PeakPower', 'PeakPowerFreq', 'Freq25Quartile', 'MedianFrequency', 'Freq75Quartile', 'Freq95Quartile', 'AUC', 'TotalPower'}];
PSD_data = [];
% Loop through each hour
for uHour = uniqueHours'
    
    % Find all entries for this hour
    hourEntries = updated_mice_data_hours([updated_mice_data_hours{:, 2}] == uHour, :);

    % Loop through each mouse for the current hour
    for uMouseNumber = uniqueMouseNumbers'
        
        % Extract fs for the current mouse using its identifier
        fs_varName = sprintf('signal_fs_%d', uMouseNumber);
        fs = eval(fs_varName); % Assuming fs is defined in the workspace
        
        combinedPSDData = struct(); % Structure to hold combined PSD data for each sleep stage

        % Loop through each sleep stage for the current mouse and hour
        for uSleepStage = sleepStages
            sleepStage = uSleepStage{1}(1:end-8); % Removing '_periods'
            stageEntries = hourEntries(strcmp(hourEntries(:,3), sleepStage), :);

            weightedPSD = [];
            freqs = [];
            totalDataPoints = 0;

            % Process each sleep bout within the stage
            for entry = stageEntries'
                secSignalData = entry{5};
                deltaSignalData = entry{7};

                % Process each signal segment to calculate PSD
                [detrendedSignal, segmentPSD, freqs, segmentDataPoints] = processSignalSegment(secSignalData, deltaSignalData, fs, max_freq, sample_pr_sec);

                % figure
                % set(gcf, 'Position',  [100, 300, 1500, 250])
                % titleStr = sprintf('Sleep Stage: %s, Mouse: %d', sleepStage, uMouseNumber);
                % sgtitle(titleStr); 
                % a = subplot(1,2,1);
                %     %a.Position = [0.1300 0.1100 0.6200 0.8150];
                %     plot(secSignalData,deltaSignalData);
                %     hold on
                %     plot(secSignalData,detrendedSignal);
                %     legend({'raw','fitted'})
                %     hold off
                % b = subplot(1,2,2);
                %     %b.Position = [0.8140 0.1100 0.1533 0.8150];
                %     plot(freqs,segmentPSD);

                if isempty(weightedPSD)
                    weightedPSD = segmentPSD * segmentDataPoints;
                else
                    weightedPSD = weightedPSD + segmentPSD * segmentDataPoints;
                end
                totalDataPoints = totalDataPoints + segmentDataPoints;
            end

            if totalDataPoints > 0
                % Calculate average PSD for this stage
                avgPSD = weightedPSD / totalDataPoints;
                PSD_data = [PSD_data; [uMouseNumber, uHour, sleepStage, {eval(freqs)}, {eval(newDeltaName)}]];

                % Calculate additional metrics from avgPSD and freqs
                [metrics] = calculatePSDMetrics(avgPSD, freqs);

                % Append the calculated metrics for this mouse, hour, and sleep stage to PSD_NE_table_new
                PSD_NE_table_new = [PSD_NE_table_new; {uMouseNumber, uHour, sleepStage, metrics.peakPower, metrics.peakPowerFreq, metrics.Freq25Quartile, metrics.MedianFrequency, metrics.Freq75Quartile, metrics.Freq95Quartile, metrics.AUC, metrics.totalPower}];
            end
        end
    end
end
