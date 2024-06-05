function NREMinclMA_HRB_table = create_NREMinclMA_HRB_table(suffixes)

    % Initialize the cell array to store results
    NREMinclMA_HRB_data = {};

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
                period_start = NREMinclMA_periods(i, 1);
                period_end = NREMinclMA_periods(i, 2);
                period_length_minutes = (period_end - period_start) / 60; % Convert to minutes
                
                % Divide the period into segments based on laser periods
                segment_start = period_start;
                laser_on_found = false; % Flag to check if laser on period is found within this NREM period
                for j = 1:size(laser_periods, 1)
                    laser_on = laser_periods(j, 1);
                    laser_off = laser_periods(j, 2);

                    % Handle the segment before the laser turns on
                    if segment_start < laser_on && period_end > laser_on
                        segment_end = min(laser_on, period_end);

                        % Find HRB events in this segment
                        HRB_count = sum(HRB_time >= segment_start & HRB_time < segment_end);

                        % Store the segment with laser off
                        if HRB_count > 0
                            HRB_rate = HRB_count / ((segment_end - segment_start) / 60);
                            NREMinclMA_HRB_data{end+1, 1} = suffix;        % Store suffix
                            NREMinclMA_HRB_data{end, 2} = HRB_rate;        % Store HRB rate
                            NREMinclMA_HRB_data{end, 3} = 'off';           % Store laser status
                        end

                        % Move to the next segment starting from laser_on
                        segment_start = laser_on;
                    end

                    % Handle the segment during laser on
                    if segment_start >= laser_on && segment_start < laser_off
                        segment_end = min(laser_off, period_end);

                        % Find HRB events in this segment
                        HRB_count = sum(HRB_time >= segment_start & HRB_time <= segment_end);

                        % Store the segment with laser on
                        if HRB_count > 0
                            HRB_rate = HRB_count / ((segment_end - segment_start) / 60);
                            NREMinclMA_HRB_data{end+1, 1} = suffix;        % Store suffix
                            NREMinclMA_HRB_data{end, 2} = HRB_rate;        % Store HRB rate
                            NREMinclMA_HRB_data{end, 3} = 'on';            % Store laser status
                        end

                        % Move to the next segment starting from laser_off
                        segment_start = laser_off;
                        laser_on_found = true; % Laser on period found within this NREM period
                    end
                end

                % Handle the last segment if it extends beyond the last laser period
                if segment_start < period_end
                    % Find HRB events in this segment
                    HRB_count = sum(HRB_time >= segment_start & HRB_time <= period_end);

                    % Store the segment with laser off (if the last laser period has ended)
                    if HRB_count > 0
                        HRB_rate = HRB_count / ((period_end - segment_start) / 60);
                        NREMinclMA_HRB_data{end+1, 1} = suffix;        % Store suffix
                        NREMinclMA_HRB_data{end, 2} = HRB_rate;        % Store HRB rate
                        NREMinclMA_HRB_data{end, 3} = 'off';           % Store laser status
                    end
                end
                
                % Handle the case where no laser on period was found within the NREM period
                if ~laser_on_found
                    % Find HRB events in the entire NREM period
                    HRB_count = sum(HRB_time >= period_start & HRB_time <= period_end);

                    % Store the entire period with laser off
                    if HRB_count > 0
                        HRB_rate = HRB_count / ((period_end - period_start) / 60);
                        NREMinclMA_HRB_data{end+1, 1} = suffix;        % Store suffix
                        NREMinclMA_HRB_data{end, 2} = HRB_rate;        % Store HRB rate
                        NREMinclMA_HRB_data{end, 3} = 'off';           % Store laser status
                    end
                end
            end
        else
            warning('Variables %s, %s, %s, and/or %s do not exist in the workspace.', ...
                HRB_name, HRB_time_name, NREMinclMA_periods_name, laser_periods_name);
        end
    end

    % Convert the cell array to a table for better visualization
    NREMinclMA_HRB_table = cell2table(NREMinclMA_HRB_data, 'VariableNames', {'Suffix', 'HRB_Rate', 'Laser_Status'});

    % Clear temporary variables
    clear suffixes s suffix HRB_name HRB_time_name NREMinclMA_periods_name laser_periods_name HRB HRB_time NREMinclMA_periods laser_periods NREMinclMA_HRB_data period_start period_end segment_start segment_end HRB_count HRB_rate laser_on_found;
end