function [PXX_group, f, PXX_bouts] = process_group_RR_eventbased(group, group_name, PXX_group)
    sampling_hz = 0.002;
    fs = 64;
    dataDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\arch_yfp\Copy_of_figure_3_data';

    % Initialize array to store PSD values across subjects
    PSD_subjects = [];
    bouts_count = 0;
    f = [];  % Initialize f as an empty array

    for s = 1:length(group)
        suffix = group{s};

        % Load the RR values
        variable_name = sprintf('RR_laser_on_NREM_%s', suffix);
        if evalin('base', ['exist(''', variable_name, ''', ''var'')'])
            RR_values = evalin('base', variable_name);
        else
            filename = fullfile(dataDirectory, sprintf('%s.mat', variable_name));
            if exist(filename, 'file')
                RR_data = load(filename);
                RR_values = RR_data.(variable_name);
            else
                disp(['File not found: ', filename]);
                continue;
            end
        end

        % Loop through each bout and calculate the PSD
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

        % Accumulate PSD values for each bout for the current subject
        if ~isempty(PXX_bouts)
            PSD_subjects = [PSD_subjects; PXX_bouts];
            bouts_count = bouts_count + size(PXX_bouts, 1);
        end
    end

    % Calculate mean and SEM across all subjects
    if ~isempty(PSD_subjects)
        mean_PXX = mean(PSD_subjects, 1);
        SEM_PXX = std(PSD_subjects, 0, 1) / sqrt(bouts_count);
        PXX_group{1, 1} = mean_PXX;
        PXX_group{1, 2} = SEM_PXX;
    else
        % Assign empty arrays if no valid data was found
        PXX_group{1, 1} = [];
        PXX_group{1, 2} = [];
        f = linspace(0, 3, 100); % Provide a default f value with a fixed number of points
    end
end
