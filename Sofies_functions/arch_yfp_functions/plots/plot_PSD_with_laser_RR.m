function [psd_table, AUC_table, PeakFrequency_table, PeakPower_table] = plot_PSD_with_laser_RR(RR_data_NREM_table, arch, yfp, min_period_dur)
    sampling_hz = 0.0002;
    fs = 64;

    % Initialize the cell arrays to store the results for each group
    PSD_results_arch_on = {};
    PSD_results_arch_off = {};
    PSD_results_yfp_on = {};
    PSD_results_yfp_off = {};

        % Initialize empty cell arrays to store the results
    AUC_results = {};
    PeakFrequency_results = {};
    PeakPower_results = {};

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
            RR_Values = current_data.RR_Values{i};
            laser_status = current_data.Laser{i};
            period_length = length(RR_Values) / fs;
            
            if period_length < min_period_dur % periods shorter than 180 s are excluded from analysis
                continue
            end
            
            % Detrend (and center around 0)
            [p, s, mu] = polyfit((1:numel(RR_Values))', RR_Values, 5);
            f_y = polyval(p, (1:numel(RR_Values))', [], mu);
            detrend_data = RR_Values - f_y'; % Detrend data
            
            [pxx, f] = pwelch(detrend_data, [], [], [0:sampling_hz:3], fs); % Calculate PSD
                

            
            % Store the PSD data and period durations in the appropriate category
            if ismember(suffix, arch)
                if strcmp(laser_status, 'on')
                    PXX_arch_on = [PXX_arch_on pxx'];
                    period_duration_arch_on = [period_duration_arch_on period_length];
                    event = 'Arch_on';
                else
                    PXX_arch_off = [PXX_arch_off pxx'];
                    period_duration_arch_off = [period_duration_arch_off period_length];
                    event = 'Arch_off';
                end
            elseif ismember(suffix, yfp)
                if strcmp(laser_status, 'on')
                    PXX_yfp_on = [PXX_yfp_on pxx'];
                    period_duration_yfp_on = [period_duration_yfp_on period_length];
                    event = 'Yfp_on';
                else
                    PXX_yfp_off = [PXX_yfp_off pxx'];
                    period_duration_yfp_off = [period_duration_yfp_off period_length];
                    event = 'Yfp_off';
                end
            end
            
            AUC = trapz(f, pxx); % Calculate area under the curve

                        % Find the peak frequency and peak power
            [peakPower, maxIdx] = max(pxx);
            peak_frequency = f(maxIdx);

            % Store the AUC value, suffix, and laser level in the results cell array
            AUC_results{end+1, 1} = AUC;
            AUC_results{end, 2} = suffix;
            AUC_results{end, 3} = event;

            % Store the peak frequency value, suffix, and laser level in the results cell array
            PeakFrequency_results{end+1, 1} = peak_frequency;
            PeakFrequency_results{end, 2} = suffix;
            PeakFrequency_results{end, 3} = event;

            % Store the peak power value, suffix, and laser level in the results cell array
            PeakPower_results{end+1, 1} = peakPower;
            PeakPower_results{end, 2} = suffix;
            PeakPower_results{end, 3} = event;
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

    % Ensure all vectors are column vectors
    if size(f, 2) > size(f, 1)
        f = f';
    end
    if size(mean_PXX_arch_on, 2) > size(mean_PXX_arch_on, 1)
        mean_PXX_arch_on = mean_PXX_arch_on';
    end
    if size(SEM_PXX_arch_on, 2) > size(SEM_PXX_arch_on, 1)
        SEM_PXX_arch_on = SEM_PXX_arch_on';
    end
    if size(mean_PXX_arch_off, 2) > size(mean_PXX_arch_off, 1)
        mean_PXX_arch_off = mean_PXX_arch_off';
    end
    if size(SEM_PXX_arch_off, 2) > size(SEM_PXX_arch_off, 1)
        SEM_PXX_arch_off = SEM_PXX_arch_off';
    end
    if size(mean_PXX_yfp_on, 2) > size(mean_PXX_yfp_on, 1)
        mean_PXX_yfp_on = mean_PXX_yfp_on';
    end
    if size(SEM_PXX_yfp_on, 2) > size(SEM_PXX_yfp_on, 1)
        SEM_PXX_yfp_on = SEM_PXX_yfp_on';
    end
    if size(mean_PXX_yfp_off, 2) > size(mean_PXX_yfp_off, 1)
        mean_PXX_yfp_off = mean_PXX_yfp_off';
    end
    if size(SEM_PXX_yfp_off, 2) > size(SEM_PXX_yfp_off, 1)
        SEM_PXX_yfp_off = SEM_PXX_yfp_off';
    end
    
    % Create the table with the requested columns
    psd_table = table(f, mean_PXX_arch_on, SEM_PXX_arch_on, mean_PXX_arch_off, SEM_PXX_arch_off, ...
                      mean_PXX_yfp_on, SEM_PXX_yfp_on, mean_PXX_yfp_off, SEM_PXX_yfp_off, ...
                      'VariableNames', {'Frequency', 'Mean_ARCH_Laser_On', 'SEM_ARCH_Laser_On', ...
                                        'Mean_ARCH_Laser_Off', 'SEM_ARCH_Laser_Off', ...
                                        'Mean_YFP_Laser_On', 'SEM_YFP_Laser_On', ...
                                        'Mean_YFP_Laser_Off', 'SEM_YFP_Laser_Off'});


    % Plot the results
    figure;

    % Subplot for YFP
    subplot(1, 2, 1);
    hold on;

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
    clear fs min_period_dur sampling_hz unique_suffixes s suffix current_data i RR_Values period_length ...
          p s mu f_y detrend_data pxx PXX_arch_on PXX_arch_off PXX_yfp_on PXX_yfp_off ...
          period_duration_arch_on period_duration_arch_off period_duration_yfp_on period_duration_yfp_off ...
          weighted_mean_PXX mean_PXX SEM_PXX;

    AUC_table = cell2table(AUC_results, 'VariableNames', {'AUC', 'Suffix', 'EventVar'});
    PeakFrequency_table = cell2table(PeakFrequency_results, 'VariableNames', {'PeakFrequency', 'Suffix', 'EventVar'});
    PeakPower_table = cell2table(PeakPower_results, 'VariableNames', {'PeakPower', 'Suffix', 'EventVar'});
end



function [mean_PXX, SEM_PXX] = calculate_weighted_mean_SEM(PXX, durations)
    % Calculate weighted mean
    total_duration = sum(durations);
    weights = durations / total_duration;
    mean_PXX = sum(PXX .* weights, 2);
    
    % Calculate weighted SEM
    n = length(durations);
    SEM_PXX = sqrt(sum(weights .* (PXX - mean_PXX).^2, 2) / n);
end
