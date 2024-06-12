function RR_table = extract_RR_intervals(o, epoc_end, saveDirectory)
    % Initialize the cell array to store results
    RR_data = {};
    fs = 64; % Sampling frequency

    % Loop over each subject
    for idx = 1:length(o)
        uniqueId = o{idx};  % Get the current subject ID
        
        % Load the RR_collector for this subject and event type
        RR_variable_name = sprintf('RR_laser_on_NREM_%s', uniqueId);
        loaded_data = load(fullfile(saveDirectory, [RR_variable_name '.mat']));
        RR_collector = loaded_data.(RR_variable_name);

        % Determine the number of events for this subject and event type
        num_events = size(RR_collector, 1);
        
        % Loop through each event and extract RR values
        for i = 1:num_events
            RR_values = RR_collector(i, :);
            
            % Extract RR value at time 0 and at +20 seconds
            % Convert time to indices
            onset_idx = epoc_end * fs; % Index for time 0
            during_idx = (epoc_end + 20) * fs; % Index for +20 seconds

            if onset_idx <= length(RR_values) && during_idx <= length(RR_values)
                RR_laser_onset = RR_values(onset_idx);
                RR_during_laser = RR_values(during_idx);

                % Store the information in the cell array
                RR_data{end+1, 1} = uniqueId;         % Store suffix
                RR_data{end, 2} = RR_laser_onset;     % Store RR value at time 0
                RR_data{end, 3} = RR_during_laser;    % Store RR value at +20 seconds
            end
        end
    end

    % Convert the cell array to a table for better visualization
    RR_table = cell2table(RR_data, 'VariableNames', {'Suffix', 'RR_laser_onset', 'RR_during_laser'});

    % Clear temporary variables
    clear o epoc_end saveDirectory idx uniqueId RR_variable_name loaded_data RR_collector num_events i RR_values RR_laser_onset RR_during_laser;
end
