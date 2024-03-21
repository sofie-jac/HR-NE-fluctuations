function EMG_section_reviewer(clean_sections, sec_signal_EMG, EMG, selected_peak_locs, selected_peaks, threshold)
    % Function to review EMG sections and mark them for inclusion or exclusion

    % Check for previously stored answers and determine starting index
    persistent review_answers;
    if isempty(review_answers)
        review_answers = [];
        start_row = 1;
    else
        start_row = size(review_answers, 1) + 1;
        disp(['Starting from row ', num2str(start_row)]);
    end

    % Define callbacks for the buttons
    function keepCallback(hObject, ~)
        review_answers(end+1, :) = [i, 1];
        disp(['Row ', num2str(i), ': keep']);
        uiresume(gcbf);
    end

    function discardCallback(hObject, ~)
        review_answers(end+1, :) = [i, 0];
        disp(['Row ', num2str(i), ': discard']);
        uiresume(gcbf);
    end

    % Iterate over each clean section
    for i = start_row:size(clean_sections, 1)
        % Define the time range for the current clean section
        time_range = clean_sections(i, :);
        
        % Find indices within the current clean section's time range
        time_indices = find(sec_signal_EMG >= time_range(1) & sec_signal_EMG <= time_range(2));
        
        % Extract the data for the current clean section
        current_time = sec_signal_EMG(time_indices);
        current_EMG = EMG(time_indices);
        
        % Find selected peaks that fall within the current time range
        peaks_in_range_indices = find(sec_signal_EMG(selected_peak_locs) >= time_range(1) & sec_signal_EMG(selected_peak_locs) <= time_range(2));
        current_peak_locs_in_time = selected_peak_locs(peaks_in_range_indices); % Peaks in range
        current_peak_locs_in_time = current_peak_locs_in_time - time_indices(1) + 1; % Adjusting indices
        current_peaks = selected_peaks(peaks_in_range_indices);
        
        % Plot the current clean section
        hFig = figure;
        plot(current_time, current_EMG, 'b-');
        hold on;
        
        % Ensure we have peaks to plot and all indices are positive
        if ~isempty(current_peak_locs_in_time) && all(current_peak_locs_in_time > 0)
            plot(current_time(current_peak_locs_in_time), current_peaks, 'ro');
        end
        
        % Draw threshold line
        line([current_time(1), current_time(end)], [threshold, threshold], 'Color', 'g', 'LineStyle', '--');

        
        % Decorate the plot
        xlabel('Time (s)');
        ylabel('EMG (V)');
        title(['EMG with Selected Peaks, Section ' num2str(i)]);
        grid on;
        legend('Filtered EMG', 'Selected Peaks', 'Threshold');
        set(gcf,'color','white');
        
        % Create the buttons
        uicontrol('String', 'Keep', 'Callback', @keepCallback, 'Position', [20 20 60 20]);
        uicontrol('String', 'Discard', 'Callback', @discardCallback, 'Position', [100 20 60 20]);
        
        % Wait for the user to click 'Keep' or 'Discard'
        uiwait(hFig);
        
        % Save the review answers after each section
        save('review_answers.mat', 'review_answers');
        if isvalid(hFig)
            close(hFig); % Ensure the figure is closed if it's still open
        end
    end
    % Output the review answers variable if needed outside the function
    assignin('base', 'review_answers', review_answers);
end
