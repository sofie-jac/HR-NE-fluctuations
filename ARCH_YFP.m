%% Load files with certain suffixes
% Specify the directory containing the .mat files
folderPath = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\arch_yfp';

% List of 3-digit elements to look for in file names
suffixes = {'387', '403', '412', '414', '416', '408', '420'};

% Get a list of all files in the folder and subfolders with the .mat extension
matFiles = dir(fullfile(folderPath, '**', '*.mat'));  % '**' enables recursive search in subfolders

% Loop through each file
for k = 1:length(matFiles)
    fileName = matFiles(k).name;
    
    % Check if file name contains any of the specified elements
    shouldLoad = false;
    for i = 1:length(suffixes)
        if contains(fileName, suffixes{i})
            shouldLoad = true;
            break;
        end
    end
    
    % If the file name contains one of the specified elements, load the file
    if shouldLoad
        filePath = fullfile(matFiles(k).folder, matFiles(k).name);
        data = load(filePath);
        
        % Assuming each .mat file contains only one variable and can be converted to a double
        varNames = fieldnames(data);  % Get the name of the variable in the .mat file
        if length(varNames) == 1  % Check if there's exactly one variable in the file
            varData = data.(varNames{1});  % Extract that variable
            
            % Check if the data can be converted to a double
            if isnumeric(varData) || islogical(varData)
                varData = double(varData);  % Convert to double if not already
                % Store it in a variable dynamically named according to the file without the loop index
                eval([varNames{1}, ' = varData;']);  % Remove num2str(k) to prevent indexing by load order
            else
                warning('%s contains data that cannot be converted to double.', matFiles(k).name);
            end
        else
            warning('%s does not contain exactly one variable.', matFiles(k).name);
        end
    end
end

clear matFiles filePath folderPath varNames varData data k shouldLoad i suffixes fileName
%% Get all laser starts
% List of suffixes for each animal
% List of suffixes for each animal
suffixes = {'387', '403', '412', '414', '416', '408', '420'};
baseName = 'laser_binary';

% Directory where you want to save the .mat files
saveDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\arch_yfp\laser_times';

% Check if the save directory exists, if not, create it
if ~exist(saveDirectory, 'dir')
    mkdir(saveDirectory);
end

% Loop through each suffix to load and process the laser binary variables
for s = 1:length(suffixes)
    suffix = suffixes{s};
    varName = [baseName, '_', suffix];  % Create the full variable name

    % Dynamically load the variable
    if evalin('base', ['exist(''' varName ''', ''var'')'])
        laser_binary = evalin('base', varName);

        % Load the sampling frequency
        fs_varName = ['signal_fs_', suffix];
        if evalin('base', ['exist(''' fs_varName ''', ''var'')'])
            signal_fs = evalin('base', fs_varName);

            % Convert laser_binary to laser_periods
            [laser_onset, laser_offset] = binaryToOnOff(laser_binary);
            laser_periods = [laser_onset; laser_offset]' / signal_fs;  % Convert to seconds

            % Load the corresponding NREMinclMA_periods
            NREMinclMA_varName = ['NREMinclMA_periods_', suffix];
            if evalin('base', ['exist(''' NREMinclMA_varName ''', ''var'')'])
                NREMinclMA_periods = evalin('base', NREMinclMA_varName);

                % Filter laser_periods to ensure they fall within NREMinclMA_periods
                laser_NREM = [];
                for i = 1:size(laser_periods, 1)
                    laser_onset = laser_periods(i, 1);
                    laser_offset = laser_periods(i, 2);

                    % Check if laser period falls within NREMinclMA period
                    for j = 1:size(NREMinclMA_periods, 1)
                        NREM_onset = NREMinclMA_periods(j, 1);
                        NREM_offset = NREMinclMA_periods(j, 2);

                        % Criteria: NREM starts minimally 30s before laser onset
                        % and extends minimally 60s after laser onset
                        if (NREM_onset <= (laser_onset - 60)) && ((laser_onset + 30) <= NREM_offset)
                            laser_NREM = [laser_NREM; laser_onset, laser_offset];
                            break;
                        end
                    end
                end
                laser_on_NREM = laser_NREM(:,1);

                % Save laser_periods and laser_NREM to the environment and the specified directory
                laser_periods_varName = ['laser_periods_', suffix];
                laser_NREM_varName = ['laser_NREM_', suffix];
                laser_on_NREM_varName = ['laser_on_NREM_', suffix];

                assignin('base', laser_periods_varName, laser_periods);
                assignin('base', laser_NREM_varName, laser_NREM);
                assignin('base', laser_on_NREM_varName, laser_on_NREM);


                save(fullfile(saveDirectory, [laser_periods_varName, '.mat']), laser_periods_varName);
                save(fullfile(saveDirectory, [laser_NREM_varName, '.mat']), laser_NREM_varName);
                save(fullfile(saveDirectory, [laser_on_NREM_varName, '.mat']), laser_on_NREM_varName);

            else
                fprintf('Variable %s does not exist in the workspace.\n', NREMinclMA_varName);
            end
        else
            fprintf('Variable %s does not exist in the workspace.\n', fs_varName);
        end
    else
        fprintf('Variable %s does not exist in the workspace.\n', varName);
    end

    % Clear temporary variables
    clear laser_binary laser_onset laser_offset laser_periods NREMinclMA_periods laser_NREM signal_fs laser_on_NREM_varName laser_on_NREM laser_off;
end
%% POWER

power_bands = {[0.5, 1], [1, 4], [4, 8], [8, 15], [15, 30], [60, 80], [80, 100]}; % define SO, delta, theta, sigma, and beta, respectively
frw = 0:0.2:100;
window_in_sec = 1; % sec. 1 for 30 sec

[mean_spectrogram_387, time_spectrogram_zero_387, F_387, band_powers_387, EEG_bands_fs_387] = PowerAnalysisEEG(EEG_387, EEG_fs_387, frw, window_in_sec, power_bands);
[mean_spectrogram_403, time_spectrogram_zero_403, F_403, band_powers_403, EEG_bands_fs_403] = PowerAnalysisEEG(EEG_403, EEG_fs_403, frw, window_in_sec, power_bands);
[mean_spectrogram_412, time_spectrogram_zero_412, F_412, band_powers_412, EEG_bands_fs_412] = PowerAnalysisEEG(EEG_412, EEG_fs_412, frw, window_in_sec, power_bands);
[mean_spectrogram_414, time_spectrogram_zero_414, F_414, band_powers_414, EEG_bands_fs_414] = PowerAnalysisEEG(EEG_414, EEG_fs_414, frw, window_in_sec, power_bands);
[mean_spectrogram_416, time_spectrogram_zero_416, F_416, band_powers_416, EEG_bands_fs_416] = PowerAnalysisEEG(EEG_416, EEG_fs_416, frw, window_in_sec, power_bands);
[mean_spectrogram_408, time_spectrogram_zero_408, F_408, band_powers_408, EEG_bands_fs_408] = PowerAnalysisEEG(EEG_408, EEG_fs_408, frw, window_in_sec, power_bands);
[mean_spectrogram_420, time_spectrogram_zero_420, F_420, band_powers_420, EEG_bands_fs_420] = PowerAnalysisEEG(EEG_420, EEG_fs_420, frw, window_in_sec, power_bands);

clear power_bands frw window_in_sec

%% Get figure 3 single animal
o = {'387', '403', '412', '414', '416', '408', '420'};
for idx = 1:length(o)
    uniqueId = o{idx};
    disp(uniqueId)

    % Access the variables dynamically
    laser_on = eval(sprintf('laser_NREM_%s', uniqueId));
    laser_on_NREM = laser_on(:,1);
    sec_signal_2 = eval(sprintf('sec_signal_2_%s', uniqueId));
    delta465_filt_2= eval(sprintf('delta465_filt_2_%s', uniqueId));
    RR = eval(sprintf('RR_%s', uniqueId));
    RR_time = eval(sprintf('RR_time_%s', uniqueId));
    EEG_bands_fs = eval(sprintf('EEG_bands_fs_%s', uniqueId));
    F = eval(sprintf('F_%s', uniqueId));
    mean_spectrogram = eval(sprintf('mean_spectrogram_%s', uniqueId));
    NE_fs = eval(sprintf('signal_fs_%s', uniqueId));
    
event_var = {laser_on_NREM};
titles = {'Laser on: NREM'};
main_title = (['Averaged Activity During LC Supression (' uniqueId ')']);

figure_2(event_var, 60, 60, titles, main_title, delta465_filt_2, sec_signal_2, NE_fs, RR, RR_time, 64,  mean_spectrogram, F, EEG_bands_fs, 60);
end
clear idx uniqueId event_var titles main_title laser_on laser_on_NREM sec_signal_2 delta465_filt_2 RR RR_time EEG_bands_fs F mean_spectrogram NE_fs
%% Get Figure 3 data

warning('off','all')
warning

o = {'387', '403', '412', '414', '416', '408', '420'};
event_var = {'laser_on_NREM'};
epoc_start = 60;
epoc_end = 60; 
cross_cor_sec = 60;
saveDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\arch_yfp\figure_3_data';


% Loop over each event type
for stage_idx = 1:length(event_var)
    event_type_name = event_var{stage_idx};  % Get the current event type name

    % Loop over each subject
    for idx = 1:length(o)
        uniqueId = o{idx};  % Get the current subject ID

        % Resetting individual collectors for each subject and each data type
        NE_collector = [];
        RR_collector = [];
        SO_collector = [];
        Delta_collector = [];
        Theta_collector = [];
        Sigma_collector = [];
        Beta_collector = [];
        Gamma_low_collector = [];
        Gamma_high_collector = [];
        mean_cc1 = [];

        % Collect data for the current event type and subject
        event_type = eval(sprintf('%s_%s', event_type_name, uniqueId));
        if isempty(event_type)
            disp(['Skipping ', event_type_name, ' for subject ', uniqueId, ' due to no events.']);
            continue;
        end

            % Load other necessary data for this subject
            sec_signal_2 = eval(sprintf('sec_signal_2_%s', uniqueId));
            delta465_filt_2 = eval(sprintf('delta465_filt_2_%s', uniqueId));
            RR = eval(sprintf('RR_%s', uniqueId));
            RR_time = eval(sprintf('RR_time_%s', uniqueId));
            EEG_bands_fs = eval(sprintf('EEG_bands_fs_%s', uniqueId));
            F = eval(sprintf('F_%s', uniqueId));
            mean_spectrogram = eval(sprintf('mean_spectrogram_%s', uniqueId));
            NE_fs = eval(sprintf('signal_fs_%s', uniqueId));
        
            % Calculate the greatest common divisor to find the optimal downsample factor
            gcd_fs = gcd(round(NE_fs), 64);
            
            % Compute downsample and upsample factors
            P = 64 / gcd_fs;
            Q = round(NE_fs) / gcd_fs;

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
            NE_collector = [NE_collector; NEpk_epoc_i];
    
            HRB_i = event_type(i);
            if HRB_i < RR_time(1) + epoc_start || HRB_i > RR_time(end) - epoc_end
                disp(['Event ', num2str(i), ' skipped due to proximity to start/end of recording']);
                continue;  % Skip this event
            end

            RR_epoc= RR(:, (find(RR_time>HRB_i,1)-(64*epoc_start):find(RR_time>HRB_i,1)+(64*epoc_end)));
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
        
        cc1_all = cell(length(event_type), 1);

        for i = 1:size(NE_collector, 1)
            NE = NE_collector(i,:);
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
                    warning_msg = sprintf('Warning: NE and RR not the same length. Cutting %d datapoints from NE %s - NE now %d long', diff, event_type_name, length(NE_cross_corr));
                else
                    % RR is longer, trim it
                    RR_cross = RR_cross(1:end-diff);
                    warning_msg = sprintf('Warning: NE and RR not the same length. Cutting %d datapoints from RR %s - RR now %d long', diff, event_type_name, length(RR));
                end
                % Display the warning message
            end
            [cc1,lags] = xcorr(unity(detrend(RR_cross)), unity(detrend(NE_cross_corr)), (cross_cor_sec*64),'unbiased');
            cc1_all{i, 1} = cc1.';  % Store as a row vector if cc1 is initially a column vector
        end
        disp(warning_msg);

        % Assuming cc1_all is already filled with cc1 vectors as described
        cc1_matrix = cell2mat(cc1_all.');  % Transpose to make each cc1 vector a column
        cc1_matrix = cc1_matrix';
        mean_cc1 = mean(cc1_matrix, 1);    % Compute the mean across columns

        % Optional: If you want to work with the mean_cc1 as a column vector
        mean_cc1 = mean_cc1(:);

        % Save each type of collected data into a variable named by combining event_type_name, data type, and uniqueId
        data_types = {'NE', 'RR', 'SO', 'Delta', 'Theta', 'Sigma', 'Beta', 'Gamma_low', 'Gamma_high', 'x_corr'};
        collectors = {NE_collector, RR_collector, SO_collector, Delta_collector, Theta_collector, Sigma_collector, Beta_collector, Gamma_low_collector, Gamma_high_collector, cc1_matrix};
        
        for j = 1:length(data_types)
            variable_name = sprintf('%s_%s_%s', data_types{j}, event_type_name, uniqueId);
            eval([variable_name ' = collectors{j};']);  % Create variable with unique name
            
            % Save the variable to a file named after the variable itself within the specified directory
            save(fullfile(saveDirectory, [variable_name '.mat']), variable_name);
        end
    end
end

%% Get figure 3 all animals
data_types = {'NE', 'RR', 'SO', 'Delta', 'Theta', 'Sigma', 'Beta', 'Gamma_low', 'Gamma_high', 'x_corr'};
titles = {'NREM'};
main_title_arch = ('Averaged Activity During LC Supression');
main_title_yfp = ('Averaged Activity During non LC Supression');
arch = {'387', '403', '412', '414', '416'};
yfp = {'408', '420'};
event_var = {'laser_on_NREM'};
epoc_start = 60;
epoc_end = 60; 
saveDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\arch_yfp\figure_3_data';

results_arch = aggregate_event_data(saveDirectory, event_var, arch, data_types);
[global_max_arch, global_min_arch] = compute_global_extremes(results_arch, data_types);
figure_2_cross_animals(results_arch, global_max_arch, global_min_arch, 60, 60, main_title_arch, titles)

results_yfp = aggregate_event_data(saveDirectory, event_var, yfp, data_types);
[global_max_yfp, global_min_yfp] = compute_global_extremes(results_yfp, data_types);
figure_2_cross_animals(results_yfp, global_max_yfp, global_min_yfp, 60, 60, main_title_yfp, titles)

%% RR PSD SECTION
%% Create NREMinclMA if you don't have it

% List of suffixes for each animal
suffixes = {'387', '403', '412', '414', '416', '408', '420'}; % Add more suffixes as needed

% Loop through each suffix
for s = 1:length(suffixes)
    suffix = suffixes{s};
    
    % Construct variable names with the current suffix
    sws_varName = ['sws_binary_vector_', suffix];
    MA_varName = ['MA_binary_vector_', suffix];
    
    % Check if the variables exist in the environment
    if exist(sws_varName, 'var') && exist(MA_varName, 'var')
        % Retrieve the variables from the workspace
        sws_binary_vector = eval(sws_varName);
        MA_binary_vector = eval(MA_varName);
        
        % Add the binary vectors to create NREMinclMA_binary
        NREMinclMA_binary = sws_binary_vector + MA_binary_vector;
        NREMinclMA_binary(NREMinclMA_binary > 1) = 1; % Ensure it remains binary
        
        % Convert NREMinclMA_binary to NREMinclMA_periods
        [NREMinclMA_onset, NREMinclMA_offset] = binaryToOnOff(NREMinclMA_binary);
        NREMinclMA_periods = [NREMinclMA_onset; NREMinclMA_offset];
        NREMinclMA_periods = NREMinclMA_periods';

        % Save the results with a new name
        NREMinclMA_binary_name = ['NREMinclMA_binary_', suffix];
        NREMinclMA_periods_name = ['NREMinclMA_periods_', suffix];
        assignin('base', NREMinclMA_binary_name, NREMinclMA_binary);
        assignin('base', NREMinclMA_periods_name, NREMinclMA_periods);
    else
        warning('Variables %s and/or %s do not exist in the workspace.', sws_varName, MA_varName);
    end
end

% Clear temporary variables
clear baseVariables suffixes s suffix sws_varName MA_varName sws_binary_vector MA_binary_vector NREMinclMA_binary NREMinclMA_onset NREMinclMA_offset NREMinclMA_periods NREMinclMA_binary_name NREMinclMA_periods_name;
%% Get RR from NREMiclMA
suffixes = {'387', '403', '412', '414', '416', '408', '420'}; % Add more suffixes as needed
RR_data_NREM_table = process_NREM_with_laser(suffixes);

%% RR PSD plot
    arch = {'387', '403', '412', '414', '416'};
    yfp = {'408', '420'};
plot_PSD_with_laser(RR_data_NREM_table, arch, yfp, 60)

%% HRB Generation
suffixes = {'387', '403', '412', '414', '416', '408', '420'}; % Add more suffixes as needed
find_plot_HRB(suffixes);

%% Plot HRB values
HRB_table = create_HRB_table(suffixes);
plot_HRB_rate_violins(HRB_table, arch, yfp, 'HRB_Value', 'Time between R peaks for HRB events', 'HRB Value Distribution by Group and Laser Status');

%% Plot HRB Rate
NREMinclMA_HRB_table = create_NREMinclMA_HRB_table(suffixes);
plot_HRB_rate_violins(NREMinclMA_HRB_table, arch, yfp, 'HRB_Rate', 'HRB Rate (event pr. minute)', 'HRB Rate Distribution by Group and Laser Status');

