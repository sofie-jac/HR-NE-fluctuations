function [PXX_group, f] = process_group_NE_30sec(group, group_name, PXX_group)
    PXX_yfp = cell(5, 2);
    yfp = {'584', '577', '512', '513'};
    sampling_hz = 0.0001;
    dataDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\Figure_4_data';
    fsDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\Traces';

    % Initialize cell arrays to store PSD values for each laser level
    PSD_subjects = cell(5, 1);
    bouts_count = zeros(5, 1);

    for s = 1:length(group)
        suffix = group{s};

        variable_name_fs = sprintf('signal_fs_%s', suffix);
        if evalin('base', ['exist(''', variable_name_fs, ''', ''var'')'])
            fs = evalin('base', variable_name_fs);
        else
            filename_NE = fullfile(fsDirectory, sprintf('%s.mat', variable_name_fs));
            if exist(filename_NE, 'file')
                fs = load(filename_NE);
                fs = fs.(variable_name_fs);
            else
                disp(['File not found: ', filename_NE]);
                continue;
            end
        end
        % Calculate the number of samples to trim (30 seconds from each end)
        samples_to_trim = round(30 * fs);

        % Loop through each laser level
        for laser_level = 1:5
            variable_name = sprintf('NE_laser_%d_NREM_%s', laser_level, suffix);
            if evalin('base', ['exist(''', variable_name, ''', ''var'')'])
                NE_values = evalin('base', variable_name);
            else
                filename = fullfile(dataDirectory, sprintf('%s.mat', variable_name));
                if exist(filename, 'file')
                    NE_values = load(filename);
                    NE_values = NE_values.(variable_name);
                else
                    disp(['File not found: ', filename]);
                    continue;
                end
            end

            % Loop through each bout
            PXX_bouts = [];
            for i = 1:size(NE_values, 1)
                bout_data = NE_values(i, :);

                % Remove the first and last 30 seconds (samples_to_trim each)
                if length(bout_data) > 2 * samples_to_trim % Ensure data is long enough
                    bout_data = bout_data(samples_to_trim + 1:end - samples_to_trim);
                else
                    disp('Bout data is too short to trim 30 seconds off both ends.');
                    continue;
                end

                % Detrend (and center around 0)
                [p, s, mu] = polyfit((1:numel(bout_data))', bout_data, 5);
                f_y = polyval(p, (1:numel(bout_data))', [], mu);
                detrend_data = bout_data - f_y'; % Detrend data

                [pxx, f] = pwelch(detrend_data, [], [], [0:sampling_hz:0.2], fs); % Calculate PSD
                PXX_bouts = [PXX_bouts; pxx];
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
