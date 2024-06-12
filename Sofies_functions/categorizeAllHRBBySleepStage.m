function categorizeAllHRBBySleepStage(suffixes)
    for s = 1:length(suffixes)
        suffix = suffixes{s};

        % Construct variable names with the current suffix
        HRB_times_name = ['HRB_time_', suffix];
        HRB_name = ['HRB_', suffix];
        MA_binary_name = ['MA_binary_vector_', suffix];
        NREMexclMA_binary_name = ['sws_binary_vector_', suffix];

        % Check if the variables exist in the environment
        if evalin('base', ['exist(''' HRB_times_name ''', ''var'')']) && ...
           evalin('base', ['exist(''' HRB_name ''', ''var'')']) && ...
           evalin('base', ['exist(''' MA_binary_name ''', ''var'')']) && ...
           evalin('base', ['exist(''' NREMexclMA_binary_name ''', ''var'')'])
       
            % Retrieve the variables from the workspace
            HRB_times_no_troughs = evalin('base', HRB_times_name);
            HRB_values = evalin('base', HRB_name);
            MA_binary = evalin('base', MA_binary_name);
            NREMexclMA_binary = evalin('base', NREMexclMA_binary_name);
            
            % Initialize empty arrays to hold HRB times and values for each sleep stage
            HRB_NREM = [];
            HRB_NREM_values = [];
            HRB_MA = [];
            HRB_MA_values = [];

            % Iterate through each HRB time
            for i = 1:length(HRB_times_no_troughs)
                HRB_time = HRB_times_no_troughs(i);
                rounded_HRB_time = round(HRB_time);

                % Check if HRB_time falls within NREMexclMA_binary and is not within 5 seconds of the end
                if rounded_HRB_time > 0 && rounded_HRB_time <= length(NREMexclMA_binary) && ...
                   NREMexclMA_binary(rounded_HRB_time) == 1

                    % Find the end of the NREM period
                    end_NREM = rounded_HRB_time;
                    while end_NREM <= length(NREMexclMA_binary) && NREMexclMA_binary(end_NREM) == 1
                        end_NREM = end_NREM + 1;
                    end

                    % Check if HRB_time is not within 5 seconds of the end of the NREM period
                    if end_NREM - rounded_HRB_time > 5
                        HRB_NREM = [HRB_NREM; HRB_time];
                        HRB_NREM_values = [HRB_NREM_values; HRB_values(i)];
                    end
                end

                % Check if HRB_time falls within or 5 seconds before/after MA_binary
                for j = -5:5
                    if rounded_HRB_time+j > 0 && rounded_HRB_time+j <= length(MA_binary) && MA_binary(rounded_HRB_time+j) == 1
                        HRB_MA = [HRB_MA; HRB_time];
                        HRB_MA_values = [HRB_MA_values; HRB_values(i)];
                        break;
                    end
                end
            end

            % Assign the results to the workspace with the appropriate suffix
            assignin('base', ['HRB_time_NREM_', suffix], HRB_NREM);
            assignin('base', ['HRB_value_NREM_', suffix], HRB_NREM_values);
            assignin('base', ['HRB_time_MA_', suffix], HRB_MA);
            assignin('base', ['HRB_value_MA_', suffix], HRB_MA_values);

            % Clear unnecessary variables
            clear HRB_times_no_troughs HRB_values MA_binary NREMexclMA_binary HRB_NREM HRB_NREM_values HRB_MA HRB_MA_values;
        else
            warning('Variables %s, %s, %s, and/or %s do not exist in the workspace.', ...
                HRB_times_name, HRB_name, MA_binary_name, NREMexclMA_binary_name);
        end
    end
    clear suffixes s suffix HRB_times_name HRB_name MA_binary_name NREMexclMA_binary_name;
end
