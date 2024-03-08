function QC_plot_all_NE_troughs(pklocs_variables, titles, ds_delta465_filt_2, ds_sec_signal_2, signal_fs)
figure; % Create a new figure

for subplot_idx = 1:4
    subplot(2, 2, subplot_idx);
    hold on;
    pklocs = pklocs_variables{subplot_idx};
    event_count = length(pklocs); % Count the number of events for the current sleep stage
    for i = 1:event_count
        pkloc_time = pklocs(i);
        % Find the index of pkloc_time in sec_signal_2
        [~, closest_index] = min(abs(ds_sec_signal_2 - pkloc_time)); % Corrected variable names
        start_index = max(1, closest_index - round(30 * signal_fs));
        end_index = min(length(ds_delta465_filt_2), closest_index + round(60 * signal_fs));
        
        % Extract and plot the NE trace for this event
        plot(ds_sec_signal_2(start_index:end_index) - ds_sec_signal_2(closest_index), ds_delta465_filt_2(start_index:end_index));
    end
    % Update title to include the number of events
    title([titles{subplot_idx}, ' (', num2str(event_count), ' Events)']);
    xlabel('Time (s)');
    ylabel('NE Activity');
    xlim([-30, 60]); % 30 seconds before to 60 seconds after the event
    hold off;
end

% Enhance plot readability
sgtitle('NE Activity around Troughs');