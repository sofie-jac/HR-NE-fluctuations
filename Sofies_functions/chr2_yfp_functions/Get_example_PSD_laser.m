function [RR_values, PSD_values] = Get_example_PSD_laser()
    sampling_hz = 0.002;
    fs = 64;
    dataDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\Figure_4_data';

    % Define specific bouts to extract for each laser level
    specific_bouts = [1, 1, 2, 3, 19];
    
    % Initialize cell arrays to store RR values and PSD values
    RR_values_laser = cell(1, 5);  % To store bout data for each laser level
    PSD_values_laser = cell(1, 5);  % To store pxx values for each laser level

    % Process only for suffix '480'
    suffix = '480';

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

        % Extract the specific bout for the current laser level
        bout_index = specific_bouts(laser_level);
        if bout_index > size(RR_values, 1)
            disp(['Bout index ', num2str(bout_index), ' exceeds the available bouts for laser level ', num2str(laser_level)]);
            continue;
        end

        bout_data = RR_values(bout_index, :);

        % Remove the first and last 30 seconds (1920 samples each)
        if length(bout_data) > 3840 % Ensure data is long enough
            bout_data = bout_data(1921:end-1920);
        else
            disp('Bout data is too short to trim 30 seconds off both ends.');
            continue;
        end

        % Detrend (and center around 0)
        [p, s, mu] = polyfit((1:numel(bout_data))', bout_data, 5);
        f_y = polyval(p, (1:numel(bout_data))', [], mu);
        detrend_data = bout_data - mean(bout_data); % Detrend data

        % Calculate PSD
        [pxx, f] = pwelch(detrend_data, [], [], [0:sampling_hz:3], fs); 

        % Store the RR values and PSD values for the current laser level
        RR_values_laser{laser_level} = bout_data';
        PSD_values_laser{laser_level} = pxx(:); % Ensure PSD values are column vectors

        % Plot the example traces for each laser level
        figure;
        sgtitle(sprintf(' Not detrended - Laser Level %d, Suffix %s, Bout %d', laser_level, suffix, bout_index));

        % Left subplot for raw RR values
        subplot(1, 2, 1);
        time_axis = linspace(-30, 30, length(detrend_data)); % Time axis from -30 to 30 seconds
        plot(time_axis, detrend_data);
        xline(0, '--');
        xlabel('Time (s)');
        ylabel('RR Values');

        % Right subplot for PSD
        subplot(1, 2, 2);
        plot(f, pxx);
        xlabel('Frequency (Hz)');
        ylabel('Power Spectral Density');
    end

    % Prepare the output tables
    time_axis = linspace(-30, 30, length(RR_values_laser{1}))'; % Time axis for RR_values table

    % Create the RR_values table
    RR_values = table(time_axis, RR_values_laser{1}, RR_values_laser{2}, RR_values_laser{3}, RR_values_laser{4}, RR_values_laser{5}, ...
        'VariableNames', {'Time', 'Laser_1', 'Laser_2', 'Laser_3', 'Laser_4', 'Laser_5'});

    % Convert PSD values to column vectors
    f_col = f(:); % Ensure frequency values are column vectors

    % Create the PSD_values table
    PSD_values = table(f_col, PSD_values_laser{1}, PSD_values_laser{2}, PSD_values_laser{3}, PSD_values_laser{4}, PSD_values_laser{5}, ...
        'VariableNames', {'Frequency', 'Laser_1', 'Laser_2', 'Laser_3', 'Laser_4', 'Laser_5'});
end