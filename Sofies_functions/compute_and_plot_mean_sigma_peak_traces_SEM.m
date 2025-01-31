function mean_traces = compute_and_plot_mean_sigma_peak_traces_SEM(suffixes, apply_smoothing, smoothing_window_size)
    % Define window for mean trace (-30s to +30s)
    window_size = 30; % seconds before and after peak

    % Define colors for different peak types
    colors = struct('NREMexclMA_periods', [0.5, 0.8, 1], ... % Light Blue
                    'SWS_before_MA_short', [1, 1, 0], ...     % Yellow
                    'SWS_before_MA_long', [1, 0.6, 0], ...    % Orange
                    'SWS_before_wake', [1, 0, 0]);           % Red

    % Initialize struct to store mean and SEM traces
    mean_traces = struct('Sigma', struct(), 'NE', struct(), 'RR', struct());
    
    % Initialize structures for reference time vectors and peak counts
    stages = fieldnames(colors);
    peak_counts = struct();
    ref_time_vectors = struct('Sigma', [], 'NE', [], 'RR', []);
    first_subject = true; % Flag for using first subject as reference

    % Initialize peak_counts and storage
    for j = 1:length(stages)
        stage = stages{j};
        peak_counts.(stage) = 0;
        mean_traces.Sigma.(stage) = [];
        mean_traces.Sigma_SEM.(stage) = [];
        mean_traces.NE.(stage) = [];
        mean_traces.NE_SEM.(stage) = [];
        mean_traces.RR.(stage) = [];
        mean_traces.RR_SEM.(stage) = [];
    end

    % Loop through each suffix
    for i = 1:length(suffixes)
        suffix = suffixes{i};

        try
            % Load peak data for this suffix
            peak_data = evalin('base', sprintf('sigma_peaks_%s', suffix));

            % Load time series data
            sigma_band_power = evalin('base', sprintf('band_powers_%s{4}', suffix));
            sigma_time = evalin('base', sprintf('time_spectrogram_zero_%s', suffix));
            NE_var = evalin('base', sprintf('delta465_filt_2_%s', suffix));
            NE_time = evalin('base', sprintf('sec_signal_2_%s', suffix));
            RR_var = evalin('base', sprintf('RR_%s', suffix));
            RR_time = evalin('base', sprintf('RR_time_%s', suffix));

            % Apply smoothing if enabled
            if apply_smoothing
                sigma_band_power = movmean(sigma_band_power, smoothing_window_size);
            end

            % Load sampling frequencies
            sigma_fs = evalin('base', sprintf('EEG_bands_fs_%s', suffix));
            NE_fs = round(evalin('base', sprintf('signal_fs_%s', suffix)));
            RR_fs = 64; % Fixed FS for RR

            % Create expected time vectors
            sigma_time_window = linspace(-window_size, window_size, round(2 * window_size * sigma_fs + 1));
            NE_time_window = linspace(-window_size, window_size, round(2 * window_size * NE_fs + 1));
            RR_time_window = linspace(-window_size, window_size, round(2 * window_size * RR_fs + 1));

            % Store reference time vectors if this is the first subject
            if first_subject
                ref_time_vectors.Sigma = sigma_time_window;
                ref_time_vectors.NE = NE_time_window;
                ref_time_vectors.RR = RR_time_window;
                first_subject = false;
            end
             
            % Loop through each sleep stage
            for j = 1:length(stages)
                stage = stages{j};

                if isfield(peak_data, stage) && ~isempty(peak_data.(stage))
                    peaks = peak_data.(stage);
                    peak_counts.(stage) = peak_counts.(stage) + length(peaks);

                    % Initialize arrays to hold extracted traces
                    sigma_traces = [];
                    NE_traces = [];
                    RR_traces = [];

                    % Process each peak
                    for k = 1:length(peaks)
                        peak_time = peaks(k);

                        % Extract sigma power around peak
                        sigma_trace = extract_window(sigma_band_power, sigma_time, peak_time, sigma_fs, window_size);
                        NE_trace = extract_window(NE_var, NE_time, peak_time, NE_fs, window_size);
                        RR_trace = extract_window(RR_var, RR_time, peak_time, RR_fs, window_size);

                        % Ensure extracted traces match reference length
                        if length(sigma_trace) == length(ref_time_vectors.Sigma) && ...
                           length(NE_trace) == length(ref_time_vectors.NE) && ...
                           length(RR_trace) == length(ref_time_vectors.RR)
                            sigma_traces = [sigma_traces; sigma_trace];
                            NE_traces = [NE_traces; NE_trace];
                            RR_traces = [RR_traces; RR_trace];
                        end
                    end

                    % Compute mean and SEM traces and store them
                    if ~isempty(sigma_traces)
                        mean_traces.Sigma.(stage) = mean(sigma_traces, 1, 'omitnan');
                        mean_traces.Sigma_SEM.(stage) = std(sigma_traces, 0, 1, 'omitnan') ./ sqrt(size(sigma_traces, 1));
                        mean_traces.NE.(stage) = mean(NE_traces, 1, 'omitnan');
                        mean_traces.NE_SEM.(stage) = std(NE_traces, 0, 1, 'omitnan') ./ sqrt(size(NE_traces, 1));
                        mean_traces.RR.(stage) = mean(RR_traces, 1, 'omitnan');
                        mean_traces.RR_SEM.(stage) = std(RR_traces, 0, 1, 'omitnan') ./ sqrt(size(RR_traces, 1));
                    end
                end
            end
        catch ME
            fprintf('Error processing suffix "%s": %s\n', suffix, ME.message);
        end
    end

            % Print the number of peaks used for each stage
    fprintf('Number of peaks used per category:\n');
    for j = 1:length(stages)
        stage = stages{j};
        if isfield(peak_counts, stage) % Check if stage exists
            fprintf('%s: %d peaks\n', stage, peak_counts.(stage));
        else
            fprintf('%s: 0 peaks (No data found)\n', stage);
        end
    end

    % Plot mean traces with SEM
    figure;

    % Plot Sigma Power
    subplot(3, 1, 1);
    hold on;
    for j = 1:length(stages)
        stage = stages{j};
        if ~isempty(mean_traces.Sigma.(stage))
            plot_with_sem(ref_time_vectors.Sigma, mean_traces.Sigma.(stage), mean_traces.Sigma_SEM.(stage), colors.(stage));
        end
    end
    xline(0, 'k--');
    hold off;
    title('Mean Sigma Power');
    xlabel('Time (s)');
    ylabel('Sigma Power');

    % Plot NE Signal
    subplot(3, 1, 2);
    hold on;
    for j = 1:length(stages)
        stage = stages{j};
        if ~isempty(mean_traces.NE.(stage))
            plot_with_sem(ref_time_vectors.NE, mean_traces.NE.(stage), mean_traces.NE_SEM.(stage), colors.(stage));
        end
    end
    xline(0, 'k--');
    hold off;
    title('Mean NE Signal');
    xlabel('Time (s)');
    ylabel('NE Signal');

    % Plot RR Signal
    subplot(3, 1, 3);
    hold on;
    for j = 1:length(stages)
        stage = stages{j};
        if ~isempty(mean_traces.RR.(stage))
            plot_with_sem(ref_time_vectors.RR, mean_traces.RR.(stage), mean_traces.RR_SEM.(stage), colors.(stage));
        end
    end
    xline(0, 'k--');
    hold off;
    title('Mean RR Interval');
    xlabel('Time (s)');
    ylabel('RR Interval');
end
%% Helper function for SEM plotting
function plot_with_sem(time_vector, mean_trace, sem_trace, color)
    % Fill area between mean ± SEM
    fill([time_vector, fliplr(time_vector)], ...
         [mean_trace - sem_trace, fliplr(mean_trace + sem_trace)], ...
         color, 'FaceAlpha', 0.15, 'EdgeColor', 'none');
    % Plot the mean trace
    plot(time_vector, mean_trace, 'Color', color, 'LineWidth', 2);
end

function check_time_alignment(ref_time, new_time, signal_type, suffix)
    % Check if the new time vector matches the reference time vector
    if length(ref_time) ~= length(new_time)
        length_diff = abs(length(ref_time) - length(new_time));
        
        % Allow minor differences (e.g., 1-2 samples)
        if length_diff > 2
            error('Mismatch in %s sampling rate for subject %s: Expected %d samples, got %d samples.', ...
                signal_type, suffix, length(ref_time), length(new_time));
        else
            fprintf('Warning: Slight mismatch in %s sampling for subject %s. Adjusting to reference.\n', ...
                signal_type, suffix);
        end
    end
end

function trace = ensure_length_match(trace, expected_length)
    % Adjusts trace length to match the expected number of samples
    if isempty(trace)
        trace = NaN(1, expected_length);
    elseif length(trace) > expected_length
        trace = trace(1:expected_length);
    elseif length(trace) < expected_length
        trace = [trace, NaN(1, expected_length - length(trace))];
    end
end

function trace = extract_window(data, time_vec, peak_time, fs, window_size)
    % Extracts a segment of data around a peak within [-window_size, +window_size] seconds
    start_time = peak_time - window_size;
    end_time = peak_time + window_size;
    
    % Generate expected time vector based on FS
    expected_samples = round(2 * window_size * fs + 1);
    time_window = linspace(start_time, end_time, expected_samples);
    
    % Interpolate data to match expected time vector
    trace = interp1(time_vec, data, time_window, 'linear', 'extrap');
end