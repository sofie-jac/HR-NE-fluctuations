function plot_PSD_with_laser(RR_data_NREM_table, arch, yfp, min_period_dur)
    fs = 64; % Specify sampling frequency of your signal trace
    sampling_hz = 0.0002;

    % Initialize the cell arrays to store the results for each group
    PSD_results_arch_on = {};
    PSD_results_arch_off = {};
    PSD_results_yfp_on = {};
    PSD_results_yfp_off = {};


    % Loop through each unique suffix in RR_data_NREM
    unique_suffixes = unique(RR_data_NREM_table.MouseID);
    
    % Initialize arrays to hold PSD data and period durations
    PXX_arch_on = [];
    PXX_arch_off = [];
    PXX_yfp_on = [];
    PXX_yfp_off = [];
    
    period_duration_arch_on = [];
    period_duration_arch_off = [];
    period_duration_yfp_on = [];
    period_duration_yfp_off = [];

    for s = 1:length(unique_suffixes)
        suffix = unique_suffixes{s};
        
        % Filter RR_data_NREM to get data for the current suffix
        current_data = RR_data_NREM_table(strcmp(RR_data_NREM_table.MouseID, suffix), :);
        
        
        % Loop through each period for the current suffix
        for i = 1:height(current_data)
            RR_values = current_data.RR_Values{i};
            laser_status = current_data.Laser{i};
            period_length = length(RR_values) / fs;
            
            if period_length < min_period_dur % periods shorter than 180 s are excluded from analysis
                continue
            end
            
            % Detrend (and center around 0)
            [p, s, mu] = polyfit((1:numel(RR_values))', RR_values, 5);
            f_y = polyval(p, (1:numel(RR_values))', [], mu);
            detrend_data = RR_values - f_y'; % Detrend data
            
            [pxx, f] = pwelch(detrend_data, [], [], [0:sampling_hz:3], fs); % Calculate PSD
            
            % Store the PSD data and period durations in the appropriate category
            if ismember(suffix, arch)
                if strcmp(laser_status, 'on')
                    PXX_arch_on = [PXX_arch_on pxx'];
                    period_duration_arch_on = [period_duration_arch_on period_length];
                else
                    PXX_arch_off = [PXX_arch_off pxx'];
                    period_duration_arch_off = [period_duration_arch_off period_length];
                end
            elseif ismember(suffix, yfp)
                if strcmp(laser_status, 'on')
                    PXX_yfp_on = [PXX_yfp_on pxx'];
                    period_duration_yfp_on = [period_duration_yfp_on period_length];
                else
                    PXX_yfp_off = [PXX_yfp_off pxx'];
                    period_duration_yfp_off = [period_duration_yfp_off period_length];
                end
            end
        end
    end

    % Calculate weighted mean and SEM for each group
    if ~isempty(PXX_arch_on)
        [mean_PXX_arch_on, SEM_PXX_arch_on] = calculate_weighted_mean_SEM(PXX_arch_on, period_duration_arch_on);
    else
        mean_PXX_arch_on = [];
        SEM_PXX_arch_on = [];
    end

    if ~isempty(PXX_arch_off)
        [mean_PXX_arch_off, SEM_PXX_arch_off] = calculate_weighted_mean_SEM(PXX_arch_off, period_duration_arch_off);
    else
        mean_PXX_arch_off = [];
        SEM_PXX_arch_off = [];
    end

    if ~isempty(PXX_yfp_on)
        [mean_PXX_yfp_on, SEM_PXX_yfp_on] = calculate_weighted_mean_SEM(PXX_yfp_on, period_duration_yfp_on);
    else
        mean_PXX_yfp_on = [];
        SEM_PXX_yfp_on = [];
    end

    if ~isempty(PXX_yfp_off)
        [mean_PXX_yfp_off, SEM_PXX_yfp_off] = calculate_weighted_mean_SEM(PXX_yfp_off, period_duration_yfp_off);
    else
        mean_PXX_yfp_off = [];
        SEM_PXX_yfp_off = [];
    end

% Plot the results
figure;

% Define the frequency ranges for shading
vlf_range = [0, 0.15];
lf_range = [0.15, 1.5];
hf_range = [1.5, 5];

% Subplot for YFP
subplot(1, 2, 1);
hold on;
% Shade Very Low Frequency (VLF) band
fill([vlf_range(1) vlf_range(2) vlf_range(2) vlf_range(1)], ...
    [0 0 1 1], 'r', 'FaceAlpha', 0.1, 'EdgeColor', 'none', 'HandleVisibility', 'off');

% Shade Low Frequency (LF) band
fill([lf_range(1) lf_range(2) lf_range(2) lf_range(1)], ...
    [0 0 1 1], 'g', 'FaceAlpha', 0.1, 'EdgeColor', 'none', 'HandleVisibility', 'off');

% Shade High Frequency (HF) band
fill([hf_range(1) hf_range(2) hf_range(2) hf_range(1)], ...
    [0 0 1 1], 'y', 'FaceAlpha', 0.1, 'EdgeColor', 'none', 'HandleVisibility', 'off');

% Plot mean PSD and SEM for YFP
if ~isempty(mean_PXX_yfp_on)
    h_yfp_on = shadedErrorBar(f, mean_PXX_yfp_on, SEM_PXX_yfp_on, {'Color', [0 0.4470 0.7410]}, 1);
    set(h_yfp_on.mainLine, 'DisplayName', 'Laser On');
    % Hide the SEM line from the legend
    set(get(get(h_yfp_on.patch, 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
    set(get(get(h_yfp_on.edge(1), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
    set(get(get(h_yfp_on.edge(2), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
end
if ~isempty(mean_PXX_yfp_off)
    h_yfp_off = shadedErrorBar(f, mean_PXX_yfp_off, SEM_PXX_yfp_off, {'Color', [0.4660 0.6740 0.1880]}, 1);
    set(h_yfp_off.mainLine, 'DisplayName', 'Laser Off');
    % Hide the SEM line from the legend
    set(get(get(h_yfp_off.patch, 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
    set(get(get(h_yfp_off.edge(1), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
    set(get(get(h_yfp_off.edge(2), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
end
maxY = max([mean_PXX_yfp_on + SEM_PXX_yfp_on; mean_PXX_yfp_off + SEM_PXX_yfp_off; mean_PXX_arch_on + SEM_PXX_arch_on; mean_PXX_arch_off + SEM_PXX_arch_off]) + 0.00001;
maxX = max(f);
ylim([0, maxY]);
xlim([0, maxX]);
title('YFP - RR Intervals');
xlabel('Frequency (Hz)');
ylabel('Power Spectral Density (PSD)');
legend('show', 'Location', 'northeast');
hold off;

% Subplot for Arch
subplot(1, 2, 2);
hold on;
% Shade Very Low Frequency (VLF) band
fill([vlf_range(1) vlf_range(2) vlf_range(2) vlf_range(1)], ...
    [0 0 1 1], 'r', 'FaceAlpha', 0.1, 'EdgeColor', 'none', 'HandleVisibility', 'off');

% Shade Low Frequency (LF) band
fill([lf_range(1) lf_range(2) lf_range(2) lf_range(1)], ...
    [0 0 1 1], 'g', 'FaceAlpha', 0.1, 'EdgeColor', 'none', 'HandleVisibility', 'off');

% Shade High Frequency (HF) band
fill([hf_range(1) hf_range(2) hf_range(2) hf_range(1)], ...
    [0 0 1 1], 'y', 'FaceAlpha', 0.1, 'EdgeColor', 'none', 'HandleVisibility', 'off');

% Plot mean PSD and SEM for Arch
if ~isempty(mean_PXX_arch_on)
    h_arch_on = shadedErrorBar(f, mean_PXX_arch_on, SEM_PXX_arch_on, {'Color', [0 0.4470 0.7410]}, 1);
    set(h_arch_on.mainLine, 'DisplayName', 'Laser On');
    % Hide the SEM line from the legend
    set(get(get(h_arch_on.patch, 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
    set(get(get(h_arch_on.edge(1), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
    set(get(get(h_arch_on.edge(2), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
end
if ~isempty(mean_PXX_arch_off)
    h_arch_off = shadedErrorBar(f, mean_PXX_arch_off, SEM_PXX_arch_off, {'Color', [0.4660 0.6740 0.1880]}, 1);
    set(h_arch_off.mainLine, 'DisplayName', 'Laser Off');
    % Hide the SEM line from the legend
    set(get(get(h_arch_off.patch, 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
    set(get(get(h_arch_off.edge(1), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
    set(get(get(h_arch_off.edge(2), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
end
maxX = max(f);
ylim([0, maxY]);
xlim([0, maxX]);
title('Arch - RR Intervals');
xlabel('Frequency (Hz)');
ylabel('Power Spectral Density (PSD)');
legend('show', 'Location', 'northeast');
hold off;

linkaxes([subplot(1, 2, 1), subplot(1, 2, 2)], 'x');

% Set figure background color to white
set(gcf, 'Color', 'w');

    % Clear temporary variables
    clear fs min_period_dur sampling_hz unique_suffixes s suffix current_data i RR_values period_length ...
          p s mu f_y detrend_data pxx PXX_arch_on PXX_arch_off PXX_yfp_on PXX_yfp_off ...
          period_duration_arch_on period_duration_arch_off period_duration_yfp_on period_duration_yfp_off ...
          weighted_mean_PXX mean_PXX SEM_PXX;

end
