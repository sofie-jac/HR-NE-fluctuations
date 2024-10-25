function [psd_table, AUC_table, PeakFrequency_table, PeakPower_table] = NE_PSD_fig2(NE_data_NREM_table, min_period_dur)
    sampling_hz = 0.0002;

    % Initialize empty cell arrays to store the results
    AUC_results = {};
    PeakFrequency_results = {};
    PeakPower_results = {};

    % Loop through each unique suffix in NE_data_NREM
    unique_suffixes = unique(NE_data_NREM_table.MouseID);
    
    % Initialize arrays to hold PSD data and period durations
    PXX_all = [];
    period_duration_all = [];

    for s = 1:length(unique_suffixes)
        suffix = unique_suffixes{s};
        
        % Load sampling frequency
        variable_name_fs = sprintf('signal_fs_%s', suffix);
        if evalin('base', ['exist(''', variable_name_fs, ''', ''var'')'])
            fs = evalin('base', variable_name_fs);
        else
            % Handle missing sampling frequency
            warning(['Sampling frequency not found for: ', suffix]);
            continue;
        end

        % Filter NE_data_NREM to get data for the current suffix
        current_data = NE_data_NREM_table(strcmp(NE_data_NREM_table.MouseID, suffix), :);
        
        % Loop through each period for the current suffix
        for i = 1:height(current_data)
            NE_Values = current_data.NE_Values{i};
            period_length = length(NE_Values) / fs;
            
            if period_length < min_period_dur % periods shorter than 180 s are excluded from analysis
                continue
            end
            
            % Detrend (and center around 0)
            [p, s, mu] = polyfit((1:numel(NE_Values))', NE_Values, 5);
            f_y = polyval(p, (1:numel(NE_Values))', [], mu);
            detrend_data = NE_Values - f_y'; % Detrend data
            
            [pxx, f] = pwelch(detrend_data, [], [], [0:sampling_hz:0.1], fs); % Calculate PSD
            AUC = trapz(f, pxx); % Calculate area under the curve
            
            % Store the PSD data and period durations
            PXX_all = [PXX_all, pxx'];
            period_duration_all = [period_duration_all, period_length];

            % Find the peak frequency and peak power
            [peakPower, maxIdx] = max(pxx);
            peak_frequency = f(maxIdx);

            % Store the results in the results cell arrays
            AUC_results{end+1, 1} = AUC;
            AUC_results{end, 2} = suffix;
            AUC_results{end, 3} = period_length;

            PeakFrequency_results{end+1, 1} = peak_frequency;
            PeakFrequency_results{end, 2} = suffix;
            PeakFrequency_results{end, 3} = period_length;

            PeakPower_results{end+1, 1} = peakPower;
            PeakPower_results{end, 2} = suffix;
            PeakPower_results{end, 3} = period_length;
        end
    end

    % Calculate weighted mean and SEM for the combined data
    if ~isempty(PXX_all)
        [mean_PXX_all, SEM_PXX_all] = calculate_weighted_mean_SEM(PXX_all, period_duration_all);
    else
        mean_PXX_all = [];
        SEM_PXX_all = [];
    end

    % Ensure all vectors are column vectors
    if size(f, 2) > size(f, 1)
        f = f';
    end
    if size(mean_PXX_all, 2) > size(mean_PXX_all, 1)
        mean_PXX_all = mean_PXX_all';
    end
    if size(SEM_PXX_all, 2) > size(SEM_PXX_all, 1)
        SEM_PXX_all = SEM_PXX_all';
    end

    % Create the table with the requested columns
    psd_table = table(f, mean_PXX_all, SEM_PXX_all, 'VariableNames', {'Frequency', 'Mean_PSD', 'SEM_PSD'});

    % Plot the results
    figure;
    hold on;

    % Plot mean PSD and SEM
    if ~isempty(mean_PXX_all)
        h_psd = shadedErrorBar(f, mean_PXX_all, SEM_PXX_all, {'Color', [0 0.4470 0.7410]}, 1);
        set(h_psd.mainLine, 'DisplayName', 'PSD');
        % Hide the SEM line from the legend
        set(get(get(h_psd.patch, 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
        set(get(get(h_psd.edge(1), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
        set(get(get(h_psd.edge(2), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
    end

    maxY = max(mean_PXX_all + SEM_PXX_all) + 0.00001;
    maxX = max(f);
    ylim([0, maxY]);
    xlim([0, maxX]);
    title('NE Intervals - Power Spectral Density (PSD)');
    xlabel('Frequency (Hz)');
    ylabel('Power Spectral Density (PSD)');
    legend('show', 'Location', 'northeast');
    hold off;

    set(gcf, 'Color', 'w');

    % Convert results to tables
    AUC_table = cell2table(AUC_results, 'VariableNames', {'AUC', 'Suffix', 'BoutLength'});
    PeakFrequency_table = cell2table(PeakFrequency_results, 'VariableNames', {'PeakFrequency', 'Suffix', 'BoutLength'});
    PeakPower_table = cell2table(PeakPower_results, 'VariableNames', {'PeakPower', 'Suffix', 'BoutLength'});
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
