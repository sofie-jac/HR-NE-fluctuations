function [global_max, global_min] = compute_global_extremes(results, data_types)
    % Initialize global max and min structures
    global_max = struct();
    global_ns = struct();
    
    % Initialize variables to a very low and very high number respectively
    for d_idx = 1:length(data_types)
        global_max.(data_types{d_idx}) = -inf;
        global_min.(data_types{d_idx}) = inf;
    end
    
    % Iterate through the results to find global max and min
    event_var_names = fieldnames(results);
    for e_idx = 1:length(event_var_names)
        event_type_name = event_var_names{e_idx};
        
        for d_idx = 1:length(data_types)
            data_type = data_types{d_idx};
            
            if isfield(results.(event_type_name), data_type) && ~isempty(results.(event_type_name).(data_type))
                % For EEG bands, consider only the mean values
                if ismember(data_type, {'SO', 'Delta', 'Theta', 'Sigma', 'Beta', 'Gamma_low', 'Gamma_high'})
                    current_max = max(results.(event_type_name).(data_type).mean);
                    current_min = min(results.(event_type_name).(data_type).mean);
                else
                    % For other data types, consider mean +/- SEM
                    current_max = max(results.(event_type_name).(data_type).mean + results.(event_type_name).(data_type).sem);
                    current_min = min(results.(event_type_name).(data_type).mean - results.(event_type_name).(data_type).sem);
                end
                
                % Update global max and min
                if current_max > global_max.(data_type)
                    global_max.(data_type) = current_max;
                end
                if current_min < global_min.(data_type)
                    global_min.(data_type) = current_min;
                end
            end
        end
    end
    
    % Merge EEG bands into one global max/min for simplicity
    eeg_band_names = {'SO', 'Delta', 'Theta', 'Sigma', 'Beta', 'Gamma_low', 'Gamma_high'};
    global_max_eeg_bands = -inf;
    global_min_eeg_bands = inf;
    
    for band = eeg_band_names
        band_name = band{1};
        if global_max.(band_name) > global_max_eeg_bands
            global_max_eeg_bands = global_max.(band_name);
        end
        if global_min.(band_name) < global_min_eeg_bands
            global_min_eeg_bands = global_min.(band_name);
        end
        
        % Remove individual band max/min after merging
        global_max = rmfield(global_max, band_name);
        global_min = rmfield(global_min, band_name);
    end
    
    % Assign the merged values
    global_max.EEG_bands = global_max_eeg_bands;
    global_min.EEG_bands = global_min_eeg_bands;
end
