function plot_RR_bar(RR_table, arch, yfp, event_var_onset, event_var_during, y_lab, main_title)
    % Helper function to calculate SEM
    calc_sem = @(data) std(data) / sqrt(length(data));

    % Extract and preprocess data for each group and event variable
    yfp_RR_onset = RR_table.(event_var_onset)(ismember(RR_table.Suffix, yfp));
    yfp_RR_during = RR_table.(event_var_during)(ismember(RR_table.Suffix, yfp));
    arch_RR_onset = RR_table.(event_var_onset)(ismember(RR_table.Suffix, arch));
    arch_RR_during = RR_table.(event_var_during)(ismember(RR_table.Suffix, arch));
    
    % Remove outliers from the data
    yfp_RR_onset = remove_outliers(yfp_RR_onset);
    yfp_RR_during = remove_outliers(yfp_RR_during);
    arch_RR_onset = remove_outliers(arch_RR_onset);
    arch_RR_during = remove_outliers(arch_RR_during);

    % Combine all data
    data = {yfp_RR_onset, yfp_RR_during, arch_RR_onset, arch_RR_during};
    group_labels = {'YFP - Laser Onset', 'YFP - During Laser', 'ARCH - Laser Onset', 'ARCH - During Laser'};
    
    % Calculate means and SEMs
    means = cellfun(@mean, data);
    sems = cellfun(calc_sem, data);
    
    % Create figure
    figure;
    hold on;

    % Define colors
    pastel_blue = [0 0.4470 0.7410];
    box_color = [0 0 0]; % Black color for boxplot
    
    % Plot bars with error bars
    bar_handle = bar(1:length(data), means, 'FaceColor', pastel_blue, 'EdgeColor', pastel_blue);
    errorbar(1:length(data), means, sems, 'k', 'LineStyle', 'none', 'LineWidth', 1, 'CapSize', 10);

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

function data = remove_outliers(data)
    % Remove data points that are more than 5 standard deviations away from the mean
    data = data(abs(data - mean(data)) <= 5 * std(data));
end
