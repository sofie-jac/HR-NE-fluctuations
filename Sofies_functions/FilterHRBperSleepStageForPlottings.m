function filteredEventVars = FilterHRBperSleepStageForPlottings(event_var, epoch_start, echoch_end, sec_signal_2_124)
    % Determine the upper time limit based on sec_signal_2_124
    upperTimeLimit = max(sec_signal_2_124) - echoch_end;
    
    % Initialize a cell array to store the filtered event variables
    filteredEventVars = cell(size(event_var));
    
    % Iterate through each event variable in event_var
    for i = 1:length(event_var)
        % Retrieve the current event variable
        currentEventVar = event_var{i};
        
        % Filter the timestamps based on the criteria
        filteredTimestamps = currentEventVar(currentEventVar > epoch_start & currentEventVar < upperTimeLimit);
        
        % Store the filtered timestamps in the corresponding cell of filteredEventVars
        filteredEventVars{i} = filteredTimestamps;
    end
end
