function plot_correlations_HRB(amplitude_diff_data, event_var)
    % Gather data for correlations
    NE_data = [];
    RR_data = [];
    SO_data = [];
    Delta_data = [];
    Theta_data = [];
    Sigma_data = [];
    Beta_data = [];
    Gamma_low_diff_data = [];
    Gamma_high_diff_data = [];
    group_labels = [];

    % Concatenate data from all unique IDs
    uniqueIds = fieldnames(amplitude_diff_data);
    exclude_ids = {'213', '205'};  % Define the IDs to be excluded

    for idx = 1:length(uniqueIds)
        uniqueId = uniqueIds{idx};
        if any(strcmp(uniqueId, exclude_ids))
            continue;  % Skip excluded IDs
        end
        for event_type = 1:length(event_var)
            event_type_name = event_var{event_type};
            if contains(uniqueId, event_type_name)
                NE_data = [NE_data; amplitude_diff_data.(uniqueId).NE_diff];
                RR_data = [RR_data; amplitude_diff_data.(uniqueId).RR_diff];
                
                if isfield(amplitude_diff_data.(uniqueId), 'SO_diff')
                    SO_data = [SO_data; amplitude_diff_data.(uniqueId).SO_diff];
                else
                    SO_data = [SO_data; NaN(length(amplitude_diff_data.(uniqueId).RR_diff), 1)];
                end
                if isfield(amplitude_diff_data.(uniqueId), 'Delta_diff')
                    Delta_data = [Delta_data; amplitude_diff_data.(uniqueId).Delta_diff];
                else
                    Delta_data = [Delta_data; NaN(length(amplitude_diff_data.(uniqueId).RR_diff), 1)];
                end
                if isfield(amplitude_diff_data.(uniqueId), 'Theta_diff')
                    Theta_data = [Theta_data; amplitude_diff_data.(uniqueId).Theta_diff];
                else
                    Theta_data = [Theta_data; NaN(length(amplitude_diff_data.(uniqueId).RR_diff), 1)];
                end
                if isfield(amplitude_diff_data.(uniqueId), 'Sigma_diff')
                    Sigma_data = [Sigma_data; amplitude_diff_data.(uniqueId).Sigma_diff];
                else
                    Sigma_data = [Sigma_data; NaN(length(amplitude_diff_data.(uniqueId).RR_diff), 1)];
                end
                if isfield(amplitude_diff_data.(uniqueId), 'Beta_diff')
                    Beta_data = [Beta_data; amplitude_diff_data.(uniqueId).Beta_diff];
                else
                    Beta_data = [Beta_data; NaN(length(amplitude_diff_data.(uniqueId).RR_diff), 1)];
                end
                if isfield(amplitude_diff_data.(uniqueId), 'Gamma_low_diff')
                    Gamma_low_diff_data = [Gamma_low_diff_data; amplitude_diff_data.(uniqueId).Gamma_low_diff];
                else
                    Gamma_low_diff_data = [Gamma_low_diff_data; NaN(length(amplitude_diff_data.(uniqueId).RR_diff), 1)];
                end
                if isfield(amplitude_diff_data.(uniqueId), 'Gamma_high_diff')
                    Gamma_high_diff_data = [Gamma_high_diff_data; amplitude_diff_data.(uniqueId).Gamma_high_diff];
                else
                    Gamma_high_diff_data = [Gamma_high_diff_data; NaN(length(amplitude_diff_data.(uniqueId).RR_diff), 1)];
                end
                
                group_labels = [group_labels; repmat(event_type, length(amplitude_diff_data.(uniqueId).RR_diff), 1)];
            end
        end
    end

    % Debugging: Display data after concatenation
    disp('NE_data:');
    disp(NE_data);
    disp('RR_data:');
    disp(RR_data);
    disp('SO_data:');
    disp(SO_data);
    disp('Delta_data:');
    disp(Delta_data);
    disp('Theta_data:');
    disp(Theta_data);
    disp('Sigma_data:');
    disp(Sigma_data);
    disp('Beta_data:');
    disp(Beta_data);
    disp('Gamma_low_diff_data:');
    disp(Gamma_low_diff_data);
    disp('Gamma_high_diff_data:');
    disp(Gamma_high_diff_data);

    % Define the bands and their corresponding data
    bands = {'NE', 'SO', 'Delta', 'Theta', 'Sigma', 'Beta', 'Gamma Low', 'Gamma High'};
    data = {NE_data, SO_data, Delta_data, Theta_data, Sigma_data, Beta_data, Gamma_low_diff_data, Gamma_high_diff_data};
    colors = lines(length(event_var));  % Generate distinct colors for each event_var

    % Create a figure with subplots for each band
    figure('Name', 'Correlation Plots', 'NumberTitle', 'off');
    set(gcf, 'Color', 'w');

    for i = 1:length(bands)
        subplot(4, 2, i);
        hold on;
        
        % Plot data points for each event type
        for event_type = 1:length(event_var)
            event_type_name = event_var{event_type};
            idx = group_labels == event_type;
            if i == 1
                x = NE_data(idx);
                y = RR_data(idx);
            else
                x = RR_data(idx);
                y = data{i}(idx);
            end
            valid_idx = ~isnan(y) & ~isnan(x); % Exclude NaNs
            x = x(valid_idx); % Ensure x and y are matched
            y = y(valid_idx);
            
            % Debugging: Display valid indices and corresponding data points
            disp(['Event Type: ', event_type_name, ', Band: ', bands{i}]);
            disp('Valid indices:');
            disp(valid_idx);
            disp('x:');
            disp(x);
            disp('y:');
            
            % Plot the data points
            scatter(x, y, 100, 'o', 'MarkerEdgeColor', colors(event_type, :), 'MarkerFaceColor', colors(event_type, :), 'DisplayName', event_type_name);
        end

        % Run a single correlation analysis for all data points combined
        if i == 1
            x_all = NE_data(~isnan(RR_data));
            y_all = RR_data(~isnan(RR_data));
        else
            x_all = RR_data(~isnan(data{i}));
            y_all = data{i}(~isnan(data{i}));
        end
        valid_idx = ~isnan(x_all) & ~isnan(y_all);
        x_all = x_all(valid_idx);
        y_all = y_all(valid_idx);

        % Debugging: Display combined data points for correlation
        disp(['Combined data for Band: ', bands{i}]);
        disp('x_all:');
        disp(x_all);
        disp('y_all:');
        
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
        if i == 1
            xlabel('NE Difference');
            ylabel('RR Difference');
            title('Correlation between NE and RR');
        else
            xlabel('RR Difference');
            ylabel([bands{i} ' Difference']);
            title(['Correlation between RR and ', bands{i}]);
        end

        % Add legend
        legend('Location', 'northeast');
        
        % Adjust plot appearance
        grid on;
        hold off;
    end
end
