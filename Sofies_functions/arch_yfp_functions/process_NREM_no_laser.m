function RR_data_NREM_table = process_NREM_no_laser(suffixes)

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

    % Check if the variables exist in the environment
    if evalin('base', ['exist(''' NREMinclMA_periods_name ''', ''var'')']) && ...
       evalin('base', ['exist(''' RR_name ''', ''var'')']) && ...
       evalin('base', ['exist(''' RR_time_name ''', ''var'')'])
   
        % Retrieve the variables from the workspace
        NREMinclMA_periods = evalin('base', NREMinclMA_periods_name);
        RR = evalin('base', RR_name);
        RR_time = evalin('base', RR_time_name);

        % Loop through each period in NREMinclMA_periods
        for i = 1:size(NREMinclMA_periods, 1)
            startTime = NREMinclMA_periods(i, 1);
            endTime = NREMinclMA_periods(i, 2);

            % Find indices in RR_time corresponding to the current NREM period
            periodIndices = find(RR_time >= startTime & RR_time <= endTime);
            RR_values = RR(periodIndices);

            % Store the NREM period data
            if ~isempty(periodIndices)
                RR_data_NREM{end+1, 1} = suffix_str; % Store suffix without initial underscore
                RR_data_NREM{end, 2} = RR_values;    % Store the extracted RR values
                RR_data_NREM{end, 3} = length(RR_values)/64; % Store the length of the period
            end
        end
    else
        warning('Variables %s, %s, and/or %s do not exist in the workspace.', ...
            NREMinclMA_periods_name, RR_name, RR_time_name);
    end
end

% Convert the cell array to a table for better visualization (optional)
RR_data_NREM_table = cell2table(RR_data_NREM, 'VariableNames', {'MouseID', 'RR_Values', 'Length_of_Period'});

% Clear temporary variables
clear suffixes s suffix suffix_str NREMinclMA_periods_name RR_name RR_time_name NREMinclMA_periods RR RR_time i startTime endTime periodIndices RR_values;

end
