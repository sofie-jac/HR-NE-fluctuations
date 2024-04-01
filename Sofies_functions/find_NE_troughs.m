function pklocs_all = find_NE_troughs(NREMexclMA_periods_cut, signal_fs, delta465_filt_2, sec_signal_2, min_peak_prominence)
    % Initialize variables for storing results
    pklocs_all = []; % Stores all the peak locations

    period = NREMexclMA_periods_cut;

    % Time window in seconds before transition
    time_window = 5; % seconds

    % Initialize variables for storing results
    pklocs_all = []; % Stores all the peak (trough) locations

    for i = 1:size(period, 1)
        if (period(i,2)-period(i,1)) > time_window % Process only periods longer than the time window
            % Convert period from seconds to samples
            period_i_samples = round(period(i,:) * signal_fs);
            period_i_samples(1) = max(1, period_i_samples(1)); % Ensure start is at least 1
            period_i_samples(2) = min(length(delta465_filt_2), period_i_samples(2)); % Ensure end does not exceed the signal length

            % Extract the current period and its corresponding NE trace
            NEtrace_i = delta465_filt_2(period_i_samples(1):period_i_samples(2));
            timetrace_i = sec_signal_2(period_i_samples(1):period_i_samples(2));

            if length(NEtrace_i) < 3
                % Skip this segment if it does not contain enough data for peak detection
                continue;
            end

            % Calculate metrics for the current period
            curr_std = std(NEtrace_i);
            percentile_diff = prctile(NEtrace_i, 95) - prctile(NEtrace_i, 5);

            % Update peak (trough) detection criteria based on the current period
            min_pkDist = curr_std * 3; % Adjusted based on standard deviation

            % Detect troughs (as inverted peaks) for the current period
            [pks, pklocs] = findpeaks(-NEtrace_i, 'MinPeakDistance', min_pkDist, 'MinPeakProminence', min_peak_prominence);

            pklocs_time = timetrace_i(pklocs); % This is already correct if `timetrace_i` is a column vector
            if ~iscolumn(pklocs_time)
                pklocs_time = pklocs_time'; % Transpose if it's not a column vector
            end
            pklocs_all = [pklocs_all; pklocs_time]; % This should now work without error
        end
    end

    pklocs_all = pklocs_all';



% function pklocs_all = find_NE_troughs(NREMexclMA_periods_cut, signal_fs, delta465_filt_2, sec_signal_2, sd_multiplier_for_min_pkProm)
%     %currently selected period
%     period = NREMexclMA_periods_cut;
% 
%     % Time window in seconds before transition
%     time_window = 5; % seconds
% 
%     % Initialize variables for storing results
%     pklocs_all = []; % Stores all the peak locations
% 
%     for i = 1:length(period)
%         if period(i,2)-period(i,1) < time_window-1 % Skip periods shorter than the timewindow used to define the intervals
%             continue
%         end
% 
%         % Extract the current period and its corresponding NE trace
%         period_i = period(i,:) * signal_fs;
%         period_i = max(1, round(period(i,:) * signal_fs)); % Before indexing with round(period_i(1)) and round(period_i(2)), ensure they are positive and >= 1. If signal_fs can scale period such that the result is less than 1, adjust accordingly
%         NEtrace_i = delta465_filt_2(round(period_i(1)):round(period_i(2)));
%         timetrace_i = sec_signal_2(round(period_i(1)):round(period_i(2)));
% 
%         % Calculate metrics for the current period
%         curr_std = std(NEtrace_i);
%         percentile_diff = prctile(NEtrace_i,95) - prctile(NEtrace_i,5);
% 
%         % Update peak detection criteria based on the current period
%         min_pkDist = curr_std * 3;
%         min_pkProm = curr_std * sd_multiplier_for_min_pkProm; % Adjusted based on input parameter
%         min_pkWdth = 8; % Assuming this remains constant - 
% 
%         % Detect peaks for the current period
%         [pks, pklocs, w, p] = findpeaks(-NEtrace_i, timetrace_i, 'MinPeakDistance', min_pkDist, 'MinPeakWidth', 6, 'MinPeakProminence', min_pkProm);
% 
%         % Append results to the list of all peak locations
%         pklocs_all = [pklocs_all pklocs];
%     end
% end
