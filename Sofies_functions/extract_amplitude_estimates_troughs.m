function amplitude_data = extract_amplitude_estimates_troughs(o, event_var, saveDirectory, times_matrix, outputDirectory)
    % Set default epoch start and end times
    epoc_start = 60;
    epoc_end = 60;
    
    % Create output directory if it does not exist
    if ~exist(outputDirectory, 'dir')
        mkdir(outputDirectory);
    end

    % Initialize the structure to hold all summary files
    amplitude_data = struct();

    % Loop over each event type
    for stage_idx = 1:length(event_var)
        event_type_name = event_var{stage_idx};  % Get the current event type name

        % Loop over each subject
        for idx = 1:length(o)
            uniqueId = o{idx};  % Get the current subject ID

            % Initialize collectors for summary values
            summary_data = struct();

            % Load necessary data
            try
                NE_collector = load(fullfile(saveDirectory, sprintf('NE_%s_%s.mat', event_type_name, uniqueId)));
                RR_collector = load(fullfile(saveDirectory, sprintf('RR_%s_%s.mat', event_type_name, uniqueId)));
                if ~any(strcmp(uniqueId, {'213', '205'}))
                    SO_collector = load(fullfile(saveDirectory, sprintf('SO_%s_%s.mat', event_type_name, uniqueId)));
                    Delta_collector = load(fullfile(saveDirectory, sprintf('Delta_%s_%s.mat', event_type_name, uniqueId)));
                    Theta_collector = load(fullfile(saveDirectory, sprintf('Theta_%s_%s.mat', event_type_name, uniqueId)));
                    Sigma_collector = load(fullfile(saveDirectory, sprintf('Sigma_%s_%s.mat', event_type_name, uniqueId)));
                    Beta_collector = load(fullfile(saveDirectory, sprintf('Beta_%s_%s.mat', event_type_name, uniqueId)));
                    Gamma_low_collector = load(fullfile(saveDirectory, sprintf('Gamma_low_%s_%s.mat', event_type_name, uniqueId)));
                    Gamma_high_collector = load(fullfile(saveDirectory, sprintf('Gamma_high_%s_%s.mat', event_type_name, uniqueId)));
                end
            catch
                warning('Data not found for %s_%s', event_type_name, uniqueId);
                continue;
            end

            % Define time vectors based on sampling frequencies
            time_vector_NE = linspace(-epoc_start, epoc_end, size(NE_collector.(['NE_' event_type_name '_' uniqueId]), 2));
            time_vector_RR = linspace(-epoc_start, epoc_end, size(RR_collector.(['RR_' event_type_name '_' uniqueId]), 2));
            if ~any(strcmp(uniqueId, {'213', '205'}))
                time_vector_EEG = linspace(-epoc_start, epoc_end, size(SO_collector.(['SO_' event_type_name '_' uniqueId]), 2));
            end

            % Extract min/max/baseline values for each event and store in summary data
            for event_idx = 1:size(NE_collector.(['NE_' event_type_name '_' uniqueId]), 1)
                % Calculate NE min/max
                [NE_min, NE_max] = calculate_min_max(NE_collector.(['NE_' event_type_name '_' uniqueId])(event_idx, :), time_vector_NE, times_matrix.NE.min_range, times_matrix.NE.max_range);
                summary_data.NE_min(event_idx, 1) = NE_min;
                summary_data.NE_max(event_idx, 1) = NE_max;

                % Calculate RR baseline and min, and convert to milliseconds
                [RR_min, RR_max] = calculate_min_max(RR_collector.(['RR_' event_type_name '_' uniqueId])(event_idx, :), time_vector_RR, times_matrix.RR.min_range, times_matrix.RR.max_range);
                summary_data.RR_min(event_idx, 1) = RR_min * 1000;
                summary_data.RR_max(event_idx, 1) = RR_max * 1000;

                % Calculate EEG band values if not excluded
                if ~any(strcmp(uniqueId, {'213', '205'}))
                    eeg_bands = {'SO', 'Delta', 'Theta', 'Sigma', 'Beta'};
                    gamma_bands = {'Gamma_low', 'Gamma_high'};
                    for band_idx = 1:length(eeg_bands)
                        band_name = eeg_bands{band_idx};
                        band_data = eval([band_name '_collector.(''' band_name '_' event_type_name '_' uniqueId ''')(event_idx, :)']);
                        [band_baseline, band_min] = calculate_mean_min(band_data, time_vector_EEG, times_matrix.EEG.mean_range, times_matrix.EEG.min_range);
                        summary_data.([band_name '_min'])(event_idx, 1) = band_min;
                        summary_data.([band_name '_baseline'])(event_idx, 1) = band_baseline;
                    end
                    for band_idx = 1:length(gamma_bands)
                        band_name = gamma_bands{band_idx};
                        band_data = eval([band_name '_collector.(''' band_name '_' event_type_name '_' uniqueId ''')(event_idx, :)']);
                        baseline_range = [-40, -20];
                        max_range = [0, 25];
                        baseline_mean = calculate_mean(band_data, time_vector_EEG, baseline_range);
                        max_mean = calculate_max_mean(band_data, time_vector_EEG, max_range);
                        summary_data.([band_name '_baseline'])(event_idx, 1) = baseline_mean;
                        summary_data.([band_name '_max_mean'])(event_idx, 1) = max_mean;
                    end
                end
            end

            % Save the summary data
            summary_filename = fullfile(outputDirectory, sprintf('amplitude_%s_%s.mat', event_type_name, uniqueId));
            save(summary_filename, '-struct', 'summary_data');

            % Assign summary data to output structure
            amplitude_data.(sprintf('%s_%s', event_type_name, uniqueId)) = summary_data;
        end
    end
end

function [mean_value, min_value] = calculate_mean_min(data, time_vector, mean_range, min_range)
    mean_indices = time_vector >= mean_range(1) & time_vector <= mean_range(2);
    min_indices = time_vector >= min_range(1) & time_vector <= min_range(2);
    mean_value = mean(data(mean_indices), 2); % Mean of the specified interval
    min_value = mean(prctile(data(min_indices), 5)); % Mean of the bottom 5% of the specified interval
end

function mean_value = calculate_mean(data, time_vector, mean_range)
    mean_indices = time_vector >= mean_range(1) & time_vector <= mean_range(2);
    mean_value = mean(data(mean_indices), 2); % Mean of the specified interval
end

function mean_value = calculate_max_mean(data, time_vector, max_range)
    max_indices = time_vector >= max_range(1) & time_vector <= max_range(2);
    mean_value = mean(prctile(data(max_indices), 95)); % Mean of the top 5% of the specified interval
end

function [min_value, max_value] = calculate_min_max(data, time_vector, min_range, max_range)
    min_indices = time_vector >= min_range(1) & time_vector <= min_range(2);
    max_indices = time_vector >= max_range(1) & time_vector <= max_range(2);
    min_value = mean(prctile(data(min_indices), 5)); % Mean of the bottom 5% of the specified interval
    max_value = mean(prctile(data(max_indices), 95)); % Mean of the top 5% of the specified interval
end
