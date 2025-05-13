function [HRB, HRB_time] = findHRB_all(new_time_vector, RR_data)
    average_mouse_HR = 600; % BPM for mice
    human_window_minutes = 3;
    
    % Calculate mouse window in seconds
    mouse_window_minutes = (human_window_minutes * 80) / average_mouse_HR;
    mouse_window_seconds = mouse_window_minutes * 60;
    
    % Initialize output variables
    HRB = [];
    HRB_time = [];
    
    % Calculate the number of windows
    total_time_seconds = new_time_vector(end) - new_time_vector(1);
    num_windows = floor(total_time_seconds / mouse_window_seconds);
    
    for w = 1:num_windows
        % Define window boundaries in terms of indices
        window_start_idx = find(new_time_vector >= (w-1) * mouse_window_seconds, 1, 'first');
        window_end_idx   = find(new_time_vector <  w    * mouse_window_seconds, 1, 'last');
        
        if isempty(window_start_idx) || isempty(window_end_idx)
            continue;
        end
        
        current_window_RR   = RR_data(window_start_idx:window_end_idx);
        current_window_time = new_time_vector(window_start_idx:window_end_idx);
        
        % Detect troughs (invert the signal to use findpeaks)
        [pks, pklocs] = findpeaks(-current_window_RR);
        troughs = -pks; % actual trough values
        
        % Calculate mean and standard deviation for the window
        mean_RR = mean(current_window_RR);
        std_RR  = std(current_window_RR);
        
        % Threshold: mean − 2.2·SD
        threshold = mean_RR - 2.2 * std_RR;
        
        % Find all troughs below threshold
        valid_idx = find(troughs < threshold);
        if isempty(valid_idx)
            continue;
        end
        
        % pull out all trough values & times...
        valid_troughs = troughs(valid_idx);
        valid_times   = current_window_time(pklocs(valid_idx));
        
        % ensure they’re column vectors, then append
        HRB = [HRB; valid_troughs(:)];
        HRB_time = [HRB_time; valid_times(:)];

    end
end
