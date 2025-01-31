function detect_and_plot_sigma_peaks_stage_based(suffixes, peak_prominences, apply_smoothing, window_size)

% Define colors for different peak types
    colors = [
        0 0 1;  % Blue for NREMexclMA
        0 1 0;  % Green for SWS_before_MA_short
        1 0 0;  % Red for SWS_before_MA_long
        0.5 0.5 0.5  % Gray for SWS_before_wake
    ];

    % Define stages
    stages = {'NREMexclMA_periods', 'SWS_before_MA_short', 'SWS_before_MA_long', 'SWS_before_wake'};

    % Loop through each suffix
    for i = 1:length(suffixes)
        suffix = suffixes{i};
        try
            % Load required variables dynamically from the workspace
            sigma_band_power = evalin('base', sprintf('band_powers_%s{4}', suffix));
            sigma_time = evalin('base', sprintf('time_spectrogram_zero_%s', suffix));
            NE_var = evalin('base', sprintf('delta465_filt_2_%s', suffix));
            NE_time = evalin('base', sprintf('sec_signal_2_%s', suffix));
            RR_var = evalin('base', sprintf('RR_%s', suffix));
            RR_time = evalin('base', sprintf('RR_time_%s', suffix));
            wake_binary_vector = evalin('base', sprintf('wake_woMA_binary_vector_%s', suffix));
            sws_binary_vector = evalin('base', sprintf('sws_binary_vector_%s', suffix));
            rem_binary_vector = evalin('base', sprintf('REM_binary_vector_%s', suffix));
            ma_binary_vector = evalin('base', sprintf('MA_binary_vector_%s', suffix));
            sleepscore_time = 0:length(wake_binary_vector)-1; % Assuming all vectors are the same length

            % Apply smoothing if enabled
            if apply_smoothing
                sigma_band_power = movmean(sigma_band_power, window_size);
            end

            % Initialize variables to store peak timestamps for all stages
            stage_peak_timestamps = struct();

            % Loop through each stage
            for j = 1:length(stages)
                stage = stages{j};
                try
                    % Load the periods for the current stage
                    stage_periods = evalin('base', sprintf('%s_%s', stage, suffix));

                    % Get the prominence for the current stage
                    prominence = peak_prominences(stage);

                    % Initialize an array to store valid sigma peaks for the current stage
                    valid_sigma_peaks = [];

                    % Loop through each period to find peaks
                    for k = 1:size(stage_periods, 1)
                        onset = stage_periods(k, 1);
                        offset = stage_periods(k, 2);

                        % Restrict sigma band to the current period
                        valid_indices = sigma_time >= onset & sigma_time <= offset;

                        % Extract valid sigma band power and corresponding times
                        valid_times = sigma_time(valid_indices);
                        valid_sigma = sigma_band_power(valid_indices);

                        % Detect peaks in the sigma band power during valid times
                        if ~isempty(valid_sigma) && numel(valid_sigma) > 2
                            [~, locs] = findpeaks(valid_sigma, valid_times, 'MinPeakProminence', prominence);
                        else
                            locs = []; % No peaks if valid_sigma is empty or insufficient in size
                        end

                        % Handling multiple peaks within a single valid period
                        if strcmp(stage, 'NREMexclMA_periods')
                            % Keep all peaks for NREMexclMA
                            valid_sigma_peaks = [valid_sigma_peaks; locs'];
                        else
                            % Keep only the last peak per period for other stages
                            if ~isempty(locs)
                                valid_sigma_peaks = [valid_sigma_peaks; max(locs)];
                            end
                        end
                    end

                    % Remove SWS_before_wake peaks that occur in REM periods
                    valid_sigma_peaks = remove_peaks_in_REM(valid_sigma_peaks, rem_binary_vector);


                    % Save valid peaks for the current stage
                    stage_peak_timestamps.(stage) = valid_sigma_peaks;

                catch ME
                    fprintf('Could not process stage "%s" for suffix "%s": %s\n', stage, suffix, ME.message);
                end
            end

            % Save the peaks to the workspace
            peaks_var_name = sprintf('sigma_peaks_%s', suffix);
            assignin('base', peaks_var_name, stage_peak_timestamps);

            % Plot the results
            figure;

            % Plot sigma band power
            subplot(3, 1, 1);
            plot_sleep(sigma_time, sigma_band_power, sleepscore_time, wake_binary_vector, sws_binary_vector, rem_binary_vector, ma_binary_vector);
            hold on;
            for j = 1:length(stages)
                stage = stages{j};
                peaks = stage_peak_timestamps.(stage);
                if ~isempty(peaks)
                    scatter(peaks, ...
                            interp1(sigma_time, sigma_band_power, peaks, 'linear', 'extrap'), ...
                            50, colors(j, :), 'filled');
                end
            end
            hold off;
            ylabel('Sigma Power');
            title(sprintf('Sigma Power for Suffix %s', suffix));
            grid on;

            % Plot NE signal
            subplot(3, 1, 2);
            plot_sleep(NE_time, NE_var, sleepscore_time, wake_binary_vector, sws_binary_vector, rem_binary_vector, ma_binary_vector);
            hold on;
            for j = 1:length(stages)
                stage = stages{j};
                peaks = stage_peak_timestamps.(stage);
                if ~isempty(peaks)
                    scatter(peaks, ...
                            interp1(NE_time, NE_var, peaks, 'linear', 'extrap'), ...
                            50, colors(j, :), 'filled');
                end
            end
            hold off;
            ylabel('NE Signal');
            grid on;

            % Plot RR signal
            subplot(3, 1, 3);
            plot_sleep(RR_time, RR_var, sleepscore_time, wake_binary_vector, sws_binary_vector, rem_binary_vector, ma_binary_vector);
            hold on;
            for j = 1:length(stages)
                stage = stages{j};
                peaks = stage_peak_timestamps.(stage);
                if ~isempty(peaks)
                    scatter(peaks, ...
                            interp1(RR_time, RR_var, peaks, 'linear', 'extrap'), ...
                            50, colors(j, :), 'filled');
                end
            end
            hold off;
            xlabel('Time (s)');
            ylabel('RR Interval');
            grid on;

            % Link x-axes
            linkaxes(findall(gcf, 'Type', 'axes'), 'x');

        catch ME
            fprintf('Error processing suffix "%s": %s\n', suffix, ME.message);
        end
    end
end

%% Helper Function: Remove Peaks in REM Periods
function filtered_peaks = remove_peaks_in_REM(peaks, rem_binary_vector)
    % Convert REM binary vector to REM periods
    [REM_onsets, REM_offsets] = binaryToOnOff(rem_binary_vector);
    
    % Remove peaks that fall within REM periods
    filtered_peaks = [];
    for j = 1:length(peaks)
        peak_time = peaks(j);
        if ~any((peak_time >= REM_onsets) & (peak_time <= REM_offsets))
            filtered_peaks = [filtered_peaks; peak_time];
        end
    end
end

%% Helper Function: Convert Binary Vector to On/Off Periods
function [onsets, offsets] = binaryToOnOff(binary_vector)
    % Identify changes in binary vector to find onsets and offsets
    transitions = diff([0; binary_vector(:); 0]);
    onsets = find(transitions == 1);
    offsets = find(transitions == -1);
end
