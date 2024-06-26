function AUC_table = extract_AUC_RR_intervals(o, epoc_end, saveDirectory)
    % Initialize the cell array to store results
    AUC_data = {};
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
        
        % Loop through each event and calculate AUC
        for i = 1:num_events
            RR_values = RR_collector(i, :);
            
            % Extract RR intervals between timepoint 0 and 30 seconds
            % Convert time to indices
            start_idx_pre = round((size(RR_collector, 2)/2) - (20*fs));
            end_idx_pre = round((size(RR_collector, 2)/2));
            RR_interval_pre = RR_values(start_idx_pre:end_idx_pre);

            start_idx_post =  round((size(RR_collector, 2)/2));
            end_idx_post = round((size(RR_collector, 2)/2) + (20*fs));
            RR_interval_post = RR_values(start_idx_post:end_idx_post);

            % Calculate the AUC using the trapezoidal rule
            AUC_pre = trapz(RR_interval_pre);
            AUC_post = trapz(RR_interval_post);

            % Store the information in the cell array
            AUC_data{end+1, 1} = uniqueId;  % Store suffix
            AUC_data{end, 2} = AUC_pre;     % Store AUC_pre value
            AUC_data{end, 3} = AUC_post;    % Store AUC_post value

        end
    end

    % Convert the cell array to a table for better visualization
    AUC_table = cell2table(AUC_data, 'VariableNames', {'Suffix', 'AUC_pre', 'AUC_post'});

    % Clear temporary variables
    clear o epoc_end saveDirectory idx uniqueId RR_variable_name loaded_data RR_collector num_events i RR_values RR_interval_pre RR_interval_post AUC_pre AUC_post;
end
