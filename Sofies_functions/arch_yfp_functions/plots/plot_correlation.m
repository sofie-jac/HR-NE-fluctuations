function plot_correlation(amplitude_diff_data, event_var)
    % Gather data for correlations
    NE_data = [];
    RR_data = [];
    SO_data = [];
    Delta_data = [];
    Theta_data = [];
    Sigma_data = [];
    Beta_data = [];
    group_labels = [];

    % Concatenate data from all unique IDs
    uniqueIds = fieldnames(amplitude_diff_data);
    for idx = 1:length(uniqueIds)
        uniqueId = uniqueIds{idx};
        for event_type = 1:length(event_var)
            event_type_name = event_var{event_type};
            if contains(uniqueId, event_type_name)
                NE_data = [NE_data; amplitude_diff_data.(uniqueId).NE_diff];
                RR_data = [RR_data; amplitude_diff_data.(uniqueId).RR_diff];
                SO_data = [SO_data; amplitude_diff_data.(uniqueId).SO_diff];
                Delta_data = [Delta_data; amplitude_diff_data.(uniqueId).Delta_diff];
                Theta_data = [Theta_data; amplitude_diff_data.(uniqueId).Theta_diff];
                Sigma_data = [Sigma_data; amplitude_diff_data.(uniqueId).Sigma_diff];
                Beta_data = [Beta_data; amplitude_diff_data.(uniqueId).Beta_diff];
                group_labels = [group_labels; repmat(event_type, length(amplitude_diff_data.(uniqueId).NE_diff), 1)];
            end
        end
    end

    % Define the bands and their corresponding data
    bands = {'RR', 'SO', 'Delta', 'Theta', 'Sigma', 'Beta'};
    data = {RR_data, SO_data, Delta_data, Theta_data, Sigma_data, Beta_data};

    % Create separate correlation plots for each event variable
    for event_type = 1:length(event_var)
        event_type_name = event_var{event_type};

        figure('Name', ['Correlation Plots for ', event_type_name], 'NumberTitle', 'off');
        set(gcf, 'Color', 'w');

        for i = 1:length(bands)
            subplot(3, 2, i);
            hold on;
            
            % Extract data for the current event type
            idx = group_labels == event_type;
            x = NE_data(idx);
            y = data{i}(idx);

            % Plot the data points
            scatter(x, y, 100, 'o', 'MarkerEdgeColor', [0 0.4470 0.7410], 'MarkerFaceColor', [0 0.4470 0.7410]);

            % Calculate and plot linear fit
            lm = fitlm(x, y);
            plot(lm);
            
            % Extract R and p-value
            R = lm.Rsquared.Ordinary;
            p = coefTest(lm);
            
            % Display correlation coefficient and p-value on the plot
            text(min(x) + 0.1 * range(x), max(y) - 0.1 * range(y), ...
                sprintf('R^2 = %.2f\np = %.3f', R, p), 'FontSize', 12, 'BackgroundColor', 'w');

            % Set labels and title
            xlabel('NE Difference');
            ylabel([bands{i} ' Difference']);
            title(['Correlation between NE and ', bands{i}]);

            % Adjust plot appearance
            grid on;
            hold off;
        end

        % Add a main title to the figure
        sgtitle(['Correlation Plots for ', event_type_name]);
    end
end
