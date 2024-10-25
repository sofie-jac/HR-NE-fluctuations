function updated_table = add_condition_column(table)
    % Extract the 'EventVar' column
    event_var = table.EventVar;
    
    % Initialize the new columns
    condition_column = cell(height(table), 1);
    new_eventvar_column = cell(height(table), 1);
    
    % Loop over each entry in the EventVar column
    for i = 1:height(table)
        parts = strsplit(event_var{i}, '_'); % Split the string at the underscore
        condition_column{i} = parts{1};      % Everything before the underscore
        new_eventvar_column{i} = parts{2};   % Everything after the underscore
    end
    
    % Convert the new columns to tables
    condition_table = array2table(condition_column, 'VariableNames', {'Condition'});
    eventvar_table = array2table(new_eventvar_column, 'VariableNames', {'EventVar'});
    
    % Replace the old 'EventVar' column and add the new 'Condition' column
    updated_table = [table(:, setdiff(table.Properties.VariableNames, 'EventVar')), condition_table, eventvar_table];
end