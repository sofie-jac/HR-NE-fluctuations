function auc_data = extract_auc_and_plot(o, event_var, saveDirectory, times_matrix_post, outputDirectory, titles)
    % Set default epoch start and end times
    epoc_start = 60;
    epoc_end = 60;

    % Create output directory if it does not exist
    if ~exist(outputDirectory, 'dir')
        mkdir(outputDirectory);
    end

    % Initialize the structure to hold AUC values
    auc_data = struct();

    % Loop over each event type
    for stage_idx = 1:length(event_var)
        event_type_name = event_var{stage_idx};  % Get the current event type name

        % Loop over each subject
        for idx = 1:length(o)
            uniqueId = o{idx};  % Get the current subject ID

            % Initialize collectors for AUC values
            auc_summary = struct();

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

            % Adjust NE values so that the NE value at timepoint 0 is 0
            NE_data = NE_collector.(['NE_' event_type_name '_' uniqueId]);
            [~, zero_index] = min(abs(time_vector_NE));  % Find the index closest to time 0
            NE_adjustment = NE_data(:, zero_index);  % Get the NE value at time 0
            NE_data = NE_data - NE_adjustment;  % Adjust NE values
            
            % Adjust RR and EEG values
            RR_data = RR_collector.(['RR_' event_type_name '_' uniqueId]) + 0.02;
            if ~any(strcmp(uniqueId, {'213', '205'}))
                SO_data = SO_collector.(['SO_' event_type_name '_' uniqueId]) + 0.6;
                Delta_data = Delta_collector.(['Delta_' event_type_name '_' uniqueId]) + 0.6;
                Theta_data = Theta_collector.(['Theta_' event_type_name '_' uniqueId]) + 0.6;
                Sigma_data = Sigma_collector.(['Sigma_' event_type_name '_' uniqueId]) + 0.6;
                Beta_data = Beta_collector.(['Beta_' event_type_name '_' uniqueId]) + 0.6;
                Gamma_low_data = Gamma_low_collector.(['Gamma_low_' event_type_name '_' uniqueId]) + 0.6;
                Gamma_high_data = Gamma_high_collector.(['Gamma_high_' event_type_name '_' uniqueId]) + 0.6;
            end

            % Calculate AUC for each event for post time matrices
            auc_summary.NE_post = calculate_auc_from_min_max(NE_data, time_vector_NE, times_matrix_post.NE.range, 'rise');
            auc_summary.RR_post = calculate_auc_from_min_max(RR_data, time_vector_RR, times_matrix_post.RR.range, 'fall') * 1000;  % Convert to ms

            if ~any(strcmp(uniqueId, {'213', '205'}))
                eeg_bands = {'SO', 'Delta', 'Theta', 'Sigma', 'Beta', 'Gamma_low', 'Gamma_high'};
                for band_idx = 1:length(eeg_bands)
                    band_name = eeg_bands{band_idx};
                    band_data = eval([band_name '_data']);
                    trend = 'fall';
                    if contains(band_name, 'Gamma')
                        trend = 'rise';
                    end
                    auc_summary.([band_name '_post']) = calculate_auc_from_min_max(band_data, time_vector_EEG, times_matrix_post.EEG.range, trend);
                end
            end

            % Assign AUC values to the main structure
            auc_data.(sprintf('%s_%s', event_type_name, uniqueId)) = auc_summary;
        end
    end

    % Plotting the AUC values
    data_types = {'NE', 'RR', 'SO', 'Delta', 'Theta', 'Sigma', 'Beta', 'Gamma_low', 'Gamma_high'};
    exclude_ids = {'213', '205'};

    % Initialize matrices to store mean and SEM values
    mean_auc_post = zeros(length(data_types), length(event_var));
    sem_auc_post = zeros(length(data_types), length(event_var));

    for data_idx = 1:length(data_types)
        data_type = data_types{data_idx};
        
        for stage_idx = 1:length(event_var)
            event_type_name = event_var{stage_idx};
            subject_aucs_post = [];

            for idx = 1:length(o)
                uniqueId = o{idx};
                if any(strcmp(uniqueId, exclude_ids)) && ~ismember(data_type, {'NE', 'RR'})
                    continue;
                end
                field_name = sprintf('%s_%s', event_type_name, uniqueId);
                if isfield(auc_data, field_name) && isfield(auc_data.(field_name), [data_type '_post'])
                    post_values = auc_data.(field_name).([data_type '_post']);
                    subject_aucs_post = [subject_aucs_post; post_values];
                end
            end

            mean_auc_post(data_idx, stage_idx) = mean(subject_aucs_post, 'omitnan');
            sem_auc_post(data_idx, stage_idx) = std(subject_aucs_post, 'omitnan') / sqrt(length(subject_aucs_post));
        end
    end

    % Create subplots for each data type
    figure('Name', 'AUC Post Bar Plots', 'NumberTitle', 'off');
    set(gcf, 'Color', 'w');

    for data_idx = 1:length(data_types)
        subplot(3, 3, data_idx);
        hold on;
        
        % Create bar plot
        b = bar(mean_auc_post(data_idx, :), 'FaceColor', 'flat');
        
        % Add error bars
        errorbar(b.XEndPoints, mean_auc_post(data_idx, :), sem_auc_post(data_idx, :), 'k', 'linestyle', 'none');

        % Set subplot properties
        set(gca, 'XTick', 1:length(event_var), 'XTickLabel', titles, 'XTickLabelRotation', 45);
        ylabel('AUC');
        title(data_types{data_idx});
        
        % Adjust y-limits
        min_ylim = min(mean_auc_post(data_idx, :) - sem_auc_post(data_idx, :));
        max_ylim = max(mean_auc_post(data_idx, :) + sem_auc_post(data_idx, :));
        ylim([min_ylim, max_ylim]);
        
        hold off;
    end

    sgtitle('AUC Post Bar Plots for Each Data Type');
end

function auc = calculate_auc_from_min_max(data, time_vector, time_range)
    % Calculate the area under the curve for the specified time range
    indices = time_vector >= time_range(1) & time_vector <= time_range(2);
    data_segment = data(:, indices);
    auc = trapz(time_vector(indices), abs(data_segment), 2); % Use abs to ensure positive AUC
end
