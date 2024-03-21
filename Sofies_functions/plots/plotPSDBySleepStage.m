function plotPSDBySleepStage(avgPSD_data, uSleepStage)
    % Filter avgPSD_data for the given sleep stage
    filteredData = avgPSD_data(strcmp(avgPSD_data(:, 2), uSleepStage), :);
    
    % Initialize a figure
    figure;
    hold on;
    
    % Define a colormap of 12 visually distinct colors
    colors = [0, 0.4470, 0.7410; % MATLAB default blue
              0.8500, 0.3250, 0.0980; % MATLAB default orange
              0.9290, 0.6940, 0.1250; % MATLAB default yellow
              0.4940, 0.1840, 0.5560; % MATLAB default purple
              0.4660, 0.6740, 0.1880; % MATLAB default green
              0.3010, 0.7450, 0.9330; % MATLAB default light blue
              0.6350, 0.0780, 0.1840; % MATLAB default dark red
              0.3000, 0.3000, 0.3000; % Dark gray
              1, 0, 0; % Red
              0, 1, 0; % Green
              0, 0, 1; % Blue
              1, 0, 1]; % Magenta
    
    % Extract unique hours for plotting
    uniqueHours = unique(cell2mat(filteredData(:, 1)));
    
    % Plot a line for each unique hour using the color map
    for hourIdx = 1:length(uniqueHours)
        hour = uniqueHours(hourIdx);
        % Adjust hour by subtracting 7
        adjustedHour = hour - 7;
        
        % Filter data for the current hour
        currentHourData = filteredData(cell2mat(filteredData(:, 1)) == hour, :);
        
        frequencies = currentHourData{1, 3};
        psdValues = mean(cell2mat(currentHourData(:, 4)), 1); % Average PSD across all entries for the hour
        
        % Choose color based on hourIdx
        color = colors(mod(hourIdx - 1, size(colors, 1)) + 1, :);
        
        % Plot
        plot(frequencies, psdValues, 'DisplayName', sprintf('Hour %d', adjustedHour), 'Color', color);
    end
    
    % Collecting all mouse numbers and extracting unique values
    allMouseNumbers = cell2mat(cellfun(@(x) x(:)', avgPSD_data(:, 5), 'UniformOutput', false));
    uniqueMouseNumbers = unique(allMouseNumbers);
    
    % Convert unique mouse numbers to a string with commas
    mouseNumbersStr = strjoin(arrayfun(@(x) num2str(x), uniqueMouseNumbers, 'UniformOutput', false), ', ');
    
    % Add plot decorations
    titleText = sprintf('Power Spectral Density of NE during %s - Averaged Across Mice (%s)', uSleepStage, mouseNumbersStr);
    title(titleText);
    xlabel('Frequency (Hz)');
    ylabel('Power');
    legendObj = legend;
    title(legendObj, 'Zeitgeber Time');
    grid on;
    
    hold off;
end
