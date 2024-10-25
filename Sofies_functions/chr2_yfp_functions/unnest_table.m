function new_table = unnest_table(tableName)
    % Extract the first row as headers
    headers = tableName(1, :);
    
    % Extract the rest of the rows as the actual data
    data = tableName(2:end, :);
    
    % Convert the first row into cell array for headers
    headers_cell = table2cell(headers);
    
    % Create a new table with the headers as variable names
    new_table = array2table(table2array(data), 'VariableNames', headers_cell);
    
    % Display the new table
    disp(new_table);
end