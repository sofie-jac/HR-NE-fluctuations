function plot_correlation_memory_arch(updated_table, arch, yfp, variable_name)
    % Filter out rows with NaN in the specified variable or novel_familiar_ratio
    valid_rows = ~isnan(updated_table.(variable_name)) & ~isnan(updated_table.novel_familiar_ratio);
    filtered_table = updated_table(valid_rows, :);

    % Convert arch and yfp to numeric for comparison
    arch_numeric = cellfun(@str2num, arch);
    yfp_numeric = cellfun(@str2num, yfp);

    % Convert Suffix column to numeric
    suffix_numeric = cellfun(@str2num, filtered_table.Suffix);

    % Identify arch and yfp suffixes
    is_arch = ismember(suffix_numeric, arch_numeric);
    is_yfp = ismember(suffix_numeric, yfp_numeric);

    % Extract data for correlation
    x = filtered_table.(variable_name);
    y = filtered_table.novel_familiar_ratio;

    % Plot the data
    figure;
    hold on;

    % Define colors
    color_arch = [0 0.4470 0.7410];
    color_yfp = [0.4660 0.6740 0.1880];

    % Plot arch data points
    scatter(x(is_arch), y(is_arch), 100, 'o', 'MarkerEdgeColor', color_arch, 'MarkerFaceColor', color_arch);

    % Plot yfp data points
    scatter(x(is_yfp), y(is_yfp), 100, 'o', 'MarkerEdgeColor', color_yfp, 'MarkerFaceColor', color_yfp);

    % Label each data point with its Suffix
    for i = 1:height(filtered_table)
        text(x(i), y(i), filtered_table.Suffix{i}, 'FontSize', 8, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
    end

    % Calculate and plot linear fit
    coeffs = polyfit(x, y, 1);
    fittedX = linspace(min(x), max(x), 200);
    fittedY = polyval(coeffs, fittedX);
    plot(fittedX, fittedY, 'k--', 'LineWidth', 1.5);

    % Calculate correlation coefficient and p-value
    [R, p] = corr(x, y, 'Type', 'Pearson');

    % Display correlation coefficient and p-value on the plot
    text(min(x) + 0.1 * range(x), max(y) - 0.1 * range(y), ...
        sprintf('R = %.2f\np = %.3f', R, p), 'FontSize', 12, 'BackgroundColor', 'w');

    % Set labels and title
    xlabel(strrep(variable_name, '_', ' ')); % Convert variable name to label
    ylabel('Novel/Familiar Ratio');
    title(['Correlation between ', strrep(variable_name, '_', ' '), ' and Novel/Familiar Ratio']);

    % Set legend
    legend({'ARCH', 'YFP', 'Fit Line'}, 'Location', 'best');

    % Adjust plot appearance
    set(gcf, 'Color', 'w');
    grid on;
    hold off;
end
