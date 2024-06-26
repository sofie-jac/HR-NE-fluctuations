function plot_amplitude_diff_bar(amplitude_diff_data, event_var, subjects, titles)
    data_types = {'NE', 'RR', 'SO', 'Delta', 'Theta', 'Sigma', 'Beta', 'Gamma_low', 'Gamma_high'};
    exclude_ids = {'213', '205'};
    colors = {[0 0.4470 0.7410], [0.8500 0.3250 0.0980], [0.9290 0.6940 0.1250], [0.4660 0.6740 0.1880]};

    % Initialize matrices to store mean and SEM values
    mean_diff = zeros(length(data_types), length(event_var));
    sem_diff = zeros(length(data_types), length(event_var));

    for data_idx = 1:length(data_types)
        data_type = data_types{data_idx};
        
        for stage_idx = 1:length(event_var)
            event_type_name = event_var{stage_idx};
            subject_diffs = [];

            for idx = 1:length(subjects)
                uniqueId = subjects{idx};
                if any(strcmp(uniqueId, exclude_ids)) && ~ismember(data_type, {'NE', 'RR'})
                    continue;
                end
                field_name = sprintf('%s_%s', event_type_name, uniqueId);
                if isfield(amplitude_diff_data, field_name) && isfield(amplitude_diff_data.(field_name), [data_type '_diff'])
                    diff_values = amplitude_diff_data.(field_name).([data_type '_diff']);
                    subject_diffs = [subject_diffs; diff_values];
                end
            end

            mean_diff(data_idx, stage_idx) = mean(subject_diffs, 'omitnan');
            sem_diff(data_idx, stage_idx) = std(subject_diffs, 'omitnan') / sqrt(length(subject_diffs));
        end
    end

    % Create subplots for each data type
    figure('Name', 'Amplitude Bar Plots', 'NumberTitle', 'off');
    set(gcf, 'Color', 'w');

    for data_idx = 1:length(data_types)
        subplot(3, 3, data_idx);
        hold on;

        % Create bar plot and set bar colors
        b = bar(mean_diff(data_idx, :), 'FaceColor', 'flat');
        for k = 1:length(event_var)
            b.CData(k,:) = colors{k};
        end

        % Add error bars
        errorbar(1:length(event_var), mean_diff(data_idx, :), sem_diff(data_idx, :), 'k', 'linestyle', 'none');

        % Set subplot properties
        set(gca, 'XTick', 1:length(event_var), 'XTickLabel', titles, 'XTickLabelRotation', 45);
        ylabel('Amplitude');

        % Adjust subplot titles for Gamma variables
        if strcmp(data_types{data_idx}, 'Gamma_low')
            title('Gamma (low)');
        elseif strcmp(data_types{data_idx}, 'Gamma_high')
            title('Gamma (high)');
        else
            title(data_types{data_idx});
        end

        % Adjust y-limits to fit error bars
        mean_values = mean_diff(data_idx, :);
        all_values = [mean_values - sem_diff(data_idx, :), mean_values + sem_diff(data_idx, :)];
        min_ylim = min(all_values) - 0.1 * range(all_values);
        max_ylim = max(all_values) + 0.1 * range(all_values);
        ylim([min_ylim, max_ylim]);

        hold off;
    end

    sgtitle('Amplitude Bar Plots for Each Data Type');
end

%This works - old version was for safekeeping



% function plot_amplitude_diff_bar(amplitude_diff_data, event_var, subjects, titles)
%     data_types = {'NE', 'RR', 'SO', 'Delta', 'Theta', 'Sigma', 'Beta', 'Gamma_low', 'Gamma_high'};
%     exclude_ids = {'213', '205'};
% 
%     % Initialize matrices to store mean and SEM values
%     mean_diff = zeros(length(data_types), length(event_var));
%     sem_diff = zeros(length(data_types), length(event_var));
% 
%     for data_idx = 1:length(data_types)
%         data_type = data_types{data_idx};
% 
%         for stage_idx = 1:length(event_var)
%             event_type_name = event_var{stage_idx};
%             subject_diffs = [];
% 
%             for idx = 1:length(subjects)
%                 uniqueId = subjects{idx};
%                 if any(strcmp(uniqueId, exclude_ids)) && ~ismember(data_type, {'NE', 'RR'})
%                     continue;
%                 end
%                 field_name = sprintf('%s_%s', event_type_name, uniqueId);
%                 if isfield(amplitude_diff_data, field_name) && isfield(amplitude_diff_data.(field_name), [data_type '_diff'])
%                     diff_values = amplitude_diff_data.(field_name).([data_type '_diff']);
%                     subject_diffs = [subject_diffs; diff_values];
%                 end
%             end
% 
%             mean_diff(data_idx, stage_idx) = mean(subject_diffs, 'omitnan');
%             sem_diff(data_idx, stage_idx) = std(subject_diffs, 'omitnan') / sqrt(length(subject_diffs));
%         end
%     end
% 
%     % Create subplots for each data type
%     figure('Name', 'Amplitude Difference Bar Plots', 'NumberTitle', 'off');
%     set(gcf, 'Color', 'w');
% 
%     for data_idx = 1:length(data_types)
%         subplot(3, 3, data_idx);
%         hold on;
% 
%         % Create bar plot
%         b = bar(mean_diff(data_idx, :), 'FaceColor', 'flat');
% 
%         % Add error bars
%         errorbar(1:length(event_var), mean_diff(data_idx, :), sem_diff(data_idx, :), 'k', 'linestyle', 'none');
% 
%         % Set subplot properties
%         set(gca, 'XTick', 1:length(event_var), 'XTickLabel', titles, 'XTickLabelRotation', 45);
%         ylabel('Amplitude Difference');
%         title(data_types{data_idx});
% 
%         % Adjust y-limits
%         min_ylim = min(mean_diff(data_idx, :) - sem_diff(data_idx, :));
%         max_ylim = max(mean_diff(data_idx, :) + sem_diff(data_idx, :));
%         ylim([min_ylim, max_ylim]);
% 
%         hold off;
%     end
% 
%     sgtitle('Amplitude Difference Bar Plots for Each Data Type');
% end