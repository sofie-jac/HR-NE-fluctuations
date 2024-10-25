% Function to add 'Condition' column to a table
function updated_table = condition_column_to_AUC(table, arch_suffixes, yfp_suffixes)
    % Initialize the 'Condition' column with 'Unknown'
    condition_column = repmat({'Unknown'}, height(table), 1);
    
    % Assign 'arch' to the rows where Suffix belongs to arch_suffixes
    is_arch = ismember(table.SubjectID, arch_suffixes);
    condition_column(is_arch) = {'arch'};
    
    % Assign 'yfp' to the rows where Suffix belongs to yfp_suffixes
    is_yfp = ismember(table.SubjectID, yfp_suffixes);
    condition_column(is_yfp) = {'yfp'};
    
    % Convert the condition_column to a table and add it to the original table
    condition_table = array2table(condition_column, 'VariableNames', {'Condition'});
    updated_table = [table, condition_table];
end

