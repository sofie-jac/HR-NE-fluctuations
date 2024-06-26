function [table_NE, table_RR, table_SO, table_Delta, table_Theta, table_Sigma, table_Beta, table_Gamma_low, table_Gamma_high] = create_tables_from_results(results)
    % Function to subtract the mean value of the trace from -40 to -30 seconds
    function aligned_data = subtract_baseline(data, time_vector)
        baseline_indices = time_vector >= -40 & time_vector <= -30;
        baseline_mean = mean(data(baseline_indices));
        aligned_data = data - baseline_mean;
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
            aligned_mean_NE = subtract_baseline(results.(event_name).NE.mean, epoc_FPtime_NE)';

            % Append data to the table
            if isempty(table_NE)
                table_NE.Time = epoc_FPtime_NE;
            end
            table_NE = addvars(table_NE, aligned_mean_NE, results.(event_name).NE.sem', ...
                'NewVariableNames', {sprintf('%s_mean', event_name), sprintf('%s_sem', event_name)});
        end
    end

    % Process RR data
    for i = 1:length(event_var_names)
        event_name = event_var_names{i};

        if isfield(results.(event_name), 'RR')
            lenRR = length(results.(event_name).RR.mean);
            epoc_FPtime_RR = linspace(plot_start, plot_end, lenRR)';
            aligned_mean_RR = subtract_baseline(results.(event_name).RR.mean, epoc_FPtime_RR)';

            if isempty(table_RR)
                table_RR.Time = epoc_FPtime_RR;
            end
            table_RR = addvars(table_RR, aligned_mean_RR, results.(event_name).RR.sem', ...
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
                        table_SO = addvars(table_SO, aligned_mean_EEG, results.(event_name).(eeg_band).sem', ...
                            'NewVariableNames', {sprintf('%s_mean', event_name), sprintf('%s_sem', event_name)});
                    case 'Delta'
                        if isempty(table_Delta)
                            table_Delta.Time = epoc_FPtime_EEG;
                        end
                        table_Delta = addvars(table_Delta, aligned_mean_EEG, results.(event_name).(eeg_band).sem', ...
                            'NewVariableNames', {sprintf('%s_mean', event_name), sprintf('%s_sem', event_name)});
                    case 'Theta'
                        if isempty(table_Theta)
                            table_Theta.Time = epoc_FPtime_EEG;
                        end
                        table_Theta = addvars(table_Theta, aligned_mean_EEG, results.(event_name).(eeg_band).sem', ...
                            'NewVariableNames', {sprintf('%s_mean', event_name), sprintf('%s_sem', event_name)});
                    case 'Sigma'
                        if isempty(table_Sigma)
                            table_Sigma.Time = epoc_FPtime_EEG;
                        end
                        table_Sigma = addvars(table_Sigma, aligned_mean_EEG, results.(event_name).(eeg_band).sem', ...
                            'NewVariableNames', {sprintf('%s_mean', event_name), sprintf('%s_sem', event_name)});
                    case 'Beta'
                        if isempty(table_Beta)
                            table_Beta.Time = epoc_FPtime_EEG;
                        end
                        table_Beta = addvars(table_Beta, aligned_mean_EEG, results.(event_name).(eeg_band).sem', ...
                            'NewVariableNames', {sprintf('%s_mean', event_name), sprintf('%s_sem', event_name)});
                    case 'Gamma_low'
                        if isempty(table_Gamma_low)
                            table_Gamma_low.Time = epoc_FPtime_EEG;
                        end
                        table_Gamma_low = addvars(table_Gamma_low, aligned_mean_EEG, results.(event_name).(eeg_band).sem', ...
                            'NewVariableNames', {sprintf('%s_mean', event_name), sprintf('%s_sem', event_name)});
                    case 'Gamma_high'
                        if isempty(table_Gamma_high)
                            table_Gamma_high.Time = epoc_FPtime_EEG;
                        end
                        table_Gamma_high = addvars(table_Gamma_high, aligned_mean_EEG, results.(event_name).(eeg_band).sem', ...
                            'NewVariableNames', {sprintf('%s_mean', event_name), sprintf('%s_sem', event_name)});
                end
            end
        end
    end
end
