function [psd_table, AUC_table, PeakFrequency_table, PeakPower_table] = plot_PSD_with_laser_combined(NE_data_NREM_table, RR_data_NREM_table, arch, yfp, min_period_dur_NE, min_period_dur_RR)
    % Define the sampling frequencies
    fs_NE = 1073;
    fs_RR = 64;
    sampling_hz = 0.0002;

    % Initialize arrays to hold PSD data and period durations
    PXX_arch_on = [];
    PXX_arch_off = [];
    PXX_yfp_on = [];
    PXX_yfp_off = [];
    
    period_duration_arch_on = [];
    period_duration_arch_off = [];
    period_duration_yfp_on = [];
    period_duration_yfp_off = [];

    % Initialize empty cell arrays to store the results
    AUC_results = {};
    PeakFrequency_results = {};
    PeakPower_results = {};

    % Loop through each unique suffix in NE_data_NREM and RR_data_NREM
    unique_suffixes_NE = unique(NE_data_NREM_table.MouseID);
    unique_suffixes_RR = unique(RR_data_NREM_table.MouseID);
    unique_suffixes = intersect(unique_suffixes_NE, unique_suffixes_RR);

    for s = 1:length(unique_suffixes)
        suffix = unique_suffixes{s};
        
        % Filter NE_data_NREM and RR_data_NREM to get data for the current suffix
        current_data_NE = NE_data_NREM_table(strcmp(NE_data_NREM_table.MouseID, suffix), :);
        current_data_RR = RR_data_NREM_table(strcmp(RR_data_NREM_table.MouseID, suffix), :);
        
        % Loop through each period for the current suffix, ensuring it meets both NE and RR criteria
        for i = 1:min(height(current_data_NE), height(current_data_RR))
            NE_Values = current_data_NE.NE_Values{i};
            RR_Values = current_data_RR.RR_Values{i};
            laser_status_NE = current_data_NE.Laser{i};
            laser_status_RR = current_data_RR.Laser{i};

            period_length_NE = length(NE_Values) / fs_NE;
            period_length_RR = length(RR_Values) / fs_RR;

            % Check if the period meets both length criteria
            if period_length_NE < min_period_dur_NE || period_length_RR < min_period_dur_RR
                continue
            end

            % Detrend NE and RR data
            [p_NE, s_NE, mu_NE] = polyfit((1:numel(NE_Values))', NE_Values, 5);
            f_y_NE = polyval(p_NE, (1:numel(NE_Values))', [], mu_NE);
            detrend_data_NE = NE_Values - f_y_NE';

            [p_RR, s_RR, mu_RR] = polyfit((1:numel(RR_Values))', RR_Values, 5);
            f_y_RR = polyval(p_RR, (1:numel(RR_Values))', [], mu_RR);
            detrend_data_RR = RR_Values - f_y_RR';

            % Calculate PSD for NE and RR
            [pxx_NE, f_NE] = pwelch(detrend_data_NE, [], [], [0:sampling_hz:0.1], fs_NE);
            [pxx_RR, f_RR] = pwelch(detrend_data_RR, [], [], [0:sampling_hz:3], fs_RR);

            % Store the PSD data and period durations in the appropriate category
            if ismember(suffix, arch)
                if strcmp(laser_status_NE, 'on') && strcmp(laser_status_RR, 'on')
                    PXX_arch_on = [PXX_arch_on pxx_NE'];
                    period_duration_arch_on = [period_duration_arch_on period_length_NE];
                    event = 'Arch_on';
                elseif strcmp(laser_status_NE, 'off') && strcmp(laser_status_RR, 'off')
                    PXX_arch_off = [PXX_arch_off pxx_NE'];
                    period_duration_arch_off = [period_duration_arch_off period_length_NE];
                    event = 'Arch_off';
                else
                    disp('Warning: inconsistencies in laser labels between RR and NE')
                    event = 'NA';
                end
            elseif ismember(suffix, yfp)
                if strcmp(laser_status_NE, 'on') && strcmp(laser_status_RR, 'on')
                    PXX_yfp_on = [PXX_yfp_on pxx_NE'];
                    period_duration_yfp_on = [period_duration_yfp_on period_length_NE];
                    event = 'Yfp_on';
                elseif strcmp(laser_status_NE, 'off') && strcmp(laser_status_RR, 'off')
                    PXX_yfp_off = [PXX_yfp_off pxx_NE'];
                    period_duration_yfp_off = [period_duration_yfp_off period_length_NE];
                    event = 'Yfp_off';
                else
                    disp('Warning: inconsistencies in laser labels between RR and NE')
                    event = 'NA';
                end
            end

            % Calculate AUC, Peak Frequency, and Peak Power for NE
            AUC_NE = trapz(f_NE, pxx_NE);
            [peakPower_NE, maxIdx_NE] = max(pxx_NE);
            peak_frequency_NE = f_NE(maxIdx_NE);

            % Calculate AUC, Peak Frequency, and Peak Power for RR
            AUC_RR = trapz(f_RR, pxx_RR);
            [peakPower_RR, maxIdx_RR] = max(pxx_RR);
            peak_frequency_RR = f_RR(maxIdx_RR);

            % Store the results for both NE and RR
            AUC_results{end+1, 1} = AUC_NE;
            AUC_results{end, 2} = AUC_RR;
            AUC_results{end, 3} = suffix;
            AUC_results{end, 4} = event;

            PeakFrequency_results{end+1, 1} = peak_frequency_NE;
            PeakFrequency_results{end, 2} = peak_frequency_RR;
            PeakFrequency_results{end, 3} = suffix;
            PeakFrequency_results{end, 4} = event;

            PeakPower_results{end+1, 1} = peakPower_NE;
            PeakPower_results{end, 2} = peakPower_RR;
            PeakPower_results{end, 3} = suffix;
            PeakPower_results{end, 4} = event;
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
    if size(f_NE, 2) > size(f_NE, 1)
        f_NE = f_NE';
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
    psd_table = table(f_NE, mean_PXX_arch_on, SEM_PXX_arch_on, mean_PXX_arch_off, SEM_PXX_arch_off, ...
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
        h_yfp_on = shadedErrorBar(f_NE, mean_PXX_yfp_on, SEM_PXX_yfp_on, {'Color', [0 0.4470 0.7410]}, 1);
        set(h_yfp_on.mainLine, 'DisplayName', 'Laser On');
        % Hide the SEM line from the legend
        set(get(get(h_yfp_on.patch, 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
        set(get(get(h_yfp_on.edge(1), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
        set(get(get(h_yfp_on.edge(2), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
    end
    if ~isempty(mean_PXX_yfp_off)
        h_yfp_off = shadedErrorBar(f_NE, mean_PXX_yfp_off, SEM_PXX_yfp_off, {'Color', [0.4660 0.6740 0.1880]}, 1);
        set(h_yfp_off.mainLine, 'DisplayName', 'Laser Off');
        % Hide the SEM line from the legend
        set(get(get(h_yfp_off.patch, 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
        set(get(get(h_yfp_off.edge(1), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
        set(get(get(h_yfp_off.edge(2), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
    end
    maxY = max([mean_PXX_yfp_on + SEM_PXX_yfp_on; mean_PXX_yfp_off + SEM_PXX_yfp_off; mean_PXX_arch_on + SEM_PXX_arch_on; mean_PXX_arch_off + SEM_PXX_arch_off]) + 0.00001;
    maxX = max(f_NE);
    ylim([0, maxY]);
    xlim([0, maxX]);
    title('YFP - NE Intervals');
    xlabel('Frequency (Hz)');
    ylabel('Power Spectral Density (PSD)');
    legend('show', 'Location', 'northeast');
    hold off;

    % Subplot for Arch
    subplot(1, 2, 2);
    hold on;
    % Plot mean PSD and SEM for Arch
    if ~isempty(mean_PXX_arch_on)
        h_arch_on = shadedErrorBar(f_NE, mean_PXX_arch_on, SEM_PXX_arch_on, {'Color', [0 0.4470 0.7410]}, 1);
        set(h_arch_on.mainLine, 'DisplayName', 'Laser On');
        % Hide the SEM line from the legend
        set(get(get(h_arch_on.patch, 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
        set(get(get(h_arch_on.edge(1), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
        set(get(get(h_arch_on.edge(2), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
    end
    if ~isempty(mean_PXX_arch_off)
        h_arch_off = shadedErrorBar(f_NE, mean_PXX_arch_off, SEM_PXX_arch_off, {'Color', [0.4660 0.6740 0.1880]}, 1);
        set(h_arch_off.mainLine, 'DisplayName', 'Laser Off');
        % Hide the SEM line from the legend
        set(get(get(h_arch_off.patch, 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
        set(get(get(h_arch_off.edge(1), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
        set(get(get(h_arch_off.edge(2), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
    end
    maxX = max(f_NE);
    ylim([0, maxY]);
    xlim([0, maxX]);
    title('Arch - NE Intervals');
    xlabel('Frequency (Hz)');
    ylabel('Power Spectral Density (PSD)');
    legend('show', 'Location', 'northeast');
    hold off;

    linkaxes([subplot(1, 2, 1), subplot(1, 2, 2)], 'x');

    % Set figure background color to white
    set(gcf, 'Color', 'w');

    % Clear temporary variables
    clear fs_NE fs_RR min_period_dur_NE min_period_dur_RR sampling_hz unique_suffixes s suffix current_data_NE current_data_RR i ...
          NE_Values RR_Values period_length_NE period_length_RR p_NE p_RR s_NE s_RR mu_NE mu_RR f_y_NE f_y_RR ...
          detrend_data_NE detrend_data_RR pxx_NE pxx_RR PXX_arch_on PXX_arch_off PXX_yfp_on PXX_yfp_off ...
          period_duration_arch_on period_duration_arch_off period_duration_yfp_on period_duration_yfp_off ...
          mean_PXX SEM_PXX f_NE f_RR;

    % Convert the results to tables
    AUC_table = cell2table(AUC_results, 'VariableNames', {'AUC_NE', 'AUC_RR', 'Suffix', 'EventVar'});
    PeakFrequency_table = cell2table(PeakFrequency_results, 'VariableNames', {'PeakFrequency_NE', 'PeakFrequency_RR', 'Suffix', 'EventVar'});
    PeakPower_table = cell2table(PeakPower_results, 'VariableNames', {'PeakPower_NE', 'PeakPower_RR', 'Suffix', 'EventVar'});
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
