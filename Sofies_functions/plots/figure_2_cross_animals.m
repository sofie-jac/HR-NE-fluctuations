function figure_2_cross_animals(results, global_max, global_min, epoc_start, epoc_end, main_title, titles)
    
% Define the number of rows and columns for subplot
    numEventVars = length(fieldnames(results));
    numColumns = 4; % NE, RR, x-corr, and EEG bands

    % Initialize the figure
    figure('Name', 'Event Data Analysis', 'NumberTitle', 'off');
    set(gcf, 'Color', 'w'); % Set background color to white

    event_var_names = fieldnames(results);
    
    % Iterate over each event type
    for i = 1:numEventVars
        event_name = event_var_names{i};
        
        % Adjust subplot titles based on titles array
        currentTitle = titles{i};

        % Determine the length of time vectors dynamically from data if available
        if isfield(results.(event_name), 'NE')
            lenNE = length(results.(event_name).NE.mean);
            epoc_FPtime_NE = linspace(-epoc_start, epoc_end, lenNE);
        else
            epoc_FPtime_NE = linspace(-epoc_start, epoc_end, 1000);  % Default length
        end

        if isfield(results.(event_name), 'RR')
            lenRR = length(results.(event_name).RR.mean);
            epoc_FPtime_RR = linspace(-epoc_start, epoc_end, lenRR);
        else
            epoc_FPtime_RR = linspace(-epoc_start, epoc_end, 1000);  % Default length
        end

        if isfield(results.(event_name), 'SO')
            lenSO = length(results.(event_name).SO.mean);
            epoc_FPtime_EEG = linspace(-epoc_start, epoc_end, lenSO);
        else
            epoc_FPtime_EEG = linspace(-epoc_start, epoc_end, 1000);  % Default length
        end

        % Plot NE data
        subplot(numEventVars, numColumns, (i-1)*numColumns + 1);
        lineProps = {'Color', [0 0.4470 0.7410]};  % Sets line color and width
        hold on
        plot([0 0], [global_min.NE, global_max.NE], 'Color', [0.5 0.5 0.5], 'LineWidth', 1, 'LineStyle', '--');
        shadedErrorBar(epoc_FPtime_NE, results.(event_name).NE.mean, results.(event_name).NE.sem, lineProps, 1);
        plot(epoc_FPtime_NE, results.(event_name).NE.mean, 'Color', [0 0.4470 0.7410]);  % Light blue
        hold off
        %plot_data_with_error('NE', currentTitle, epoc_FPtime_NE, results.(event_name), global_max, global_min, results.(event_name).NE.num_events);
        n_events = results.(event_name).NE.num_events; % Assuming num_events is stored correctly in data structure
        title(sprintf('NE %s (%d Events)', currentTitle, n_events));
        ylabel('Delta F/F');
        xlim([-epoc_start, epoc_end]);
        ylim([global_min.NE, global_max.NE]);
        grid on;

        % Plot RR data
        subplot(numEventVars, numColumns, (i-1)*numColumns + 2);
        lineProps = {'Color',[0.8500 0.3250 0.0980]};  % Sets line color and width
        hold on
        plot([0 0], [global_min.RR, global_max.RR], 'Color', [0.5 0.5 0.5], 'LineWidth', 1, 'LineStyle', '--');
        shadedErrorBar(epoc_FPtime_RR, results.(event_name).RR.mean, results.(event_name).RR.sem, lineProps, 1);
        plot(epoc_FPtime_RR, results.(event_name).RR.mean, 'Color', [0.8500 0.3250 0.0980]); 
        hold off
        %plot_data_with_error('RR', currentTitle, epoc_FPtime_RR, results.(event_name), global_max, global_min, results.(event_name).RR.num_events);
        n_events = results.(event_name).RR.num_events; % Assuming num_events is stored correctly in data structure
        title(sprintf('RR %s (%d Events)', currentTitle, n_events));
        ylabel('RR Intervals (s)');
        xlim([-epoc_start, epoc_end]);
        ylim([global_min.RR, global_max.RR]);
        grid on;
        %plot_data_with_error('RR', currentTitle, epoc_FPtime_RR, results.(event_name), global_max, global_min, results.(event_name).RR.num_events);

        % Plot x-corr data
        subplot(numEventVars, numColumns, (i-1)*numColumns + 3);
        lineProps = {'Color',[0.4660 0.6740 0.1880]};  % Sets line color and width
        hold on
        plot([0 0], [global_min.x_corr, global_max.x_corr], 'Color', [0.5 0.5 0.5], 'LineWidth', 1, 'LineStyle', '--');
        shadedErrorBar(epoc_FPtime_RR, results.(event_name).x_corr.mean, results.(event_name).x_corr.sem, lineProps, 1);
        plot(epoc_FPtime_RR, results.(event_name).x_corr.mean, 'Color',[0.4660 0.6740 0.1880]);  % Light green
        hold off
        %plot_data_with_error('x_corr', currentTitle, epoc_FPtime_x_corr, results.(event_name), global_max, global_min, results.(event_name).x_corr.num_events);
        n_events = results.(event_name).x_corr.num_events; % Assuming num_events is stored correctly in data structure
        title(sprintf('x-corr %s (%d Events)', currentTitle, n_events));
        ylabel('R');
        xlim([-epoc_start, epoc_end]);
        ylim([global_min.x_corr, global_max.x_corr]);
        grid on;
       % plot_data_with_error('x_corr', currentTitle, epoc_FPtime_RR, results.(event_name), global_max, global_min, results.(event_name).x_corr.num_events);

        % Plot EEG bands data
        subplot(numEventVars, numColumns, (i-1)*numColumns + 4);
        %plot_EEG_bands(currentTitle, epoc_FPtime_EEG, results.(event_name), global_max, global_min);
            hold on;
        eeg_bands = {'SO', 'Delta', 'Theta', 'Sigma', 'Beta', 'Gamma_low', 'Gamma_high'};
        colors = lines(numel(eeg_bands));  % Get distinct colors for each EEG band
        legend_entries = {};
        plot([0 0], [global_min.EEG_bands, global_max.EEG_bands], 'Color', [0.5 0.5 0.5], 'LineWidth', 1, 'LineStyle', '--', 'HandleVisibility', 'off');
        for i = 1:length(eeg_bands)
            display_names = {'SO', 'Delta', 'Theta', 'Sigma', 'Beta', 'Gamma (low)', 'Gamma (high)'};
            band = eeg_bands{i};
            plot(epoc_FPtime_EEG, results.(event_name).(band).mean, 'Color', colors(i,:), 'DisplayName', display_names{i});
            legend_entries{end+1} = display_names{i};
        end
        if ~isempty(legend_entries)
            legend(legend_entries, 'Location', 'EastOutside');
        end
        hold off
        %plot_data_with_error('NE', currentTitle, epoc_FPtime_NE, results.(event_name), global_max, global_min, results.(event_name).NE.num_events);
        n_events = results.(event_name).SO.num_events; % Assuming num_events is stored correctly in data structure
        title(sprintf('EEG %s (%d Events)', currentTitle, n_events));
        ylabel('Power');
        xlim([-epoc_start, epoc_end]);
        ylim([global_min.EEG_bands, global_max.EEG_bands]);
        grid on;
    end

    % Adjust overall plot settings
    sgtitle(main_title);

end



