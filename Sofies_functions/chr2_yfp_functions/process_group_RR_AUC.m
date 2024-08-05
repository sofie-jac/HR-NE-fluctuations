function [AUC_table, PeakFreq_table, PeakPower_table] = process_group_RR_AUC(group, min_fs, max_fs)
    fs = 64;
    sampling_hz = 0.002;
    dataDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\Figure_4_data';

    % Initialize empty cell arrays to store the results
    AUC_results = {};
    PeakFreq_results = {};
    PeakPower_results = {};

    for s = 1:length(group)
        suffix = group{s};

        % Loop through each laser level
        for laser_level = 1:5
            variable_name = sprintf('RR_laser_%d_NREM_%s', laser_level, suffix);
            if evalin('base', ['exist(''', variable_name, ''', ''var'')'])
                RR_values = evalin('base', variable_name);
            else
                filename = fullfile(dataDirectory, sprintf('%s.mat', variable_name));
                if exist(filename, 'file')
                    RR_values = load(filename);
                    RR_values = RR_values.(variable_name);
                else
                    disp(['File not found: ', filename]);
                    continue;
                end
            end

            % Loop through each bout
            for i = 1:size(RR_values, 1)
                bout_data = RR_values(i, :);

                % Detrend (and center around 0)
                [p, s, mu] = polyfit((1:numel(bout_data))', bout_data, 5);
                f_y = polyval(p, (1:numel(bout_data))', [], mu);
                detrend_data = bout_data - f_y'; % Detrend data

                [pxx, f] = pwelch(detrend_data, [], [], [min_fs:sampling_hz:max_fs], fs); % Calculate PSD
                AUC = trapz(f, pxx); % Calculate area under the curve
                
                % Find the peak frequency and peak power
                [peakPower, peakIdx] = max(pxx);
                peakFrequency = f(peakIdx);

                % Store the AUC value, suffix, and laser level in the results cell array
                AUC_results{end+1, 1} = AUC;
                AUC_results{end, 2} = suffix;
                AUC_results{end, 3} = laser_level;

                % Store the peak frequency value, suffix, and laser level in the results cell array
                PeakFreq_results{end+1, 1} = peakFrequency;
                PeakFreq_results{end, 2} = suffix;
                PeakFreq_results{end, 3} = laser_level;

                % Store the peak power value, suffix, and laser level in the results cell array
                PeakPower_results{end+1, 1} = peakPower;
                PeakPower_results{end, 2} = suffix;
                PeakPower_results{end, 3} = laser_level;
            end
        end
    end

    % Convert the results cell arrays to tables
    AUC_table = cell2table(AUC_results, 'VariableNames', {'AUC', 'Suffix', 'LaserLevel'});
    PeakFreq_table = cell2table(PeakFreq_results, 'VariableNames', {'PeakFrequency', 'Suffix', 'LaserLevel'});
    PeakPower_table = cell2table(PeakPower_results, 'VariableNames', {'PeakPower', 'Suffix', 'LaserLevel'});
end
