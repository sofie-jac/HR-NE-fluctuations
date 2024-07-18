function plot_relative_perc_auc_chr2(data_chr2, data_yfp, title_text)
    num_laser_levels = 6;

    % Calculate means and SEMs for chr2
    means_chr2 = zeros(num_laser_levels, 1);
    sems_chr2 = zeros(num_laser_levels, 1);
    for i = 0:num_laser_levels-1
        data = data_chr2.AUC(data_chr2.LaserLevel == i);
        means_chr2(i+1) = mean(data);
        sems_chr2(i+1) = std(data) / sqrt(length(data));
    end
    
    % Calculate means and SEMs for yfp
    means_yfp = zeros(num_laser_levels, 1);
    sems_yfp = zeros(num_laser_levels, 1);
    for i = 0:num_laser_levels-1
        data = data_yfp.AUC(data_yfp.LaserLevel == i);
        means_yfp(i+1) = mean(data);
        sems_yfp(i+1) = std(data) / sqrt(length(data));
    end
    
    % Convert means to relative percent
    means_chr2_relative = (means_chr2 / means_chr2(1)) * 100;
    means_yfp_relative = (means_yfp / means_yfp(1)) * 100;
    
    % Convert SEMs to relative percent
    sems_chr2_relative = (sems_chr2 / means_chr2(1)) * 100;
    sems_yfp_relative = (sems_yfp / means_yfp(1)) * 100;
    
    % Create a bar plot
    figure;
    hold on;

    % Define the bar width
    barWidth = 0.35;

    % Define x positions for the bars
    x = 0:num_laser_levels-1;

    % Plot bars for chr2
    bar1 = bar(x - barWidth/2, means_chr2_relative, barWidth, 'FaceColor', [0 0.4470 0.7410], 'DisplayName', 'chr2');

    % Plot bars for yfp
    bar2 = bar(x + barWidth/2, means_yfp_relative, barWidth, 'FaceColor', [0.8500 0.3250 0.0980], 'DisplayName', 'yfp');

    % Plot error bars for chr2
    errorbar(x - barWidth/2, means_chr2_relative, sems_chr2_relative, 'k', 'LineStyle', 'none', 'LineWidth', 1.5);

    % Plot error bars for yfp
    errorbar(x + barWidth/2, means_yfp_relative, sems_yfp_relative, 'k', 'LineStyle', 'none', 'LineWidth', 1.5);

    % Customize the plot
    set(gca, 'XTick', x);
    set(gca, 'XTickLabel', {'Laser Level 0', 'Laser Level 1', 'Laser Level 2', 'Laser Level 3', 'Laser Level 4', 'Laser Level 5'});
    xlabel('Laser Levels');
    ylabel('Relative Area Under the Curve (AUC) [%]');
    title(title_text);
    legend('show');
    grid on;

    % Set figure background color to white
    set(gcf, 'Color', 'w');

    hold off;
end
