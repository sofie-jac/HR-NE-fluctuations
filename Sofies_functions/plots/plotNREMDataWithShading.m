function plotNREMDataWithShading(dataTable, plotTitle, variableName, yAxisLabel, useFixedYLim, wholeNumberTicks)
    % Extract unique Zeitgeber Times
    uniqueTimes = unique(dataTable.('Zeitgeber Time'));
    
    % Initialize arrays for mean and SE calculations
    meanValues = zeros(length(uniqueTimes), 1);
    seValues = zeros(length(uniqueTimes), 1);
    
    % Calculate mean and SE for the specified variable across Zeitgeber Times
    for i = 1:length(uniqueTimes)
        time = uniqueTimes(i);
        valuesAtTime = dataTable{dataTable.('Zeitgeber Time') == time, variableName};
        meanValues(i) = mean(valuesAtTime);
        seValues(i) = std(valuesAtTime) / sqrt(length(valuesAtTime));
    end
    
    % Determine the limits for the x-axis
    min_x_lim = min(uniqueTimes) - 0.5;
    max_x_lim = max(uniqueTimes) + 0.5;

    % Determine y-axis limits early based on allYValues
    if useFixedYLim
        yLimits = [0, 100];
    else
        yLimits = [min(meanValues - seValues)*0.9, max(meanValues + seValues)*1.1];
    end
    
    % Begin plotting
    figure;
    hold on;
    
    % Add light gray shading for negative Zeitgeber Times with transparency, using determined yLimits
    if min_x_lim < 0
        fill([min_x_lim, 0, 0, min_x_lim], [yLimits(1), yLimits(1), yLimits(2), yLimits(2)], [0.95 0.95 0.95], 'EdgeColor', 'none', 'FaceAlpha', 0.5, 'HandleVisibility', 'off');
    end
    
    % Plot the data with error bars
    errorbar(uniqueTimes, meanValues, seValues, 'o-', 'Color', [0.3010, 0.7450, 0.9330], 'MarkerEdgeColor', [0, 0.4470, 0.7410], 'MarkerFaceColor', [0, 0.4470, 0.7410]);
    
    % Labels, title, and formatting
    xlabel('Zeitgeber Time');
    ylabel(yAxisLabel);
    combinedTitle = strcat(plotTitle, ' (Mouse IDs: ', join(string(unique(dataTable.MouseID)), ', '), ')');
    title(combinedTitle, 'Interpreter', 'none');
    
    % Set axis limits, grid
    xlim([min_x_lim, max_x_lim]);
    ylim(yLimits);
    grid on;
    set(gca, 'Layer', 'top');
    
    % Determine x-ticks based on the boolean flag
    if wholeNumberTicks
        xTicks = floor(min_x_lim):ceil(max_x_lim); % Ticks at every whole number
    else
        xTicks = floor(min_x_lim):0.5:ceil(max_x_lim); % Ticks at every whole and half number
    end
    xticks(xTicks);
    
    hold off;
    set(gcf, 'color', 'white');
end