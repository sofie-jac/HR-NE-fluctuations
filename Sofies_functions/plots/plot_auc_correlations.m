function plot_auc_correlations(auc_data, event_var, subjects)
    data_types = {'RR', 'SO', 'Delta', 'Theta', 'Sigma', 'Beta'};
    exclude_ids = {'213', '205'};
    colors = lines(length(event_var));

    figure('Name', 'AUC Correlation Plots', 'NumberTitle', 'off');
    set(gcf, 'Color', 'w');

    for i = 1:length(data_types)
        subplot(3, 2, i);
        hold on;

        x_all = [];
        y_all = [];

        for event_type = 1:length(event_var)
            event_type_name = event_var{event_type};
            x = [];
            y = [];

            for idx = 1:length(subjects)
                uniqueId = subjects{idx};
                if any(strcmp(uniqueId, exclude_ids)) && ~strcmp(data_types{i}, 'RR')
                    continue;
                end
                field_name = sprintf('%s_%s', event_type_name, uniqueId);
                if isfield(auc_data, field_name)
                    if isfield(auc_data.(field_name), 'NE') && isfield(auc_data.(field_name), data_types{i})
                        x = [x; auc_data.(field_name).NE];
                        y = [y; auc_data.(field_name).(data_types{i})];
                    end
                end
            end

            x_all = [x_all; x];
            y_all = [y_all; y];

            % Plot the data points
            scatter(x, y, 100, 'o', 'MarkerEdgeColor', colors(event_type, :), 'MarkerFaceColor', colors(event_type, :), 'DisplayName', event_var{event_type});
        end

        % Calculate and plot linear fit
        if length(x_all) > 1 && length(y_all) > 1
            lm = fitlm(x_all, y_all);
            plot(lm);

            % Extract R and p-value
            R = lm.Rsquared.Ordinary;
            p = coefTest(lm);

            % Display correlation coefficient and p-value on the plot
            text(min(x_all) + 0.1 * range(x_all), max(y_all) - 0.1 * range(y_all), ...
                sprintf('R^2 = %.2f\np = %.3f', R, p), 'FontSize', 12, 'BackgroundColor', 'w');
        end

        % Set labels and title
        xlabel('NE AUC');
        ylabel([data_types{i} ' AUC']);
        title(['Correlation between NE and ', data_types{i}]);

        % Add legend
        legend('Location', 'best');
        grid on;
        hold off;
    end
end