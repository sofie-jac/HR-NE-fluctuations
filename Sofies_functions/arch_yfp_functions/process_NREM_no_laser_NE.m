function NE_data_NREM_table = process_NREM_no_laser_NE(suffixes)

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
    fs_name = ['signal_fs_', suffix];

    % Check if the variables exist in the environment
    if evalin('base', ['exist(''' NREMinclMA_periods_name ''', ''var'')']) && ...
       evalin('base', ['exist(''' NE_name ''', ''var'')']) && ...
       evalin('base', ['exist(''' NE_time_name ''', ''var'')']) && ...
       evalin('base', ['exist(''' fs_name ''', ''var'')'])

        % Retrieve the variables from the workspace
        NREMinclMA_periods = evalin('base', NREMinclMA_periods_name);
        NE = evalin('base', NE_name);
        NE_time = evalin('base', NE_time_name);
        fs = evalin('base', fs_name);

        % Loop through each period in NREMinclMA_periods
        for i = 1:size(NREMinclMA_periods, 1)
            startTime = NREMinclMA_periods(i, 1);
            endTime = NREMinclMA_periods(i, 2);

            % Find indices in NE_time corresponding to the current NREM period
            periodIndices = find(NE_time >= startTime & NE_time <= endTime);
            NE_values = NE(periodIndices);

            % Store the NREM period data
            if ~isempty(periodIndices)
                NE_data_NREM{end+1, 1} = suffix_str; % Store suffix without initial underscore
                NE_data_NREM{end, 2} = NE_values;    % Store the extracted NE values
                NE_data_NREM{end, 3} = length(NE_values)/fs; % Store the length of the period
            end
        end
    else
        warning('Variables %s, %s, %s, and/or %s do not exist in the workspace.', ...
            NREMinclMA_periods_name, NE_name, NE_time_name, fs_name);
    end
end

% Convert the cell array to a table for better visualization (optional)
NE_data_NREM_table = cell2table(NE_data_NREM, 'VariableNames', {'MouseID', 'NE_Values', 'Length_of_Period'});

% Clear temporary variables
clear suffixes s suffix suffix_str NREMinclMA_periods_name NE_name NE_time_name NREMinclMA_periods NE NE_time fs i startTime endTime periodIndices NE_values;

end
