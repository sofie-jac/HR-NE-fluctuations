function NE_data_NREM_table = process_NREM_with_laser_NE(suffixes)

% List of suffixes for each animal

% Initialize the cell array to store results
NE_data_NREM = {};

% Loop through each suffix
for s = 1:length(suffixes)
    suffix = suffixes{s};
    suffix_str = suffix; % Store the suffix without initial underscore

    % Construct variable names with the current suffix
    NREMinclMA_periods_name = ['NREMinclMA_periods_', suffix];
    NE_name = ['delta465_filt_2_', suffix];
    NE_time_name = ['sec_signal_2_', suffix];
    laser_periods_name = ['laser_periods_', suffix];
    fs_name = ['signal_fs_', suffix];

    % Check if the variables exist in the environment
    if evalin('base', ['exist(''' NREMinclMA_periods_name ''', ''var'')']) && ...
       evalin('base', ['exist(''' NE_name ''', ''var'')']) && ...
       evalin('base', ['exist(''' NE_time_name ''', ''var'')']) && ...
       evalin('base', ['exist(''' laser_periods_name ''', ''var'')'])
       evalin('base', ['exist(''' fs_name ''', ''var'')'])

        % Retrieve the variables from the workspace
        NREMinclMA_periods = evalin('base', NREMinclMA_periods_name);
        NE = evalin('base', NE_name);
        NE_time = evalin('base', NE_time_name);
        laser_periods = evalin('base', laser_periods_name);
        fs = evalin('base', fs_name);

        % Loop through each period in NREMinclMA_periods
        for i = 1:size(NREMinclMA_periods, 1)
            startTime = NREMinclMA_periods(i, 1);
            endTime = NREMinclMA_periods(i, 2);

            % Find segments within the NREMinclMA period based on laser on/off periods
            segment_start = startTime;
            laser_on_found = false; % Flag to check if laser on period is found within this NREM period
            for j = 1:size(laser_periods, 1)
                laser_on = laser_periods(j, 1);
                laser_off = laser_periods(j, 2);

                % Handle the segment before the laser turns on
                if segment_start < laser_on && endTime > laser_on
                    segment_end = min(laser_on, endTime);

                    % Find indices in NE_time coNEesponding to the current segment
                    periodIndices = find(NE_time >= segment_start & NE_time < segment_end);
                    NE_values = NE(periodIndices);

                    % Store the segment with laser off
                    if ~isempty(periodIndices)
                        NE_data_NREM{end+1, 1} = suffix_str; % Store suffix without initial underscore
                        NE_data_NREM{end, 2} = NE_values;    % Store the extracted NE values
                        NE_data_NREM{end, 3} = 'off';        % Store the laser status
                        NE_data_NREM{end, 4} = length(NE_values)/fs;
                    end

                    % Move to the next segment starting from laser_on
                    segment_start = laser_on;
                end

                % Handle the segment during laser on
                if segment_start >= laser_on && segment_start < laser_off
                    segment_end = min(laser_off, endTime);

                    % Find indices in NE_time corresponding to the current segment
                    periodIndices = find(NE_time >= segment_start & NE_time <= segment_end);
                    NE_values = NE(periodIndices);

                    % Store the segment with laser on
                    if ~isempty(periodIndices)
                        NE_data_NREM{end+1, 1} = suffix_str; % Store suffix without initial underscore
                        NE_data_NREM{end, 2} = NE_values;    % Store the extracted NE values
                        NE_data_NREM{end, 3} = 'on';         % Store the laser status
                        NE_data_NREM{end, 4} = length(NE_values)/fs; 

                    end

                    % Move to the next segment starting from 10 seconds after laser_off
                    segment_start = laser_off + 10;
                    laser_on_found = true; % Laser on period found within this NREM period
                end
            end

            % Handle the last segment if it extends beyond the last laser period
            if segment_start < endTime
                % Find indices in NE_time corresponding to the current segment
                periodIndices = find(NE_time >= segment_start & NE_time <= endTime);
                NE_values = NE(periodIndices);

                % Store the segment with laser off (if the last laser period has ended)
                if ~isempty(periodIndices)
                    NE_data_NREM{end+1, 1} = suffix_str; % Store suffix without initial underscore
                    NE_data_NREM{end, 2} = NE_values;    % Store the extracted NE values
                    NE_data_NREM{end, 3} = 'off';        % Store the laser status
                    NE_data_NREM{end, 4} = length(NE_values)/fs; 
                end
            end
            
            % Handle the case where no laser on period was found within the NREM period
            if ~laser_on_found
                % Find indices in NE_time corresponding to the entire NREM period
                periodIndices = find(NE_time >= startTime & NE_time <= endTime);
                NE_values = NE(periodIndices);

                % Store the entire period with laser off
                if ~isempty(periodIndices)
                    NE_data_NREM{end+1, 1} = suffix_str; % Store suffix without initial underscore
                    NE_data_NREM{end, 2} = NE_values;    % Store the extracted NE values
                    NE_data_NREM{end, 3} = 'off';        % Store the laser status
                    NE_data_NREM{end, 4} = length(NE_values)/64; 
                end
            end
        end
    else
        warning('Variables %s, %s, %s, and/or %s do not exist in the workspace.', ...
            NREMinclMA_periods_name, NE_name, NE_time_name, laser_periods_name);
    end
end

% Convert the cell array to a table for better visualization (optional)
NE_data_NREM_table = cell2table(NE_data_NREM, 'VariableNames', {'MouseID', 'NE_Values', 'Laser', 'Length_of_Period'});

% Clear temporary variables
clear suffixes s suffix suffix_str NREMinclMA_periods_name NE_name NE_time_name laser_periods_name NREMinclMA_periods NE NE_time laser_periods i j startTime endTime periodIndices NE_values NE_times laser_status segment_start segment_end;

end