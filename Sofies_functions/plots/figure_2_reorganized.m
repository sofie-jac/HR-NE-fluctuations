function [NE_table, RR_table, SO_table, Delta_table, Theta_table, Sigma_table, Beta_table, Gamma_low_table, Gamma_high_table] = figure_2_reorganized(results, epoc_start, epoc_end, main_title, titles)
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

    % Down-sampling function
    function [downsampled_x, downsampled_y] = downsample_data(x, y, factor)
        downsampled_x = x(1:factor:end);
        downsampled_y = y(1:factor:end);
    end

    % Initialize tables for storing the data
    NE_table = table();
    RR_table = table();
    SO_table = table();
    Delta_table = table();
    Theta_table = table();
    Sigma_table = table();
    Beta_table = table();
    Gamma_low_table = table();
    Gamma_high_table = table();

    % Plot NE data
    subplot(numRows, numColumns, 1);
    hold on;
    legend_entries = {};
    for i = 1:numEventVars
        event_name = event_var_names{i};
        currentTitle = titles{i};

        % Determine the length of time vectors dynamically from data if available
        if isfield(results.(event_name), 'NE')
            lenNE = length(results.(event_name).NE.mean);
            epoc_FPtime_NE = linspace(-epoc_start, epoc_end, lenNE);
        else
            epoc_FPtime_NE = linspace(-epoc_start, epoc_end, 1000); % Default length
        end
        plot(epoc_FPtime_NE, results.(event_name).NE.mean, 'Color', colors{i}); % Event specific color
        legend_entries{i} = currentTitle;
    end
    for i = 1:numEventVars
        event_name = event_var_names{i};

        % Determine the length of time vectors dynamically from data if available
        if isfield(results.(event_name), 'NE')
            lenNE = length(results.(event_name).NE.mean);
            epoc_FPtime_NE = linspace(-epoc_start, epoc_end, lenNE);
        else
            epoc_FPtime_NE = linspace(-epoc_start, epoc_end, 1000); % Default length
        end

        lineProps = {'Color', colors{i}, 'HandleVisibility', 'off'}; % Sets line color and width
        shadedErrorBar(epoc_FPtime_NE, results.(event_name).NE.mean, results.(event_name).NE.sem, lineProps, 1);

        % Down-sample NE data
        [downsampled_time_NE, downsampled_mean_NE] = downsample_data(epoc_FPtime_NE, results.(event_name).NE.mean, 100);
        [~, downsampled_sem_NE] = downsample_data(epoc_FPtime_NE, results.(event_name).NE.sem, 100);

        % Add the data to the NE table
        if i == 1
            NE_table = table(downsampled_time_NE(:), downsampled_mean_NE(:), downsampled_sem_NE(:), 'VariableNames', {'Time', sprintf('Mean_%s', event_name), sprintf('SEM_%s', event_name)});
        else
            NE_table = [NE_table, table(downsampled_mean_NE(:), downsampled_sem_NE(:), 'VariableNames', {sprintf('Mean_%s', event_name), sprintf('SEM_%s', event_name)})];
        end
    end
    plot([0 0], ylim, 'Color', [0.5 0.5 0.5], 'LineWidth', 1, 'LineStyle', '--');
    hold off;
    n_events_all = arrayfun(@(i) results.(event_var_names{i}).NE.num_events, 1:numEventVars);
    n_events_str = format_num_events(n_events_all);
    title(sprintf('NE (%s Events)', n_events_str));
    ylabel('Delta F/F');
    xlim([-epoc_start, epoc_end]);
    legend(legend_entries, 'Location', 'best');
    grid on;

    % Plot RR data
    subplot(numRows, numColumns, 2);
    hold on;
    for i = 1:numEventVars
        event_name = event_var_names{i};
        currentTitle = titles{i};

        if isfield(results.(event_name), 'RR')
            lenRR = length(results.(event_name).RR.mean);
            epoc_FPtime_RR = linspace(-epoc_start, epoc_end, lenRR);
        else
            epoc_FPtime_RR = linspace(-epoc_start, epoc_end, 1000); % Default length
        end

        lineProps = {'Color', colors{i}}; % Sets line color and width
        shadedErrorBar(epoc_FPtime_RR, results.(event_name).RR.mean, results.(event_name).RR.sem, lineProps, 1);
        plot(epoc_FPtime_RR, results.(event_name).RR.mean, 'Color', colors{i}); % Event specific color

        % Down-sample RR data
        [downsampled_time_RR, downsampled_mean_RR] = downsample_data(epoc_FPtime_RR, results.(event_name).RR.mean, 7);
        [~, downsampled_sem_RR] = downsample_data(epoc_FPtime_RR, results.(event_name).RR.sem, 7);

        % Add the data to the RR table
        if i == 1
            RR_table = table(downsampled_time_RR(:), downsampled_mean_RR(:), downsampled_sem_RR(:), 'VariableNames', {'Time', sprintf('Mean_%s', event_name), sprintf('SEM_%s', event_name)});
        else
            RR_table = [RR_table, table(downsampled_mean_RR(:), downsampled_sem_RR(:), 'VariableNames', {sprintf('Mean_%s', event_name), sprintf('SEM_%s', event_name)})];
        end
    end
    plot([0 0], ylim, 'Color', [0.5 0.5 0.5], 'LineWidth', 1, 'LineStyle', '--');
    hold off;
    n_events_all = arrayfun(@(i) results.(event_var_names{i}).RR.num_events, 1:numEventVars);
    n_events_str = format_num_events(n_events_all);
    title(sprintf('RR (%s Events)', n_events_str));
    ylabel('RR Intervals (s)');
    xlim([-epoc_start, epoc_end]);
    grid on;

    % Plot EEG bands data
    eeg_bands = {'SO', 'Delta', 'Theta', 'Sigma', 'Beta', 'Gamma_low', 'Gamma_high'};
    for k = 1:length(eeg_bands)
        subplot(numRows, numColumns, k + 3);
        hold on;
        for i = 1:numEventVars
            event_name = event_var_names{i};
            currentTitle = titles{i};

            if isfield(results.(event_name), eeg_bands{k})
                lenEEG = length(results.(event_name).(eeg_bands{k}).mean);
                epoc_FPtime_EEG = linspace(-epoc_start, epoc_end, lenEEG);
            else
                epoc_FPtime_EEG = linspace(-epoc_start, epoc_end, 1000); % Default length
            end

            lineProps = {'Color', colors{i}}; % Sets line color and width
            shadedErrorBar(epoc_FPtime_EEG, results.(event_name).(eeg_bands{k}).mean, results.(event_name).(eeg_bands{k}).sem, lineProps, 1);
            plot(epoc_FPtime_EEG, results.(event_name).(eeg_bands{k}).mean, 'Color', colors{i}); % Event specific color

            % Add the data to the corresponding EEG table
            switch eeg_bands{k}
                case 'SO'
                    if i == 1
                        SO_table = table(epoc_FPtime_EEG(:), results.(event_name).(eeg_bands{k}).mean(:), results.(event_name).(eeg_bands{k}).sem(:), 'VariableNames', {'Time', sprintf('Mean_%s', event_name), sprintf('SEM_%s', event_name)});
                    else
                        SO_table = [SO_table, table(results.(event_name).(eeg_bands{k}).mean(:), results.(event_name).(eeg_bands{k}).sem(:), 'VariableNames', {sprintf('Mean_%s', event_name), sprintf('SEM_%s', event_name)})];
                    end
                case 'Delta'
                    if i == 1
                        Delta_table = table(epoc_FPtime_EEG(:), results.(event_name).(eeg_bands{k}).mean(:), results.(event_name).(eeg_bands{k}).sem(:), 'VariableNames', {'Time', sprintf('Mean_%s', event_name), sprintf('SEM_%s', event_name)});
                    else
                        Delta_table = [Delta_table, table(results.(event_name).(eeg_bands{k}).mean(:), results.(event_name).(eeg_bands{k}).sem(:), 'VariableNames', {sprintf('Mean_%s', event_name), sprintf('SEM_%s', event_name)})];
                    end
                case 'Theta'
                    if i == 1
                        Theta_table = table(epoc_FPtime_EEG(:), results.(event_name).(eeg_bands{k}).mean(:), results.(event_name).(eeg_bands{k}).sem(:), 'VariableNames', {'Time', sprintf('Mean_%s', event_name), sprintf('SEM_%s', event_name)});
                    else
                        Theta_table = [Theta_table, table(results.(event_name).(eeg_bands{k}).mean(:), results.(event_name).(eeg_bands{k}).sem(:), 'VariableNames', {sprintf('Mean_%s', event_name), sprintf('SEM_%s', event_name)})];
                    end
                case 'Sigma'
                    if i == 1
                        Sigma_table = table(epoc_FPtime_EEG(:), results.(event_name).(eeg_bands{k}).mean(:), results.(event_name).(eeg_bands{k}).sem(:), 'VariableNames', {'Time', sprintf('Mean_%s', event_name), sprintf('SEM_%s', event_name)});
                    else
                        Sigma_table = [Sigma_table, table(results.(event_name).(eeg_bands{k}).mean(:), results.(event_name).(eeg_bands{k}).sem(:), 'VariableNames', {sprintf('Mean_%s', event_name), sprintf('SEM_%s', event_name)})];
                    end
                case 'Beta'
                    if i == 1
                        Beta_table = table(epoc_FPtime_EEG(:), results.(event_name).(eeg_bands{k}).mean(:), results.(event_name).(eeg_bands{k}).sem(:), 'VariableNames', {'Time', sprintf('Mean_%s', event_name), sprintf('SEM_%s', event_name)});
                    else
                        Beta_table = [Beta_table, table(results.(event_name).(eeg_bands{k}).mean(:), results.(event_name).(eeg_bands{k}).sem(:), 'VariableNames', {sprintf('Mean_%s', event_name), sprintf('SEM_%s', event_name)})];
                    end
                case 'Gamma_low'
                    if i == 1
                        Gamma_low_table = table(epoc_FPtime_EEG(:), results.(event_name).(eeg_bands{k}).mean(:), results.(event_name).(eeg_bands{k}).sem(:), 'VariableNames', {'Time', sprintf('Mean_%s', event_name), sprintf('SEM_%s', event_name)});
                    else
                        Gamma_low_table = [Gamma_low_table, table(results.(event_name).(eeg_bands{k}).mean(:), results.(event_name).(eeg_bands{k}).sem(:), 'VariableNames', {sprintf('Mean_%s', event_name), sprintf('SEM_%s', event_name)})];
                    end
                case 'Gamma_high'
                    if i == 1
                        Gamma_high_table = table(epoc_FPtime_EEG(:), results.(event_name).(eeg_bands{k}).mean(:), results.(event_name).(eeg_bands{k}).sem(:), 'VariableNames', {'Time', sprintf('Mean_%s', event_name), sprintf('SEM_%s', event_name)});
                    else
                        Gamma_high_table = [Gamma_high_table, table(results.(event_name).(eeg_bands{k}).mean(:), results.(event_name).(eeg_bands{k}).sem(:), 'VariableNames', {sprintf('Mean_%s', event_name), sprintf('SEM_%s', event_name)})];
                    end
            end
        end
        plot([0 0], ylim, 'Color', [0.5 0.5 0.5], 'LineWidth', 1, 'LineStyle', '--');
        hold off;
        band_title = strrep(eeg_bands{k}, '_', ' '); % Replace underscores with spaces for titles
        n_events_all = arrayfun(@(i) results.(event_var_names{i}).(eeg_bands{k}).num_events, 1:numEventVars);
        n_events_str = format_num_events(n_events_all);
        title(sprintf('%s (%s Events)', band_title, n_events_str));
        ylabel('Power');
        xlim([-epoc_start, epoc_end]);
        grid on;
    end

    % Adjust overall plot settings
    sgtitle(main_title);
end
