function plot_AUC_bar(AUC_table, arch, yfp, y_lab, main_title)
    % Helper function to calculate SEM
    calc_sem = @(data) std(data) / sqrt(length(data));

    % Extract and preprocess data for each group
    yfp_pre = remove_outliers(AUC_table.AUC_pre(ismember(AUC_table.Suffix, yfp)));
    yfp_post = remove_outliers(AUC_table.AUC_post(ismember(AUC_table.Suffix, yfp)));
    arch_pre = remove_outliers(AUC_table.AUC_pre(ismember(AUC_table.Suffix, arch)));
    arch_post = remove_outliers(AUC_table.AUC_post(ismember(AUC_table.Suffix, arch)));
    
    % Combine all data
    data = {yfp_pre, yfp_post, arch_pre, arch_post};
    group_labels = {'YFP - Pre', 'YFP - Post', 'ARCH - Pre', 'ARCH - Post'};
    
    % Calculate means and SEMs
    means = cellfun(@mean, data);
    sems = cellfun(calc_sem, data);
    
    % Create figure
    figure;
    hold on;

    % Define colors
    pastel_blue = [0 0.4470 0.7410];
    
    % Plot bars with error bars
    bar_handle = bar(1:length(data), means, 'FaceColor', pastel_blue, 'EdgeColor', 'none');
    errorbar(1:length(data), means, sems, 'k', 'LineStyle', 'none', 'LineWidth', 1.5, 'CapSize', 10);

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
