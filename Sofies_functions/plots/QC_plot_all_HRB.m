function QC_plot_all_HRB(sleep_stage_periods, sleep_stages, HRB, HRB_time)
    % Prepare figure
    figure;
    sgtitle('RR Values around HRB Events by Sleep Stage');
    
    % Iterate over each sleep stage
    for stage_idx = 1:length(sleep_stages)
        % Initialize counter for HRB events in the current sleep stage
        HRB_count = 0;
    
        % Current sleep stage periods
        current_stage_periods = sleep_stage_periods{stage_idx};
    
        % Iterate over each HRB event to count relevant events first
        for event_idx = 1:length(HRB)
            HRB_event_time = HRB_time(event_idx);
    
            % Check if HRB event falls within current sleep stage
            for period_idx = 1:size(current_stage_periods, 1)
                period_start = current_stage_periods(period_idx, 1);
                period_end = current_stage_periods(period_idx, 2);
    
                % Check if event is within the period
                if HRB_event_time >= period_start && HRB_event_time <= period_end
                    HRB_count = HRB_count + 1; % Increment the HRB counter for the sleep stage
                    break; % Break the loop once the event is counted
                end
            end
        end
    
        % Plot settings for current sleep stage
        subplot(2, 2, stage_idx);
        hold on;
        title([sleep_stages{stage_idx}, ' (', num2str(HRB_count), ' Events)']); % Include number of events in title
    
        % Repeat the iteration for plotting
        for event_idx = 1:length(HRB)
            HRB_event_time = HRB_time(event_idx);
    
            % Check if HRB event falls within current sleep stage again for plotting
            for period_idx = 1:size(current_stage_periods, 1)
                period_start = current_stage_periods(period_idx, 1);
                period_end = current_stage_periods(period_idx, 2);
    
                % Check if event is within the period for plotting
                if HRB_event_time >= period_start && HRB_event_time <= period_end
                    window_start = HRB_event_time - 30;
                    window_end = HRB_event_time + 60;
    
                    % Find indices of RR values within the window
                    indices = find(filtered_RR_time >= window_start & filtered_RR_time <= window_end);
    
                    if ~isempty(indices)
                        plot(filtered_RR_time(indices) - HRB_event_time, filtered_RR(indices), 'DisplayName', ['Event ' num2str(event_idx)]);
                    end
    
                    break; % No need to check other periods for plotting once matched
                end
            end
        end
        
        xlabel('Time (s)');
        ylabel('RR Values');
        xlim([-30, 60]);
        legend('hide'); % Optionally hide legend if it's too cluttered
        hold off;
    end
    
    linkaxes(findobj(gcf, 'Type', 'Axes'), 'x'); % Sync x-axis across subplots
