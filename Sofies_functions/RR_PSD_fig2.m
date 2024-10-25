function [psd_table, AUC_table, PeakFrequency_table, PeakPower_table] = RR_PSD_fig2(RR_data_NREM_table, min_period_dur, min_val, max_val)
    sampling_hz = 0.0002;
    fs = 64;

    % Initialize empty cell arrays to store the results
    AUC_results = {};
    PeakFrequency_results = {};
    PeakPower_results = {};

    % Loop through each unique suffix in RR_data_NREM
    unique_suffixes = unique(RR_data_NREM_table.MouseID);
    
    % Initialize arrays to hold PSD data and period durations
    PXX_all = [];
    period_duration_all = [];

    for s = 1:length(unique_suffixes)
        suffix = unique_suffixes{s};
        
        % Filter RR_data_NREM to get data for the current suffix
        current_data = RR_data_NREM_table(strcmp(RR_data_NREM_table.MouseID, suffix), :);
        
        % Loop through each period for the current suffix
        for i = 1:height(current_data)
            RR_Values = current_data.RR_Values{i};
            period_length = length(RR_Values) / fs;
            
            if period_length < min_period_dur % periods shorter than 180 s are excluded from analysis
                continue
            end
            
            % Detrend (and center around 0)
            [p, s, mu] = polyfit((1:numel(RR_Values))', RR_Values, 5);
            f_y = polyval(p, (1:numel(RR_Values))', [], mu);
            detrend_data = RR_Values - f_y'; % Detrend data

level = 9; % Decomposition level
waveletName = 'db4'; % Daubechies 4 wavelet

% Perform wavelet decomposition
[c, l] = wavedec(RR_Values, level, waveletName);

% Zero out the approximation coefficients at Level 9
cA9 = zeros(1, l(1));

% Reconstruct the signal without the approximation at Level 9
detrend_data2 = waverec([cA9, c(l(1)+1:end)], l, waveletName);
            
            [pxx, f] = pwelch(detrend_data, [], [], [min_val:sampling_hz:max_val], fs); % Calculate PSD

                %     if i == 12 & suffix == '209'
                %     figure;
                %     time = length(RR_Values)/64;
                %     % Left subplot for raw RR values
                %     subplot(1, 2, 1);
                %     time_axis = linspace(0, time, length(RR_Values)); % Time axis from -30 to 30 seconds
                %     plot(time_axis, RR_Values);
                %     xline(0, '--');
                %     xlabel('Time (s)');
                %     ylabel('RR Values');
                % 
                %     % Right subplot for PSD
                %     subplot(1, 2, 2);
                %     plot(f, pxx);
                %     xlabel('Frequency (Hz)');
                %     ylabel('Power Spectral Density');
                % end
                % 
            % Calculate AUC
            AUC = trapz(f, pxx); % Calculate area under the curve

            % Find the peak frequency and peak power
            [peakPower, maxIdx] = max(pxx);
            peak_frequency = f(maxIdx);

            % Store the PSD data and period durations
            PXX_all = [PXX_all, pxx'];
            period_duration_all = [period_duration_all, period_length];

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

    % Transparent shading for different frequency bands
vlf_range = [0, 0.15];
lf_range = [0.15, 1.5];
hf_range = [1.5, 5];



    maxY = max(mean_PXX_all + SEM_PXX_all) + 0.00001;
    maxX = max(f);

        % Shade Very Low Frequency (VLF) band
fill([vlf_range(1) vlf_range(2) vlf_range(2) vlf_range(1)], ...
    [0 0 maxY maxY], 'r', 'FaceAlpha', 0.1, 'EdgeColor', 'none', 'DisplayName', 'Very Low Frequency (VLF)');

% Shade Low Frequency (LF) band
fill([lf_range(1) lf_range(2) lf_range(2) lf_range(1)], ...
    [0 0 maxY maxY], 'g', 'FaceAlpha', 0.1, 'EdgeColor', 'none', 'DisplayName', 'Low Frequency (LF)');

% Shade High Frequency (HF) band
fill([hf_range(1) hf_range(2) hf_range(2) hf_range(1)], ...
    [0 0 maxY maxY], 'y', 'FaceAlpha', 0.1, 'EdgeColor', 'none', 'DisplayName', 'High Frequency (HF)');

    ylim([0, maxY]);
    xlim([0, maxX]);
    title('RR Intervals - Power Spectral Density (PSD)');
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
