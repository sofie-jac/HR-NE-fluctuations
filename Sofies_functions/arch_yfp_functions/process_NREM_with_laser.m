function RR_data_NREM_table = process_NREM_with_laser(suffixes)

% List of suffixes for each animal

% Initialize the cell array to store results
RR_data_NREM = {};

% Loop through each suffix
for s = 1:length(suffixes)
    suffix = suffixes{s};
    suffix_str = suffix; % Store the suffix without initial underscore

    % Construct variable names with the current suffix
    NREMinclMA_periods_name = ['NREMinclMA_periods_', suffix];
    RR_name = ['RR_', suffix];
    RR_time_name = ['RR_time_', suffix];
    laser_periods_name = ['laser_periods_', suffix];

    % Check if the variables exist in the environment
    if evalin('base', ['exist(''' NREMinclMA_periods_name ''', ''var'')']) && ...
       evalin('base', ['exist(''' RR_name ''', ''var'')']) && ...
       evalin('base', ['exist(''' RR_time_name ''', ''var'')']) && ...
       evalin('base', ['exist(''' laser_periods_name ''', ''var'')'])
   
        % Retrieve the variables from the workspace
        NREMinclMA_periods = evalin('base', NREMinclMA_periods_name);
        RR = evalin('base', RR_name);
        RR_time = evalin('base', RR_time_name);
        laser_periods = evalin('base', laser_periods_name);

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

                    % Find indices in RR_time corresponding to the current segment
                    periodIndices = find(RR_time >= segment_start & RR_time < segment_end);
                    RR_values = RR(periodIndices);

                    % Store the segment with laser off
                    if ~isempty(periodIndices)
                        RR_data_NREM{end+1, 1} = suffix_str; % Store suffix without initial underscore
                        RR_data_NREM{end, 2} = RR_values;    % Store the extracted RR values
                        RR_data_NREM{end, 3} = 'off';        % Store the laser status
                        RR_data_NREM{end, 4} = length(RR_values)/64;
                    end

                    % Move to the next segment starting from laser_on
                    segment_start = laser_on;
                end

                % Handle the segment during laser on
                if segment_start >= laser_on && segment_start < laser_off
                    segment_end = min(laser_off, endTime);

                    % Find indices in RR_time corresponding to the current segment
                    periodIndices = find(RR_time >= segment_start & RR_time <= segment_end);
                    RR_values = RR(periodIndices);

                    % Store the segment with laser on
                    if ~isempty(periodIndices)
                        RR_data_NREM{end+1, 1} = suffix_str; % Store suffix without initial underscore
                        RR_data_NREM{end, 2} = RR_values;    % Store the extracted RR values
                        RR_data_NREM{end, 3} = 'on';         % Store the laser status
                        RR_data_NREM{end, 4} = length(RR_values)/64; 

                    end

                    % Move to the next segment starting from 10 seconds after laser_off
                    segment_start = laser_off + 10;
                    laser_on_found = true; % Laser on period found within this NREM period
                end
            end

            % Handle the last segment if it extends beyond the last laser period
            if segment_start < endTime
                % Find indices in RR_time corresponding to the current segment
                periodIndices = find(RR_time >= segment_start & RR_time <= endTime);
                RR_values = RR(periodIndices);

                % Store the segment with laser off (if the last laser period has ended)
                if ~isempty(periodIndices)
                    RR_data_NREM{end+1, 1} = suffix_str; % Store suffix without initial underscore
                    RR_data_NREM{end, 2} = RR_values;    % Store the extracted RR values
                    RR_data_NREM{end, 3} = 'off';        % Store the laser status
                    RR_data_NREM{end, 4} = length(RR_values)/64; 
                end
            end
            
            % Handle the case where no laser on period was found within the NREM period
            if ~laser_on_found
                % Find indices in RR_time corresponding to the entire NREM period
                periodIndices = find(RR_time >= startTime & RR_time <= endTime);
                RR_values = RR(periodIndices);

                % Store the entire period with laser off
                if ~isempty(periodIndices)
                    RR_data_NREM{end+1, 1} = suffix_str; % Store suffix without initial underscore
                    RR_data_NREM{end, 2} = RR_values;    % Store the extracted RR values
                    RR_data_NREM{end, 3} = 'off';        % Store the laser status
                    RR_data_NREM{end, 4} = length(RR_values)/64; 
                end
            end
        end
    else
        warning('Variables %s, %s, %s, and/or %s do not exist in the workspace.', ...
            NREMinclMA_periods_name, RR_name, RR_time_name, laser_periods_name);
    end
end

% Convert the cell array to a table for better visualization (optional)
RR_data_NREM_table = cell2table(RR_data_NREM, 'VariableNames', {'MouseID', 'RR_Values', 'Laser', 'Length_of_Period'});

% Clear temporary variables
clear suffixes s suffix suffix_str NREMinclMA_periods_name RR_name RR_time_name laser_periods_name NREMinclMA_periods RR RR_time laser_periods i j startTime endTime periodIndices RR_values RR_times laser_status segment_start segment_end;

end