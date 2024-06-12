function plot_AUC_violins(AUC_table, arch, yfp, y_lab, main_title)
    remove_outliers = @(data) data(abs(data - mean(data)) <= 5 * std(data));

    % Extract and preprocess data for each group
    yfp_pre = remove_outliers(AUC_table.AUC_pre(ismember(AUC_table.Suffix, yfp)));
    yfp_post = remove_outliers(AUC_table.AUC_post(ismember(AUC_table.Suffix, yfp)));
    arch_pre = remove_outliers(AUC_table.AUC_pre(ismember(AUC_table.Suffix, arch)));
    arch_post = remove_outliers(AUC_table.AUC_post(ismember(AUC_table.Suffix, arch)));
    
    % Combine all data
    data = {yfp_pre, yfp_post, arch_pre, arch_post};
    group_labels = {'YFP - Pre', 'YFP - Post', 'ARCH - Pre', 'ARCH - Post'};
       
    % Create figure
    figure;
    hold on;

    % Define colors
    pastel_blue = [0 0.4470 0.7410];
    box_color = [0 0 0]; % Black color for boxplot
    
    % Plot violins and boxplots
    positions = 1:length(data);
    for i = 1:length(data)
        % Create a violin plot
        violinplot(data{i}, 'Pos', positions(i), 'Color', pastel_blue);
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
