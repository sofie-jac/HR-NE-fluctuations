function [PXX_chr2, PXX_yfp, f, resultTable_chr2, resultTable_yfp, RR_table_chr2, RR_table_yfp] = PSD_chr2(chr2, yfp)
    fs = 64; % Specify sampling frequency of your signal trace
    sampling_hz = 0.002;
    dataDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\Figure_4_data';

    % Initialize arrays to hold PSD data for each laser level
    PXX_chr2 = cell(5, 2);
    PXX_yfp = cell(5, 2);
    
    % Process chr2 group
    [PXX_chr2, f, RR_table_chr2] = process_group_RR_30sec(chr2, 'chr2', PXX_chr2);
    % Process yfp group
    [PXX_yfp, f, RR_table_yfp] = process_group_RR_30sec(yfp, 'yfp', PXX_yfp);
    
    % Initialize tables for returning mean and SEM
    resultTable_chr2 = table(f(:), 'VariableNames', {'f'});
    resultTable_yfp = table(f(:), 'VariableNames', {'f'});
    
    % Initialize a variable to store the maximum y-axis value
    maxY = 0;
    
    % First pass to compute maxY for YFP
    for laser_level = 1:5
        if ~isempty(PXX_yfp{laser_level})
            mean_PXX_yfp = PXX_yfp{laser_level, 1};
            SEM_PXX_yfp = PXX_yfp{laser_level, 2};
            maxY = max(maxY, max(mean_PXX_yfp + SEM_PXX_yfp));
        end
    end
    
    % Second pass to compute maxY for Chr2
    for laser_level = 1:5
        if ~isempty(PXX_chr2{laser_level})
            mean_PXX_chr2 = PXX_chr2{laser_level, 1};
            SEM_PXX_chr2 = PXX_chr2{laser_level, 2};
            maxY = max(maxY, max(mean_PXX_chr2 + SEM_PXX_chr2));
        end
    end
    
    % Add a small margin to maxY for better visualization
    maxY = maxY * 1.1;

    % Plot the results
    figure;
    colors = lines(5); % Get 5 colors from the default colormap
    
    % Define the frequency ranges for shading
    vlf_range = [0, 0.15];
    lf_range = [0.15, 1.5];
    hf_range = [1.5, 3];

    % Subplot for YFP
    subplot(1, 2, 1);
    hold on;
    % Shade Very Low Frequency (VLF) band
    fill([vlf_range(1) vlf_range(2) vlf_range(2) vlf_range(1)], ...
        [0 0 maxY maxY], 'r', 'FaceAlpha', 0.1, 'EdgeColor', 'none', 'HandleVisibility', 'off');

    % Shade Low Frequency (LF) band
    fill([lf_range(1) lf_range(2) lf_range(2) lf_range(1)], ...
        [0 0 maxY maxY], 'g', 'FaceAlpha', 0.1, 'EdgeColor', 'none', 'HandleVisibility', 'off');

    % Shade High Frequency (HF) band
    fill([hf_range(1) hf_range(2) hf_range(2) hf_range(1)], ...
        [0 0 maxY maxY], 'y', 'FaceAlpha', 0.1, 'EdgeColor', 'none', 'HandleVisibility', 'off');

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
    ylim([0,maxY]);
    xlim([0, max(f)]);
    title('YFP - RR Intervals');
    xlabel('Frequency (Hz)');
    ylabel('Power Spectral Density (PSD)');
    legend('show', 'Location', 'northeast');
    hold off;

    % Subplot for Chr2
    subplot(1, 2, 2);
    hold on;
    % Shade Very Low Frequency (VLF) band
    fill([vlf_range(1) vlf_range(2) vlf_range(2) vlf_range(1)], ...
        [0 0 maxY maxY], 'r', 'FaceAlpha', 0.1, 'EdgeColor', 'none', 'HandleVisibility', 'off');

    % Shade Low Frequency (LF) band
    fill([lf_range(1) lf_range(2) lf_range(2) lf_range(1)], ...
        [0 0 maxY maxY], 'g', 'FaceAlpha', 0.1, 'EdgeColor', 'none', 'HandleVisibility', 'off');

    % Shade High Frequency (HF) band
    fill([hf_range(1) hf_range(2) hf_range(2) hf_range(1)], ...
        [0 0 maxY maxY], 'y', 'FaceAlpha', 0.1, 'EdgeColor', 'none', 'HandleVisibility', 'off');

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
    ylim([0,maxY]);
    xlim([0, max(f)]);
    title('Chr2 - RR Intervals');
    xlabel('Frequency (Hz)');
    ylabel('Power Spectral Density (PSD)');
    legend('show', 'Location', 'northeast');
    hold off;

    linkaxes([subplot(1, 2, 1), subplot(1, 2, 2)], 'x');

    % Set figure background color to white
    set(gcf, 'Color', 'w');

    % Clear temporary variables
    clear fs sampling_hz dataDirectory mean_PXX_chr2 SEM_PXX_chr2 mean_PXX_yfp SEM_PXX_yfp colors;
end

%  function [PXX_group, f, PXX_bouts] = process_group(group, group_name, PXX_group)
%     fs = 64;
%     sampling_hz = 0.0002;
%     dataDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\Figure_4_data';
% 
% 
%     for s = 1:length(group)
%         suffix = group{s};
% 
%         % Loop through each laser level
%         for laser_level = 1:5
%             variable_name = sprintf('RR_laser_%d_NREM_%s', laser_level, suffix);
%             if evalin('base', ['exist(''', variable_name, ''', ''var'')'])
%                 RR_values = evalin('base', variable_name);
%             else
%                 filename = fullfile(dataDirectory, sprintf('%s.mat', variable_name));
%                 if exist(filename, 'file')
%                     RR_values = load(filename);
%                     RR_values = RR_values.(variable_name);
%                 else
%                     disp(['File not found: ', filename]);
%                     continue;
%                 end
%             end
% 
%             % Loop through each bout
%             PXX_bouts = [];
%             for i = 1:size(RR_values, 1)
%                 bout_data = RR_values(i, :);
% 
%                 % Detrend (and center around 0)
%                 [p, s, mu] = polyfit((1:numel(bout_data))', bout_data, 5);
%                 f_y = polyval(p, (1:numel(bout_data))', [], mu);
%                 detrend_data = bout_data - f_y'; % Detrend data
% 
%                 [pxx, f] = pwelch(detrend_data, [], [], [0:sampling_hz:3], fs); % Calculate PSD
%                 PXX_bouts = [PXX_bouts, pxx'];
%             end
% 
%             % Calculate mean PSD for the current animal and laser level
%             if ~isempty(PXX_bouts)
%                 PXX_bouts = PXX_bouts';
%                 mean_PXX_bouts = mean(PXX_bouts, 1);
%                 SEM_PXX_bouts = std(PXX_bouts, 0, 1) / sqrt(size(PXX_bouts, 1));
%                 PXX_group{laser_level, 1} = mean_PXX_bouts;
%                 PXX_group{laser_level, 2} = SEM_PXX_bouts;
%             end
%         end
%     end
% end