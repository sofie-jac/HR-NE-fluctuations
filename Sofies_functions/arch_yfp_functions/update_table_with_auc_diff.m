function updated_table = update_table_with_auc_diff(AUC_table, data_table)
    % Calculate AUC differences
    suffixes = unique(AUC_table.Suffix);
    mean_auc_diff = arrayfun(@(s) mean(AUC_table.AUC_post(strcmp(AUC_table.Suffix, s)) - ...
                                        AUC_table.AUC_pre(strcmp(AUC_table.Suffix, s))), suffixes);
    
    % Calculate mean AUC_pre and AUC_post for each suffix
    mean_auc_pre = arrayfun(@(s) mean(AUC_table.AUC_pre(strcmp(AUC_table.Suffix, s))), suffixes);
    mean_auc_post = arrayfun(@(s) mean(AUC_table.AUC_post(strcmp(AUC_table.Suffix, s))), suffixes);

    % Initialize the updated table
    updated_table = data_table;

    % Add AUC_diff, AUC_pre, and AUC_post to the table
    updated_table.AUC_diff = NaN(height(data_table), 1);
    updated_table.AUC_pre = NaN(height(data_table), 1);
    updated_table.AUC_post = NaN(height(data_table), 1);

    for i = 1:height(data_table)
        suffix = num2str(data_table.Suffix(i)); % Convert suffix to string
        if any(strcmp(suffixes, suffix))
            idx = strcmp(suffixes, suffix);
            updated_table.AUC_diff(i) = mean_auc_diff(idx);
            updated_table.AUC_pre(i) = mean_auc_pre(idx);
            updated_table.AUC_post(i) = mean_auc_post(idx);
        end
    end
end
