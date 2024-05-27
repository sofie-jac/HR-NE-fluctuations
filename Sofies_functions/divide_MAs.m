function [NREM_before_MA_short, NREM_before_MA_long] = divide_MAs(SWS_before_MA_pklocs, MA_periods)
    % Initialize the output variables
    NREM_before_MA_short = [];
    NREM_before_MA_long = [];
    
    % Loop through each timestamp in SWS_before_MA_pklocs
    for i = 1:length(SWS_before_MA_pklocs)
        current_time = SWS_before_MA_pklocs(i);
        
        % Check if the current time falls within any existing microarousal periods
        within_MA = find(current_time >= MA_periods(:,1) & current_time <= MA_periods(:,2));
        
        if ~isempty(within_MA)  % Current time is within a microarousal period
            MA_onset = MA_periods(within_MA, 1);
            MA_offset = MA_periods(within_MA, 2);
            MA_duration = MA_offset - MA_onset;
            
            % Assign based on the duration of the microarousal
            if MA_duration < 5
                NREM_before_MA_short = [NREM_before_MA_short, current_time];
            else
                NREM_before_MA_long = [NREM_before_MA_long, current_time];
            end
        else  % Current time is not within a microarousal period
            % Find the closest upcoming microarousal period
            upcoming_MA = find(MA_periods(:,1) > current_time);
            if ~isempty(upcoming_MA)
                closest_MA = upcoming_MA(1);  % Index of the closest upcoming MA
                MA_onset = MA_periods(closest_MA, 1);
                MA_duration = MA_periods(closest_MA, 2) - MA_onset;
                
                % Assign based on the duration of this closest microarousal
                if MA_duration < 5
                    NREM_before_MA_short = [NREM_before_MA_short, current_time];
                else
                    NREM_before_MA_long = [NREM_before_MA_long, current_time];
                end
            end
        end
    end
end
