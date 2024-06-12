function plot_RR_violins(RR_table, arch, yfp, event_var_onset, event_var_during, y_lab, main_title)
    remove_outliers = @(data) data(abs(data - mean(data)) <= 5 * std(data));

    % Extract and preprocess data for each group and event variable
    yfp_RR_onset = remove_outliers(RR_table.(event_var_onset)(ismember(RR_table.Suffix, yfp)));
    yfp_RR_during = remove_outliers(RR_table.(event_var_during)(ismember(RR_table.Suffix, yfp)));
    arch_RR_onset = remove_outliers(RR_table.(event_var_onset)(ismember(RR_table.Suffix, arch)));
    arch_RR_during = remove_outliers(RR_table.(event_var_during)(ismember(RR_table.Suffix, arch)));
    
    % Combine all data
    data = {yfp_RR_onset, yfp_RR_during, arch_RR_onset, arch_RR_during};
    group_labels = {'YFP - Laser Onset', 'YFP - During Laser', 'ARCH - Laser Onset', 'ARCH - During Laser'};
       
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
