function [table_NE, table_RR, table_SO, table_Delta, table_Theta, table_Sigma, table_Beta, table_Gamma_low, table_Gamma_high] = create_tables_from_results(results)
    % Function to subtract the mean value of the trace from -40 to -30 seconds
    function aligned_data = subtract_baseline(data, time_vector)
        baseline_indices = time_vector >= -40 & time_vector <= -30;
        baseline_mean = mean(data(baseline_indices));
        aligned_data = data - baseline_mean;
    end

    % Function to downsample data by a specified factor
    function [downsampled_data, downsampled_time, downsampled_sem] = downsample_data(data, time_vector, sem, factor)
        downsampled_data = data(1:factor:end);
        downsampled_time = time_vector(1:factor:end);
        downsampled_sem = sem(1:factor:end);  % Downsample SEM in the same way
    end

    % Initialize the tables to store mean and SEM
    table_NE = table();
    table_RR = table();
    eeg_bands = {'SO', 'Delta', 'Theta', 'Sigma', 'Beta', 'Gamma_low', 'Gamma_high'};
    table_SO = table();
    table_Delta = table();
    table_Theta = table();
    table_Sigma = table();
    table_Beta = table();
    table_Gamma_low = table();
    table_Gamma_high = table();
    
    event_var_names = fieldnames(results);

    % Define the epoch range
    plot_start = -60;
    plot_end = 60;

    % Process NE data
    for i = 1:length(event_var_names)
        event_name = event_var_names{i};

        if isfield(results.(event_name), 'NE')
            lenNE = length(results.(event_name).NE.mean);
            epoc_FPtime_NE = linspace(plot_start, plot_end, lenNE)';
           % aligned_mean_NE = subtract_baseline(results.(event_name).NE.mean, epoc_FPtime_NE)';
            NE_data = results.(event_name).NE.mean';
            aligned_sem_NE = results.(event_name).NE.sem';  % Directly use the SEM without baseline correction

            % Downsample by a factor of 100
            factor = 100;
            % disp(size(NE_data))
            % disp(size(aligned_sem_NE))
            % disp(size(epoc_FPtime_NE))

            [downsampled_mean_NE, downsampled_time_NE, downsampled_sem_NE] = downsample_data(NE_data, epoc_FPtime_NE, aligned_sem_NE, factor);

            % Append data to the table
            if isempty(table_NE)
                table_NE.Time = downsampled_time_NE;
            end
            table_NE = addvars(table_NE, downsampled_mean_NE, downsampled_sem_NE, ...
                'NewVariableNames', {sprintf('%s_mean', event_name), sprintf('%s_sem', event_name)});
        end
    end

    % Process RR data
    for i = 1:length(event_var_names)
        event_name = event_var_names{i};

        if isfield(results.(event_name), 'RR')
            lenRR = length(results.(event_name).RR.mean);
            epoc_FPtime_RR = linspace(plot_start, plot_end, lenRR)';
           % aligned_mean_RR = subtract_baseline(results.(event_name).RR.mean, epoc_FPtime_RR)';

            if isempty(table_RR)
                table_RR.Time = epoc_FPtime_RR;
            end
            table_RR = addvars(table_RR, results.(event_name).RR.mean', results.(event_name).RR.sem', ...
                'NewVariableNames', {sprintf('%s_mean', event_name), sprintf('%s_sem', event_name)});
        end
    end

    % Process EEG bands data
    for k = 1:length(eeg_bands)
        eeg_band = eeg_bands{k};
        for i = 1:length(event_var_names)
            event_name = event_var_names{i};

            if isfield(results.(event_name), eeg_band)
                lenEEG = length(results.(event_name).(eeg_band).mean);
                epoc_FPtime_EEG = linspace(plot_start, plot_end, lenEEG)';
                aligned_mean_EEG = subtract_baseline(results.(event_name).(eeg_band).mean, epoc_FPtime_EEG)';

                switch eeg_band
                    case 'SO'
                        if isempty(table_SO)
                            table_SO.Time = epoc_FPtime_EEG;
                        end
                        table_SO = addvars(table_SO, results.(event_name).(eeg_band).mean', results.(event_name).(eeg_band).sem', ...
                            'NewVariableNames', {sprintf('%s_mean', event_name), sprintf('%s_sem', event_name)});
                    case 'Delta'
                        if isempty(table_Delta)
                            table_Delta.Time = epoc_FPtime_EEG;
                        end
                        table_Delta = addvars(table_Delta, results.(event_name).(eeg_band).mean', results.(event_name).(eeg_band).sem', ...
                            'NewVariableNames', {sprintf('%s_mean', event_name), sprintf('%s_sem', event_name)});
                    case 'Theta'
                        if isempty(table_Theta)
                            table_Theta.Time = epoc_FPtime_EEG;
                        end
                        table_Theta = addvars(table_Theta, results.(event_name).(eeg_band).mean', results.(event_name).(eeg_band).sem', ...
                            'NewVariableNames', {sprintf('%s_mean', event_name), sprintf('%s_sem', event_name)});
                    case 'Sigma'
                        if isempty(table_Sigma)
                            table_Sigma.Time = epoc_FPtime_EEG;
                        end
                        table_Sigma = addvars(table_Sigma, results.(event_name).(eeg_band).mean', results.(event_name).(eeg_band).sem', ...
                            'NewVariableNames', {sprintf('%s_mean', event_name), sprintf('%s_sem', event_name)});
                    case 'Beta'
                        if isempty(table_Beta)
                            table_Beta.Time = epoc_FPtime_EEG;
                        end
                        table_Beta = addvars(table_Beta, results.(event_name).(eeg_band).mean', results.(event_name).(eeg_band).sem', ...
                            'NewVariableNames', {sprintf('%s_mean', event_name), sprintf('%s_sem', event_name)});
                    case 'Gamma_low'
                        if isempty(table_Gamma_low)
                            table_Gamma_low.Time = epoc_FPtime_EEG;
                        end
                        table_Gamma_low = addvars(table_Gamma_low, results.(event_name).(eeg_band).mean', results.(event_name).(eeg_band).sem', ...
                            'NewVariableNames', {sprintf('%s_mean', event_name), sprintf('%s_sem', event_name)});
                    case 'Gamma_high'
                        if isempty(table_Gamma_high)
                            table_Gamma_high.Time = epoc_FPtime_EEG;
                        end
                        table_Gamma_high = addvars(table_Gamma_high, results.(event_name).(eeg_band).mean', results.(event_name).(eeg_band).sem', ...
                            'NewVariableNames', {sprintf('%s_mean', event_name), sprintf('%s_sem', event_name)});
                end
            end
        end
    end
end
