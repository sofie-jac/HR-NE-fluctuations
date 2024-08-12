%% ARCH - YFP lists
yfp = {'408', '420', '484', '468', '015' '079', '089'};
arch = {'387', '403', '412', '414', '416', '013', '019'};

% List of base variable names
baseVariables = {'sec_signal_EEG_', 'EEG_fs_'};

% List of suffixes for each animal
suffixes = {'007', '015', '079', '089', '013', '019', '009'};

% Directory where the .mat files are stored
loadDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\arch_yfp\2nd_round\Traces';

% Check if the load directory exists
if ~exist(loadDirectory, 'dir')
    fprintf('Path %s does not exist.\n', loadDirectory);
else
    % Loop through each base variable and each suffix to form the full variable name
    for i = 1:length(baseVariables)
        for j = 1:length(suffixes)
            fullVarName = [baseVariables{i}, suffixes{j}];  % Create the full variable name
            filename = fullfile(loadDirectory, [fullVarName '.mat']);  % Construct the filename

            % Check if the .mat file exists before loading
            if exist(filename, 'file')
                % Load the variable from the .mat file into the workspace
                loadedData = load(filename);
                assignin('base', fullVarName, loadedData.(fullVarName));
            else
                fprintf('File %s does not exist and will not be loaded.\n', filename);
            end
        end
    end
end

clear i j fullVarName filename loadDirectory baseVariables suffixes loadedData

[EMG_hp_007, EMG_hplp_007] = Analyze_EMG_windows([],1,610.3516,1,45,2.5,0,0,1); %Take -EMG_hp_007
%[RR_007, RR_time_007, RR_fs_007, Rpeaks_007, Rpeaks_time_007] = GetRRIntervals_arch('M007', -EMG_hp_007, sec_signal_EEG_007, EEG_fs_007, 2, 2); 

[EMG_hp_009, EMG_hplp_009] = Analyze_EMG_windows([],1,610.3516,1,80,2.5,0,0,1); %Take -EMG_hp_009
%[RR_009, RR_time_009, RR_fs_009, Rpeaks_009, Rpeaks_time_009] = GetRRIntervals_arch('M009', -EMG_hp_009, sec_signal_EEG_009, EEG_fs_009, 2, 2); 

[EMG_hp_013, EMG_hplp_013] = Analyze_EMG_windows([],1,610.3516,1,80,2.5,0,0,1); %Take -EMG_hp_013
[RR_013, RR_time_013, RR_fs_013, Rpeaks_013, Rpeaks_time_013] = GetRRIntervals('M013', -EMG_hp_013, sec_signal_EEG_013, EEG_fs_013, 4.1, 2.3); 

[EMG_hp_015, EMG_hplp_015] = Analyze_EMG_windows([],1,610.3516,1,80,2.5,0,0,1); %Take EMG_hp_015
[RR_015, RR_time_015, RR_fs_015, Rpeaks_015, Rpeaks_time_015] = GetRRIntervals('M015', EMG_hp_015, sec_signal_EEG_015, EEG_fs_015, 4, 1.8); 

[EMG_hp_019, EMG_hplp_019] = Analyze_EMG_windows([],1,610.3516,1,80,2.5,0,0,1); %Take EMG_hp_019
[RR_019, RR_time_019, RR_fs_019, Rpeaks_019, Rpeaks_time_019] = GetRRIntervals('M019', EMG_hp_019, sec_signal_EEG_019, EEG_fs_019, 4, 1.8); 

[EMG_hp_079, EMG_hplp_079] = Analyze_EMG_windows([],1,610.3516,1,80,2.5,0,0,1); %Take EMG_hp_079
[RR_079, RR_time_079, RR_fs_079, Rpeaks_079, Rpeaks_time_079] = GetRRIntervals('M079', EMG_hp_079, sec_signal_EEG_079, EEG_fs_079, 4, 1.8); 

[EMG_hp_089, EMG_hplp_089] = Analyze_EMG_windows([],1,610.3516,1,80,2.5,0,0,1); %Take EMG_hp_089
[RR_089, RR_time_089, RR_fs_089, Rpeaks_089, Rpeaks_time_089] = GetRRIntervals('M089', EMG_hp_089, sec_signal_EEG_089, EEG_fs_089, 4, 1.8); 

%Old for re-do
[RR_420, RR_time_420, RR_fs_420, Rpeaks_420, Rpeaks_time_420] = GetRRIntervals_arch('M420', -EMG_420, sec_signal_EEG_420, EEG_fs_420, 6.3, 2.5);

[EMG_hp_408, EMG_hplp_408] = Analyze_EMG_windows([],1,512,2,80,2.5,0,0,1); %Take EMG_hplp_408
[RR_408, RR_time_408, RR_fs_408, Rpeaks_408, Rpeaks_time_408] = GetRRIntervals_arch('M408', EMG_hplp_408, sec_signal_EEG_408, EEG_fs_408, 2, 1.6); 

[EMG_hp_387, EMG_hplp_387] = Analyze_EMG_windows([],1,512,2,80,2.5,0,0,1); %Take EMG_hplp_387
[RR_387, RR_time_387, RR_fs_387, Rpeaks_387, Rpeaks_time_387] = GetRRIntervals_arch('M387', EMG_hplp_387, sec_signal_EEG_387, EEG_fs_387, 2.3, 1.8); 

[EMG_hp_403, EMG_hplp_403] = Analyze_EMG_windows([],1,512,2,80,2.5,0,0,1); %Take EMG_hp_403 (v good)
[RR_403, RR_time_403, RR_fs_403, Rpeaks_403, Rpeaks_time_403] = GetRRIntervals_arch('M403', -EMG_hp_403, sec_signal_EEG_403, EEG_fs_403, 2.3, 2); 
[EMG_hp_412, EMG_hplp_412] = Analyze_EMG_windows([],1,512,2,80,2.5,0,0,1); %Take -EMG_hp_412
[RR_412, RR_time_412, RR_fs_412, Rpeaks_412, Rpeaks_time_412] = GetRRIntervals_arch('M412', -EMG_hp_412, sec_signal_EEG_412, EEG_fs_412, 2.5, 2.2); 
[EMG_hp_414, EMG_hplp_414] = Analyze_EMG_windows([],1,512,2,80,2.5,0,0,1); %Take EMG_hplp_414 (v good)
[RR_414, RR_time_414, RR_fs_414, Rpeaks_414, Rpeaks_time_414] = GetRRIntervals_arch('M414', EMG_hplp_414, sec_signal_EEG_414, EEG_fs_414, 2.5, 1.4); 
[EMG_hp_416, EMG_hplp_416] = Analyze_EMG_windows([],1,512,2,80,2.5,0,0,1); %Take -EMG_hp_416
[RR_416, RR_time_416, RR_fs_416, Rpeaks_416, Rpeaks_time_416] = GetRRIntervals_arch('M416', -EMG_hp_416, sec_signal_EEG_416, EEG_fs_416, 2, 2); 

load('C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\SOFIE_control_files\EMG_484_filtered_low_pass.mat')
load('C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\SOFIE_control_files\EMG_484_filtered_high_pass.mat')
sec_signal_EEG = (1:length(emg_f))/512;
[RR_484, RR_time_484, RR_fs_484, Rpeaks_484, Rpeaks_time_484] = GetRRIntervals_arch('M484', -emg_f, sec_signal_EEG, 512, 1.8, 1.3); 

% save('C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\saved_data\RR_intervals\RR_484.mat','RR_484'); 
% save('C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\saved_data\RR_intervals\RR_time_484.mat','RR_time_484');

load('C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\SOFIE_control_files\2nd round\EMG_468_filtered_low_pass.mat')
load('C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\SOFIE_control_files\2nd round\EMG_468_filtered_high_pass.mat')
sec_signal_EEG = (1:length(emg_f))/512;
[RR_468, RR_time_468, RR_fs_468, Rpeaks_468, Rpeaks_time_468] = GetRRIntervals_arch('M468', emg_f, sec_signal_EEG, 512, 2, 1.3); 


load('C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\SOFIE_control_files\EMG_477_filtered_low_pass.mat')
load('C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\SOFIE_control_files\EMG_477_filtered_high_pass.mat')
sec_signal_EEG = (1:length(emg_fhp))/512;
[RR_477, RR_time_477, RR_fs_477, Rpeaks_477, Rpeaks_time_477] = GetRRIntervals_arch('M477', -emg_fhp, sec_signal_EEG, 512, 2.5, 2); 


%% Save RR for ARCH and YFP
% List of base variable names
baseVariables = {'RR_', 'RR_time_'};

% List of suffixes for each animal
suffixes = {'013', '015', '019', '079', '089'};

% Directory where you want to save the .mat files
saveDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\arch_yfp\RR';

% Check if the save directory exists, if not, create it
if ~exist(saveDirectory, 'dir')
fprintf('Path %s does not exist.\n', saveDirectory);
end

% Loop through each base variable and each suffix to form the full variable name
for i = 1:length(baseVariables)
    for j = 1:length(suffixes)
        fullVarName = [baseVariables{i}, suffixes{j}];  % Create the full variable name
        filename = fullfile(saveDirectory, [fullVarName '.mat']);  % Construct the filename
        
        % Check if the variable exists in the workspace before saving
        if evalin('base', ['exist(''' fullVarName ''', ''var'')'])
            % Save the variable to a .mat file
            evalin('base', ['save(''' filename ''', ''' fullVarName ''');']);
        else
            fprintf('Variable %s does not exist in the workspace and will not be saved.\n', fullVarName);
        end
    end
end

clear i j fullVarName filename saveDirectory baseVariables suffixes
%% Load files with certain suffixes
% Specify the directory containing the .mat files
folderPath = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\arch_yfp';

% List of 3-digit elements to look for in file names
suffixes = {'387', '403', '412', '414', '416', '408', '420'};
suffixes = {'468', '484'};

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

%% Determine time to fall asleep

% Example usage:
yfp = {'408', '420', '484', '468', '015', '079', '089'};
arch = {'387', '403', '412', '414', '416', '013', '019'};

sleep_onset_table = identify_first_sleep_onset(yfp, arch);

%% Create NREMinclMA if you don't have it

% List of suffixes for each animal
suffixes = {'013', '015', '019', '079', '089'};

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

%% Get all laser starts
% List of suffixes for each animal
% List of suffixes for each animal
suffixes = {'387', '403', '412', '414', '416', '408', '420'};
suffixes = {'468', '484'};
suffixes = {'013', '015', '019', '079', '089'};

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

%round 1
[mean_spectrogram_387, time_spectrogram_zero_387, F_387, band_powers_387, EEG_bands_fs_387] = PowerAnalysisEEG(EEG_387, EEG_fs_387, frw, window_in_sec, power_bands);
[mean_spectrogram_403, time_spectrogram_zero_403, F_403, band_powers_403, EEG_bands_fs_403] = PowerAnalysisEEG(EEG_403, EEG_fs_403, frw, window_in_sec, power_bands);
[mean_spectrogram_412, time_spectrogram_zero_412, F_412, band_powers_412, EEG_bands_fs_412] = PowerAnalysisEEG(EEG_412, EEG_fs_412, frw, window_in_sec, power_bands);
[mean_spectrogram_414, time_spectrogram_zero_414, F_414, band_powers_414, EEG_bands_fs_414] = PowerAnalysisEEG(EEG_414, EEG_fs_414, frw, window_in_sec, power_bands);
[mean_spectrogram_416, time_spectrogram_zero_416, F_416, band_powers_416, EEG_bands_fs_416] = PowerAnalysisEEG(EEG_416, EEG_fs_416, frw, window_in_sec, power_bands);
[mean_spectrogram_408, time_spectrogram_zero_408, F_408, band_powers_408, EEG_bands_fs_408] = PowerAnalysisEEG(EEG_408, EEG_fs_408, frw, window_in_sec, power_bands);
[mean_spectrogram_420, time_spectrogram_zero_420, F_420, band_powers_420, EEG_bands_fs_420] = PowerAnalysisEEG(EEG_420, EEG_fs_420, frw, window_in_sec, power_bands);
[mean_spectrogram_484, time_spectrogram_zero_484, F_484, band_powers_484, EEG_bands_fs_484] = PowerAnalysisEEG(EEG_484, EEG_fs_484, frw, window_in_sec, power_bands);
[mean_spectrogram_468, time_spectrogram_zero_468, F_468, band_powers_468, EEG_bands_fs_468] = PowerAnalysisEEG(EEG_468, EEG_fs_468, frw, window_in_sec, power_bands);

%round 2
[mean_spectrogram_013, time_spectrogram_zero_013, F_013, band_powers_013, EEG_bands_fs_013] = PowerAnalysisEEG(EEG_013, EEG_fs_013, frw, window_in_sec, power_bands);
[mean_spectrogram_015, time_spectrogram_zero_015, F_015, band_powers_015, EEG_bands_fs_015] = PowerAnalysisEEG(EEG_015, EEG_fs_015, frw, window_in_sec, power_bands);
[mean_spectrogram_019, time_spectrogram_zero_019, F_019, band_powers_019, EEG_bands_fs_019] = PowerAnalysisEEG(EEG_019, EEG_fs_019, frw, window_in_sec, power_bands);
[mean_spectrogram_079, time_spectrogram_zero_079, F_079, band_powers_079, EEG_bands_fs_079] = PowerAnalysisEEG(EEG_079(1, :), EEG_fs_079, frw, window_in_sec, power_bands);
[mean_spectrogram_089, time_spectrogram_zero_089, F_089, band_powers_089, EEG_bands_fs_089] = PowerAnalysisEEG(EEG_089(1, :), EEG_fs_089, frw, window_in_sec, power_bands);

clear frw window_in_sec

%% Get figure 3 single animal
o = {'387', '403', '412', '414', '416', '408', '420'};
o = {'468', '484'};
o = {'468'};

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

o = {'015' '079', '089', '013', '019'};
%'387', '403', '412', '414', '416', '408', '420', 
event_var = {'laser_on_NREM'};
epoc_start = 60;
epoc_end = 60; 
% cross_cor_sec = 60;
saveDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\arch_yfp\Copy_of_figure_3_data';


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
        
        % cc1_all = cell(length(event_type), 1);
        % 
        % for i = 1:size(NE_collector, 1)
        %     NE = NE_collector(i,:);
        %     RR_cross = RR_collector(i,:);
        %     NE_cross_corr = resample(NE, P, Q);
        % 
        %     NE_length = length(NE_cross_corr); % number of obs in NE data
        %     RR_length = length(RR_cross); % number of obs in RR data
        % 
        %     if NE_length ~= RR_length
        %         % Calculate the difference and determine which one is longer
        %         diff = abs(NE_length - RR_length);
        %         if NE_length > RR_length
        %             % NE is longer, trim it
        %             NE_cross_corr = NE_cross_corr(1:end-diff);
        %             warning_msg = sprintf('Warning: NE and RR not the same length. Cutting %d datapoints from NE %s - NE now %d long', diff, event_type_name, length(NE_cross_corr));
        %         else
        %             % RR is longer, trim it
        %             RR_cross = RR_cross(1:end-diff);
        %             warning_msg = sprintf('Warning: NE and RR not the same length. Cutting %d datapoints from RR %s - RR now %d long', diff, event_type_name, length(RR));
        %         end
        %         % Display the warning message
        %     end
        %     % [cc1,lags] = xcorr(unity(detrend(RR_cross)), unity(detrend(NE_cross_corr)), (cross_cor_sec*64),'unbiased');
        %     % cc1_all{i, 1} = cc1.';  % Store as a row vector if cc1 is initially a column vector
        % end
        % disp(warning_msg);
        % 
        % % Assuming cc1_all is already filled with cc1 vectors as described
        % cc1_matrix = cell2mat(cc1_all.');  % Transpose to make each cc1 vector a column
        % cc1_matrix = cc1_matrix';
        % mean_cc1 = mean(cc1_matrix, 1);    % Compute the mean across columns
        % 
        % % Optional: If you want to work with the mean_cc1 as a column vector
        % mean_cc1 = mean_cc1(:);

        % Save each type of collected data into a variable named by combining event_type_name, data type, and uniqueId
        data_types = {'NE', 'RR', 'SO', 'Delta', 'Theta', 'Sigma', 'Beta', 'Gamma_low', 'Gamma_high'};
        collectors = {NE_collector, RR_collector, SO_collector, Delta_collector, Theta_collector, Sigma_collector, Beta_collector, Gamma_low_collector, Gamma_high_collector};
        
        for j = 1:length(data_types)
            variable_name = sprintf('%s_%s_%s', data_types{j}, event_type_name, uniqueId);
            eval([variable_name ' = collectors{j};']);  % Create variable with unique name
            
            % Save the variable to a file named after the variable itself within the specified directory
            save(fullfile(saveDirectory, [variable_name '.mat']), variable_name);
        end
    end
end

%% Get figure 3 (all traces)
data_types = {'NE', 'RR', 'SO', 'Delta', 'Theta', 'Sigma', 'Beta', 'Gamma_low', 'Gamma_high'};
titles = {'Laser On'};
main_title_yfp = ('Averaged Activity During LC supression (Laser onset) for YFP');
main_title_arch = ('Averaged Activity During LC supression (Laser onset) for ARCH');
event_var = {'laser_on_NREM'};
arch = {'387', '412', '414', '416', '013', '019'};
yfp = {'408', '420', '484', '468', '015' '079', '089'};

arch = {'387', '403', '412', '414', '416', '013', '019'};
yfp = {'408', '420', '484', '468', '015' '079', '089'};


saveDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\arch_yfp\Copy_of_figure_3_data';
epoc_start = 60;
epoc_end = 60; 

results = aggregate_event_data(saveDirectory, event_var, yfp, data_types);
[table_NE, table_RR, table_SO, table_Delta, table_Theta, table_Sigma, table_Beta, table_Gamma_low, table_Gamma_high] = create_tables_from_results(results);
table_NE_ds = table_NE(1:5:end, :);
table_RR_ds = table_RR(1:5:end, :);
writetable(table_NE, 'yfp_NE_traces_ds.csv')
writetable(table_RR_ds, 'yfp_RR_traces.csv')
writetable(table_SO, 'yfp_table_SO.csv')
writetable(table_Delta, 'yfp_table_Delta.csv')
writetable(table_Theta, 'yfp_table_Theta.csv')
writetable(table_Sigma, 'yfp_table_Sigma.csv')
writetable(table_Beta, 'yfp_table_Beta.csv')
writetable(table_Gamma_low, 'yfp_table_Gamma_low.csv')
writetable(table_Gamma_high, 'yfp_table_Gamma_high.csv')

[NE_table, RR_table, SO_table, Delta_table, Theta_table, Sigma_table, Beta_table, Gamma_low_table, Gamma_high_table] = figure_2_reorganized(results, epoc_start, epoc_end, main_title_yfp, titles);
figure_2_reorganized_mean_centered(results, epoc_start, epoc_end, main_title_yfp, titles);
figure_2_reorganized(results, epoc_start, epoc_end, main_title_yfp, titles);

results = aggregate_event_data(saveDirectory, event_var, arch, data_types);
[table_NE, table_RR, table_SO, table_Delta, table_Theta, table_Sigma, table_Beta, table_Gamma_low, table_Gamma_high] = create_tables_from_results(results);
table_NE_ds = table_NE(1:5:end, :);
table_RR_ds = table_RR(1:5:end, :);
writetable(table_NE, 'arch_NE_traces_ds.csv')
writetable(table_RR_ds, 'arch_RR_traces.csv')
writetable(table_SO, 'arch_table_SO.csv')
writetable(table_Delta, 'arch_table_Delta.csv')
writetable(table_Theta, 'arch_table_Theta.csv')
writetable(table_Sigma, 'arch_table_Sigma.csv')
writetable(table_Beta, 'arch_table_Beta.csv')
writetable(table_Gamma_low, 'arch_table_Gamma_low.csv')
writetable(table_Gamma_high, 'arch_table_Gamma_high.csv')

[NE_table, RR_table, SO_table, Delta_table, Theta_table, Sigma_table, Beta_table, Gamma_low_table, Gamma_high_table] = figure_2_reorganized(results, epoc_start, epoc_end, main_title_arch, titles);
figure_2_reorganized_mean_centered(results, epoc_start, epoc_end, main_title_arch, titles);
figure_2_reorganized(results, epoc_start, epoc_end, main_title_arch, titles);

yfp = {'408', '420', '484', '468', '015' '079', '089'};
arch = {'387', '403', '412', '414', '416', '013', '019'};

%Run figure for single animal
saveDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\arch_yfp\figure_3_data';
results_single = aggregate_event_data_single(saveDirectory, event_var, '019', data_types);
figure_2_reorganized_single(results_single, epoc_start, epoc_end, '019' , titles)
%% AUC !!!

%% AUC diff ARCH/YFP
event_var = {'laser_on_NREM'};
titles = {'Laser On'};
saveDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\arch_yfp\Copy_of_figure_3_data';
outputDirectory = fullfile(saveDirectory, 'AUC');
yfp = {'408', '420', '484', '468', '015' '079', '089'};
arch = {'387', '403', '412', '414', '416', '013', '019'};
yfp = { '420', '484', '468', '408'};
arch = {'387', '412', '414', '416'};
Suffix = {'408', '420', '484', '468', '015' '079', '089', '387', '412', '414', '416', '013', '019'};
% Define the times_matrix
times_matrix_post = struct();
times_matrix_post.NE.range = [5, 45];
times_matrix_post.RR.range = [5, 45];
times_matrix_post.EEG.range = [5, 45];

times_matrix_pre = struct();
times_matrix_pre.NE.range = [-45, -5];
times_matrix_pre.RR.range = [-45, -5];
times_matrix_pre.EEG.range = [-45, -5];

% Call the function with the specified time range
%auc_data = extract_auc_and_plot(o, event_var, saveDirectory, times_matrix_post, outputDirectory, titles);

auc_data_yfp = extract_auc_and_plot_3(yfp, event_var, saveDirectory, times_matrix_pre, times_matrix_post); %This is the right one
auc_diff_table_yfp = plot_auc_bar(auc_data_yfp, event_var, yfp, titles);
writetable(auc_diff_table_yfp, 'yfp_auc_table.csv')

auc_data_arch = extract_auc_and_plot_3(arch, event_var, saveDirectory, times_matrix_pre, times_matrix_post); %This is the right one
auc_diff_table_arch = plot_auc_bar(auc_data_arch, event_var, arch, titles);
writetable(auc_diff_table_arch, 'arch_auc_table.csv')

auc_diff_table_combined = [auc_diff_table_yfp; auc_diff_table_arch];

% Assuming auc_diff_table and updated_table from the previous functions are already in the workspace
auc_diff_table_mean = compute_mean_by_subject(auc_diff_table_combined);
% Merge the two tables on the Suffix column
merged_table = outerjoin(auc_diff_table_mean, data_table_update_AUC, 'MergeKeys', true);
% Display the merged table
disp(merged_table);
plot_correlation_memory_arch(merged_table, arch, yfp, 'mean_RR'); % Change 'AUC_diff' to any other variable as needed

% AUC will be subtracting -40 to -5 from 5 to 40

%% continued - change table to graphpad format

    % Define the file path
    file_path = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\arch_yfp\yfp_auc_diff_post_table.csv';
    
    % Load the CSV file into a table
    data_table = readtable(file_path);
    
    % Convert SubjectID to strings for consistent comparison
    data_table.SubjectID = string(data_table.SubjectID);
    
    % List of columns to process
    data_columns = {'NE', 'RR', 'SO', 'Delta', 'Theta', 'Sigma', 'Beta', 'Gamma_low', 'Gamma_high'};
        
    % Define the output directory
    output_dir = fullfile('C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\arch_yfp\Copy_of_figure_3_data', 'AUC of Traces');
    
    % Create the directory if it doesn't exist
    if ~exist(output_dir, 'dir')
        mkdir(output_dir);
    end
    
    % Process each data column
    for i = 1:length(data_columns)
        column_name = data_columns{i};
        
        % Filter data for chr2 subjects
        chr2_data = data_table(ismember(data_table.SubjectID, yfp), :);
        
        % Initialize an empty table to store the results
        combined_table = table(chr2_data.SubjectID, 'VariableNames', {'SubjectID'});
        
        % Add the data across all laser levels
        combined_table = [combined_table, table(chr2_data.(column_name), 'VariableNames', {column_name})];
        
        % Loop over EventVar_num values (laser levels 1 to 5)
        for event_var_num = 1:5
            % Initialize a column with NaN values
            new_column = NaN(height(chr2_data), 1);
            
            % Fill the new column with the filtered data
            indices = (chr2_data.EventVar_num == event_var_num);
            new_column(indices) = chr2_data.(column_name)(indices);
            
            % Add the new column to the combined table
            combined_table = [combined_table, table(new_column, 'VariableNames', {sprintf('%s_LaserLevel_%d', column_name, event_var_num)})];
        end
        
        % Save the combined table to a CSV file
        output_file = fullfile(output_dir, sprintf('%s_combined_post_yfp.csv', column_name));
        writetable(combined_table, output_file);
    end

    %% Make a pre-post table
    % Define the pre and post file paths
pre_file_path = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\arch_yfp\arch_auc_diff_pre_table.csv';
post_file_path = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\arch_yfp\arch_auc_diff_post_table.csv';

% Load the CSV files into tables
pre_data_table = readtable(pre_file_path);
post_data_table = readtable(post_file_path);

% Convert SubjectID to strings for consistent comparison
pre_data_table.SubjectID = string(pre_data_table.SubjectID);
post_data_table.SubjectID = string(post_data_table.SubjectID);

% List of columns to process
data_columns = {'NE', 'RR', 'SO', 'Delta', 'Theta', 'Sigma', 'Beta', 'Gamma_low', 'Gamma_high'};

% Define the output directory
output_dir = fullfile('C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\arch_yfp\Copy_of_figure_3_data', 'AUC of Traces');

% Create the directory if it doesn't exist
if ~exist(output_dir, 'dir')
    mkdir(output_dir);
end

% Process each data column
for i = 1:length(data_columns)
    column_name = data_columns{i};
    
    % Load pre and post tables for each data type
    pre_table_path = fullfile(output_dir, sprintf('%s_combined_pre_yfp.csv', column_name));
    post_table_path = fullfile(output_dir, sprintf('%s_combined_post_yfp.csv', column_name));
    
    pre_table = readtable(pre_table_path);
    post_table = readtable(post_table_path);
    
    % Initialize the combined table with the SubjectID column
    combined_table = table(pre_table.SubjectID, 'VariableNames', {'SubjectID'});
    
    % Loop through each column in the pre and post tables (excluding SubjectID)
    for j = 2:width(pre_table)
        pre_column = pre_table{:, j};
        post_column = post_table{:, j};
        
        % Subtract post values from pre values
        difference_column = pre_column - post_column;
        
        % Add the difference column to the combined table
        combined_table = [combined_table, table(difference_column, 'VariableNames', {pre_table.Properties.VariableNames{j}})];
    end
    
    % Save the combined table to a CSV file
    output_file = fullfile(output_dir, sprintf('%s_combined_both_table_arch.csv', column_name));
    writetable(combined_table, output_file);
end


%% Create memory table
% Create the data
Suffix = {'387', '399', '392', '403', '412', '414', '416', '418', '486', '408', '420', '468', '477', '484', '015', '079', '089', '013', '019'};
%sigma_power_increase = [0.056842, 0.057477, 0.047644, 0.062896, 0.064325, 0.068995, 0.080907, 0.045944, 0.051554, 0.016309, 0.041683, 0.012267, 0.03086, 0.058014]';
novel_familiar_ratio = [1.12, 1.75, 1.384615, 1.15, 3, 1.5, 2.166667, 0.75, 1.666667, 0, 0.909091, 1.3, 0.272727, 1.444444, 1.5, 1, 2.5, 2.3333, 1.3333]';
Suffix = Suffix';
% Create the table
data_table = table(Suffix, novel_familiar_ratio);
%% Add AUC diff to memory table

% Update the data_table with AUC differences
data_table_update_AUC = update_table_with_auc_diff_arch(AUC_table, data_table);
data_table_update_amplitude = update_table_with_amplitude(RR_slope_table, data_table);

%% Correlation plot between RR AUC diff and memory
arch = {'387', '403', '412', '414', '416'};
yfp = {'408', '420', '468', '484'};

% Plot the correlation
plot_correlation_memory_arch(merged_table, arch, yfp, 'mean_RR'); % Change 'AUC_diff' to any other variable as needed
plot_correlation_memory(data_table_update_amplitude, arch, yfp, 'MeanAmplitude'); % Change 'AUC_diff' to any other variable as needed

%% Get figure 3 all animals
data_types = {'NE', 'RR', 'SO', 'Delta', 'Theta', 'Sigma', 'Beta', 'Gamma_low', 'Gamma_high', 'x_corr'};
titles = {'NREM'};
main_title_arch = ('Averaged Activity During LC Supression');
main_title_yfp = ('Averaged Activity During non LC Supression');
% arch = {'387', '403', '412', '414', '416'};
% yfp = {'408', '420', '468', '484'};
event_var = {'laser_on_NREM'};
epoc_start = 60;
epoc_end = 60; 
saveDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\arch_yfp\arch_figure';

results_arch = aggregate_event_data(saveDirectory, event_var, arch, data_types);
[global_max_arch, global_min_arch] = compute_global_extremes(results_arch, data_types);
figure_2_cross_animals(results_arch, global_max_arch, global_min_arch, 60, 60, main_title_arch, titles)

results_yfp = aggregate_event_data(saveDirectory, event_var, yfp, data_types);
[global_max_yfp, global_min_yfp] = compute_global_extremes(results_yfp, data_types);
figure_2_cross_animals(results_yfp, global_max_yfp, global_min_yfp, 60, 60, main_title_yfp, titles)
%% Get RR for 0 and 20 sec from figure 3
% Define the suffixes for subjects
suffixes = {'387', '403', '412', '414', '416', '408', '420', '468', '484'};

% Define the end of the epoch in seconds
epoch_end = 60;

% Define the directory where the RR_collector files are saved
saveDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\arch_yfp\figure_3_data';

% Call the function to extract RR intervals and create the table
RR_table = extract_RR_intervals(suffixes, epoch_end, saveDirectory);

% Define the suffixes for subjects
suffixes = {'387', '403', '412', '414', '416', '408', '420', '468', '484'};
arch = {'387', '403', '412', '414', '416'};
yfp = {'408', '420', '468', '484'};

% Define the event variables and labels
event_var_onset = 'RR_laser_onset';
event_var_during = 'RR_during_laser';
y_lab = 'RR Values';
main_title = 'RR Values Distribution by Group at laser onset and 20 seconds after';

% Call the function to plot the violin plots
%plot_RR_violins(RR_table, arch, yfp, event_var_onset, event_var_during, y_lab, main_title);

% Call the function to plot the bar plot with SEM error bars
plot_RR_bar(RR_table, arch, yfp, event_var_onset, event_var_during, y_lab, main_title);


%% Get AUC for time 0 to 20 for RR
o = {'387', '403', '412', '414', '416', '420', '468', '484', '408','079', '089', '013', '019' };
%'079', '089', '013', '019' , '408'
event_var = {'laser_on_NREM'};
epoc_start = 60;
epoc_end = 60;
saveDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\arch_yfp\Copy_of_figure_3_data';

yfp = {'408', '420', '484', '468', '015', '079', '089'};
arch = {'387', '403', '412', '414', '416', '013', '019'};

% Assuming AUC_table is already created from the previous steps
y_lab = 'AUC';
y_lab_diff = 'AUC Difference';
main_title = 'AUC Distribution by Group 20 sec before and after laser onset';
main_title_diff = 'Difference in AUC Distribution by Group 20 sec before and after laser onset';

AUC_table = extract_AUC_RR_intervals(o, epoc_end, saveDirectory);
% Call the function to plot the bar plot with SEM error bars
plot_AUC_bar_fig3(AUC_table, arch, yfp, y_lab, main_title);
plot_AUC_bar_fig3_diff(AUC_table, arch, yfp, y_lab_diff, main_title_diff)

%plot_HRB_arch_yfp_violins(AUC_table, arch, yfp, 'AUC', 'AUC for RR', 'AUC for RR from laser onset to 30 seconds after')
% Call the function to plot the violins
%plot_AUC_violins(AUC_table, arch, yfp, y_lab, main_title);
%% Get Amplitude for time 0 to 20 for RR
o = {'387', '403', '412', '414', '416', '408', '420', '468', '484'};
arch = {'387', '403', '412', '414', '416'};
yfp = {'408', '420', '468', '484'};

event_var = {'laser_on_NREM'};
titles = {'Laser on NREM'};
saveDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\arch_yfp\figure_3_data';
outputDirectory = fullfile(saveDirectory, 'AUC');

% Define the times_matrix
times_matrix.RR.min_range = [-20 0];
times_matrix.RR.max_range = [0 20];

RR_slope_table = extract_amplitude_fig_3(o, event_var, saveDirectory, times_matrix, arch, yfp);
mean_amplitude_table = calculate_mean_amplitude_fig3(RR_slope_table);
plot_mean_amplitude_bar_fig3(RR_slope_table, 'RR Amplitude', 'Bar plot of RR Amplitude')
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
Suffix = {'408', '420', '484', '468', '015' '079', '089', '387', '412', '414', '416', '013', '019'};

RR_data_NREM_table = process_NREM_with_laser(Suffix);
NE_data_NREM_table = process_NREM_with_laser_NE(Suffix);

%% RR PSD plot
yfp = {'408', '420', '484', '468', '015' '079', '089'};
arch = {'387', '412', '414', '416', '013', '019'};
psd_table = plot_PSD_with_laser(RR_data_NREM_table, arch, yfp, 60);
[psd_table_NE, AUC_table_NE, PeakFrequency_table_NE, PeakPower_table_NE]= plot_PSD_with_laser_NE(NE_data_NREM_table, arch, yfp, 60);
[psd_table_RR, AUC_table_RR, PeakFrequency_table_RR, PeakPower_table_RR]= plot_PSD_with_laser_RR(RR_data_NREM_table, arch, yfp, 60);

[psd_table, AUC_table, PeakFrequency_table, PeakPower_table] = plot_PSD_with_laser_combined(NE_data_NREM_table, RR_data_NREM_table, arch, yfp, 60, 60);

writetable(psd_table, 'PSD_traces.csv')
writetable(psd_table_RR, 'PSD_traces_RR.csv')

    %% Export peak frquency to graphpad format
% Define the unique event options
event_options = {'Arch_on', 'Arch_off', 'Yfp_on', 'Yfp_off'};

% Initialize the combined table with PeakFrequency for NE and RR as the first columns
combined_table_graphpad_peak = table(PeakFrequency_table.PeakFrequency_NE, PeakFrequency_table.PeakFrequency_RR, ...
    'VariableNames', {'peakfre_NE', 'peakfre_RR'});

% Loop over the event options for Peak Frequency NE
for i = 1:length(event_options)
    event = event_options{i};

    % Initialize the column for the current event option with NaN
    peakfre_NE_column = NaN(height(PeakFrequency_table), 1);

    % Find the indices for the current event option
    indices = strcmp(PeakFrequency_table.EventVar, event);

    % Assign the PeakFrequency values to the corresponding event option
    peakfre_NE_column(indices) = PeakFrequency_table.PeakFrequency_NE(indices);

    % Add the column to the combined table with the appropriate name
    combined_table_graphpad_peak = [combined_table_graphpad_peak, ...
        table(peakfre_NE_column, 'VariableNames', {['peakfre_NE_' event]})];
end

% Loop over the event options for Peak Frequency RR
for i = 1:length(event_options)
    event = event_options{i};

    % Initialize the column for the current event option with NaN
    peakfre_RR_column = NaN(height(PeakFrequency_table), 1);

    % Find the indices for the current event option
    indices = strcmp(PeakFrequency_table.EventVar, event);

    % Assign the PeakFrequency values to the corresponding event option
    peakfre_RR_column(indices) = PeakFrequency_table.PeakFrequency_RR(indices);

    % Add the column to the combined table with the appropriate name
    combined_table_graphpad_peak = [combined_table_graphpad_peak, ...
        table(peakfre_RR_column, 'VariableNames', {['peakfre_RR_' event]})];
end

% Write the combined table to a CSV file
 writetable(combined_table_graphpad_peak, 'peakfreq_NE_RR_PSD.csv');

%% For AUC Table
% Initialize the combined table with AUC for NE and RR as the first columns
combined_table_graphpad_AUC = table(AUC_table.AUC_NE, AUC_table.AUC_RR, ...
    'VariableNames', {'AUC_NE', 'AUC_RR'});

% Loop over the event options for AUC NE
for i = 1:length(event_options)
    event = event_options{i};

    % Initialize the column for the current event option with NaN
    AUC_NE_column = NaN(height(AUC_table), 1);

    % Find the indices for the current event option
    indices = strcmp(AUC_table.EventVar, event);

    % Assign the AUC values to the corresponding event option
    AUC_NE_column(indices) = AUC_table.AUC_NE(indices);

    % Add the column to the combined table with the appropriate name
    combined_table_graphpad_AUC = [combined_table_graphpad_AUC, ...
        table(AUC_NE_column, 'VariableNames', {['AUC_NE_' event]})];
end

% Loop over the event options for AUC RR
for i = 1:length(event_options)
    event = event_options{i};

    % Initialize the column for the current event option with NaN
    AUC_RR_column = NaN(height(AUC_table), 1);

    % Find the indices for the current event option
    indices = strcmp(AUC_table.EventVar, event);

    % Assign the AUC values to the corresponding event option
    AUC_RR_column(indices) = AUC_table.AUC_RR(indices);

    % Add the column to the combined table with the appropriate name
    combined_table_graphpad_AUC = [combined_table_graphpad_AUC, ...
        table(AUC_RR_column, 'VariableNames', {['AUC_RR_' event]})];
end

% Write the combined table to a CSV file
writetable(combined_table_graphpad_AUC, 'AUC_NE_RR_PSD.csv');

%% For Peak Power Table
% Initialize the combined table with PeakPower for NE and RR as the first columns
combined_table_graphpad_power = table(PeakPower_table.PeakPower_NE, PeakPower_table.PeakPower_RR, ...
    'VariableNames', {'PeakPower_NE', 'PeakPower_RR'});

% Loop over the event options for Peak Power NE
for i = 1:length(event_options)
    event = event_options{i};

    % Initialize the column for the current event option with NaN
    PeakPower_NE_column = NaN(height(PeakPower_table), 1);

    % Find the indices for the current event option
    indices = strcmp(PeakPower_table.EventVar, event);

    % Assign the PeakPower values to the corresponding event option
    PeakPower_NE_column(indices) = PeakPower_table.PeakPower_NE(indices);

    % Add the column to the combined table with the appropriate name
    combined_table_graphpad_power = [combined_table_graphpad_power, ...
        table(PeakPower_NE_column, 'VariableNames', {['PeakPower_NE_' event]})];
end

% Loop over the event options for Peak Power RR
for i = 1:length(event_options)
    event = event_options{i};

    % Initialize the column for the current event option with NaN
    PeakPower_RR_column = NaN(height(PeakPower_table), 1);

    % Find the indices for the current event option
    indices = strcmp(PeakPower_table.EventVar, event);

    % Assign the PeakPower values to the corresponding event option
    PeakPower_RR_column(indices) = PeakPower_table.PeakPower_RR(indices);

    % Add the column to the combined table with the appropriate name
    combined_table_graphpad_power = [combined_table_graphpad_power, ...
        table(PeakPower_RR_column, 'VariableNames', {['PeakPower_RR_' event]})];
end

% Write the combined table to a CSV file
writetable(combined_table_graphpad_power, 'PeakPower_NE_RR_PSD.csv');

%% HRB Generation
suffixes = {'387', '403', '412', '414', '416', '408', '420'}; % Add more suffixes as needed
find_plot_HRB(suffixes);

%% Plot HRB values
HRB_table = create_HRB_table(suffixes);
plot_HRB_rate_violins(HRB_table, arch, yfp, 'HRB_Value', 'Time between R peaks for HRB events', 'HRB Value Distribution by Group and Laser Status');
plot_HRB_arch_yfp_violins(HRB_table, arch, yfp, 'HRB_Value', 'Time between R peaks for HRB events', 'HRB Value Distribution by Group and Laser Status')
%% Plot HRB Rate
NREMinclMA_HRB_table = create_NREMinclMA_HRB_table(suffixes);
plot_HRB_rate_violins(NREMinclMA_HRB_table, arch, yfp, 'HRB_Rate', 'HRB Rate (event pr. minute)', 'HRB Rate Distribution by Group and Laser Status');
plot_HRB_arch_yfp_violins(NREMinclMA_HRB_table, arch, yfp, 'HRB_Rate', 'HRB Rate (event pr. minute)', 'HRB Rate Distribution by Group and Laser Status');

%% PSD with the chr2 approach
yfp = {'408', '420', '484', '468', '015' '079', '089'};
arch = {'387', '412', '414', '416', '013', '019'};

[PXX_NE_arch, PXX_NE_yfp, f_NE, resultTable_NE_PSD] = PSD_arch_NE_eventbased(arch, yfp);
[PXX_RR_chr2, PXX_RR_yfp, f_RR, resultTable_RR_PSD] = PSD_RR_eventbased(arch, yfp);
