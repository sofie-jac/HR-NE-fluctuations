function figure_3_chr2(uniqueIDs, event_var, epoc_start, epoc_end, EEG_bands_fs, band_powers)
% Directories
dataDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\Traces';
rrDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\RR';

% Loop over each subject
for idx = 1:length(uniqueIDs)
    uniqueId = uniqueIDs{idx};  % Get the current subject ID
    
    % Create figure for plotting
    figure;
    
    % Initialize collectors for each event type
    all_NE_collector = [];
    all_RR_collector = [];
    all_SO_collector = [];
    all_Delta_collector = [];
    all_Theta_collector = [];
    all_Sigma_collector = [];
    all_Beta_collector = [];
    all_Gamma_low_collector = [];
    all_Gamma_high_collector = [];
    
    % Loop over each event type
    for stage_idx = 1:length(event_var)
        event_type = event_var{stage_idx};  % Get the current event type name

        % Skip if the event variable is empty
        if isempty(event_type)
            disp(['Skipping ', event_type, ' due to no events.']);
            continue;
        end

        % Load NE-related variables
        load(fullfile(dataDirectory, sprintf('sec_signal_2_%s.mat', uniqueId)));
        eval(['sec_signal_2 = sec_signal_2_', uniqueId, ';']);
        eval(['clear sec_signal_2_', uniqueId]);
        
        load(fullfile(dataDirectory, sprintf('delta465_filt_2_%s.mat', uniqueId)));
        eval(['delta465_filt_2 = delta465_filt_2_', uniqueId, ';']);
        eval(['clear delta465_filt_2_', uniqueId]);
        
        load(fullfile(dataDirectory, sprintf('signal_fs_%s.mat', uniqueId)));
        eval(['signal_fs = signal_fs_', uniqueId, ';']);
        eval(['clear signal_fs_', uniqueId]);
        
        % Load RR-related variables
        load(fullfile(rrDirectory, sprintf('RR_%s.mat', uniqueId)));
        eval(['RR = RR_', uniqueId, ';']);
        eval(['clear RR_', uniqueId]);
        
        load(fullfile(rrDirectory, sprintf('RR_time_%s.mat', uniqueId)));
        eval(['RR_time = RR_time_', uniqueId, ';']);
        eval(['clear RR_time_', uniqueId]);

        
        % Calculate epoch time variables
        epoc_FPtime_NE = linspace(-epoc_start, epoc_end, size(delta465_filt_2, 2));
        epoc_FPtime_EEG_bands = linspace(-epoc_start, epoc_end, size(band_powers{1}, 2));
        epoc_FPtime_RR = linspace(-epoc_start, epoc_end, size(RR, 2));
        
        % Initialize collectors
        NE_collector = [];
        RR_collector = [];
        SO_collector = [];
        Delta_collector = [];
        Theta_collector = [];
        Sigma_collector = [];
        Beta_collector = [];
        Gamma_low_collector = [];
        Gamma_high_collector = [];
        
        % Extract epochs for NE, RR, and EEG bands
        for i = 1:length(event_type)
            NEpk_i = event_type(i);
            
            % Check bounds for NE epochs
            if NEpk_i < epoc_start || NEpk_i > sec_signal_2(end) - epoc_end
                continue;
            end
            
            % Extract NE epochs
            NEpk_epoc_i = delta465_filt_2((NEpk_i - epoc_start) * signal_fs : (NEpk_i + epoc_end) * signal_fs);
            NE_collector = [NE_collector; NEpk_epoc_i];
            
            % Check bounds for RR epochs
            if NEpk_i < RR_time(1) + epoc_start || NEpk_i > RR_time(end) - epoc_end
                continue;
            end
            
            % Extract RR epochs
            RR_epoc = RR(:, (find(RR_time > NEpk_i, 1) - 64 * epoc_start : find(RR_time > NEpk_i, 1) + 64 * epoc_end));
            RR_collector = [RR_collector; RR_epoc];
            
            % Extract epochs for EEG bands
            for b = 1:length(band_powers)
                EEG_band_epoc_i = band_powers{b}(:, (NEpk_i - epoc_start) * EEG_bands_fs : (NEpk_i + epoc_end) * EEG_bands_fs);
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
        
        % Append to all event type collectors
        all_NE_collector = [all_NE_collector; NE_collector];
        all_RR_collector = [all_RR_collector; RR_collector];
        all_SO_collector = [all_SO_collector; SO_collector];
        all_Delta_collector = [all_Delta_collector; Delta_collector];
        all_Theta_collector = [all_Theta_collector; Theta_collector];
        all_Sigma_collector = [all_Sigma_collector; Sigma_collector];
        all_Beta_collector = [all_Beta_collector; Beta_collector];
        all_Gamma_low_collector = [all_Gamma_low_collector; Gamma_low_collector];
        all_Gamma_high_collector = [all_Gamma_high_collector; Gamma_high_collector];
    end
    
    % Calculate mean and SEM for NE, RR, and EEG bands
    mean_NEpk_epocs = nanmean(all_NE_collector, 1);
    mean_RR_epocs = nanmean(all_RR_collector, 1);
    mean_SO_epocs = nanmean(all_SO_collector, 1);
    mean_Delta_epocs = nanmean(all_Delta_collector, 1);
    mean_Theta_epocs = nanmean(all_Theta_collector, 1);
    mean_Sigma_epocs = nanmean(all_Sigma_collector, 1);
    mean_Beta_epocs = nanmean(all_Beta_collector, 1);
    mean_Gamma_low_epocs = nanmean(all_Gamma_low_collector, 1);
    mean_Gamma_high_epocs = nanmean(all_Gamma_high_collector, 1);
    
    SEM_NE = nanstd(all_NE_collector, 0, 1) / sqrt(size(all_NE_collector, 1));
    SEM_RR = nanstd(all_RR_collector, 0, 1) / sqrt(size(all_RR_collector, 1));
    SEM_SO = nanstd(all_SO_collector, 0, 1) / sqrt(size(all_SO_collector, 1));
    SEM_Delta = nanstd(all_Delta_collector, 0, 1) / sqrt(size(all_Delta_collector, 1));
    SEM_Theta = nanstd(all_Theta_collector, 0, 1) / sqrt(size(all_Theta_collector, 1));
    SEM_Sigma = nanstd(all_Sigma_collector, 0, 1) / sqrt(size(all_Sigma_collector, 1));
    SEM_Beta = nanstd(all_Beta_collector, 0, 1) / sqrt(size(all_Beta_collector, 1));
    SEM_Gamma_low = nanstd(all_Gamma_low_collector, 0, 1) / sqrt(size(all_Gamma_low_collector, 1));
    SEM_Gamma_high = nanstd(all_Gamma_high_collector, 0, 1) / sqrt(size(all_Gamma_high_collector, 1));
        epoc_FPtime_NE = linspace(-epoc_start, epoc_end, length(mean_NEpk_epocs));

    % Plot NE
    subplot(3, 1, 1);
    shadedErrorBar(epoc_FPtime_NE, mean_NEpk_epocs, SEM_NE);
    title(['NE']);
    xlabel('Time (s)');
    ylabel('Delta F/F');
    grid on;
    
    % Adjust length of time vector to match mean_RR_epocs
    epoc_FPtime_RR = linspace(-epoc_start, epoc_end, length(mean_RR_epocs));

    % Plot RR
    subplot(3, 1, 2);
    shadedErrorBar(epoc_FPtime_RR, mean_RR_epocs, SEM_RR);
    title(['RR']);
    xlabel('Time (s)');
    ylabel('RR Interval (s)');
    grid on;
        epoc_FPtime_EEG_bands = linspace(-epoc_start, epoc_end, length(mean_SO_epocs));

    % Plot EEG bands
    subplot(3, 1, 3);
    hold on;
    shadedErrorBar(epoc_FPtime_EEG_bands, mean_SO_epocs, SEM_SO);
    shadedErrorBar(epoc_FPtime_EEG_bands, mean_Delta_epocs, SEM_Delta);
    shadedErrorBar(epoc_FPtime_EEG_bands, mean_Theta_epocs, SEM_Theta);
    shadedErrorBar(epoc_FPtime_EEG_bands, mean_Sigma_epocs, SEM_Sigma);
    shadedErrorBar(epoc_FPtime_EEG_bands, mean_Beta_epocs, SEM_Beta);
    shadedErrorBar(epoc_FPtime_EEG_bands, mean_Gamma_low_epocs, SEM_Gamma_low);
    shadedErrorBar(epoc_FPtime_EEG_bands, mean_Gamma_high_epocs, SEM_Gamma_high);
    hold off;
    
    legend({'SO', 'Delta', 'Theta', 'Sigma', 'Beta', 'Gamma (Low)', 'Gamma (High)'});
    title(['EEG Bands (' uniqueId ')']);
    xlabel('Time (s)');
    ylabel('Power');
    grid on;
    
    sgtitle([uniqueId ' - All Event Types']);
    
    % Save the figure
    saveas(gcf, fullfile(dataDirectory, ['Figure_' uniqueId '_All_Event_Types.png']));
    
    % Close the figure
    close(gcf);
    
    % Clear variables for the next iteration
    clear(['laser_binary_', uniqueId]);
    clear(['delta465_filt_2_', uniqueId]);
    clear(['sec_signal_2_', uniqueId]);
    clear(['signal_fs_', uniqueId]);
    clear(['RR_', uniqueId]);
    clear(['RR_time_', uniqueId]);
    clear(['mean_spectrogram_', uniqueId]);
    clear(['EEG_bands_fs_', uniqueId]);
    clear(['F_', uniqueId]);
end
end
