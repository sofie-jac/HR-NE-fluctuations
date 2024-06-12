function plot_HRB_arch_yfp_violins(NREMinclMA_HRB_table, arch, yfp, event_var, y_lab, main_title)
    remove_outliers = @(data) data(abs(data - mean(data)) <= 5 * std(data));

    % Extract and preprocess data for each group
    yfp_data = remove_outliers(NREMinclMA_HRB_table.(event_var)(ismember(NREMinclMA_HRB_table.Suffix, yfp)));
    arch_data = remove_outliers(NREMinclMA_HRB_table.(event_var)(ismember(NREMinclMA_HRB_table.Suffix, arch)));
    
    % Combine all data
    data = {yfp_data, arch_data};
    group_labels = {'YFP', 'ARCH'};
       
    % Create figure
    figure;
    hold on;

    % Define colors
    violin_color = [0 0.4470 0.7410];
    box_color = [0 0 0]; % Black color for boxplot
    
    % Plot violins and boxplots
    positions = 1:length(data);
    for i = 1:length(data)
        % Create a violin plot
        violinplot(data{i}, 'Pos', positions(i), 'Color', violin_color);
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
