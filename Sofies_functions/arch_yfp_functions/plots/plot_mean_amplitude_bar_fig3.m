function plot_mean_amplitude_bar_fig3(RR_amplitude_table, y_lab, main_title)
    % Extract data for each group
    yfp_data = RR_amplitude_table.Amplitude(strcmp(RR_amplitude_table.Group, 'yfp'));
    arch_data = RR_amplitude_table.Amplitude(strcmp(RR_amplitude_table.Group, 'arch'));

    % Calculate means and SEMs
    yfp_mean = mean(yfp_data);
    arch_mean = mean(arch_data);

    yfp_sem = std(yfp_data) / sqrt(length(yfp_data));
    arch_sem = std(arch_data) / sqrt(length(arch_data));

    % Combine data for plotting
    means = [yfp_mean, arch_mean];
    sems = [yfp_sem, arch_sem];
    group_labels = {'YFP', 'ARCH'};
    
    % Create figure
    figure;
    hold on;

    % Define colors
    pastel_blue = [0 0.4470 0.7410];
    pastel_red = [0.8500 0.3250 0.0980];
    
    % Plot bars with error bars
    bar_handle = bar(1:length(means), means, 'FaceColor', pastel_blue, 'EdgeColor', 'none');
    errorbar(1:length(means), means, sems, 'k', 'LineStyle', 'none', 'LineWidth', 1.5, 'CapSize', 10);

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
