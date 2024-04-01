function [NE_associated_HRB_time, HRB_times_no_troughs] = separateHRBAssociatedTroughs(trough_variables, all_trough_times, HRB_time)

% Initialize a variable to store HRB times associated with any NE trough
NE_associated_HRB_time = [];
disp('Following variables have been generated:')
% Iterate over each set of trough times
for i = 1:size(trough_variables, 1)
    trough_name = trough_variables{i, 1};
    trough_times = trough_variables{i, 2};
    
    % Sanitize the trough_name to create a valid MATLAB variable name
    valid_trough_name = matlab.lang.makeValidName(trough_name);
    
    % Initialize variables to hold HRB-associated and non-associated trough times
    trough_HRB = []; % For troughs with an associated HRB
    trough_no_HRB = []; % For troughs without an associated HRB
    
    % Check each trough for an associated HRB
    for j = 1:length(trough_times)
        % Find HRBs within 15 seconds after the current trough
        hrb_within_15 = HRB_time(HRB_time >= trough_times(j) & HRB_time <= trough_times(j) + 15);
        
        if ~isempty(hrb_within_15)
            closest_HRB = min(hrb_within_15); % Closest HRB after the trough
            % Find troughs between current trough and closest HRB
            troughs_in_between = all_trough_times(all_trough_times > trough_times(j) & all_trough_times < closest_HRB);
            if isempty(troughs_in_between)
                trough_HRB = [trough_HRB; trough_times(j)]; % Associate this trough with an HRB
                NE_associated_HRB_time = [NE_associated_HRB_time; closest_HRB];
            else
                trough_no_HRB = [trough_no_HRB; trough_times(j)];
            end
        else
            trough_no_HRB = [trough_no_HRB; trough_times(j)];
        end
    end
    
    % Save the HRB-associated and non-associated trough times in the workspace
    assignin('base', strcat(valid_trough_name, '_HRB'), trough_HRB);
    assignin('base', strcat(valid_trough_name, '_no_HRB'), trough_no_HRB);
    disp(strcat(valid_trough_name, '_no_HRB'))
    disp(strcat(valid_trough_name, '_HRB'))
end

% Remove duplicates from NE_associated_HRB_time
NE_associated_HRB_time = unique(NE_associated_HRB_time);

% Define HRB_times_no_troughs as HRB_time but remove any that match with NE_associated_HRB_time
HRB_times_no_troughs = setdiff(HRB_time, NE_associated_HRB_time);


end
