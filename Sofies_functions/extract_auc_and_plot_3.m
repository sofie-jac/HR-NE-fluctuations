function auc_data = extract_auc_and_plot_3(o, event_var, saveDirectory, times_matrix_pre, times_matrix_post)
% Set default epoch start and end times
epoc_start = 60;
epoc_end = 60;

% Create output directory if it does not exist (not used anymore)
% if ~exist(outputDirectory, 'dir')
%     mkdir(outputDirectory);
% end

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

        % Calculate AUC for each event for both time matrices
        auc_summary.NE_pre = calculate_auc(NE_collector.(['NE_' event_type_name '_' uniqueId]), time_vector_NE, times_matrix_pre.NE.range);
        auc_summary.NE_post = calculate_auc(NE_collector.(['NE_' event_type_name '_' uniqueId]), time_vector_NE, times_matrix_post.NE.range);
        auc_summary.RR_pre = calculate_auc(RR_collector.(['RR_' event_type_name '_' uniqueId]), time_vector_RR, times_matrix_pre.RR.range) * 1000;  % Convert to ms
        auc_summary.RR_post = calculate_auc(RR_collector.(['RR_' event_type_name '_' uniqueId]), time_vector_RR, times_matrix_post.RR.range) * 1000;  % Convert to ms

        if ~any(strcmp(uniqueId, {'213', '205'}))
            eeg_bands = {'SO', 'Delta', 'Theta', 'Sigma', 'Beta', 'Gamma_low', 'Gamma_high'};
            for band_idx = 1:length(eeg_bands)
                band_name = eeg_bands{band_idx};
                band_data = eval([band_name '_collector.(''' band_name '_' event_type_name '_' uniqueId ''')']);
                auc_summary.([band_name '_pre']) = calculate_auc(band_data, time_vector_EEG, times_matrix_pre.EEG.range);
                auc_summary.([band_name '_post']) = calculate_auc(band_data, time_vector_EEG, times_matrix_post.EEG.range);
            end
        end

        % Assign AUC values to the main structure
        auc_data.(sprintf('%s_%s', event_type_name, uniqueId)) = auc_summary;
    end
end

end

function auc = calculate_auc(data, time_vector, time_range)
% Calculate the area under the curve for the specified time range
indices = time_vector >= time_range(1) & time_vector <= time_range(2);
auc = trapz(time_vector(indices), data(:, indices), 2);
end