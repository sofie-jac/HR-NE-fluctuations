function [PXX_group, f, PXX_bouts] = process_group(group, group_name, PXX_group)
    sampling_hz = 0.002;
    fs = 64;
    dataDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\Figure_4_data';

    % Initialize cell arrays to store PSD values for each laser level
    PSD_subjects = cell(5, 1);
    bouts_count = zeros(5, 1);

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

                % Detrend (and center around 0)
                [p, s, mu] = polyfit((1:numel(bout_data))', bout_data, 5);
                f_y = polyval(p, (1:numel(bout_data))', [], mu);
                detrend_data = bout_data - f_y'; % Detrend data

                [pxx, f] = pwelch(detrend_data, [], [], [0:sampling_hz:3], fs); % Calculate PSD
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
