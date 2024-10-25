function [psd_table, AUC_table, PeakFrequency_table, PeakPower_table] = PSD_no_laser_NE(NE_data_NREM_table, arch, yfp, min_period_dur)
    sampling_hz = 0.0002;
    fsDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\arch_yfp\Traces';

    % Initialize the cell arrays to store the results
    AUC_results = {};
    PeakFrequency_results = {};
    PeakPower_results = {};

    % Loop through each unique suffix in NE_data_NREM
    unique_suffixes = unique(NE_data_NREM_table.MouseID);
    
    % Initialize arrays to hold PSD data and period durations
    PXX_arch = [];
    PXX_yfp = [];
    
    period_duration_arch = [];
    period_duration_yfp = [];

    for s = 1:length(unique_suffixes)
        suffix = unique_suffixes{s};

        % Load sampling frequency
        variable_name_fs = sprintf('signal_fs_%s', suffix);
        if evalin('base', ['exist(''', variable_name_fs, ''', ''var'')'])
            fs = evalin('base', variable_name_fs);
        else
            filename_NE = fullfile(fsDirectory, sprintf('%s.mat', variable_name_fs));
            if exist(filename_NE, 'file')
                fs = load(filename_NE);
                fs = fs.(variable_name_fs);
            else
                disp(['File not found: ', filename_NE]);
                continue;
            end
        end

        % Filter NE_data_NREM to get data for the current suffix
        current_data = NE_data_NREM_table(strcmp(NE_data_NREM_table.MouseID, suffix), :);

        % Loop through each period for the current suffix
        for i = 1:height(current_data)
            NE_Values = current_data.NE_Values{i};
            period_length = length(NE_Values) / fs;

            if period_length < min_period_dur % periods shorter than min_period_dur are excluded from analysis
                continue
            end

            % Detrend (and center around 0)
            [p, s, mu] = polyfit((1:numel(NE_Values))', NE_Values, 5);
            f_y = polyval(p, (1:numel(NE_Values))', [], mu);
            detrend_data = NE_Values - f_y'; % Detrend data

            [pxx, f] = pwelch(detrend_data, [], [], [0:sampling_hz:0.1], fs); % Calculate PSD
            AUC = trapz(f, pxx); % Calculate area under the curve

            % Store the PSD data and period durations in the appropriate category
            if ismember(suffix, arch)
                PXX_arch = [PXX_arch pxx'];
                period_duration_arch = [period_duration_arch period_length];
                event = 'Arch';
            elseif ismember(suffix, yfp)
                PXX_yfp = [PXX_yfp pxx'];
                period_duration_yfp = [period_duration_yfp period_length];
                event = 'YFP';
            end

            % Find the peak frequency and peak power
            [peakPower, maxIdx] = max(pxx);
            peak_frequency = f(maxIdx);

            % Store the AUC value, suffix, and event type in the results cell array
            AUC_results{end+1, 1} = AUC;
            AUC_results{end, 2} = suffix;
            AUC_results{end, 3} = event;
            AUC_results{end, 4} = period_length;


            % Store the peak frequency value, suffix, and event type in the results cell array
            PeakFrequency_results{end+1, 1} = peak_frequency;
            PeakFrequency_results{end, 2} = suffix;
            PeakFrequency_results{end, 3} = event;
            PeakFrequency_results{end, 4} = period_length;


            % Store the peak power value, suffix, and event type in the results cell array
            PeakPower_results{end+1, 1} = peakPower;
            PeakPower_results{end, 2} = suffix;
            PeakPower_results{end, 3} = event;
            PeakPower_results{end, 4} = period_length;

        end
    end

    % Calculate weighted mean and SEM for each group
    if ~isempty(PXX_arch)
        [mean_PXX_arch, SEM_PXX_arch] = calculate_weighted_mean_SEM(PXX_arch, period_duration_arch);
    else
        mean_PXX_arch = [];
        SEM_PXX_arch = [];
    end

    if ~isempty(PXX_yfp)
        [mean_PXX_yfp, SEM_PXX_yfp] = calculate_weighted_mean_SEM(PXX_yfp, period_duration_yfp);
    else
        mean_PXX_yfp = [];
        SEM_PXX_yfp = [];
    end

    % Ensure all vectors are column vectors
    if size(f, 2) > size(f, 1)
        f = f';
    end
    if size(mean_PXX_arch, 2) > size(mean_PXX_arch, 1)
        mean_PXX_arch = mean_PXX_arch';
    end
    if size(SEM_PXX_arch, 2) > size(SEM_PXX_arch, 1)
        SEM_PXX_arch = SEM_PXX_arch';
    end
    if size(mean_PXX_yfp, 2) > size(mean_PXX_yfp, 1)
        mean_PXX_yfp = mean_PXX_yfp';
    end
    if size(SEM_PXX_yfp, 2) > size(SEM_PXX_yfp, 1)
        SEM_PXX_yfp = SEM_PXX_yfp';
    end
    
    % Create the table with the requested columns
    psd_table = table(f, mean_PXX_arch, SEM_PXX_arch, mean_PXX_yfp, SEM_PXX_yfp, ...
                      'VariableNames', {'Frequency', 'Mean_ARCH', 'SEM_ARCH', ...
                                        'Mean_YFP', 'SEM_YFP'});

    % Plot the results
    figure;
    hold on;

    % Plot mean PSD and SEM for YFP
    if ~isempty(mean_PXX_yfp)
        h_yfp = shadedErrorBar(f, mean_PXX_yfp, SEM_PXX_yfp, {'Color', [0 0.4470 0.7410]}, 1);
        set(h_yfp.mainLine, 'DisplayName', 'YFP');
        % Hide the SEM line from the legend
        set(get(get(h_yfp.patch, 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
        set(get(get(h_yfp.edge(1), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
        set(get(get(h_yfp.edge(2), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
    end

    % Plot mean PSD and SEM for Arch
    if ~isempty(mean_PXX_arch)
        h_arch = shadedErrorBar(f, mean_PXX_arch, SEM_PXX_arch, {'Color', [0.8500 0.3250 0.0980]}, 1);
        set(h_arch.mainLine, 'DisplayName', 'Arch');
        % Hide the SEM line from the legend
        set(get(get(h_arch.patch, 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
        set(get(get(h_arch.edge(1), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
        set(get(get(h_arch.edge(2), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
    end

    % Set axes and labels
    maxY = max([mean_PXX_arch + SEM_PXX_arch; mean_PXX_yfp + SEM_PXX_yfp]) + 0.00001;
    maxX = max(f);
    ylim([0, maxY]);
    xlim([0, maxX]);
    title('PSD - NE Intervals');
    xlabel('Frequency (Hz)');
    ylabel('Power Spectral Density (PSD)');
    legend('show', 'Location', 'northeast');
    hold off;

    % Set figure background color to white
    set(gcf, 'Color', 'w');

    % Clear temporary variables
    clear fs min_period_dur sampling_hz unique_suffixes s suffix current_data i NE_Values period_length ...
          p s mu f_y detrend_data pxx PXX_arch PXX_yfp ...
          period_duration_arch period_duration_yfp ...
          weighted_mean_PXX mean_PXX SEM_PXX;

    AUC_table = cell2table(AUC_results, 'VariableNames', {'AUC', 'Suffix', 'EventVar', 'BoutLength'});
    PeakFrequency_table = cell2table(PeakFrequency_results, 'VariableNames', {'PeakFrequency', 'Suffix', 'EventVar', 'BoutLength'});
    PeakPower_table = cell2table(PeakPower_results, 'VariableNames', {'PeakPower', 'Suffix', 'EventVar', 'BoutLength'});
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
