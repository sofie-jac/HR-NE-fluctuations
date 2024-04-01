function [NREMinclMA_HRB_124, NREMexclMA_HRB_124, wake_HRB_124, REM_HRB_124] = categorizeHRBBySleepStage(HRB_times_no_troughs, NREMinclMA_periods_124, NREMexclMA_periods_124, wake_periods_124, REM_periods_124)

% Initialize empty arrays to hold HRB times for each sleep stage
NREMinclMA_HRB_124 = [];
NREMexclMA_HRB_124 = [];
wake_HRB_124 = [];
REM_HRB_124 = [];

% Iterate through each HRB time
for i = 1:length(HRB_times_no_troughs)
    HRB_time = HRB_times_no_troughs(i);
    
    % Check if HRB_time falls within any NREMinclMA_periods
    for j = 1:size(NREMinclMA_periods_124, 1)
        if HRB_time >= NREMinclMA_periods_124(j, 1) && HRB_time <= NREMinclMA_periods_124(j, 2)
            NREMinclMA_HRB_124 = [NREMinclMA_HRB_124; HRB_time];
            break; % No need to check further if already found
        end
    end
    
    % Check if HRB_time falls within any NREMexclMA_periods
    for j = 1:size(NREMexclMA_periods_124, 1)
        if HRB_time >= NREMexclMA_periods_124(j, 1) && HRB_time <= NREMexclMA_periods_124(j, 2)
            NREMexclMA_HRB_124 = [NREMexclMA_HRB_124; HRB_time];
            break; % No need to check further if already found
        end
    end
    
    % Check if HRB_time falls within any wake_periods
    for j = 1:size(wake_periods_124, 1)
        if HRB_time >= wake_periods_124(j, 1) && HRB_time <= wake_periods_124(j, 2)
            wake_HRB_124 = [wake_HRB_124; HRB_time];
            break; % No need to check further if already found
        end
    end
    
    % Check if HRB_time falls within any REM_periods
    for j = 1:size(REM_periods_124, 1)
        if HRB_time >= REM_periods_124(j, 1) && HRB_time <= REM_periods_124(j, 2)
            REM_HRB_124 = [REM_HRB_124; HRB_time];
            break; % No need to check further if already found
        end
    end
end

end
