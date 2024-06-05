function [results] = aggregate_event_data(saveDirectory, event_var, animals, data_types)
    % Predefine the structure to hold the mean, SEM values, and event counts for each event and data type
    results = struct();

    % Define EEG bands
    eeg_bands = {'SO', 'Delta', 'Theta', 'Sigma', 'Beta', 'Gamma_low', 'Gamma_high'};
    % Define the maximum length for EEG bands (modifiable)
    max_length_EEG = 240;

    % Helper function to trim and warn
    function trimmed_var = trim_and_warn(variable, target_length, var_name)
        if length(variable) > target_length
            disp(['Warning: Trimming ', var_name, ' from ', num2str(length(variable)), ' to ', num2str(target_length)]);
            trimmed_var = variable(1:target_length);
        else
            trimmed_var = variable;
        end
    end

    % Iterate over each event type
    for e_idx = 1:length(event_var)
        event_type_name = event_var{e_idx};
        
        % Structures to hold aggregated data for all animals for current event type
        all_data = struct();
        for d_idx = 1:length(data_types)
            all_data.(data_types{d_idx}) = [];  % Initialize an empty array for each data type
        end
        
        % Load and aggregate data for each animal
        for a_idx = 1:length(animals)
            uniqueId = animals{a_idx};
            
            % Determine if EEG data should be excluded for this animal
            excludeEEG = any(strcmp(uniqueId, {'213', '205'}));  
            
            % Load data for each data type
            for d_idx = 1:length(data_types)
                % Skip EEG data if the condition is met
                if excludeEEG && ismember(data_types{d_idx}, eeg_bands)
                    continue;
                end

                filename = fullfile(saveDirectory, sprintf('%s_%s_%s.mat', data_types{d_idx}, event_type_name, uniqueId));
                if isfile(filename)
                    loaded_data = load(filename);
                    variable_name = sprintf('%s_%s_%s', data_types{d_idx}, event_type_name, uniqueId);
                    if isfield(loaded_data, variable_name)
                        data_to_append = loaded_data.(variable_name);

                        % Check if data is an EEG band and needs trimming
                        if ismember(data_types{d_idx}, eeg_bands)
                            data_to_append = trim_and_warn(data_to_append, max_length_EEG, variable_name);
                        end

                        % Append the data for this animal to the all_data structure
                        all_data.(data_types{d_idx}) = [all_data.(data_types{d_idx}); data_to_append];
                    end
                end
            end
        end

        % Calculate the mean and SEM for each data type
        for d_idx = 1:length(data_types)
            if ~isempty(all_data.(data_types{d_idx}))
                % Calculate mean
                results.(event_type_name).(data_types{d_idx}).mean = mean(all_data.(data_types{d_idx}), 1);
                
                % Calculate SEM only if it's not an EEG band
                if ~ismember(data_types{d_idx}, eeg_bands)
                    results.(event_type_name).(data_types{d_idx}).sem = std(all_data.(data_types{d_idx}), 0, 1) / sqrt(size(all_data.(data_types{d_idx}), 1));
                end

                % Store the number of events
                results.(event_type_name).(data_types{d_idx}).num_events = size(all_data.(data_types{d_idx}), 1);
            else
                results.(event_type_name).(data_types{d_idx}).num_events = 0;
            end
        end
    end
end
