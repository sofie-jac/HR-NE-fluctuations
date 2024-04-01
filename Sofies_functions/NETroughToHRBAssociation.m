function resultsTable = NETroughToHRBAssociation(trough_variables, all_trough_times, HRB_time)

results = cell(size(trough_variables, 1), 2); % Prepare results container

for i = 1:size(trough_variables, 1)
    trough_name = trough_variables{i, 1};
    trough_times = trough_variables{i, 2};
    
    associated_count = 0; % Initialize counter for troughs with associated HRB
    
    for j = 1:length(trough_times)
        % Find HRBs within 15 seconds after the current trough
        hrb_within_15 = HRB_time(HRB_time >= trough_times(j) & HRB_time <= trough_times(j) + 15);
        
        % Check if there's another trough from any variable between the current trough and the closest HRB
        if ~isempty(hrb_within_15)
            closest_HRB = min(hrb_within_15); % Closest HRB after the trough
            % Find troughs between current trough and closest HRB
            troughs_in_between = all_trough_times(all_trough_times > trough_times(j) & all_trough_times < closest_HRB);
            if isempty(troughs_in_between)
                associated_count = associated_count + 1;
            end
        end
    end
    
    % Calculate percentage
    percentage = (associated_count / length(trough_times)) * 100;
    
    % Store results
    results{i, 1} = trough_name;
    results{i, 2} = percentage;
end

% Convert results to a table for better readability
resultsTable = cell2table(results, 'VariableNames', {'Trough Variable', 'Percentage Associated with HRB'});