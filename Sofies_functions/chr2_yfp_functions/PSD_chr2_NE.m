function [PXX_chr2, PXX_yfp, f, resultTable_chr2, resultTable_yfp] = PSD_chr2_NE(chr2, yfp)

    sampling_hz = 0.0002;
    dataDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\Figure_4_data';

    % Initialize arrays to hold PSD data for each laser level
    PXX_chr2 = cell(5, 2);
    PXX_yfp = cell(5, 2);
    
    % Process chr2 group
    [PXX_chr2, f] = process_group_NE_30sec(chr2, 'chr2', PXX_chr2);
    % Process yfp group
    [PXX_yfp, f] = process_group_NE_30sec(yfp, 'yfp', PXX_yfp);
    
    % Initialize tables for returning mean and SEM
    resultTable_chr2 = table(f(:), 'VariableNames', {'f'});
    resultTable_yfp = table(f(:), 'VariableNames', {'f'});
    
    % Plot the results
    figure;
    colors = lines(5); % Get 5 colors from the default colormap
    
    % Subplot for YFP
    subplot(1, 2, 1);
    hold on;
    % Plot mean PSD and SEM for YFP
    for laser_level = 1:5
        switch laser_level
            case 1
                lineProps = {'-b'}; % blue
            case 2
                lineProps = {'-r'}; % red
            case 3
                lineProps = {'-g'}; % green
            case 4
                lineProps = {'-m'}; % magenta
            case 5
                lineProps = {'-c'}; % cyan
        end
        if ~isempty(PXX_yfp{laser_level})
            mean_PXX_yfp = PXX_yfp{laser_level, 1};
            SEM_PXX_yfp = PXX_yfp{laser_level, 2};
            h_yfp = shadedErrorBar(f, mean_PXX_yfp, SEM_PXX_yfp, lineProps{1});
            set(h_yfp.mainLine, 'DisplayName', ['Laser Level ', num2str(laser_level)]);
            % Hide the SEM line from the legend
            set(get(get(h_yfp.patch, 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
            set(get(get(h_yfp.edge(1), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
            set(get(get(h_yfp.edge(2), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
            
            % Add the mean and SEM to the result table
            resultTable_yfp = [resultTable_yfp, table(mean_PXX_yfp(:), SEM_PXX_yfp(:), 'VariableNames', ...
                {sprintf('Mean_Laser%d', laser_level), sprintf('SEM_Laser%d', laser_level)})];
        else
            % Add NaNs if no data is present
            resultTable_yfp = [resultTable_yfp, table(NaN(length(f), 1), NaN(length(f), 1), 'VariableNames', ...
                {sprintf('Mean_Laser%d', laser_level), sprintf('SEM_Laser%d', laser_level)})];
        end
    end
    xlim([0, max(f)]);
    title('YFP - NE');
    xlabel('Frequency (Hz)');
    ylabel('Power Spectral Density (PSD)');
    legend('show', 'Location', 'northeast');
    hold off;

    % Subplot for Chr2
    subplot(1, 2, 2);
    hold on;
    % Plot mean PSD and SEM for Chr2
    for laser_level = 1:5
        switch laser_level
            case 1
                lineProps = {'-b'}; % blue
            case 2
                lineProps = {'-r'}; % red
            case 3
                lineProps = {'-g'}; % green
            case 4
                lineProps = {'-m'}; % magenta
            case 5
                lineProps = {'-c'}; % cyan
        end
        if ~isempty(PXX_chr2{laser_level})
            mean_PXX_chr2 = PXX_chr2{laser_level, 1};
            SEM_PXX_chr2 = PXX_chr2{laser_level, 2};
            h_chr2 = shadedErrorBar(f, mean_PXX_chr2, SEM_PXX_chr2, lineProps{1});
            set(h_chr2.mainLine, 'DisplayName', ['Laser Level ', num2str(laser_level)]);
            % Hide the SEM line from the legend
            set(get(get(h_chr2.patch, 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
            set(get(get(h_chr2.edge(1), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
            set(get(get(h_chr2.edge(2), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
            
            % Add the mean and SEM to the result table
            resultTable_chr2 = [resultTable_chr2, table(mean_PXX_chr2(:), SEM_PXX_chr2(:), 'VariableNames', ...
                {sprintf('Mean_Laser%d', laser_level), sprintf('SEM_Laser%d', laser_level)})];
        else
            % Add NaNs if no data is present
            resultTable_chr2 = [resultTable_chr2, table(NaN(length(f), 1), NaN(length(f), 1), 'VariableNames', ...
                {sprintf('Mean_Laser%d', laser_level), sprintf('SEM_Laser%d', laser_level)})];
        end
    end
    xlim([0, max(f)]);
    title('Chr2 - NE');
    xlabel('Frequency (Hz)');
    ylabel('Power Spectral Density (PSD)');
    legend('show', 'Location', 'northeast');
    hold off;

    linkaxes([subplot(1, 2, 1), subplot(1, 2, 2)], 'x');

    % Set figure background color to white
    set(gcf, 'Color', 'w');

    % Clear temporary variables
    clear fs sampling_hz dataDirectory mean_PXX_chr2 SEM_PXX_chr2 mean_PXX_yfp SEM_PXX_yfp colors MaxY;
end

