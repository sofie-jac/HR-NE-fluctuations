% Define a function to process the nested cell arrays
function resultTable = processNestedCellsChr2(nestedCells, f, groupName)
    % Initialize empty arrays for storing means and SEMs
    all_means = [];
    all_sems = [];
    
    % Loop through each laser level (1 to 5)
    for laser_level = 1:5
        if ~isempty(nestedCells{laser_level, 1})
            mean_values = nestedCells{laser_level, 1};
            sem_values = nestedCells{laser_level, 2};

            % Downsample if there are more than 1000 columns
            % if size(mean_values, 2) > 1000
            %     mean_values = mean_values(1:10:end);
            %     sem_values = sem_values(1:10:end);
            %     f = f(1:10:end);
            % end
            
            % Append to the arrays
            all_means = [all_means, mean_values'];
            all_sems = [all_sems, sem_values'];
        end
    end
    
    % Create a table with appropriate headers
    headers = {strcat(groupName, '_Laser1_Mean'), strcat(groupName, '_Laser1_SEM'), ...
               strcat(groupName, '_Laser2_Mean'), strcat(groupName, '_Laser2_SEM'), ...
               strcat(groupName, '_Laser3_Mean'), strcat(groupName, '_Laser3_SEM'), ...
               strcat(groupName, '_Laser4_Mean'), strcat(groupName, '_Laser4_SEM'), ...
               strcat(groupName, '_Laser5_Mean'), strcat(groupName, '_Laser5_SEM')};
    
    % Combine means and SEMs into a single array
    combined_values = [all_means, all_sems];
    
    % Convert to table
    resultTable = array2table(combined_values, 'VariableNames', headers);
    
    % If 'f' is provided, add it as the first column in the final table
    if nargin == 3
        % Ensure 'f' is a column vector
        f = f(:);
        % Create a table for 'f' and concatenate it with the resultTable
        f_table = table(f, 'VariableNames', {'f'});
        resultTable = [f_table, resultTable];
    end
end
