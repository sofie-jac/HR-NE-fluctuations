% Define a function to convert the transition points into onset/offset format
function pklocs_all = findPeaksBeforeTransition(SWS_before_MA_filtered, signal_fs, delta465_filt_2, sec_signal_2, min_peak_prominence, min_peak_height, min_peak_dist, skip_threshold)

   % Initialize variables for storing results
    pklocs_all = []; % Stores all the peak (trough) locations
    pklocs_time = [];
    last_period_onset = -Inf; % Initialize with a value that will not affect the first comparison
    temp_pklocs_all = []; % Temporary storage for peak locations before final filtering
    
    period = SWS_before_MA_filtered;
    
    for i = 1:size(period, 1)
        current_period_onset = period(i, 1);
        % Skip the period if its onset is less than 30 seconds away from the last period
        if (current_period_onset - last_period_onset) < skip_threshold
            continue;
        end
    
        if (period(i,2) - period(i,1)) > 10 % Process only periods longer than the time window
            % Convert period from seconds to samples
            period_i_samples = round(period(i,:) * signal_fs);
            period_i_samples(1) = max(1, period_i_samples(1));
            period_i_samples(2) = min(length(delta465_filt_2), period_i_samples(2));
    
            NEtrace_i = delta465_filt_2(period_i_samples(1):period_i_samples(2));
            timetrace_i = sec_signal_2(period_i_samples(1):period_i_samples(2));
    
            if length(NEtrace_i) < 3
                continue;
            end
    
            [pks, pklocs, w, p] = findpeaks(-NEtrace_i, 'MinPeakProminence', min_peak_prominence, 'MinPeakHeight', min_peak_height, 'MinPeakDistance', min_peak_dist);
    
            % If multiple troughs are detected, store only the one with the lowest NE value
            if ~isempty(pklocs)
                [~, min_loc_idx] = min(-pks); % Since we are dealing with inverted peaks, the minimum is actually the maximum
                pklocs_time = timetrace_i(pklocs(min_loc_idx));
    
                if ~iscolumn(pklocs_time)
                    pklocs_time = pklocs_time';
                end
                temp_pklocs_all = [temp_pklocs_all; pklocs_time];
                last_period_onset = current_period_onset; % Update last processed period onset
            end
        end
            pklocs_all = [pklocs_all; pklocs_time'];
    end
        % Ensure all values in pklocs_all are unique
    pklocs_all = unique(pklocs_all);
end


    % periods = []; % Initialize empty matrix
    % for i = 1:length(transitionPoints)
    %     onset = max(1, transitionPoints(i) - timeWindow);
    %     offset = transitionPoints(i); % The transition point itself is the end of the period
    %     % Ensure the period does not start before the actual SWS period
    %     if onset < offset
    %         periods = [periods; [onset, offset-1]]; % Collect valid periods
    %     end
    % end
    % % Remove any period that exceeds the signal's duration
    % periods(periods(:,2) > totalDuration, :) = [];
