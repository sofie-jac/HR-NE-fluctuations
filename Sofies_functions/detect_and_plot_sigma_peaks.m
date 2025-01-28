function detect_and_plot_sigma_peaks(suffixes, peak_prominences)
    % Define colors for different peak types
    colors = [
        0 0 1;  % Blue for NREMexclMA
        0 1 0;  % Green for SWS_before_MA_short
        1 0 0;  % Red for SWS_before_MA_long
        0.5 0.5 0.5  % Gray for SWS_before_wake
    ];

    % Loop through each suffix
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

            % Peak prominence for this suffix
            prominence = peak_prominences(str2double(suffix));

            % Initialize variables to store peak timestamps for all stages
            stage_peak_timestamps = struct('NREMexclMA', [], 'SWS_before_MA_short', [], ...
                                           'SWS_before_MA_long', [], 'SWS_before_wake', []);

            % Define stages to loop through
            stages = {'NREMexclMA_periods', 'SWS_before_MA_short', 'SWS_before_MA_long', 'SWS_before_wake'};
            for j = 1:length(stages)
                stage = stages{j};
                try
                    % Load the periods for the current stage
                    stage_periods = evalin('base', sprintf('%s_%s', stage, suffix));

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

                        % Store valid peaks
                        valid_sigma_peaks = [valid_sigma_peaks; locs'];
                    end

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
           % plot(sigma_time, sigma_band_power, 'k', 'LineWidth', 1.5); % Black signal
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
            % plot(NE_time, NE_var, 'k', 'LineWidth', 1.5); % Black signal
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
            % plot(RR_time, RR_var, 'k', 'LineWidth', 1.5); % Black signal
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
