function RR_amplitude_table = extract_amplitude_fig_3(o, event_var, saveDirectory, times_matrix, arch, yfp)
    % Set default epoch start and end times
    epoc_start = 60;
    epoc_end = 60;
    
    % Initialize the cell array to store results
    RR_amplitude_data = {};
    
    % Loop over each event type
    for stage_idx = 1:length(event_var)
        event_type_name = event_var{stage_idx};  % Get the current event type name

        % Loop over each subject
        for idx = 1:length(o)
            uniqueId = o{idx};  % Get the current subject ID

            % Determine the group
            if ismember(uniqueId, arch)
                group = 'arch';
            elseif ismember(uniqueId, yfp)
                group = 'yfp';
            else
                warning('Subject %s not found in any group', uniqueId);
                continue;
            end

            % Load necessary data
            try
                RR_collector = load(fullfile(saveDirectory, sprintf('RR_%s_%s.mat', event_type_name, uniqueId)));
            catch
                warning('Data not found for %s_%s', event_type_name, uniqueId);
                continue;
            end

            % Define time vectors based on sampling frequencies
            time_vector_RR = linspace(-epoc_start, epoc_end, size(RR_collector.(['RR_' event_type_name '_' uniqueId]), 2));

            % Extract min/max values for each event and store in amplitude data
            for event_idx = 1:size(RR_collector.(['RR_' event_type_name '_' uniqueId]), 1)
                % Calculate RR min and max
                [RR_min, RR_max] = calculate_min_max(RR_collector.(['RR_' event_type_name '_' uniqueId])(event_idx, :), time_vector_RR, times_matrix.RR.min_range, times_matrix.RR.max_range);
                
                % Calculate the amplitude
                amplitude = RR_max - RR_min;
                
                % Store the information in the cell array
                RR_amplitude_data{end+1, 1} = uniqueId;     % Store subject ID
                RR_amplitude_data{end, 2} = group;        % Store group (arch or yfp)
                RR_amplitude_data{end, 3} = amplitude;        % Store amplitude value
            end
        end
    end

    % Convert the cell array to a table for better visualization
    RR_amplitude_table = cell2table(RR_amplitude_data, 'VariableNames', {'Subject', 'Group', 'Amplitude'});

    % Clear temporary variables
    clear o event_var saveDirectory times_matrix arch yfp;
end

function [min_value, max_value] = calculate_min_max(data, time_vector, min_range, max_range)
    min_indices = time_vector >= min_range(1) & time_vector <= min_range(2);
    max_indices = time_vector >= max_range(1) & time_vector <= max_range(2);
    min_value = mean(prctile(data(min_indices), 5)); % Mean of the bottom 5% of the specified interval
    max_value = mean(prctile(data(max_indices), 95)); % Mean of the top 5% of the specified interval
end
