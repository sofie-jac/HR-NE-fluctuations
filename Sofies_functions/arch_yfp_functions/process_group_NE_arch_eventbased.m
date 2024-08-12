function [PXX_group, f] = process_group_NE_arch_eventbased(group, group_name, PXX_group)
    sampling_hz = 0.0002;
    dataDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\arch_yfp\Copy_of_figure_3_data';
    fsDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\arch_yfp\Traces';

    % Initialize arrays to store PSD values and count bouts
    PSD_subjects = [];
    bouts_count = 0;
    f = [];  % Initialize f as an empty array

    for s = 1:length(group)
        suffix = group{s};

        % Load the sampling frequency (fs)
        variable_name_fs = sprintf('signal_fs_%s', suffix);
        if evalin('base', ['exist(''', variable_name_fs, ''', ''var'')'])
            fs = evalin('base', variable_name_fs);
        else
            filename_fs = fullfile(fsDirectory, sprintf('%s.mat', variable_name_fs));
            if exist(filename_fs, 'file')
                fs_data = load(filename_fs);
                fs = fs_data.(variable_name_fs);
            else
                disp(['File not found: ', filename_fs]);
                continue;
            end
        end

        % Load the NE values
        variable_name = sprintf('NE_laser_on_NREM_%s', suffix);
        if evalin('base', ['exist(''', variable_name, ''', ''var'')'])
            NE_values = evalin('base', variable_name);
        else
            filename = fullfile(dataDirectory, sprintf('%s.mat', variable_name));
            if exist(filename, 'file')
                NE_data = load(filename);
                NE_values = NE_data.(variable_name);
            else
                disp(['File not found: ', filename]);
                continue;
            end
        end

        % Loop through each bout and calculate the PSD
        PXX_bouts = [];
        for i = 1:size(NE_values, 1)
            bout_data = NE_values(i, :);

            % Detrend (and center around 0)
            [p, s, mu] = polyfit((1:numel(bout_data))', bout_data, 5);
            f_y = polyval(p, (1:numel(bout_data))', [], mu);
            detrend_data = bout_data - f_y'; % Detrend data

            [pxx, f] = pwelch(detrend_data, [], [], [0:sampling_hz:0.1], fs); % Calculate PSD
            PXX_bouts = [PXX_bouts; pxx];
        end

        % Accumulate PSD values for each bout for the current subject
        if ~isempty(PXX_bouts)
            PSD_subjects = [PSD_subjects; mean(PXX_bouts, 1)];
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
        f = linspace(0, 0.1, 100); % Provide a default f value with a fixed number of points
    end
end
