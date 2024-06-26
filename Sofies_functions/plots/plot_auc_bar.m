function auc_diff_table = plot_auc_bar(auc_data, event_var, subjects, titles)
    data_types = {'NE', 'RR', 'SO', 'Delta', 'Theta', 'Sigma', 'Beta', 'Gamma_low', 'Gamma_high'};
    exclude_ids = {'213', '205'};

    % Initialize structure to store individual AUC differences for each data type
    auc_diffs = struct();
    for i = 1:length(data_types)
        auc_diffs.(data_types{i}) = [];
    end
    auc_diffs.EventVar = [];
    auc_diffs.SubjectID = [];

    % Iterate through each field in auc_data
    field_names = fieldnames(auc_data);
    for field_idx = 1:length(field_names)
        field_name = field_names{field_idx};
        subject_id = field_name(end-2:end);
        event_type_name = field_name(1:end-4);

        if ismember(subject_id, exclude_ids)
            relevant_data_types = {'NE', 'RR'};
        else
            relevant_data_types = data_types;
        end

        % Create a placeholder for each data type to ensure consistent row count
        temp_diffs = struct();
        for i = 1:length(data_types)
            temp_diffs.(data_types{i}) = NaN;
        end

        for data_idx = 1:length(data_types)
            data_type = data_types{data_idx};
            if isfield(auc_data.(field_name), [data_type '_pre']) && isfield(auc_data.(field_name), [data_type '_post'])
                pre_values = auc_data.(field_name).([data_type '_pre']);
                post_values = auc_data.(field_name).([data_type '_post']);
                auc_diff = post_values - pre_values;

                if ismember(subject_id, exclude_ids) && ~ismember(data_type, {'NE', 'RR'})
                    % If the subject is excluded, set EEG bands to NaN
                    temp_diffs.(data_type) = NaN(size(auc_diff));
                else
                    % Store individual AUC differences for each data type
                    temp_diffs.(data_type) = auc_diff;
                end
            elseif ismember(subject_id, exclude_ids) && ~ismember(data_type, {'NE', 'RR'})
                % If the subject is excluded and the data type is an EEG band, set to NaN
                temp_diffs.(data_type) = NaN(length(pre_values), 1);
            end
        end

        % Append the data to the main structure
        for i = 1:length(data_types)
            data_type = data_types{i};
            auc_diffs.(data_type) = [auc_diffs.(data_type); temp_diffs.(data_type)];
        end
        num_values = length(temp_diffs.NE);  % Assuming NE has all entries, you can use any other non-EEG band for this
        auc_diffs.EventVar = [auc_diffs.EventVar; repmat({event_type_name}, num_values, 1)];
        auc_diffs.SubjectID = [auc_diffs.SubjectID; repmat({subject_id}, num_values, 1)];
    end

    % Convert to table to get unique EventVars and assign numbers
    temp_table = table(auc_diffs.EventVar, 'VariableNames', {'EventVar'});
    [unique_event_vars, ~, event_var_nums] = unique(temp_table.EventVar);
    auc_diffs.EventVar_num = event_var_nums;

    % Create table to store individual AUC differences
    auc_diff_table = table(auc_diffs.NE, auc_diffs.RR, auc_diffs.SO, auc_diffs.Delta, auc_diffs.Theta, auc_diffs.Sigma, auc_diffs.Beta, auc_diffs.Gamma_low, auc_diffs.Gamma_high, auc_diffs.EventVar, auc_diffs.SubjectID, auc_diffs.EventVar_num, ...
        'VariableNames', {'NE', 'RR', 'SO', 'Delta', 'Theta', 'Sigma', 'Beta', 'Gamma_low', 'Gamma_high', 'EventVar', 'SubjectID', 'EventVar_num'});

    % Initialize matrices to store mean and SEM values for AUC differences
    mean_auc_diff = zeros(length(data_types), length(event_var));
    sem_auc_diff = zeros(length(data_types), length(event_var));

    for data_idx = 1:length(data_types)
        data_type = data_types{data_idx};
        
        for stage_idx = 1:length(event_var)
            event_type_name = event_var{stage_idx};
            subject_auc_diffs = [];

            for idx = 1:length(subjects)
                uniqueId = subjects{idx};
                if any(strcmp(uniqueId, exclude_ids)) && ~ismember(data_type, {'NE', 'RR'})
                    continue;
                end
                field_name = sprintf('%s_%s', event_type_name, uniqueId);
                if isfield(auc_data, field_name) && isfield(auc_data.(field_name), [data_type '_pre']) && isfield(auc_data.(field_name), [data_type '_post'])
                    pre_values = auc_data.(field_name).([data_type '_pre']);
                    post_values = auc_data.(field_name).([data_type '_post']);
                    auc_diff = post_values - pre_values;
                    subject_auc_diffs = [subject_auc_diffs; auc_diff];
                end
            end

            mean_auc_diff(data_idx, stage_idx) = mean(subject_auc_diffs, 'omitnan');
            sem_auc_diff(data_idx, stage_idx) = std(subject_auc_diffs, 'omitnan') / sqrt(length(subject_auc_diffs));
        end
    end

    % Create subplots for each data type
    figure('Name', 'AUC Difference Bar Plots', 'NumberTitle', 'off');
    set(gcf, 'Color', 'w');

    for data_idx = 1:length(data_types)
        subplot(3, 3, data_idx);
        hold on;
        
        % Create bar plot
        b = bar(mean_auc_diff(data_idx, :), 'FaceColor', 'flat');
        
        % Add error bars
        errorbar(b.XEndPoints, mean_auc_diff(data_idx, :), sem_auc_diff(data_idx, :), 'k', 'linestyle', 'none');

        % Set subplot properties
        set(gca, 'XTick', 1:length(event_var), 'XTickLabel', titles, 'XTickLabelRotation', 45);
        ylabel('AUC Difference');
        title(data_types{data_idx});
        
        % Adjust y-limits
        min_ylim = min(mean_auc_diff(data_idx, :) - sem_auc_diff(data_idx, :));
        max_ylim = max(mean_auc_diff(data_idx, :) + sem_auc_diff(data_idx, :));
        ylim([min_ylim, max_ylim]);
        
        hold off;
    end

    sgtitle('AUC Difference Bar Plots for Each Data Type');
end
