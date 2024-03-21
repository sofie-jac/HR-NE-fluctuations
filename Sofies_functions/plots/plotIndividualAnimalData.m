function plotIndividualAnimalData(dataTable, plotTitle, variableName, yAxisLabel, useFixedYLim)
    % Extract unique Zeitgeber Times and Animal IDs
    uniqueTimes = unique(dataTable.('Zeitgeber Time'));
    animalIDs = unique(dataTable.MouseID);
    
    % Begin plotting
    figure;
    hold on;
    
    % Prepare to collect all y-values for dynamic ylim adjustment BEFORE plotting
    allYValues = [];
    for idx = 1:length(animalIDs)
        animalID = animalIDs(idx);
        animalData = dataTable(dataTable.MouseID == animalID, :);
        for t = 1:length(uniqueTimes)
            time = uniqueTimes(t);
            if any(animalData.('Zeitgeber Time') == time)
                yValue = animalData{animalData.('Zeitgeber Time') == time, variableName};
                allYValues = [allYValues; yValue]; % Collecting all y-values
            end
        end
    end
    
    % Determine y-axis limits early based on allYValues
    if useFixedYLim
        yLimits = [0, 100];
    else
        yLimits = [min(allYValues)*0.9, max(allYValues)*1.1];
    end
    
    % Add light gray shading for negative Zeitgeber Times with transparency, using determined yLimits
    min_x_lim = min(uniqueTimes) - 0.5;
    if min_x_lim < 0
        fill([min_x_lim, 0, 0, min_x_lim], [yLimits(1), yLimits(1), yLimits(2), yLimits(2)], [0.95 0.95 0.95], 'EdgeColor', 'none', 'FaceAlpha', 0.5, 'HandleVisibility', 'off');
    end
    
    % Plot data for each animal AFTER shading
    for idx = 1:length(animalIDs)
        animalID = animalIDs(idx);
        animalData = dataTable(dataTable.MouseID == animalID, :);
        xData = [];
        yData = [];
        for t = 1:length(uniqueTimes)
            time = uniqueTimes(t);
            if any(animalData.('Zeitgeber Time') == time)
                yValue = animalData{animalData.('Zeitgeber Time') == time, variableName};
                xData = [xData; time];
                yData = [yData; mean(yValue)]; % Assuming there might be multiple entries per time, take the mean
            end
        end
        plot(xData, yData, 'o-', 'MarkerFaceColor', 'auto', 'DisplayName', sprintf('Mouse %d', animalID));
    end
    
    % Axis labels, title, grid, and final touches
    xlabel('Zeitgeber Time');
    ylabel(yAxisLabel);
    title(plotTitle, 'Interpreter', 'none');
    xlim([min_x_lim, max(uniqueTimes) + 0.5]);
    ylim(yLimits);
    grid on;
    set(gca, 'Layer', 'top');
    legend('show', 'Location', 'southeast');
    
    hold off;
    set(gcf, 'color', 'white');
end
