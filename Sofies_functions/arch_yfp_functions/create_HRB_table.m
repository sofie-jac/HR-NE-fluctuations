function HRB_table = create_HRB_table(suffixes)

    % Initialize the cell array to store results
    HRB_data = {};

    % Loop through each suffix
    for s = 1:length(suffixes)
        suffix = suffixes{s};
        
        % Construct variable names with the current suffix
        HRB_name = ['HRB_', suffix];
        HRB_time_name = ['HRB_time_', suffix];
        NREMinclMA_periods_name = ['NREMinclMA_periods_', suffix];
        laser_periods_name = ['laser_periods_', suffix];

        % Check if the variables exist in the environment
        if evalin('base', ['exist(''' HRB_name ''', ''var'')']) && ...
           evalin('base', ['exist(''' HRB_time_name ''', ''var'')']) && ...
           evalin('base', ['exist(''' NREMinclMA_periods_name ''', ''var'')']) && ...
           evalin('base', ['exist(''' laser_periods_name ''', ''var'')'])
       
            % Retrieve the variables from the workspace
            HRB = evalin('base', HRB_name);
            HRB_time = evalin('base', HRB_time_name);
            NREMinclMA_periods = evalin('base', NREMinclMA_periods_name);
            laser_periods = evalin('base', laser_periods_name);

            % Loop through each NREMinclMA period
            for i = 1:size(NREMinclMA_periods, 1)
                startTime = NREMinclMA_periods(i, 1);
                endTime = NREMinclMA_periods(i, 2);

                % Find HRB observations within the NREMinclMA period
                HRB_indices = find(HRB_time >= startTime & HRB_time <= endTime);
                
                for idx = HRB_indices'
                    HRB_value = HRB(idx);
                    HRB_time_value = HRB_time(idx);

                    % Determine if the HRB observation is during laser on or off period
                    laser_status = 'off'; % Default to off
                    for j = 1:size(laser_periods, 1)
                        if HRB_time_value >= laser_periods(j, 1) && HRB_time_value <= laser_periods(j, 2)
                            laser_status = 'on';
                            break;
                        end
                    end

                    % Store the information in the cell array
                    HRB_data{end+1, 1} = suffix;         % Store suffix
                    HRB_data{end, 2} = HRB_value;        % Store HRB value
                    HRB_data{end, 3} = laser_status;     % Store laser status
                end
            end
        else
            warning('Variables %s, %s, %s, and/or %s do not exist in the workspace.', ...
                HRB_name, HRB_time_name, NREMinclMA_periods_name, laser_periods_name);
        end
    end

    % Convert the cell array to a table for better visualization
    HRB_table = cell2table(HRB_data, 'VariableNames', {'Suffix', 'HRB_Value', 'Laser_Status'});

    % Clear temporary variables
    clear suffixes s suffix HRB_name HRB_time_name NREMinclMA_periods_name laser_periods_name HRB HRB_time NREMinclMA_periods laser_periods HRB_data HRB_value HRB_time_value laser_status;
end
