function [AUC_table, PeakFrequency_table, PeakPower_table, mean_psd_chr2_table, sem_psd_chr2_table, mean_psd_yfp_table, sem_psd_yfp_table, f] = PSD_RR_chr2_all_NREM(RR_intervals, chr2, yfp)
      fs = 64; % Specify sampling frequency of your signal trace
    sampling_hz = 0.002;

    % Initialize the structures to store the results for each group
    PXX_chr2 = struct();
    PXX_yfp = struct();

    AUC_results = {};
    PeakFrequency_results = {};
    PeakPower_results = {};
    mean_psd_yfp = {};
    mean_psd_chr2 = {};
    sem_psd_yfp = {};
    sem_psd_chr2 = {};

    % Initialize structures to hold PSD data for each subject
    psd_chr2 = struct();
    durations_chr2 = struct();
    psd_yfp = struct();
    durations_yfp = struct();

    % Loop through each entry in RR_intervals
    for i = 1:size(RR_intervals, 1)
        RR_values = RR_intervals{i, 1};
        suffix = RR_intervals{i, 2};
        laser_level = RR_intervals{i, 3};
        
        % Calculate period duration
        period_duration = length(RR_values) / fs;
        
        if period_duration > 60
        % Detrend (and center around 0)
        [p, s, mu] = polyfit((1:numel(RR_values))', RR_values, 5);
        f_y = polyval(p, (1:numel(RR_values))', [], mu);
        detrend_data = RR_values - f_y'; % Detrend data

        [pxx, f] = pwelch(detrend_data, [], [], [0:sampling_hz:0.15], fs); % Calculate PSD
        AUC = trapz(f, pxx); % Calculate area under the curve

        % Find the peak frequency and peak power
        [peakPower, maxIdx] = max(pxx);
        peak_frequency = f(maxIdx);

                
        % Store the PSD data in the appropriate category
        if ismember(suffix, chr2)
            group = 'chr2';
            prefix = 'M';

        % Store the AUC value, suffix, and laser level in the results cell array
        AUC_results{end+1, 1} = AUC;
        AUC_results{end, 2} = suffix;
        AUC_results{end, 3} = laser_level;
        AUC_results{end, 4} = group;
        AUC_results{end, 5} = period_duration;


        % Store the peak frequency value, suffix, and laser level in the results cell array
        PeakFrequency_results{end+1, 1} = peak_frequency;
        PeakFrequency_results{end, 2} = suffix;
        PeakFrequency_results{end, 3} = laser_level;
        PeakFrequency_results{end, 4} = group;
        PeakFrequency_results{end, 5} = period_duration;

        % Store the peak power value, suffix, and laser level in the results cell array
        PeakPower_results{end+1, 1} = peakPower;
        PeakPower_results{end, 2} = suffix;
        PeakPower_results{end, 3} = laser_level;
        PeakPower_results{end, 4} = group;
        PeakPower_results{end, 5} = period_duration;

        elseif ismember(suffix, yfp)
            group = 'yfp';
            prefix = 'M';

        % Store the AUC value, suffix, and laser level in the results cell array
        AUC_results{end+1, 1} = AUC;
        AUC_results{end, 2} = suffix;
        AUC_results{end, 3} = laser_level;
        AUC_results{end, 4} = group;
        AUC_results{end, 5} = period_duration;


        % Store the peak frequency value, suffix, and laser level in the results cell array
        PeakFrequency_results{end+1, 1} = peak_frequency;
        PeakFrequency_results{end, 2} = suffix;
        PeakFrequency_results{end, 3} = laser_level;
        PeakFrequency_results{end, 4} = group;
        PeakFrequency_results{end, 5} = period_duration;

        % Store the peak power value, suffix, and laser level in the results cell array
        PeakPower_results{end+1, 1} = peakPower;
        PeakPower_results{end, 2} = suffix;
        PeakPower_results{end, 3} = laser_level;
        PeakPower_results{end, 4} = group;
        PeakPower_results{end, 5} = period_duration;
        else
            continue;
        end

        laser_field = ['Level', num2str(laser_level)];
        id_field = [prefix, suffix];

        if strcmp(group, 'chr2')
            if ~isfield(psd_chr2, laser_field)
                psd_chr2.(laser_field) = struct();
                durations_chr2.(laser_field) = struct();
            end
            if ~isfield(psd_chr2.(laser_field), id_field)
                psd_chr2.(laser_field).(id_field) = [];
                durations_chr2.(laser_field).(id_field) = [];
            end
            psd_chr2.(laser_field).(id_field) = [psd_chr2.(laser_field).(id_field), pxx'];
            durations_chr2.(laser_field).(id_field) = [durations_chr2.(laser_field).(id_field), period_duration];
        elseif strcmp(group, 'yfp')
            if ~isfield(psd_yfp, laser_field)
                psd_yfp.(laser_field) = struct();
                durations_yfp.(laser_field) = struct();
            end
            if ~isfield(psd_yfp.(laser_field), id_field)
                psd_yfp.(laser_field).(id_field) = [];
                durations_yfp.(laser_field).(id_field) = [];
            end
            psd_yfp.(laser_field).(id_field) = [psd_yfp.(laser_field).(id_field), pxx'];
            durations_yfp.(laser_field).(id_field) = [durations_yfp.(laser_field).(id_field), period_duration];
        end
        end
    end

    % Calculate weighted mean PSD for each subject and each laser level
    mean_PXX_chr2 = struct();
    SEM_PXX_chr2 = struct();
    mean_PXX_yfp = struct();
    SEM_PXX_yfp = struct();
    
    for laser_level = 0:5
        laser_field = ['Level', num2str(laser_level)];
        
        % chr2 group
        if isfield(psd_chr2, laser_field)
            ids = fieldnames(psd_chr2.(laser_field));
            for k = 1:length(ids)
                id = ids{k};
                PXX = psd_chr2.(laser_field).(id);
                period_durations = durations_chr2.(laser_field).(id);
                if ~isempty(PXX)
                    [weighted_mean_PXX, ~] = calculate_weighted_mean_SEM(PXX, period_durations);
                    psd_chr2.(laser_field).([id, '_mean']) = weighted_mean_PXX;
                end
            end
        end

        % yfp group
        if isfield(psd_yfp, laser_field)
            ids = fieldnames(psd_yfp.(laser_field));
            for k = 1:length(ids)
                id = ids{k};
                PXX = psd_yfp.(laser_field).(id);
                period_durations = durations_yfp.(laser_field).(id);
                if ~isempty(PXX)
                    [weighted_mean_PXX, ~] = calculate_weighted_mean_SEM(PXX, period_durations);
                    psd_yfp.(laser_field).([id, '_mean']) = weighted_mean_PXX;
                end
            end
        end
    end

    % Calculate the mean and SEM across all subjects for each laser level
    for laser_level = 0:5
        laser_field = ['Level', num2str(laser_level)];
        
        % chr2 group
        if isfield(psd_chr2, laser_field)
            means = [];
            ids = fieldnames(psd_chr2.(laser_field));
            ids = ids(contains(ids, '_mean')); % Only mean fields
            for k = 1:length(ids)
                means = [means, psd_chr2.(laser_field).(ids{k})];
            end
            if ~isempty(means)
                mean_PXX_chr2.(laser_field) = mean(means, 2);
                SEM_PXX_chr2.(laser_field) = std(means, 0, 2) / sqrt(size(means, 2));
            end
        end

        % yfp group
        if isfield(psd_yfp, laser_field)
            means = [];
            ids = fieldnames(psd_yfp.(laser_field));
            ids = ids(contains(ids, '_mean')); % Only mean fields
            for k = 1:length(ids)
                means = [means, psd_yfp.(laser_field).(ids{k})];
            end
            if ~isempty(means)
                mean_PXX_yfp.(laser_field) = mean(means, 2);
                SEM_PXX_yfp.(laser_field) = std(means, 0, 2) / sqrt(size(means, 2));
            end
        end
    end

    % Plot the results
    figure;
    colors = lines(6); % Get 6 colors from the default colormap

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
    for laser_level = 0:5
        laser_field = ['Level', num2str(laser_level)];
        if isfield(mean_PXX_yfp, laser_field)
            h_yfp = shadedErrorBar(f, mean_PXX_yfp.(laser_field), SEM_PXX_yfp.(laser_field), {'Color', colors(laser_level + 1, :)});
            mean_psd_yfp{1, 1+laser_level} = mean_PXX_yfp.(laser_field);
            sem_psd_yfp{1, 1+laser_level} = SEM_PXX_yfp.(laser_field);
            set(h_yfp.mainLine, 'DisplayName', ['Laser Level ', num2str(laser_level)]);
            % Hide the SEM line from the legend
            set(get(get(h_yfp.patch, 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
            set(get(get(h_yfp.edge(1), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
            set(get(get(h_yfp.edge(2), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
        end
    end

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
        [0 0 1 1], 'r', 'FaceAlpha', 0.1, 'EdgeColor', 'none', 'HandleVisibility', 'off');

    % Shade Low Frequency (LF) band
    fill([lf_range(1) lf_range(2) lf_range(2) lf_range(1)], ...
        [0 0 1 1], 'g', 'FaceAlpha', 0.1, 'EdgeColor', 'none', 'HandleVisibility', 'off');

    % Shade High Frequency (HF) band
    fill([hf_range(1) hf_range(2) hf_range(2) hf_range(1)], ...
        [0 0 1 1], 'y', 'FaceAlpha', 0.1, 'EdgeColor', 'none', 'HandleVisibility', 'off');

    % Plot mean PSD and SEM for Chr2
    for laser_level = 0:5
        laser_field = ['Level', num2str(laser_level)];
        if isfield(mean_PXX_chr2, laser_field)
            h_chr2 = shadedErrorBar(f, mean_PXX_chr2.(laser_field), SEM_PXX_chr2.(laser_field), {'Color', colors(laser_level + 1, :)});
            mean_psd_chr2{1, 1+laser_level} = mean_PXX_chr2.(laser_field);
            sem_psd_chr2{1, 1+laser_level} = SEM_PXX_chr2.(laser_field);
            set(h_chr2.mainLine, 'DisplayName', ['Laser Level ', num2str(laser_level)]);
            % Hide the SEM line from the legend
            set(get(get(h_chr2.patch, 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
            set(get(get(h_chr2.edge(1), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
            set(get(get(h_chr2.edge(2), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
        end
    end

    xlim([0, max(f)]);
    title('Chr2 - RR Intervals');
    xlabel('Frequency (Hz)');
    ylabel('Power Spectral Density (PSD)');
    legend('show', 'Location', 'northeast');
    hold off;

    linkaxes([subplot(1, 2, 1), subplot(1, 2, 2)], 'x');

    % Set figure background color to white
    set(gcf, 'Color', 'w');

    % Convert the results cell arrays to tables
    AUC_table = cell2table(AUC_results, 'VariableNames', {'AUC', 'Suffix', 'LaserLevel', 'group', 'BoutLength'});
    PeakFrequency_table = cell2table(PeakFrequency_results, 'VariableNames', {'PeakFrequency', 'Suffix', 'LaserLevel', 'group', 'BoutLength'});
    PeakPower_table = cell2table(PeakPower_results, 'VariableNames', {'PeakPower', 'Suffix', 'LaserLevel', 'group', 'BoutLength'});
    mean_psd_chr2_table = cell2table(mean_psd_chr2, 'VariableNames', {'Laser_0', 'Laser_1', 'Laser_2', 'Laser_3', 'Laser_4', 'Laser_5'});
    mean_psd_yfp_table = cell2table(mean_psd_yfp, 'VariableNames', {'Laser_0', 'Laser_1', 'Laser_2', 'Laser_3', 'Laser_4', 'Laser_5'});
    sem_psd_chr2_table = cell2table(sem_psd_chr2, 'VariableNames', {'Laser_0', 'Laser_1', 'Laser_2', 'Laser_3', 'Laser_4', 'Laser_5'});
    sem_psd_yfp_table = cell2table(sem_psd_yfp, 'VariableNames', {'Laser_0', 'Laser_1', 'Laser_2', 'Laser_3', 'Laser_4', 'Laser_5'});

    % Clear temporary variables
    clear fs sampling_hz PXX_chr2 PXX_yfp mean_PXX_chr2 SEM_PXX_chr2 mean_PXX_yfp SEM_PXX_yfp colors;

end