function plot_HRB_rate_violins(NREMinclMA_HRB_table, arch, yfp, event_var, y_lab, main_title)
    remove_outliers = @(data) data(abs(data - mean(data)) <= 5 * std(data));

    % Extract and preprocess data for each group
    yfp_laser_off = remove_outliers(NREMinclMA_HRB_table.(event_var)(ismember(NREMinclMA_HRB_table.Suffix, yfp) & strcmp(NREMinclMA_HRB_table.Laser_Status, 'off')));
    yfp_laser_on = remove_outliers(NREMinclMA_HRB_table.(event_var)(ismember(NREMinclMA_HRB_table.Suffix, yfp) & strcmp(NREMinclMA_HRB_table.Laser_Status, 'on')));
    arch_laser_off = remove_outliers(NREMinclMA_HRB_table.(event_var)(ismember(NREMinclMA_HRB_table.Suffix, arch) & strcmp(NREMinclMA_HRB_table.Laser_Status, 'off')));
    arch_laser_on = remove_outliers(NREMinclMA_HRB_table.(event_var)(ismember(NREMinclMA_HRB_table.Suffix, arch) & strcmp(NREMinclMA_HRB_table.Laser_Status, 'on')));
    
    % Combine all data
    data = {yfp_laser_off, yfp_laser_on, arch_laser_off, arch_laser_on};
    group_labels = {'YFP - Laser off', 'YFP - Laser on', 'ARCH - Laser off', 'ARCH - Laser on'};
       
    % Create figure
    figure;
    hold on;

    % Define colors
    pastel_green = [0.4660 0.6740 0.1880];
    box_color = [0 0 0]; % Black color for boxplot
    
    % Plot violins and boxplots
    positions = 1:length(data);
    for i = 1:length(data)
        % Create a violin plot
        violinplot(data{i}, 'Pos', positions(i), 'Color', pastel_green);
    end
    
    for i = 1:length(data)
        % Create a boxplot on top of the violin plot
        boxplot(data{i}, 'positions', positions(i), 'Colors', box_color, 'Widths', 0.1, 'Symbol', 'kx'); % 'kx' for black crosses
    end
    
    % Set x-axis labels
    set(gca, 'XTick', 1:length(group_labels), 'XTickLabel', group_labels);
    
    % Set labels and title
    xlabel('Group');
    ylabel(y_lab);
    title(main_title);
    
    % Adjust plot appearance
    set(gcf, 'Color', 'w');
    grid on;
    
    hold off;
end