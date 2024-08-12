function figure_2_reorganized_mean_centered(results, epoc_start, epoc_end, main_title, titles)
    % Define the number of rows and columns for subplot
    numEventVars = length(fieldnames(results));
    numColumns = 2; % Number of columns for subplots
    numRows = 5; % Number of rows for subplots

    % Initialize the figure
    figure('Name', 'Event Data Analysis', 'NumberTitle', 'off');
    set(gcf, 'Color', 'w'); % Set background color to white

    event_var_names = fieldnames(results);
    colors = {[0 0.4470 0.7410], [0.8500 0.3250 0.0980], [0.9290 0.6940 0.1250], [0.4660 0.6740 0.1880], [0.4940 0.1840 0.5560], [0.3010 0.7450 0.9330]};
    if numEventVars > 6
        disp('Please add more colors to the function - Im only loaded up with 6')
    end

    % Function to format the number of events string
    function n_events_str = format_num_events(n_events_all)
        n_events_str = '';
        for i = 1:length(n_events_all)
            n_events_str = [n_events_str, num2str(n_events_all(i))];
            if i ~= length(n_events_all)
                n_events_str = [n_events_str, ', '];
            end
        end
    end

    % Function to subtract the mean value of the trace from -40 to -30 seconds
    function aligned_data = subtract_baseline(data, time_vector)
        baseline_indices = time_vector >= -40 & time_vector <= -30;
        baseline_mean = mean(data(baseline_indices));
        aligned_data = data - baseline_mean;
    end

    % Adjust the epoch range to -30 to 30 seconds
    plot_start = -60;
    plot_end = 60;

    % Plot NE data
    subplot(numRows, numColumns, 1);
    hold on;
    legend_entries = {};
    for i = numEventVars:-1:1
        event_name = event_var_names{i};
        currentTitle = titles{i};

        % Determine the length of time vectors dynamically from data if available
        if isfield(results.(event_name), 'NE')
            lenNE = length(results.(event_name).NE.mean);
            epoc_FPtime_NE = linspace(plot_start, plot_end, lenNE);
            % Subtract the baseline
            aligned_mean_NE = subtract_baseline(results.(event_name).NE.mean, epoc_FPtime_NE);
            plot(epoc_FPtime_NE, aligned_mean_NE, 'Color', colors{i}); % Event specific color
            legend_entries{numEventVars-i+1} = currentTitle;
        end
    end
    for i = numEventVars:-1:1
        event_name = event_var_names{i};

        % Determine the length of time vectors dynamically from data if available
        if isfield(results.(event_name), 'NE')
            lenNE = length(results.(event_name).NE.mean);
            epoc_FPtime_NE = linspace(plot_start, plot_end, lenNE);
            % Subtract the baseline
            aligned_mean_NE = subtract_baseline(results.(event_name).NE.mean, epoc_FPtime_NE);

            lineProps = {'Color', colors{i}, 'HandleVisibility', 'off'}; % Sets line color and width
            shadedErrorBar(epoc_FPtime_NE, aligned_mean_NE, results.(event_name).NE.sem, lineProps, 1);
        end
    end
    plot([0 0], ylim, 'Color', [0.5 0.5 0.5], 'LineWidth', 1, 'LineStyle', '--');
    hold off;
    n_events_all = arrayfun(@(i) results.(event_var_names{i}).NE.num_events, 1:numEventVars);
    n_events_str = format_num_events(n_events_all);
    title(sprintf('NE (%s Events)', n_events_str));
    ylabel('Delta F/F');
    xlim([plot_start, plot_end]);
    legend(legend_entries, 'Location', 'northwest');
    grid on;

    % Plot RR data
    subplot(numRows, numColumns, 2);
    hold on;
    for i = numEventVars:-1:1
        event_name = event_var_names{i};
        currentTitle = titles{i};

        if isfield(results.(event_name), 'RR')
            lenRR = length(results.(event_name).RR.mean);
            epoc_FPtime_RR = linspace(plot_start, plot_end, lenRR);
            % Subtract the baseline
            aligned_mean_RR = subtract_baseline(results.(event_name).RR.mean, epoc_FPtime_RR);

            lineProps = {'Color', colors{i}}; % Sets line color and width
            shadedErrorBar(epoc_FPtime_RR, aligned_mean_RR, results.(event_name).RR.sem, lineProps, 1);
            plot(epoc_FPtime_RR, aligned_mean_RR, 'Color', colors{i}); % Event specific color
        end
    end
    plot([0 0], ylim, 'Color', [0.5 0.5 0.5], 'LineWidth', 1, 'LineStyle', '--');
    hold off;
    n_events_all = arrayfun(@(i) results.(event_var_names{i}).RR.num_events, 1:numEventVars);
    n_events_str = format_num_events(n_events_all);
    title(sprintf('RR (%s Events)', n_events_str));
    ylabel('RR Intervals (s)');
    xlim([plot_start, plot_end]);
    grid on;

    % Plot x-corr data
    subplot(numRows, numColumns, 3);
    hold on;
    minTimestamps = zeros(1, numEventVars);
    for i = numEventVars:-1:1
        event_name = event_var_names{i};
        currentTitle = titles{i};

        if isfield(results.(event_name), 'x_corr')
            lenRR = length(results.(event_name).x_corr.mean);
            epoc_FPtime_RR = linspace(plot_start, plot_end, lenRR);
            % Do not subtract the baseline
            aligned_mean_xcorr = results.(event_name).x_corr.mean;

            lineProps = {'Color', colors{i}}; % Sets line color and width
            shadedErrorBar(epoc_FPtime_RR, aligned_mean_xcorr, results.(event_name).x_corr.sem, lineProps, 1);
            plot(epoc_FPtime_RR, aligned_mean_xcorr, 'Color', colors{i}); % Event specific color

            % Find the index of the minimum x_corr value
            [minValue, minIndex] = min(aligned_mean_xcorr);
            minTimestamps(i) = epoc_FPtime_RR(minIndex);
            plot(minTimestamps(i), minValue, 'kx'); % Mark the min value with a black cross
        end
    end
    plot([0 0], ylim, 'Color', [0.5 0.5 0.5], 'LineWidth', 1, 'LineStyle', '--');
    hold off;
    titleStr = 'Cross-correlation';
    for i = 1:numEventVars
        titleStr = sprintf('%s, Min at %.2f s', titleStr, minTimestamps(i));
    end
    title(titleStr);
    ylabel('R');
    xlim([plot_start, plot_end]);
    grid on;

    % Plot EEG bands data
    eeg_bands = {'SO', 'Delta', 'Theta', 'Sigma', 'Beta', 'Gamma_low', 'Gamma_high'};
    for k = 1:length(eeg_bands)
        subplot(numRows, numColumns, k + 3);
        hold on;
        for i = numEventVars:-1:1
            event_name = event_var_names{i};
            currentTitle = titles{i};

            if isfield(results.(event_name), eeg_bands{k})
                lenSO = length(results.(event_name).(eeg_bands{k}).mean);
                epoc_FPtime_EEG = linspace(plot_start, plot_end, lenSO);
                % Subtract the baseline
                aligned_mean_EEG = subtract_baseline(results.(event_name).(eeg_bands{k}).mean, epoc_FPtime_EEG);

                lineProps = {'Color', colors{i}}; % Sets line color and width
                shadedErrorBar(epoc_FPtime_EEG, aligned_mean_EEG, results.(event_name).(eeg_bands{k}).sem, lineProps, 1);
                plot(epoc_FPtime_EEG, aligned_mean_EEG, 'Color', colors{i}); % Event specific color
            end
        end
        plot([0 0], ylim, 'Color', [0.5 0.5 0.5], 'LineWidth', 1, 'LineStyle', '--');
        hold off;
        band_title = strrep(eeg_bands{k}, '_', ' '); % Replace underscores with spaces for titles
        n_events_all = arrayfun(@(i) results.(event_var_names{i}).(eeg_bands{k}).num_events, 1:numEventVars);
        n_events_str = format_num_events(n_events_all);
        title(sprintf('%s (%s Events)', band_title, n_events_str));
        ylabel('Power');
        xlim([plot_start, plot_end]);
        grid on;
    end

    % Adjust overall plot settings
    sgtitle(main_title);
end