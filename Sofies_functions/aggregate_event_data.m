function [results] = aggregate_event_data(saveDirectory, event_var, animals, data_types)
    % Predefine the structure to hold the mean and SEM values for each event and data type
    results = struct();

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
            
            % Load data for each data type
            for d_idx = 1:length(data_types)
                filename = fullfile(saveDirectory, sprintf('%s_%s_%s.mat', data_types{d_idx}, event_type_name, uniqueId));
                if isfile(filename)
                    loaded_data = load(filename);
                    variable_name = sprintf('%s_%s_%s', data_types{d_idx}, event_type_name, uniqueId);
                    if isfield(loaded_data, variable_name)
                        % Append the data for this animal to the all_data structure
                        all_data.(data_types{d_idx}) = [all_data.(data_types{d_idx}); loaded_data.(variable_name)];
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
                if ~ismember(data_types{d_idx}, {'SO', 'Delta', 'Theta', 'Sigma', 'Beta', 'Gamma_low', 'Gamma_high'})
                    results.(event_type_name).(data_types{d_idx}).sem = std(all_data.(data_types{d_idx}), 0, 1) / sqrt(size(all_data.(data_types{d_idx}), 1));
                end
            end
        end
    end
end