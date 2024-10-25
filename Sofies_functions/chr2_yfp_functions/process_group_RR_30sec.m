function [PXX_group, f, PXX_bouts, RR_table] = process_group_RR_30sec(group, group_name, PXX_group)
    sampling_hz = 0.002;
    fs = 64;
    dataDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\Figure_4_data';

    % Initialize cell arrays to store PSD values for each laser level
    PSD_subjects = cell(5, 1);
    bouts_count = zeros(5, 1);

    % Initialize cell array to store RR values
    RR_values_laser = cell(1, 5);  % Create a 1x5 cell array to hold data for each laser level

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
            PXX_bouts = [];
            for i = 1:size(RR_values, 1)
                bout_data = RR_values(i, :);

                % Remove the first and last 30 seconds (1920 samples each)
                if length(bout_data) > 3840 % Ensure data is long enough
                    bout_data = bout_data(1921:end-1920);
                else
                    disp('Bout data is too short to trim 30 seconds off both ends.');
                    continue;
                end

                [p, s, mu] = polyfit((1:numel(bout_data))', bout_data, 5);
                f_y = polyval(p, (1:numel(bout_data))', [], mu);
                detrend_data1 = bout_data - mean(bout_data); % Detrend data

                % Using wavelet decomposition
fs = 64; % Sampling frequency
level = 9; % Decomposition level
waveletName = 'db4'; % Daubechies 4 wavelet

% Perform wavelet decomposition
[c, l] = wavedec(bout_data, level, waveletName);

% Zero out the approximation coefficients at Level 9
cA9 = zeros(1, l(1));

% Reconstruct the signal without the approximation at Level 9
detrend_data2 = waverec([cA9, c(l(1)+1:end)], l, waveletName);

                [pxx, f] = pwelch(detrend_data1, [], [], [0:sampling_hz:3], fs); % Calculate PSD
                PXX_bouts = [PXX_bouts; pxx];
                               % Plot the first 3 bouts
                % if i <= 20 & suffix == '480' & laser_level == 5
                %     figure;
                %     sgtitle(sprintf('Laser Level %d, Suffix %s, Bout %d', laser_level, suffix, i));
                % 
                %     % Left subplot for raw RR values
                %     subplot(1, 2, 1);
                %     time_axis = linspace(-30, 30, length(bout_data)); % Time axis from -30 to 30 seconds
                %     plot(time_axis, bout_data);
                %     xline(0, '--');
                %     xlabel('Time (s)');
                %     ylabel('RR Values');
                % 
                %     % Right subplot for PSD
                %     subplot(1, 2, 2);
                %     plot(f, pxx);
                %     xlabel('Frequency (Hz)');
                %     ylabel('Power Spectral Density');
                % end

                % Store the raw RR values for the current laser level
                RR_values_laser{laser_level} = [RR_values_laser{laser_level}; bout_data']; % Append data to the correct laser level cell
            end

            % Collect PSD values for each bout for the current subject and laser level
            if ~isempty(PXX_bouts)
                if isempty(PSD_subjects{laser_level})
                    PSD_subjects{laser_level} = PXX_bouts;
                else
                    PSD_subjects{laser_level} = [PSD_subjects{laser_level}; PXX_bouts];
                end
                bouts_count(laser_level) = bouts_count(laser_level) + size(PXX_bouts, 1);
            end
        end
    end

    % Determine the maximum number of rows
    max_rows = max(cellfun(@numel, RR_values_laser));

    % Pad the columns with NaN to ensure equal length
    for laser_level = 1:5
        current_length = numel(RR_values_laser{laser_level});
        if current_length < max_rows
            RR_values_laser{laser_level}(end+1:max_rows, 1) = NaN;  % Fill with NaN to match the length
        end
    end

    % Convert the cell arrays for each laser level into a table
    RR_table = table(RR_values_laser{1}, RR_values_laser{2}, RR_values_laser{3}, RR_values_laser{4}, RR_values_laser{5}, ...
        'VariableNames', {'Laser_1', 'Laser_2', 'Laser_3', 'Laser_4', 'Laser_5'});

    % Calculate mean and SEM across all subjects for each laser level
    for laser_level = 1:5
        if ~isempty(PSD_subjects{laser_level})
            mean_PXX = mean(PSD_subjects{laser_level}, 1);
            SEM_PXX = std(PSD_subjects{laser_level}, 0, 1) / sqrt(bouts_count(laser_level));
            PXX_group{laser_level, 1} = mean_PXX;
            PXX_group{laser_level, 2} = SEM_PXX;
        end
    end
end
