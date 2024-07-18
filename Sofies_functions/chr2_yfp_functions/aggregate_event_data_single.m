function [results] = aggregate_event_data_single(saveDirectory, event_var, animal, data_types)
    % Predefine the structure to hold the mean, SEM values, and event counts for each event and data type
    results = struct();

    % Define EEG bands
    eeg_bands = {'SO', 'Delta', 'Theta', 'Sigma', 'Beta', 'Gamma_low', 'Gamma_high'};
    % Define the maximum length for EEG bands (modifiable)
    max_length_EEG = 240;

    % Iterate over each event type
    for e_idx = 1:length(event_var)
        event_type_name = event_var{e_idx};
        
        % Structure to hold aggregated data for the animal for current event type
        all_data = struct();
        for d_idx = 1:length(data_types)
            all_data.(data_types{d_idx}) = [];  % Initialize an empty array for each data type
        end
        
        % Determine if EEG data should be excluded for this animal
        excludeEEG = any(strcmp(animal, {'213', '205'}));  
        
        % Load data for each data type
        for d_idx = 1:length(data_types)
            % Skip EEG data if the condition is met
            if excludeEEG && ismember(data_types{d_idx}, eeg_bands)
                continue;
            end

            filename = fullfile(saveDirectory, sprintf('%s_%s_%s.mat', data_types{d_idx}, event_type_name, animal));
            if isfile(filename)
                loaded_data = load(filename);
                variable_name = sprintf('%s_%s_%s', data_types{d_idx}, event_type_name, animal);
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

        % Calculate the mean and SEM for each data type
        for d_idx = 1:length(data_types)
            if ~isempty(all_data.(data_types{d_idx}))
                % Calculate mean
                results.(event_type_name).(data_types{d_idx}).mean = mean(all_data.(data_types{d_idx}), 1);
                results.(event_type_name).(data_types{d_idx}).sem = std(all_data.(data_types{d_idx}), 0, 1) / sqrt(size(all_data.(data_types{d_idx}), 1));

                % Store the number of events
                results.(event_type_name).(data_types{d_idx}).num_events = size(all_data.(data_types{d_idx}), 1);
            else
                results.(event_type_name).(data_types{d_idx}).num_events = 0;
            end
        end
    end
        clear eeg_bands max_length_EEG e_idx event_type_name all_data d_idx excludeEEG filename loaded_data variable_name data_to_append;
end

function data = trim_and_warn(data, max_length, variable_name)
    % Trim the data to the max_length and warn if data was trimmed
    if size(data, 2) > max_length
        data = data(:, 1:max_length);
        fprintf('Warning: Data in variable %s was trimmed to %d samples.\n', variable_name, max_length);
    end
end
