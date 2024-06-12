function [HRB, HRB_time] = findHRB(new_time_vector, RR_data)
    average_mouse_HR = 600; % BPM for mice
    human_window_minutes = 3;
    
    % Calculate mouse window in seconds
    mouse_window_minutes = (3 * 80) / average_mouse_HR;
    mouse_window_seconds = mouse_window_minutes * 60;
    
    % Initialize output variables
    HRB = [];
    HRB_time = [];
    
    % Calculate the number of windows
    total_time_seconds = new_time_vector(end) - new_time_vector(1);
    num_windows = floor(total_time_seconds / mouse_window_seconds);
    
    for w = 1:num_windows
        % Define window boundaries in terms of indices, not time
        window_start_idx = find(new_time_vector >= (w-1) * mouse_window_seconds, 1, 'first');
        window_end_idx = find(new_time_vector < w * mouse_window_seconds, 1, 'last');
        
        if ~isempty(window_start_idx) && ~isempty(window_end_idx)
            current_window_RR = RR_data(window_start_idx:window_end_idx);
            current_window_time = new_time_vector(window_start_idx:window_end_idx);
            
            % Detect troughs (invert the signal to use findpeaks)
            [pks, pklocs] = findpeaks(-current_window_RR);
            troughs = -pks; % Convert peaks back to troughs
            
            % Calculate mean and standard deviation for the window
            mean_RR = mean(current_window_RR);
            std_RR = std(current_window_RR);
            
            % Filter criteria: mean - 1.5 * SD
            criteria_threshold = mean_RR - 2.2 * std_RR;
            valid_trough_indices = find(troughs < criteria_threshold);
            
            if ~isempty(valid_trough_indices)
                % If more than one trough meets the criteria, select the lowest one
                [~, min_idx] = min(troughs(valid_trough_indices));
                selected_trough_index = valid_trough_indices(min_idx);
                
                selected_trough_time = current_window_time(pklocs(selected_trough_index));
                
                % % Check if the selected trough is more than 15 seconds away from the last trough
                % if ~isempty(HRB_time) && (selected_trough_time - HRB_time(end) <= 15)
                %     % If current trough is lower than the last, update HRB and HRB_time
                %     if troughs(selected_trough_index) < HRB(end)
                %         HRB(end) = troughs(selected_trough_index);
                %         HRB_time(end) = selected_trough_time;
                %     end
                % else
                    % If more than 15 seconds away, or first trough, simply add to HRB and HRB_time
                    HRB = [HRB; troughs(selected_trough_index)];
                    HRB_time = [HRB_time; selected_trough_time];
                % end
            end
        end
    end
end