function amplitude_diff_data = extract_amplitude_differences(amplitude_data, event_var)
    amplitude_diff_data = struct();

    for stage_idx = 1:length(event_var)
        event_type_name = event_var{stage_idx};  % Get the current event type name

        uniqueIds = fieldnames(amplitude_data);
        uniqueIds = uniqueIds(contains(uniqueIds, event_type_name));

        for idx = 1:length(uniqueIds)
            uniqueId = uniqueIds{idx};  % Get the current unique ID

            summary_data = amplitude_data.(uniqueId);

            % Calculate NE amplitude
            NE_diff = summary_data.NE_max - summary_data.NE_min;

            % Calculate RR amplitude
            RR_diff = summary_data.RR_min - summary_data.RR_max;

            % Calculate EEG band amplitudes if not excluded
            eeg_bands = {'SO', 'Delta', 'Theta', 'Sigma', 'Beta'};
            gamma_bands = {'Gamma_low', 'Gamma_high'};
            for band_idx = 1:length(eeg_bands)
                band_name = eeg_bands{band_idx};
                if isfield(summary_data, [band_name '_baseline']) && isfield(summary_data, [band_name '_min'])
                    band_diff = summary_data.([band_name '_min']) - summary_data.([band_name '_baseline']);
                    summary_data.([band_name '_diff']) = band_diff;
                end
            end
            for band_idx = 1:length(gamma_bands)
                band_name = gamma_bands{band_idx};
                if isfield(summary_data, [band_name '_baseline']) && isfield(summary_data, [band_name '_max_mean'])
                    band_diff = summary_data.([band_name '_max_mean']) - summary_data.([band_name '_baseline']);
                    summary_data.([band_name '_diff']) = band_diff;
                end
            end

            summary_data.NE_diff = NE_diff;
            summary_data.RR_diff = RR_diff;

            % Save the amplitude differences
            amplitude_diff_data.(uniqueId) = summary_data;
        end
    end
end
