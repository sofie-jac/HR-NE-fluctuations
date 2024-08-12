function auc_diff_table_mean = compute_mean_by_subject(auc_diff_table)
    % Compute the mean for each SubjectID
    auc_diff_table_mean = varfun(@mean, auc_diff_table, 'InputVariables', ...
        {'NE', 'RR', 'SO', 'Delta', 'Theta', 'Sigma', 'Beta', 'Gamma_low', 'Gamma_high'}, ...
        'GroupingVariables', 'SubjectID');
    
    % Rename the SubjectID column to Suffix
    auc_diff_table_mean.Properties.VariableNames{'SubjectID'} = 'Suffix';
end
