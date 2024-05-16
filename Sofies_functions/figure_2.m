function figure_2(event_var, epoc_start, epoc_end, titles, main_title, delta465_filt_2, sec_signal_2,NE_fs, RR, RR_time, RR_fs,  mean_spectrogram, F, EEG_bands_fs, cross_cor_sec)

warning('off','all')
warning

    mid_point = ceil(epoc_start * RR_fs);  % This should be the index of the event time
    max_epoch_length = ceil((epoc_start + epoc_end) * RR_fs);
    total_epoch_length = ceil((epoc_start + epoc_end) * RR_fs);
    power_bands = {[0.5, 1], [1, 4], [4, 8], [8, 15], [15, 30], [60, 80], [80, 100]}; % define SO, delta, theta, sigma, and beta, respectively
    
    %Add in the time variable for plotting
    epoc_FPtime_NE = linspace(-epoc_start, epoc_end, ceil((epoc_start + epoc_end) * NE_fs));
    epoc_FPtime_EEG_bands = linspace(-epoc_start, epoc_end, ceil((epoc_start + epoc_end) * EEG_bands_fs));
    epoc_FPtime_RR = linspace(-epoc_start, epoc_end, max_epoch_length);
    
    global_max_RR = -inf;
    global_min_RR = inf;
    global_max_delta_465_2 = -inf;
    global_min_delta_465_2 = inf;
    global_max_EEG_bands = -inf;
    global_min_EEG_bands = inf;
    global_max_corr = -inf; 
    global_min_corr = inf;

    fs_original = NE_fs;  % original sampling frequency
    fs_new = RR_fs;  
    % Calculate the greatest common divisor to find the optimal downsample factor
    gcd_fs = gcd(round(fs_original), fs_new);
    
    % Compute downsample and upsample factors
    P = fs_new / gcd_fs;
    Q = round(fs_original) / gcd_fs;


        % Initialize variables to store maximum and minimum values for each type of subplot

    % First pass: Loop to find global min/max
    for stage_idx = 1:length(event_var)
        event_type = event_var{stage_idx}; % Select the current event type
        event_name = titles{stage_idx}; % Current event name for titles
        num_events = length(event_type); % Number of events for the current sleep stage
        
        % Resetting collectors for each sleep stage
        NE_peak_epoc_collector = [];
        RR_collector = [];
        SO_collector = [];
        Delta_collector = [];
        Theta_collector = [];
        Sigma_collector = [];
        Beta_collector = [];
        Gamma_low_collector = [];
        Gamma_high_collector = [];

    
            % Extract power for specified bands
        band_powers = cell(1, length(power_bands));
        for b = 1:length(power_bands)
            freq_range = power_bands{b};
            band_powers{b} = mean(mean_spectrogram(F >= freq_range(1) & F <= freq_range(2), :), 1);
        end
    
        % Extract NE and EEG band epochs for the current sleep stage
        for i = 1:length(event_type)
            NEpk_i = event_type(i);
            % Skip events too close to the start of the recording
            if NEpk_i < epoc_start
                disp(['Event ', num2str(i), ' skipped due to being too close to the start of the recording']);
                continue;  % Skip to the next iteration of the loop
            end
            if NEpk_i > sec_signal_2(end) - epoc_end % Skip if event is too close to end of recording
                continue;
            end
            
            % Extract NE epochs
            NEpk_epoc_i = delta465_filt_2((NEpk_i - epoc_start) * NE_fs : (NEpk_i + epoc_end) * NE_fs);
            NE_peak_epoc_collector = [NE_peak_epoc_collector; NEpk_epoc_i];
    
            HRB_i = event_type(i);
            if HRB_i < RR_time(1) + epoc_start || HRB_i > RR_time(end) - epoc_end
                disp(['Event ', num2str(i), ' skipped due to proximity to start/end of recording']);
                continue;  % Skip this event
            end
    
            % [~, event_idx] = min(abs(RR_time - HRB_i));  % Find the event index in filtered_RR_time
            % 
            % epoch_start_idx = max(event_idx - mid_point + 1, 1);
            % epoch_end_idx = min(event_idx + (total_epoch_length - mid_point), length(RR));
            % 
            % if epoch_end_idx - epoch_start_idx + 1 <= total_epoch_length
            %     RR_collector(1:(epoch_end_idx - epoch_start_idx + 1), i) = RR(epoch_start_idx:epoch_end_idx);
            % end
            RR_epoc= RR(:, (HRB_i - epoc_start)*RR_fs:(HRB_i + epoc_end)*RR_fs);
            RR_collector = [RR_collector; RR_epoc];
            
            % Extract epochs for EEG bands
            for b = 1:length(band_powers)
                EEG_band_epoc_i = band_powers{b}(:, (NEpk_i - epoc_start)*EEG_bands_fs:(NEpk_i + epoc_end)*EEG_bands_fs);
            switch b
                case 1
                    SO_collector = [SO_collector; EEG_band_epoc_i];
                case 2
                    Delta_collector = [Delta_collector; EEG_band_epoc_i];
                case 3
                    Theta_collector = [Theta_collector; EEG_band_epoc_i];
                case 4
                    Sigma_collector = [Sigma_collector; EEG_band_epoc_i];
                case 5
                    Beta_collector = [Beta_collector; EEG_band_epoc_i];
                case 6
                    Gamma_low_collector = [Gamma_low_collector; EEG_band_epoc_i];               
                case 7
                    Gamma_high_collector = [Gamma_high_collector; EEG_band_epoc_i];
                end
            end
        end
        
    
        % Calculate mean of epochs for NE and EEG bands
        mean_NEpk_epocs = nanmean(NE_peak_epoc_collector, 1);
        mean_filtered_RR_epocs = nanmean(RR_collector, 1);
        mean_SO_pk_epocs = nanmean(SO_collector, 1);
        mean_Delta_pk_epocs = nanmean(Delta_collector, 1);
        mean_Theta_pk_epocs = nanmean(Theta_collector, 1);
        mean_Sigma_pk_epocs = nanmean(Sigma_collector, 1);
        mean_Beta_pk_epocs = nanmean(Beta_collector, 1);
        mean_Gamma_low_pk_epocs = nanmean(Gamma_low_collector, 1);
        mean_Gamma_high_pk_epocs = nanmean(Gamma_high_collector, 1);

        cc1_all = cell(num_events, 1);

        for i = 1:size(NE_peak_epoc_collector, 1)
            NE = NE_peak_epoc_collector(i,:);
            RR_cross = RR_collector(i,:);
            NE_cross_corr = resample(NE, P, Q);

            NE_length = length(NE_cross_corr); % number of obs in NE data
            RR_length = length(RR_cross); % number of obs in RR data

            if NE_length ~= RR_length
                % Calculate the difference and determine which one is longer
                diff = abs(NE_length - RR_length);
                if NE_length > RR_length
                    % NE is longer, trim it
                    NE_cross_corr = NE_cross_corr(1:end-diff);
                    warning_msg = sprintf('Warning: NE and RR not the same length. Cutting %d datapoints from NE %s - NE now %d long', diff, event_name, length(NE_cross_corr));
                else
                    % RR is longer, trim it
                    RR_cross = RR_cross(1:end-diff);
                    warning_msg = sprintf('Warning: NE and RR not the same length. Cutting %d datapoints from RR %s - RR now %d long', diff, event_name, length(RR));
                end
                % Display the warning message
            end
            [cc1,lags] = xcorr(unity(detrend(RR_cross)), unity(detrend(NE_cross_corr)), (cross_cor_sec*64),'unbiased');
            cc1_all{i, 1} = cc1.';  % Store as a row vector if cc1 is initially a column vector
        end
        disp(warning_msg);

        % Assuming cc1_all is already filled with cc1 vectors as described
        cc1_matrix = cell2mat(cc1_all.');  % Transpose to make each cc1 vector a column
        mean_cc1 = mean(cc1_matrix, 2);    % Compute the mean across columns

        % Optional: If you want to work with the mean_cc1 as a column vector
        mean_cc1 = mean_cc1(:);

        N = size(NE_peak_epoc_collector, 1); % Number of observations is the number of columns
        % Calculating standard deviation and SEM for NEpk_epocs
        std_dev_NE = std(NE_peak_epoc_collector, 0, 1); % Standard deviation across columns (time points)
        SEM_NE = std_dev_NE / sqrt(N); % Standard error of the mean
        
        % Calculating standard deviation and SEM for filtered_RR_epocs
        std_dev_RR = std(RR_collector, 0, 1); % Standard deviation across columns (time points)
        SEM_RR = std_dev_RR / sqrt(N); % Standard error of the mean
        
        % Calculating standard deviation and SEM for cc1
        std_dev_corr = std(cc1_matrix, 0, 2); % Standard deviation across columns (time points)
        SEM_corr = std_dev_corr / sqrt(N); % Standard error of the mean

        global_max_RR = max(global_max_RR, max(mean_filtered_RR_epocs+SEM_RR));
        global_min_RR = min(global_min_RR, min(mean_filtered_RR_epocs-SEM_RR));

        global_max_delta_465_2 = max(global_max_delta_465_2, max(mean_NEpk_epocs+SEM_NE));
        global_min_delta_465_2 = min(global_min_delta_465_2, min(mean_NEpk_epocs-SEM_NE));

        global_max_EEG_bands = max(global_max_EEG_bands, max([mean_SO_pk_epocs, mean_Delta_pk_epocs, mean_Theta_pk_epocs, mean_Sigma_pk_epocs, mean_Beta_pk_epocs, mean_Gamma_low_pk_epocs, mean_Gamma_high_pk_epocs]));
        global_min_EEG_bands = min(global_min_EEG_bands, min([mean_SO_pk_epocs, mean_Delta_pk_epocs, mean_Theta_pk_epocs, mean_Sigma_pk_epocs, mean_Beta_pk_epocs, mean_Gamma_low_pk_epocs, mean_Gamma_high_pk_epocs]));
        
        global_max_corr = max(global_max_corr, max(mean_cc1+SEM_corr));
        global_min_corr = min(global_min_corr, min(mean_cc1-SEM_corr));

    end
        % global_max_corr = global_max_corr + 0.05; %add a little bit here to have some air in the plot
        % global_min_corr = global_min_corr - 0.1; %add a little bit here to have some air in the plot

    % Initialize the figure
    figure;
    
    % Iterate over each sleep stage and its NE trough variables
    for stage_idx = 1:length(event_var)
        event_type = event_var{stage_idx}; % Select the current event type
        event_name = titles{stage_idx}; % Current event name for titles
        num_events = length(event_type); % Number of events for the current sleep stage
        
        % Resetting collectors for each sleep stage
        NE_peak_epoc_collector = [];
        RR_collector = [];
        SO_collector = [];
        Delta_collector = [];
        Theta_collector = [];
        Sigma_collector = [];
        Beta_collector = [];
        Gamma_low_collector = [];
        Gamma_high_collector = [];

    
            % Extract power for specified bands
        band_powers = cell(1, length(power_bands));
        for b = 1:length(power_bands)
            freq_range = power_bands{b};
            band_powers{b} = mean(mean_spectrogram(F >= freq_range(1) & F <= freq_range(2), :), 1);
        end
    
        % Extract NE and EEG band epochs for the current sleep stage
        for i = 1:length(event_type)
            NEpk_i = event_type(i);
            % Skip events too close to the start of the recording
            if NEpk_i < epoc_start
                disp(['Event ', num2str(i), ' skipped due to being too close to the start of the recording']);
                continue;  % Skip to the next iteration of the loop
            end
            if NEpk_i > sec_signal_2(end) - epoc_end % Skip if event is too close to end of recording
                continue;
            end
            
            % Extract NE epochs
            NEpk_epoc_i = delta465_filt_2((NEpk_i - epoc_start) * NE_fs : (NEpk_i + epoc_end) * NE_fs);
            NE_peak_epoc_collector = [NE_peak_epoc_collector; NEpk_epoc_i];
    
            HRB_i = event_type(i);
            if HRB_i < RR_time(1) + epoc_start || HRB_i > RR_time(end) - epoc_end
                disp(['Event ', num2str(i), ' skipped due to proximity to start/end of recording']);
                continue;  % Skip this event
            end
    
            % [~, event_idx] = min(abs(RR_time - HRB_i));  % Find the event index in filtered_RR_time
            % 
            % epoch_start_idx = max(event_idx - mid_point + 1, 1);
            % epoch_end_idx = min(event_idx + (total_epoch_length - mid_point), length(RR));
            % 
            % RR_collector(1:(epoch_end_idx - epoch_start_idx + 1), i) = RR(epoch_start_idx:epoch_end_idx);
            RR_epoc= RR(:, (NEpk_i - epoc_start)*RR_fs:(NEpk_i + epoc_end)*RR_fs);
            RR_collector = [RR_collector; RR_epoc];

            % Extract epochs for EEG bands
            for b = 1:length(band_powers)
                EEG_band_epoc_i = band_powers{b}(:, (NEpk_i - epoc_start)*EEG_bands_fs:(NEpk_i + epoc_end)*EEG_bands_fs);
            switch b
                case 1
                    SO_collector = [SO_collector; EEG_band_epoc_i];
                case 2
                    Delta_collector = [Delta_collector; EEG_band_epoc_i];
                case 3
                    Theta_collector = [Theta_collector; EEG_band_epoc_i];
                case 4
                    Sigma_collector = [Sigma_collector; EEG_band_epoc_i];
                case 5
                    Beta_collector = [Beta_collector; EEG_band_epoc_i];
                case 6
                    Gamma_low_collector = [Gamma_low_collector; EEG_band_epoc_i];               
                case 7
                    Gamma_high_collector = [Gamma_high_collector; EEG_band_epoc_i];
                end
            end
        end
        
    
        % Calculate mean of epochs for NE and EEG bands
        mean_NEpk_epocs = nanmean(NE_peak_epoc_collector, 1);
        mean_filtered_RR_epocs = nanmean(RR_collector, 1);
        mean_SO_pk_epocs = nanmean(SO_collector, 1);
        mean_Delta_pk_epocs = nanmean(Delta_collector, 1);
        mean_Theta_pk_epocs = nanmean(Theta_collector, 1);
        mean_Sigma_pk_epocs = nanmean(Sigma_collector, 1);
        mean_Beta_pk_epocs = nanmean(Beta_collector, 1);
        mean_Gamma_low_pk_epocs = nanmean(Gamma_low_collector, 1);
        mean_Gamma_high_pk_epocs = nanmean(Gamma_high_collector, 1);

        cc1_all = cell(num_events, 1);
        lags_all = cell(num_events, 1);

        for i = 1:size(NE_peak_epoc_collector, 1)
            NE = NE_peak_epoc_collector(i,:);
            RR_cross = RR_collector(i,:);
            NE_cross_corr = resample(NE, P, Q);

            NE_length = length(NE_cross_corr); % number of obs in NE data
            RR_length = length(RR_cross); % number of obs in RR data
    
            if NE_length ~= RR_length
                % Calculate the difference and determine which one is longer
                diff = abs(NE_length - RR_length);
                if NE_length > RR_length
                    % NE is longer, trim it
                    NE_cross_corr = NE_cross_corr(1:end-diff);
                    warning_msg = sprintf('Warning: NE and RR not the same length. Cutting %d datapoints from NE %s - NE now %d long', diff, event_name, length(NE_cross_corr));
                else
                    % RR is longer, trim it
                    RR_cross = RR_cross(1:end-diff);
                    warning_msg = sprintf('Warning: NE and RR not the same length. Cutting %d datapoints from RR %s - RR now %d long', diff, event_name, length(RR));
                end
                % Display the warning message
            end
            [cc1,lags] = xcorr(unity(detrend(RR_cross)), unity(detrend(NE_cross_corr)),(cross_cor_sec*64),'unbiased');
            cc1_all{i, 1} = cc1.';  % Store as a row vector if cc1 is initially a column vector
            lags_all{i, 1} = lags.';  % Store as a row vector if cc1 is initially a column vector
        end
        disp(warning_msg);


        % Assuming cc1_all is already filled with cc1 vectors as described
        cc1_matrix = cell2mat(cc1_all.');  % Transpose to make each cc1 vector a column
        mean_cc1 = mean(cc1_matrix, 2);    % Compute the mean across columns
        % Optional: If you want to work with the mean_cc1 as a column vector
        mean_cc1 = mean_cc1(:);

        lags_matrix = cell2mat(lags_all.');  % Transpose to make each cc1 vector a column
        mean_lags = mean(lags_matrix, 2);    % Compute the mean across columns
        % Optional: If you want to work with the mean_cc1 as a column vector
        mean_lags = mean_lags(:)/64;

        N = size(NE_peak_epoc_collector, 1); % Number of observations is the number of columns
        % Calculating standard deviation and SEM for NEpk_epocs
        std_dev_NE = std(NE_peak_epoc_collector, 0, 1); % Standard deviation across columns (time points)
        SEM_NE = std_dev_NE / sqrt(N); % Standard error of the mean
        
        % Calculating standard deviation and SEM for filtered_RR_epocs
        std_dev_RR = std(RR_collector, 0, 1); % Standard deviation across columns (time points)
        SEM_RR = std_dev_RR / sqrt(N); % Standard error of the mean
        
        % Calculating standard deviation and SEM for cc1
        std_dev_corr = std(cc1_matrix, 0, 2); % Standard deviation across columns (time points)
        SEM_corr = std_dev_corr / sqrt(N); % Standard error of the mean

        % After calculating max and min for each type, set consistent y-axis limits and y-ticks
        y_tick_interval_RR = (global_max_RR - global_min_RR) / 5; % Example for dividing into 5 parts
        ytick_values_RR = global_min_RR:y_tick_interval_RR:global_max_RR;
        
        y_tick_interval_delta_465_2 = (global_max_delta_465_2 - global_min_delta_465_2) / 5;
        ytick_values_delta_465_2 = global_min_delta_465_2:y_tick_interval_delta_465_2:global_max_delta_465_2;
        
        y_tick_interval_EEG_bands = (global_max_EEG_bands - global_min_EEG_bands) / 5;
        ytick_values_EEG_bands = global_min_EEG_bands:y_tick_interval_EEG_bands:global_max_EEG_bands;

        lineProps = {'Color', [0 0.4470 0.7410]};  % Sets line color and width

        % Plotting NE data
        subplot_position_ne = (stage_idx-1)*4 + 1;
        subplot(5, 4, subplot_position_ne);
        
        % Plot the red line first to ensure it appears behind the data
        hold on;  % Keeps the plot active for subsequent data plotting
        plot([0 0], [global_min_delta_465_2, global_max_delta_465_2], 'Color', [0.5 0.5 0.5], 'LineWidth', 1, 'LineStyle', '--', 'HandleVisibility', 'off'); % Dashed maroon line behind

        shadedErrorBar(epoc_FPtime_NE, mean_NEpk_epocs, SEM_NE, lineProps, 1);
        % Plot the NE data with a specific color (e.g., light blue)
        plot(epoc_FPtime_NE, mean_NEpk_epocs, 'Color', [0 0.4470 0.7410]);  % Light blue
        hold off;  % No more plots will be added
        
        title([event_name ' NE (' num2str(num_events) ' Events)']); % Including number of events in the title
        ylabel('Delta F/F');
        xlim([-epoc_start, epoc_end]);
        ylim([global_min_delta_465_2, global_max_delta_465_2]);
        yticks(ytick_values_delta_465_2);
        grid on

        lineProps = {'Color',[0.8500 0.3250 0.0980]};  % Sets line color and width


        subplot_idx_RR = subplot_position_ne + 1;  % Position for RR subplot
        subplot(5, 4, subplot_idx_RR);
        
        % Plot the red line first to ensure it appears behind the data
        hold on;  % Keeps the plot active for subsequent data plotting
        plot([0 0], [global_min_RR, global_max_RR], 'Color', [0.5 0.5 0.5], 'LineWidth', 1, 'LineStyle', '--');  % Dashed maroon line
         
        epoc_FPtime_RR = linspace(-epoc_start, epoc_end, length(mean_filtered_RR_epocs));
        shadedErrorBar(epoc_FPtime_RR, mean_filtered_RR_epocs, SEM_RR, lineProps, 1);
        % Now plot the RR interval data, ensuring it's on top of the red line
        plot(epoc_FPtime_RR, mean_filtered_RR_epocs, 'Color', [0.8500 0.3250 0.0980]);

        hold off;  % No more plots will be added
        
        title([event_name ' RR interval (' num2str(length(event_type)) ' Events)']);  % Correcting the number of events
        ylabel('RR interval (s)');
        xlim([-epoc_start, epoc_end]);
        ylim([global_min_RR, global_max_RR]);
        yticks(ytick_values_RR);  % Apply custom y-tick values based on the global min/max for RR intervals
        grid on

        lineProps = {'Color',[0.4660 0.6740 0.1880]};  % Sets line color and width
    
        subplot_idx_xcorr = subplot_position_ne + 2;  % Position for RR subplot
    
        % Create subplot
        subplot(5, 4, subplot_idx_xcorr);
        hold on;
        plot([0 0], [global_min_corr, global_max_corr], 'Color', [0.5 0.5 0.5], 'LineWidth', 1, 'LineStyle', '--', 'HandleVisibility', 'off'); % Dashed gray line behind
        
        % Call shadedErrorBar
        shadedErrorBar(mean_lags, mean_cc1, SEM_corr, lineProps, 1);
    
        % Plot mean with a green line
        plot(mean_lags, mean_cc1, 'color', [0.4660 0.6740 0.1880], 'LineWidth', 1);
        hold off;

        % Formatting the subplot
        ylabel('Correlation (R)');
        xlim([-epoc_start,epoc_end]);
        ylim([global_min_corr, global_max_corr]);
        title([event_name ' NE-RR Cross Correlation']);
        grid on;

        % Plotting EEG bands data
        subplot_position_eeg = subplot_position_ne + 3;
        subplot(5, 4, subplot_position_eeg);
        
        % Plot the red line first to ensure it appears behind the data
        hold on;  % Keeps the plot active for subsequent data plotting
        plot([0 0], [global_min_EEG_bands, global_max_EEG_bands], 'Color', [0.5 0.5 0.5], 'LineWidth', 1, 'LineStyle', '--', 'HandleVisibility', 'off'); % Dashed maroon line
        
        % Now plot the EEG band data with handles for the legend
        hSO = plot(epoc_FPtime_EEG_bands, mean_SO_pk_epocs, 'DisplayName', 'SO');
        hDelta = plot(epoc_FPtime_EEG_bands, mean_Delta_pk_epocs, 'DisplayName', 'Delta');
        hTheta = plot(epoc_FPtime_EEG_bands, mean_Theta_pk_epocs, 'DisplayName', 'Theta');
        hSigma = plot(epoc_FPtime_EEG_bands, mean_Sigma_pk_epocs, 'DisplayName', 'Sigma');
        hBeta = plot(epoc_FPtime_EEG_bands, mean_Beta_pk_epocs, 'DisplayName', 'Beta');
        hGamma_low = plot(epoc_FPtime_EEG_bands, mean_Gamma_low_pk_epocs, 'DisplayName', 'Gamma (Low)');
        hGamma_high = plot(epoc_FPtime_EEG_bands, mean_Gamma_high_pk_epocs, 'DisplayName', 'Gamma (High)');

        hold off;  % No more plots will be added
        
        % Use the handles to specify which plots to include in the legend
        legend([hSO, hDelta, hTheta, hSigma, hBeta, hGamma_low, hGamma_high], {'SO', 'Delta', 'Theta', 'Sigma', 'Beta', 'Gamma (low)', 'Gamma (high)'}, 'Location', 'EastOutside');
        
        title([event_name ' EEG Bands (' num2str(length(event_type)) ' Events)']);
        ylabel('Power');
        xlim([-epoc_start, epoc_end]);
        ylim([global_min_EEG_bands, global_max_EEG_bands]);
        yticks(ytick_values_EEG_bands);
        grid on

        set(gcf,'color','white')
    end
    
    % Adjust overall plot settings
    sgtitle(main_title);
