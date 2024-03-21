function plotNREMDataWithShading(dataTable, plotTitle, variableName, yAxisLabel, useFixedYLim)
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
    
    % Begin plotting
    figure;
    hold on;
    
    % Add light gray shading for negative Zeitgeber Times with transparency
    if min_x_lim < 0
        fill([min_x_lim, 0, 0, min_x_lim], [0, 0, 100, 100], [0.95 0.95 0.95], 'EdgeColor', 'none', 'FaceAlpha', 0.5);
    end
    
    % Plot the data with error bars
    errorbar(uniqueTimes, meanValues, seValues, 'o-', 'Color', [0.3010, 0.7450, 0.9330], 'MarkerEdgeColor', [0, 0.4470, 0.7410], 'MarkerFaceColor', [0, 0.4470, 0.7410]);
    
    % Labels, title, and formatting
    xlabel('Zeitgeber Time');
    ylabel(yAxisLabel);
    combinedTitle = strcat(plotTitle, ' (Mouse IDs: ', join(string(unique(dataTable.MouseID)), ', '), ')');
    title(combinedTitle, 'Interpreter', 'none');
    
    % Set axis limits and grid
    xlim([min_x_lim, max_x_lim]);
    if useFixedYLim
        ylim([0, 100]);
    else
        % Dynamic y-axis limits based on data range and standard error
        ylim([min(meanValues - seValues)*0.9, max(meanValues + seValues)*1.1]);
    end
    grid on;
    set(gca, 'Layer', 'top');
    
    hold off;
    set(gcf, 'color', 'white');
end
