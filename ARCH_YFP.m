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
yfp = { '420', '484', '468', '408'};
arch = {'387', '412', '414', '416'};

% List of 3-digit elements to look for in file names
suffixes = {'387', '484', '412', '414', '416', '408', '420', '468'};
% suffixes = {'468', '484'};

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
suffixes =  {'387', '484', '412', '414', '416', '408', '420', '468'};

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
% [mean_spectrogram_403, time_spectrogram_zero_403, F_403, band_powers_403, EEG_bands_fs_403] = PowerAnalysisEEG(EEG_403, EEG_fs_403, frw, window_in_sec, power_bands);
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

%% HRB

[HRB_420, HRB_time_420] = findHRB_all(RR_time_420, RR_420);
[HRB_387, HRB_time_387] = findHRB_all(RR_time_387, RR_387);
[HRB_412, HRB_time_412] = findHRB_all(RR_time_412, RR_412);
[HRB_414, HRB_time_414] = findHRB_all(RR_time_414, RR_414);
[HRB_416, HRB_time_416] = findHRB_all(RR_time_416, RR_416);
[HRB_408, HRB_time_408] = findHRB_all(RR_time_408, RR_408);
[HRB_484, HRB_time_484] = findHRB_all(RR_time_484, RR_484);
[HRB_468, HRB_time_468] = findHRB_all(RR_time_468, RR_468);


%% Get HRB based sigma/NE across laser on/off

% Parameters
preTime = 30;           % seconds before the HRB event to include
postTime = 30;          % seconds after the HRB event to include
windowTime = preTime + postTime;  % total window length (60 sec)
transitionBuffer = 15;  % minimum seconds away from a state transition

% Fixed sampling frequencies (Hz)
fs_RR = 64;         
fs_sigma = 2;     
fs_delta465 = 1017;

% Expected number of samples (using floor to ensure an integer count)
expected_RR_length = 2 * floor(preTime * fs_RR) + 1;         % should be 3841
expected_sigma_length = 2 * floor(preTime * fs_sigma) + 1;     % should be 30721
expected_delta465_length = 2 * floor(preTime * fs_delta465) + 1; % should be 61021

% List of mouse IDs (stored as numbers)
suffix = [387, 484, 412, 414, 416, 408, 420, 468];

% Containers for event segments (each row is one event)
all_RR_segments = [];          
all_delta465_segments = [];    
all_sigma_segments = [];       

for idx = 1:length(suffix)
    uniqueId = num2str(suffix(idx));
    
    % Retrieve sleep state vectors (assumed sampled at 1 Hz)
    wake_woMA_binary_vector = eval(sprintf('wake_woMA_binary_vector_%s', uniqueId));
    sws_binary_vector         = eval(sprintf('sws_binary_vector_%s', uniqueId));
    MA_binary_vector          = eval(sprintf('MA_binary_vector_%s', uniqueId));
    REM_binary_vector         = eval(sprintf('REM_binary_vector_%s', uniqueId));
    
    % Combine SWS and MA as valid sleep states
    %validSleep = sws_binary_vector;
    validSleep = sws_binary_vector | MA_binary_vector;
    sleep_time = 0:length(validSleep)-1;  % time axis for sleep states
    
    % HRB event times (in seconds)
    HRB_time = eval(sprintf('HRB_time_%s', uniqueId));
    HRB_time = HRB_time';  % ensure column vector
    
    % Retrieve signals and their time vectors
    RR = eval(sprintf('RR_%s', uniqueId));         % RR signal (fs_RR)
    RR_time = eval(sprintf('RR_time_%s', uniqueId));  % RR time vector
    
    delta465 = eval(sprintf('delta465_filt_2_%s', uniqueId));
    sec_signal_2 = eval(sprintf('sec_signal_2_%s', uniqueId));  % time vector for delta465
    
    band_powers = eval(sprintf('band_powers_%s', uniqueId));
    sigma_power = band_powers{4};
    time_spectrogram_zero = eval(sprintf('time_spectrogram_zero_%s', uniqueId));  % time vector for sigma
    
    fprintf('Processing mouse %s with %d HRB events...\n', uniqueId, length(HRB_time));
    
    for event_i = 1:length(HRB_time)
        eventTime = HRB_time(event_i);
        
        % Skip if the desired window (eventTime +/- preTime) lies outside sleep time
        if (eventTime - preTime) < sleep_time(1) || (eventTime + postTime) > sleep_time(end)
            fprintf('Mouse %s, event %d: skipped (window out of bounds).\n', uniqueId, event_i);
            continue;
        end
        
        % Check that the event occurs during valid sleep
        eventIdx_sleep = round(eventTime) + 1;  % since sleep_time starts at 0 sec
        if ~validSleep(eventIdx_sleep)
            fprintf('Mouse %s, event %d: skipped (not in valid sleep state).\n', uniqueId, event_i);
            continue;
        end
        
        % Check the contiguous valid sleep block to ensure the event is not near a transition
        blockStart = eventIdx_sleep;
        while blockStart > 1 && validSleep(blockStart-1)
            blockStart = blockStart - 1;
        end
        blockEnd = eventIdx_sleep;
        while blockEnd < length(validSleep) && validSleep(blockEnd+1)
            blockEnd = blockEnd + 1;
        end
        if (eventTime - (blockStart-1) < transitionBuffer) || ((blockEnd-1) - eventTime < transitionBuffer)
            fprintf('Mouse %s, event %d: skipped (too close to state transition).\n', uniqueId, event_i);
            continue;
        end
        
        % --- Extract RR data (fs_RR) ---
        [~, idx_RR] = min(abs(RR_time - eventTime));
        if (idx_RR - floor(preTime*fs_RR) < 1) || (idx_RR + floor(preTime*fs_RR) > length(RR_time))
            fprintf('Mouse %s, event %d: skipped (RR window out of bounds).\n', uniqueId, event_i);
            continue;
        end
        rr_segment = RR(idx_RR - floor(preTime*fs_RR) : idx_RR + floor(preTime*fs_RR));
        if length(rr_segment) ~= expected_RR_length
            fprintf('Mouse %s, event %d: skipped (RR segment length %d, expected %d).\n',...
                    uniqueId, event_i, length(rr_segment), expected_RR_length);
            continue;
        end
        fprintf('Mouse %s, event %d: RR segment length = %d.\n', uniqueId, event_i, length(rr_segment));
        
        % --- Extract delta465 data (fs_delta465) ---
        [~, idx_delta] = min(abs(sec_signal_2 - eventTime));
        if (idx_delta - floor(preTime*fs_delta465) < 1) || (idx_delta + floor(preTime*fs_delta465) > length(sec_signal_2))
            fprintf('Mouse %s, event %d: skipped (delta465 window out of bounds).\n', uniqueId, event_i);
            continue;
        end
        delta_segment = delta465(idx_delta - floor(preTime*fs_delta465) : idx_delta + floor(preTime*fs_delta465));
        if length(delta_segment) ~= expected_delta465_length
            fprintf('Mouse %s, event %d: skipped (delta465 segment length %d, expected %d).\n',...
                    uniqueId, event_i, length(delta_segment), expected_delta465_length);
            continue;
        end
        fprintf('Mouse %s, event %d: delta465 segment length = %d.\n', uniqueId, event_i, length(delta_segment));
        
        % --- Extract sigma data (fs_sigma) ---
        [~, idx_sigma] = min(abs(time_spectrogram_zero - eventTime));
        if (idx_sigma - floor(preTime*fs_sigma) < 1) || (idx_sigma + floor(preTime*fs_sigma) > length(time_spectrogram_zero))
            fprintf('Mouse %s, event %d: skipped (sigma window out of bounds).\n', uniqueId, event_i);
            continue;
        end
        sigma_segment = sigma_power(idx_sigma - floor(preTime*fs_sigma) : idx_sigma + floor(preTime*fs_sigma));
        if length(sigma_segment) ~= expected_sigma_length
            fprintf('Mouse %s, event %d: skipped (sigma segment length %d, expected %d).\n',...
                    uniqueId, event_i, length(sigma_segment), expected_sigma_length);
            continue;
        end
        fprintf('Mouse %s, event %d: sigma segment length = %d.\n', uniqueId, event_i, length(sigma_segment));
        
        % Append the segments (each as a row) to overall matrices
        all_RR_segments = [all_RR_segments; rr_segment(:)'];
        all_delta465_segments = [all_delta465_segments; delta_segment(:)'];
        all_sigma_segments = [all_sigma_segments; sigma_segment(:)'];
        fprintf('After mouse %s, event %d: all_RR_segments size: %s\n', uniqueId, event_i, mat2str(size(all_RR_segments)));
    end
end

if isempty(all_RR_segments) || isempty(all_delta465_segments) || isempty(all_sigma_segments)
    error('No valid events found across mice. Check your event selection criteria.');
end

% Compute mean and SEM for each modality (across all events)
mean_RR = mean(all_RR_segments, 1);
sem_RR  = std(all_RR_segments, 0, 1) / sqrt(size(all_RR_segments, 1));
mean_delta465 = mean(all_delta465_segments, 1);
sem_delta465  = std(all_delta465_segments, 0, 1) / sqrt(size(all_delta465_segments, 1));
mean_sigma = mean(all_sigma_segments, 1);
sem_sigma  = std(all_sigma_segments, 0, 1) / sqrt(size(all_sigma_segments, 1));

% Define common time vectors for plotting (using the fixed expected lengths)
t_RR = linspace(-preTime, postTime, expected_RR_length);
t_delta465 = linspace(-preTime, postTime, expected_delta465_length);
t_sigma = linspace(-preTime, postTime, expected_sigma_length);

% --- New Code: EEG-derived sigma power histograms ---
% We will process each mouse’s EEG data to calculate the sigma band
% power (8–15 Hz) on a per-event basis.
all_sigma_EEG_bins = [];  % will accumulate binned sigma power for each event

% Define bin edges for 5-sec intervals over a [-30,30] sec window.
bin_edges = -30:5:30;
nBins = length(bin_edges)-1;

for idx = 1:length(suffix)
    uniqueId = num2str(suffix(idx));
    
    % Retrieve the EEG data, sampling rate, and time vector.
    EEG = eval(sprintf('EEG_%s', uniqueId));
    EEG_fs = eval(sprintf('EEG_fs_%s', uniqueId));  
    % Assume EEG_time exists; if not, generate it:
    if exist(sprintf('EEG_time_%s', uniqueId), 'var')
        EEG_time = eval(sprintf('EEG_time_%s', uniqueId));
    else
        EEG_time = (0:length(EEG)-1) / EEG_fs;
    end
    
    % Get the HRB event times for this mouse (in seconds)
    HRB_time = eval(sprintf('HRB_time_%s', uniqueId));
    HRB_time = HRB_time(:);  % ensure column vector
    
    for event_i = 1:length(HRB_time)
        eventTime = HRB_time(event_i);
        
        % Find the closest index in the EEG_time vector to the HRB event.
        [~, idx_EEG] = min(abs(EEG_time - eventTime));
        
        % Check boundaries: we need 30 sec before and after the event.
        if (idx_EEG - 30*EEG_fs < 1) || (idx_EEG + 30*EEG_fs > length(EEG))
            fprintf('Mouse %s, event %d: EEG segment out of bounds, skipped.\n', uniqueId, event_i);
            continue;
        end
        
        % Extract the EEG segment (60 sec total, centered on the HRB event)
        EEG_segment = EEG(idx_EEG - 30*EEG_fs : idx_EEG + 30*EEG_fs);
        
        % Run the power analysis on this segment.
        % We call PowerAnalysisEEG with only the sigma band defined.
        sigma_band_only = {[8,15]};  % only sigma band
        [~, T_EEG, ~, bp_event, ~] = PowerAnalysisEEG(EEG_segment, EEG_fs, frw, 5, sigma_band_only);
        sigma_event = bp_event{1};  % sigma power time series for this event
        
        % Shift the spectrogram time vector so that 0 is at the HRB event.
        % (EEG_segment is 60 sec long, so center = 30 sec)
        T_EEG_shifted = T_EEG - 30;
        
        % Bin the sigma power values into 5-sec intervals.
        bin_idx = discretize(T_EEG_shifted, bin_edges);
        event_bins = nan(1, nBins);
        for j = 1:nBins
            if any(bin_idx==j)
                event_bins(j) = mean(sigma_event(bin_idx == j));
            end
        end
        
        % Append this event's binned data (as a new row)
        all_sigma_EEG_bins = [all_sigma_EEG_bins; event_bins];
    end
end

% Compute the mean and standard error of the mean (SEM) across events for each bin.
mean_sigma_EEG_bins = nanmean(all_sigma_EEG_bins, 1);
sem_sigma_EEG_bins = nanstd(all_sigma_EEG_bins, 0, 1) / sqrt(size(all_sigma_EEG_bins, 1));

% Define bin centers for plotting.
bin_centers = (bin_edges(1:end-1) + bin_edges(2:end)) / 2;

% --- Existing plotting for RR, delta465, and sigma (from spectrogram) ---
figure;
subplot(4,1,1); hold on;
plot(t_RR, mean_RR, 'b', 'LineWidth', 2);
fill([t_RR, fliplr(t_RR)], [mean_RR+sem_RR, fliplr(mean_RR-sem_RR)], 'b', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
title('RR Trace'); xlabel('Time (s)'); ylabel('RR');

subplot(4,1,2); hold on;
plot(t_delta465, mean_delta465, 'r', 'LineWidth', 2);
fill([t_delta465, fliplr(t_delta465)], [mean_delta465+sem_delta465, fliplr(mean_delta465-sem_delta465)], 'r', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
title('Norepinephrine (delta465)'); xlabel('Time (s)'); ylabel('dF/F');

subplot(4,1,3); hold on;
plot(t_sigma, mean_sigma, 'g', 'LineWidth', 2);
fill([t_sigma, fliplr(t_sigma)], [mean_sigma+sem_sigma, fliplr(mean_sigma-sem_sigma)], 'g', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
title('Sigma Power (from spectrogram)'); xlabel('Time (s)'); ylabel('Power');

% Compute overall min/max from (mean - SEM) to (mean + SEM)
lowestVal = min(mean_sigma_EEG_bins - sem_sigma_EEG_bins);
highestVal = max(mean_sigma_EEG_bins + sem_sigma_EEG_bins);
rangeVal = highestVal - lowestVal;
margin = 0.1 * rangeVal;  % 10% margin

% Define new axis limits
lowestAxis = lowestVal - margin;
highestAxis = highestVal + margin;

subplot(4,1,4); hold on;
hBar = bar(bin_centers, mean_sigma_EEG_bins, 1, ...
    'FaceColor', [0.7, 0.7, 0.7], 'EdgeColor', 'none');

% Set the bar's BaseValue to the bottom of our new axis range
set(hBar, 'BaseValue', lowestAxis);

% Overlay error bars
errorbar(bin_centers, mean_sigma_EEG_bins, sem_sigma_EEG_bins, ...
    'k.', 'LineWidth', 1.5);

% Adjust the y-axis limits
ylim([lowestAxis, highestAxis]);
xlim([-preTime, postTime]);

title('Sigma Power (EEG) Histograms in 5-sec bins');
xlabel('Time (s) relative to HRB event');
ylabel('Sigma Power');

%% HRB and SO plot across laser on/off

% Parameters
preTime = 30;           % seconds before the HRB event to include
postTime = 30;          % seconds after the HRB event to include
windowTime = preTime + postTime;  % total window length (60 sec)
transitionBuffer = 15;  % minimum seconds away from a state transition

% Fixed sampling frequencies (Hz)
fs_RR = 64;         
fs_SO = 2;     
fs_delta465 = 1017;

% Expected number of samples (using floor to ensure an integer count)
expected_RR_length = 2 * floor(preTime * fs_RR) + 1;         % should be 3841
expected_SO_length = 2 * floor(preTime * fs_SO) + 1;     % should be 30721
expected_delta465_length = 2 * floor(preTime * fs_delta465) + 1; % should be 61021

% List of mouse IDs (stored as numbers)
suffix = [387, 484, 412, 414, 416, 408, 420, 468];

% Containers for event segments (each row is one event)
all_RR_segments = [];          
all_delta465_segments = [];    
all_SO_segments = [];       

for idx = 1:length(suffix)
    uniqueId = num2str(suffix(idx));
    
    % Retrieve sleep state vectors (assumed sampled at 1 Hz)
    wake_woMA_binary_vector = eval(sprintf('wake_woMA_binary_vector_%s', uniqueId));
    sws_binary_vector         = eval(sprintf('sws_binary_vector_%s', uniqueId));
    MA_binary_vector          = eval(sprintf('MA_binary_vector_%s', uniqueId));
    REM_binary_vector         = eval(sprintf('REM_binary_vector_%s', uniqueId));
    
    % Combine SWS and MA as valid sleep states
    %validSleep = sws_binary_vector;
    validSleep = sws_binary_vector | MA_binary_vector;
    sleep_time = 0:length(validSleep)-1;  % time axis for sleep states
    
    % HRB event times (in seconds)
    HRB_time = eval(sprintf('HRB_time_%s', uniqueId));
    HRB_time = HRB_time';  % ensure column vector
    
    % Retrieve signals and their time vectors
    RR = eval(sprintf('RR_%s', uniqueId));         % RR signal (fs_RR)
    RR_time = eval(sprintf('RR_time_%s', uniqueId));  % RR time vector
    
    delta465 = eval(sprintf('delta465_filt_2_%s', uniqueId));
    sec_signal_2 = eval(sprintf('sec_signal_2_%s', uniqueId));  % time vector for delta465
    
    band_powers = eval(sprintf('band_powers_%s', uniqueId));
    SO_power = band_powers{1};
    time_spectrogram_zero = eval(sprintf('time_spectrogram_zero_%s', uniqueId));  % time vector for SO
    
    fprintf('Processing mouse %s with %d HRB events...\n', uniqueId, length(HRB_time));
    
    for event_i = 1:length(HRB_time)
        eventTime = HRB_time(event_i);
        
        % Skip if the desired window (eventTime +/- preTime) lies outside sleep time
        if (eventTime - preTime) < sleep_time(1) || (eventTime + postTime) > sleep_time(end)
            fprintf('Mouse %s, event %d: skipped (window out of bounds).\n', uniqueId, event_i);
            continue;
        end
        
        % Check that the event occurs during valid sleep
        eventIdx_sleep = round(eventTime) + 1;  % since sleep_time starts at 0 sec
        if ~validSleep(eventIdx_sleep)
            fprintf('Mouse %s, event %d: skipped (not in valid sleep state).\n', uniqueId, event_i);
            continue;
        end
        
        % Check the contiguous valid sleep block to ensure the event is not near a transition
        blockStart = eventIdx_sleep;
        while blockStart > 1 && validSleep(blockStart-1)
            blockStart = blockStart - 1;
        end
        blockEnd = eventIdx_sleep;
        while blockEnd < length(validSleep) && validSleep(blockEnd+1)
            blockEnd = blockEnd + 1;
        end
        if (eventTime - (blockStart-1) < transitionBuffer) || ((blockEnd-1) - eventTime < transitionBuffer)
            fprintf('Mouse %s, event %d: skipped (too close to state transition).\n', uniqueId, event_i);
            continue;
        end
        
        % --- Extract RR data (fs_RR) ---
        [~, idx_RR] = min(abs(RR_time - eventTime));
        if (idx_RR - floor(preTime*fs_RR) < 1) || (idx_RR + floor(preTime*fs_RR) > length(RR_time))
            fprintf('Mouse %s, event %d: skipped (RR window out of bounds).\n', uniqueId, event_i);
            continue;
        end
        rr_segment = RR(idx_RR - floor(preTime*fs_RR) : idx_RR + floor(preTime*fs_RR));
        if length(rr_segment) ~= expected_RR_length
            fprintf('Mouse %s, event %d: skipped (RR segment length %d, expected %d).\n',...
                    uniqueId, event_i, length(rr_segment), expected_RR_length);
            continue;
        end
        fprintf('Mouse %s, event %d: RR segment length = %d.\n', uniqueId, event_i, length(rr_segment));
        
        % --- Extract delta465 data (fs_delta465) ---
        [~, idx_delta] = min(abs(sec_signal_2 - eventTime));
        if (idx_delta - floor(preTime*fs_delta465) < 1) || (idx_delta + floor(preTime*fs_delta465) > length(sec_signal_2))
            fprintf('Mouse %s, event %d: skipped (delta465 window out of bounds).\n', uniqueId, event_i);
            continue;
        end
        delta_segment = delta465(idx_delta - floor(preTime*fs_delta465) : idx_delta + floor(preTime*fs_delta465));
        if length(delta_segment) ~= expected_delta465_length
            fprintf('Mouse %s, event %d: skipped (delta465 segment length %d, expected %d).\n',...
                    uniqueId, event_i, length(delta_segment), expected_delta465_length);
            continue;
        end
        fprintf('Mouse %s, event %d: delta465 segment length = %d.\n', uniqueId, event_i, length(delta_segment));
        
        % --- Extract SO data (fs_SO) ---
        [~, idx_SO] = min(abs(time_spectrogram_zero - eventTime));
        if (idx_SO - floor(preTime*fs_SO) < 1) || (idx_SO + floor(preTime*fs_SO) > length(time_spectrogram_zero))
            fprintf('Mouse %s, event %d: skipped (SO window out of bounds).\n', uniqueId, event_i);
            continue;
        end
        SO_segment = SO_power(idx_SO - floor(preTime*fs_SO) : idx_SO + floor(preTime*fs_SO));
        if length(SO_segment) ~= expected_SO_length
            fprintf('Mouse %s, event %d: skipped (SO segment length %d, expected %d).\n',...
                    uniqueId, event_i, length(SO_segment), expected_SO_length);
            continue;
        end
        fprintf('Mouse %s, event %d: SO segment length = %d.\n', uniqueId, event_i, length(SO_segment));
        
        % Append the segments (each as a row) to overall matrices
        all_RR_segments = [all_RR_segments; rr_segment(:)'];
        all_delta465_segments = [all_delta465_segments; delta_segment(:)'];
        all_SO_segments = [all_SO_segments; SO_segment(:)'];
        fprintf('After mouse %s, event %d: all_RR_segments size: %s\n', uniqueId, event_i, mat2str(size(all_RR_segments)));
    end
end

if isempty(all_RR_segments) || isempty(all_delta465_segments) || isempty(all_SO_segments)
    error('No valid events found across mice. Check your event selection criteria.');
end

% Compute mean and SEM for each modality (across all events)
mean_RR = mean(all_RR_segments, 1);
sem_RR  = std(all_RR_segments, 0, 1) / sqrt(size(all_RR_segments, 1));
mean_delta465 = mean(all_delta465_segments, 1);
sem_delta465  = std(all_delta465_segments, 0, 1) / sqrt(size(all_delta465_segments, 1));
mean_SO = mean(all_SO_segments, 1);
sem_SO  = std(all_SO_segments, 0, 1) / sqrt(size(all_SO_segments, 1));

% Define common time vectors for plotting (using the fixed expected lengths)
t_RR = linspace(-preTime, postTime, expected_RR_length);
t_delta465 = linspace(-preTime, postTime, expected_delta465_length);
t_SO = linspace(-preTime, postTime, expected_SO_length);

% --- New Code: EEG-derived SO power histograms ---
% We will process each mouse’s EEG data to calculate the SO band
% power (8–15 Hz) on a per-event basis.
all_SO_EEG_bins = [];  % will accumulate binned SO power for each event

% Define bin edges for 5-sec intervals over a [-30,30] sec window.
bin_edges = -30:5:30;
nBins = length(bin_edges)-1;

for idx = 1:length(suffix)
    uniqueId = num2str(suffix(idx));
    
    % Retrieve the EEG data, sampling rate, and time vector.
    EEG = eval(sprintf('EEG_%s', uniqueId));
    EEG_fs = eval(sprintf('EEG_fs_%s', uniqueId));  
    % Assume EEG_time exists; if not, generate it:
    if exist(sprintf('EEG_time_%s', uniqueId), 'var')
        EEG_time = eval(sprintf('EEG_time_%s', uniqueId));
    else
        EEG_time = (0:length(EEG)-1) / EEG_fs;
    end
    
    % Get the HRB event times for this mouse (in seconds)
    HRB_time = eval(sprintf('HRB_time_%s', uniqueId));
    HRB_time = HRB_time(:);  % ensure column vector
    
    for event_i = 1:length(HRB_time)
        eventTime = HRB_time(event_i);
        
        % Find the closest index in the EEG_time vector to the HRB event.
        [~, idx_EEG] = min(abs(EEG_time - eventTime));
        
        % Check boundaries: we need 30 sec before and after the event.
        if (idx_EEG - 30*EEG_fs < 1) || (idx_EEG + 30*EEG_fs > length(EEG))
            fprintf('Mouse %s, event %d: EEG segment out of bounds, skipped.\n', uniqueId, event_i);
            continue;
        end
        
        % Extract the EEG segment (60 sec total, centered on the HRB event)
        EEG_segment = EEG(idx_EEG - 30*EEG_fs : idx_EEG + 30*EEG_fs);
        
        % Run the power analysis on this segment.
        % We call PowerAnalysisEEG with only the SO band defined.
        SO_band_only = {[0.5,1]};  % only SO band
        [~, T_EEG, ~, bp_event, ~] = PowerAnalysisEEG(EEG_segment, EEG_fs, frw, 5, SO_band_only);
        SO_event = bp_event{1};  % SO power time series for this event
        
        % Shift the spectrogram time vector so that 0 is at the HRB event.
        % (EEG_segment is 60 sec long, so center = 30 sec)
        T_EEG_shifted = T_EEG - 30;
        
        % Bin the SO power values into 5-sec intervals.
        bin_idx = discretize(T_EEG_shifted, bin_edges);
        event_bins = nan(1, nBins);
        for j = 1:nBins
            if any(bin_idx==j)
                event_bins(j) = mean(SO_event(bin_idx == j));
            end
        end
        
        % Append this event's binned data (as a new row)
        all_SO_EEG_bins = [all_SO_EEG_bins; event_bins];
    end
end

% Compute the mean and standard error of the mean (SEM) across events for each bin.
mean_SO_EEG_bins = nanmean(all_SO_EEG_bins, 1);
sem_SO_EEG_bins = nanstd(all_SO_EEG_bins, 0, 1) / sqrt(size(all_SO_EEG_bins, 1));

% Define bin centers for plotting.
bin_centers = (bin_edges(1:end-1) + bin_edges(2:end)) / 2;

% --- Existing plotting for RR, delta465, and SO (from spectrogram) ---
figure;
subplot(4,1,1); hold on;
plot(t_RR, mean_RR, 'b', 'LineWidth', 2);
fill([t_RR, fliplr(t_RR)], [mean_RR+sem_RR, fliplr(mean_RR-sem_RR)], 'b', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
title('RR Trace'); xlabel('Time (s)'); ylabel('RR');

subplot(4,1,2); hold on;
plot(t_delta465, mean_delta465, 'r', 'LineWidth', 2);
fill([t_delta465, fliplr(t_delta465)], [mean_delta465+sem_delta465, fliplr(mean_delta465-sem_delta465)], 'r', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
title('Norepinephrine (delta465)'); xlabel('Time (s)'); ylabel('dF/F');

subplot(4,1,3); hold on;
plot(t_SO, mean_SO, 'g', 'LineWidth', 2);
fill([t_SO, fliplr(t_SO)], [mean_SO+sem_SO, fliplr(mean_SO-sem_SO)], 'g', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
title('SO Power (from spectrogram)'); xlabel('Time (s)'); ylabel('Power');

% Compute overall min/max from (mean - SEM) to (mean + SEM)
lowestVal = min(mean_SO_EEG_bins - sem_SO_EEG_bins);
highestVal = max(mean_SO_EEG_bins + sem_SO_EEG_bins);
rangeVal = highestVal - lowestVal;
margin = 0.1 * rangeVal;  % 10% margin

% Define new axis limits
lowestAxis = lowestVal - margin;
highestAxis = highestVal + margin;

subplot(4,1,4); hold on;
hBar = bar(bin_centers, mean_SO_EEG_bins, 1, ...
    'FaceColor', [0.7, 0.7, 0.7], 'EdgeColor', 'none');

% Set the bar's BaseValue to the bottom of our new axis range
set(hBar, 'BaseValue', lowestAxis);

% Overlay error bars
errorbar(bin_centers, mean_SO_EEG_bins, sem_SO_EEG_bins, ...
    'k.', 'LineWidth', 1.5);

% Adjust the y-axis limits
ylim([lowestAxis, highestAxis]);
xlim([-preTime, postTime]);

title('SO Power (EEG) Histograms in 5-sec bins');
xlabel('Time (s) relative to HRB event');
ylabel('SO Power');
%% HRB centered events w. sigma power and bins summary file

% Parameters
preTime = 30;           % seconds before the HRB event to include
postTime = 30;          % seconds after the HRB event to include
windowTime = preTime + postTime;  % total window length (60 sec)
transitionBuffer = 15;  % minimum seconds away from a state transition

% Fixed sampling frequencies (Hz)
fs_RR = 64;         
fs_sigma = 2;     
fs_delta465 = 1017;

% Expected number of samples (using floor to ensure an integer count)
expected_RR_length = 2 * floor(preTime * fs_RR) + 1;         % should be 3841
expected_sigma_length = 2 * floor(preTime * fs_sigma) + 1;     % should be 30721
expected_delta465_length = 2 * floor(preTime * fs_delta465) + 1; % should be 61021

% Pre-compute common time vectors
t_RR = linspace(-preTime, postTime, expected_RR_length);
t_delta465 = linspace(-preTime, postTime, expected_delta465_length);
t_sigma = linspace(-preTime, postTime, expected_sigma_length);

% Define bin edges for 5-sec intervals over a [-30,30] sec window.
bin_edges = -30:5:30;
nBins = length(bin_edges)-1;

% List of mouse IDs (stored as numbers)
suffix = [387, 484, 412, 414, 416, 408, 420, 468];

% Containers for event segments (each row is one event)
% all_RR_segments = [];          
% all_delta465_segments = [];    
% all_sigma_segments = [];       

% --- New: Containers for the summary data table ---
summary_subject         = {};  % subject IDs (as strings)
summary_HRB_RR          = [];  % HRB RR value (center of RR segment)
summary_HRB_RR_AUC      = [];
summary_sigma_bin5      = [];  % EEG-derived sigma power from bin 5
summary_sigma_bin5_bl   = [];  % new: sigma_bin5 relative to baseline (bin 1)
summary_sigma_bin_4_5   = [];  % new: combination of bins 4 + 5
summary_sigma_bin_4_5_bl= [];  % new: bins 4+5 with baseline correction (subtract bin1)
summary_sigma_bin_5_6   = [];  % new: combination of bins 5 + 6
summary_sigma_bin_5_6_bl= [];  % new: bins 5+6 with baseline correction
summary_sigma_bin_4_5_6 = [];  % new: combination of bins 4 + 5 + 6
summary_sigma_bin_4_5_6_bl = [];  % new: combination of bins 4+5+6 with baseline correction
summary_delta465_amp    = [];  % Delta465 amplitude measure
summary_delta465_AUC    = [];
summary_sigma_amp       = [];  % sigma amplitude measure
summary_sigma_AUC       = [];

for idx = 1:length(suffix)
    uniqueId = num2str(suffix(idx));
    
    % Retrieve sleep state vectors (assumed sampled at 1 Hz)
    wake_woMA_binary_vector = eval(sprintf('wake_woMA_binary_vector_%s', uniqueId));
    sws_binary_vector         = eval(sprintf('sws_binary_vector_%s', uniqueId));
    MA_binary_vector          = eval(sprintf('MA_binary_vector_%s', uniqueId));
    REM_binary_vector         = eval(sprintf('REM_binary_vector_%s', uniqueId));
    
    % Combine SWS and MA as valid sleep states
    validSleep = sws_binary_vector | MA_binary_vector;
    sleep_time = 0:length(validSleep)-1;  % time axis for sleep states
    
    % HRB event times (in seconds)
    HRB_time = eval(sprintf('HRB_time_%s', uniqueId));
    HRB_time = HRB_time';  % ensure column vector
    
    % Retrieve signals and their time vectors
    RR = eval(sprintf('RR_%s', uniqueId));         % RR signal (fs_RR)
    RR_time = eval(sprintf('RR_time_%s', uniqueId));  % RR time vector
    
    delta465 = eval(sprintf('delta465_filt_2_%s', uniqueId));
    sec_signal_2 = eval(sprintf('sec_signal_2_%s', uniqueId));  % time vector for delta465
    
    band_powers = eval(sprintf('band_powers_%s', uniqueId));
    sigma_power = band_powers{4};
    time_spectrogram_zero = eval(sprintf('time_spectrogram_zero_%s', uniqueId));  % time vector for sigma
    
    fprintf('Processing mouse %s with %d HRB events...\n', uniqueId, length(HRB_time));
    
    for event_i = 1:length(HRB_time)
        eventTime = HRB_time(event_i);
        
        % Skip if the desired window (eventTime +/- preTime) lies outside sleep time
        if (eventTime - preTime) < sleep_time(1) || (eventTime + postTime) > sleep_time(end)
            fprintf('Mouse %s, event %d: skipped (window out of bounds).\n', uniqueId, event_i);
            continue;
        end
        
        % Check that the event occurs during valid sleep
        eventIdx_sleep = round(eventTime) + 1;  % since sleep_time starts at 0 sec
        if ~validSleep(eventIdx_sleep)
            fprintf('Mouse %s, event %d: skipped (not in valid sleep state).\n', uniqueId, event_i);
            continue;
        end
        
        % Check contiguous valid sleep block to ensure the event is not near a transition
        blockStart = eventIdx_sleep;
        while blockStart > 1 && validSleep(blockStart-1)
            blockStart = blockStart - 1;
        end
        blockEnd = eventIdx_sleep;
        while blockEnd < length(validSleep) && validSleep(blockEnd+1)
            blockEnd = blockEnd + 1;
        end
        if (eventTime - (blockStart-1) < transitionBuffer) || ((blockEnd-1) - eventTime < transitionBuffer)
            fprintf('Mouse %s, event %d: skipped (too close to state transition).\n', uniqueId, event_i);
            continue;
        end
        
        % --- Extract RR data (fs_RR) ---
        [~, idx_RR] = min(abs(RR_time - eventTime));
        if (idx_RR - floor(preTime*fs_RR) < 1) || (idx_RR + floor(preTime*fs_RR) > length(RR_time))
            fprintf('Mouse %s, event %d: skipped (RR window out of bounds).\n', uniqueId, event_i);
            continue;
        end
        rr_segment = RR(idx_RR - floor(preTime*fs_RR) : idx_RR + floor(preTime*fs_RR));
        if length(rr_segment) ~= expected_RR_length
            fprintf('Mouse %s, event %d: skipped (RR segment length %d, expected %d).\n',...
                    uniqueId, event_i, length(rr_segment), expected_RR_length);
            continue;
        end
        fprintf('Mouse %s, event %d: RR segment length = %d.\n', uniqueId, event_i, length(rr_segment));
        
        % --- Extract delta465 data (fs_delta465) ---
        [~, idx_delta] = min(abs(sec_signal_2 - eventTime));
        if (idx_delta - floor(preTime*fs_delta465) < 1) || (idx_delta + floor(preTime*fs_delta465) > length(sec_signal_2))
            fprintf('Mouse %s, event %d: skipped (delta465 window out of bounds).\n', uniqueId, event_i);
            continue;
        end
        delta_segment = delta465(idx_delta - floor(preTime*fs_delta465) : idx_delta + floor(preTime*fs_delta465));
        if length(delta_segment) ~= expected_delta465_length
            fprintf('Mouse %s, event %d: skipped (delta465 segment length %d, expected %d).\n',...
                    uniqueId, event_i, length(delta_segment), expected_delta465_length);
            continue;
        end
        fprintf('Mouse %s, event %d: delta465 segment length = %d.\n', uniqueId, event_i, length(delta_segment));
        
        % --- Extract sigma data (fs_sigma) ---
        [~, idx_sigma] = min(abs(time_spectrogram_zero - eventTime));
        if (idx_sigma - floor(preTime*fs_sigma) < 1) || (idx_sigma + floor(preTime*fs_sigma) > length(time_spectrogram_zero))
            fprintf('Mouse %s, event %d: skipped (sigma window out of bounds).\n', uniqueId, event_i);
            continue;
        end
        sigma_segment = sigma_power(idx_sigma - floor(preTime*fs_sigma) : idx_sigma + floor(preTime*fs_sigma));
        if length(sigma_segment) ~= expected_sigma_length
            fprintf('Mouse %s, event %d: skipped (sigma segment length %d, expected %d).\n',...
                    uniqueId, event_i, length(sigma_segment), expected_sigma_length);
            continue;
        end
        fprintf('Mouse %s, event %d: sigma segment length = %d.\n', uniqueId, event_i, length(sigma_segment));
        
        % % Append the segments (each as a row) to overall matrices
        % all_RR_segments = [all_RR_segments; rr_segment(:)'];
        % all_delta465_segments = [all_delta465_segments; delta_segment(:)'];
        % all_sigma_segments = [all_sigma_segments; sigma_segment(:)'];
        % fprintf('After mouse %s, event %d: all_RR_segments size: %s\n', uniqueId, event_i, mat2str(size(all_RR_segments)));
        
        % --- New: Compute Summary Metrics for this HRB event ---
        % 1. HRB RR value: value at the center of the RR segment
        baseline_idx = find(t_RR >= -10 & t_RR <= -5);
        baseline_mean = mean(rr_segment(baseline_idx));
        rr_value_at_event = rr_segment(floor(preTime*fs_RR) + 1) - baseline_mean;

        baseline_RR_idx_AUC = find(t_RR >= -10 & t_RR <= -5);
        event_RR_idx_AUC = find(t_RR >= -2.5 & t_RR <= 2.5);
        rr_AUC = trapz(rr_segment(event_RR_idx_AUC)) - trapz(rr_segment(baseline_RR_idx_AUC));
        
        % 2. Delta465 amplitude: max in [-10,10] sec minus min in [-20,0] sec.
        ind_delta_min = find(t_RR >= -20 & t_RR <= 0);
        ind_delta_range = find(t_RR >= -10 & t_RR <= 10);
        delta465_amp = max(delta_segment(ind_delta_range)) - min(delta_segment(ind_delta_min));


        ind_delta_AUC_bl = find(t_RR >= -15 & t_RR <= -10);
        ind_delta_AUC_peak = find(t_RR >= -2.5 & t_RR <= 2.5);
        delta465_AUC = trapz(delta_segment(ind_delta_AUC_peak)) - trapz(delta_segment(ind_delta_AUC_bl));

        % 3. EEG-derived sigma power for bin 5 using the same 5-sec segmentation:
        % Retrieve EEG data for the current subject
        EEG = eval(sprintf('EEG_%s', uniqueId));
        EEG_fs = eval(sprintf('EEG_fs_%s', uniqueId));
        if exist(sprintf('EEG_time_%s', uniqueId), 'var')
            EEG_time = eval(sprintf('EEG_time_%s', uniqueId));
        else
            EEG_time = (0:length(EEG)-1) / EEG_fs;
        end
        [~, idx_EEG] = min(abs(EEG_time - eventTime));
        if (idx_EEG - 30*EEG_fs < 1) || (idx_EEG + 30*EEG_fs > length(EEG))
            fprintf('Mouse %s, event %d: EEG segment out of bounds for summary, skipped.\n', uniqueId, event_i);
            continue;
        end
        EEG_segment = EEG(idx_EEG - 30*EEG_fs : idx_EEG + 30*EEG_fs);
        
        % Run the power analysis for the sigma band only (8–15 Hz) with 5-sec windows.
        sigma_band_only = {[8,15]};
        [~, T_EEG, ~, bp_event, ~] = PowerAnalysisEEG(EEG_segment, EEG_fs, frw, 5, sigma_band_only);
        sigma_event = bp_event{1};
        T_EEG_shifted = T_EEG - 30;
        
        % Bin the sigma power values into 5-sec intervals (same as later code)
        bin_idx = discretize(T_EEG_shifted, bin_edges);
        event_bins = nan(1, nBins);
        for j = 1:nBins
            if any(bin_idx == j)
                event_bins(j) = mean(sigma_event(bin_idx == j));
            end
        end
        % Extract sigma power from the 5th bin
        sigma_bin5 = event_bins(5);
        sigma_bin5_bl = event_bins(5) - event_bins(1);
        
        sigma_bin_4_5 = mean([event_bins(4), event_bins(5)]);
        sigma_bin_4_5_bl = sigma_bin_4_5 - event_bins(1);
        
        sigma_bin_5_6 = mean([event_bins(5), event_bins(6)]);
        sigma_bin_5_6_bl = sigma_bin_5_6 - event_bins(1);
        
        sigma_bin_4_5_6 = mean([event_bins(4), event_bins(5), event_bins(6)]);
        sigma_bin_4_5_6_bl = sigma_bin_4_5_6 - event_bins(1);
        
        % 4. Sigma amplitude measure: mean of sigma_segment from -10 to -5 minus
        %    the mean of sigma_segment from -2.5 to 2.5.
        %Now changed to min of the -2.5 to 2.5 substracted from max of -15
        %to 0
        ind_sigma_baseline = find(t_sigma >= -15 & t_sigma <= 0);
        ind_sigma_event = find(t_sigma >= -2.5 & t_sigma <= 2.5);
        sigma_amp =  min(sigma_segment(ind_sigma_event))- max(sigma_segment(ind_sigma_baseline));

        ind_sigma_baseline_AUC = find(t_sigma >= -10 & t_sigma <= -5);
        ind_sigma_event_AUC = find(t_sigma >= -2.5 & t_sigma <= 2.5);
        sigma_AUC =  trapz(sigma_segment(ind_sigma_event_AUC)) - trapz(sigma_segment(ind_sigma_baseline_AUC));       

        
        % Append summary metrics for this event
        summary_subject{end+1,1} = uniqueId;
        summary_HRB_RR(end+1,1) = rr_value_at_event;
        summary_HRB_RR_AUC(end+1,1) = rr_AUC;
        summary_sigma_bin5(end+1,1) = sigma_bin5;
        summary_sigma_bin5_bl(end+1,1) = sigma_bin5_bl;
        summary_sigma_bin_4_5(end+1,1) = sigma_bin_4_5;
        summary_sigma_bin_4_5_bl(end+1,1) = sigma_bin_4_5_bl;
        summary_sigma_bin_5_6(end+1,1) = sigma_bin_5_6;
        summary_sigma_bin_5_6_bl(end+1,1) = sigma_bin_5_6_bl;
        summary_sigma_bin_4_5_6(end+1,1) = sigma_bin_4_5_6;
        summary_sigma_bin_4_5_6_bl(end+1,1) = sigma_bin_4_5_6_bl;
        summary_delta465_amp(end+1,1) = delta465_amp;
        summary_delta465_AUC(end+1,1) = delta465_AUC;
        summary_sigma_amp(end+1,1) = sigma_amp;
        summary_sigma_AUC(end+1,1) = sigma_AUC;

    end
end

% --- Create the Summary Data Table ---
summaryTable = table( summary_subject, ...
    summary_HRB_RR, summary_HRB_RR_AUC, ...
    summary_sigma_bin5, summary_sigma_bin5_bl, ...
    summary_sigma_bin_4_5, summary_sigma_bin_4_5_bl, ...
    summary_sigma_bin_5_6, summary_sigma_bin_5_6_bl, ...
    summary_sigma_bin_4_5_6, summary_sigma_bin_4_5_6_bl, ...
    summary_delta465_amp, summary_delta465_AUC, ...
    summary_sigma_amp, summary_sigma_AUC, ...
    'VariableNames', {'SubjectID','HRB_RR', 'HRB_RR_AUC', ...
    'SigmaBin5','SigmaBin5_BL', 'SigmaBin_4_5', 'SigmaBin_4_5_BL', ...
    'SigmaBin_5_6', 'SigmaBin_5_6_BL', 'SigmaBin_4_5_6', 'SigmaBin_4_5_6_BL', ...
    'Delta465Amplitude', 'Delta465AUC', 'SigmaAmplitude', 'SigmaAUC'});

% if isempty(all_RR_segments) || isempty(all_delta465_segments) || isempty(all_sigma_segments)
%     error('No valid events found across mice. Check your event selection criteria.');
% end

% % Compute mean and SEM for each modality (across all events)
% mean_RR = mean(all_RR_segments, 1);
% sem_RR  = std(all_RR_segments, 0, 1) / sqrt(size(all_RR_segments, 1));
% mean_delta465 = mean(all_delta465_segments, 1);
% sem_delta465  = std(all_delta465_segments, 0, 1) / sqrt(size(all_delta465_segments, 1));
% mean_sigma = mean(all_sigma_segments, 1);
% sem_sigma  = std(all_sigma_segments, 0, 1) / sqrt(size(all_sigma_segments, 1));


% disp('Summary Table:');
% disp(summaryTable);

% % --- Existing EEG-derived sigma power histograms ---
% all_sigma_EEG_bins = [];  % will accumulate binned sigma power for each event
% 
% for idx = 1:length(suffix)
%     uniqueId = num2str(suffix(idx));
% 
%     % Retrieve EEG data, sampling rate, and time vector.
%     EEG = eval(sprintf('EEG_%s', uniqueId));
%     EEG_fs = eval(sprintf('EEG_fs_%s', uniqueId));  
%     if exist(sprintf('EEG_time_%s', uniqueId), 'var')
%         EEG_time = eval(sprintf('EEG_time_%s', uniqueId));
%     else
%         EEG_time = (0:length(EEG)-1) / EEG_fs;
%     end
% 
%     % Get HRB event times for this mouse (in seconds)
%     HRB_time = eval(sprintf('HRB_time_%s', uniqueId));
%     HRB_time = HRB_time(:);  % ensure column vector
% 
%     for event_i = 1:length(HRB_time)
%         eventTime = HRB_time(event_i);
% 
%         % Find the closest index in the EEG_time vector to the HRB event.
%         [~, idx_EEG] = min(abs(EEG_time - eventTime));
% 
%         % Check boundaries: need 30 sec before and after the event.
%         if (idx_EEG - 30*EEG_fs < 1) || (idx_EEG + 30*EEG_fs > length(EEG))
%             fprintf('Mouse %s, event %d: EEG segment out of bounds, skipped.\n', uniqueId, event_i);
%             continue;
%         end
% 
%         % Extract the EEG segment (60 sec total, centered on the HRB event)
%         EEG_segment = EEG(idx_EEG - 30*EEG_fs : idx_EEG + 30*EEG_fs);
% 
%         % Run the power analysis on this segment (sigma band only, 8–15 Hz)
%         sigma_band_only = {[8,15]};
%         [~, T_EEG, ~, bp_event, ~] = PowerAnalysisEEG(EEG_segment, EEG_fs, frw, 5, sigma_band_only);
%         sigma_event = bp_event{1};
% 
%         % Shift the spectrogram time vector so that 0 is at the HRB event.
%         T_EEG_shifted = T_EEG - 30;
% 
%         % Bin the sigma power values into 5-sec intervals.
%         bin_idx = discretize(T_EEG_shifted, bin_edges);
%         event_bins = nan(1, nBins);
%         for j = 1:nBins
%             if any(bin_idx == j)
%                 event_bins(j) = mean(sigma_event(bin_idx == j));
%             end
%         end
% 
%         % Append this event's binned data (as a new row)
%         all_sigma_EEG_bins = [all_sigma_EEG_bins; event_bins];
%     end
% end
% 
% % Compute the mean and SEM across events for each bin.
% mean_sigma_EEG_bins = nanmean(all_sigma_EEG_bins, 1);
% sem_sigma_EEG_bins = nanstd(all_sigma_EEG_bins, 0, 1) / sqrt(size(all_sigma_EEG_bins, 1));
% 
% % Define bin centers for plotting.
% bin_centers = (bin_edges(1:end-1) + bin_edges(2:end)) / 2;

% % --- Plotting ---
% figure;
% subplot(4,1,1); hold on;
% plot(t_RR, mean_RR, 'b', 'LineWidth', 2);
% fill([t_RR, fliplr(t_RR)], [mean_RR+sem_RR, fliplr(mean_RR-sem_RR)], 'b', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
% title('RR Trace'); xlabel('Time (s)'); ylabel('RR');
% 
% subplot(4,1,2); hold on;
% plot(t_delta465, mean_delta465, 'r', 'LineWidth', 2);
% fill([t_delta465, fliplr(t_delta465)], [mean_delta465+sem_delta465, fliplr(mean_delta465-sem_delta465)], 'r', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
% title('Norepinephrine (delta465)'); xlabel('Time (s)'); ylabel('dF/F');
% 
% subplot(4,1,3); hold on;
% plot(t_sigma, mean_sigma, 'g', 'LineWidth', 2);
% fill([t_sigma, fliplr(t_sigma)], [mean_sigma+sem_sigma, fliplr(mean_sigma-sem_sigma)], 'g', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
% title('Sigma Power (from spectrogram)'); xlabel('Time (s)'); ylabel('Power');
% 
% % Compute overall min/max from (mean - SEM) to (mean + SEM)
% lowestVal = min(mean_sigma_EEG_bins - sem_sigma_EEG_bins);
% highestVal = max(mean_sigma_EEG_bins + sem_sigma_EEG_bins);
% rangeVal = highestVal - lowestVal;
% margin = 0.1 * rangeVal;  % 10% margin
% 
% % Define new axis limits
% lowestAxis = lowestVal - margin;
% highestAxis = highestVal + margin;
% 
% subplot(4,1,4); hold on;
% hBar = bar(bin_centers, mean_sigma_EEG_bins, 1, 'FaceColor', [0.7, 0.7, 0.7], 'EdgeColor', 'none');
% set(hBar, 'BaseValue', lowestAxis);
% errorbar(bin_centers, mean_sigma_EEG_bins, sem_sigma_EEG_bins, 'k.', 'LineWidth', 1.5);
% ylim([lowestAxis, highestAxis]);
% xlim([-preTime, postTime]);
% title('Sigma Power (EEG) Histograms in 5-sec bins');
% xlabel('Time (s) relative to HRB event');
% ylabel('Sigma Power');
%% save summary table for R + coor plot

% Save summary table to a CSV file
filename = 'Mouse_HRB_amplitude_R_data.csv';
%writetable(summaryTable, filename);
disp(['Summary table saved to ', filename]);

% Read the summary table from a CSV file (if not already in memory)
summaryTable = readtable('summaryTable.csv');

% Create a scatter plot of HRB RR vs. Delta465 Amplitude
figure;
scatter(summaryTable.HRB_RR, summaryTable.SigmaAmplitude, 'filled');
xlabel('HRB RR Value');
ylabel('Delta465 Amplitude');
title('Correlation between HRB RR and Delta465 Amplitude');
grid on;
hold on;

% Compute a linear regression fit
p = polyfit(summaryTable.HRB_RR, summaryTable.SigmaAmplitude, 1);
x_fit = linspace(min(summaryTable.HRB_RR), max(summaryTable.HRB_RR), 100);
y_fit = polyval(p, x_fit);
plot(x_fit, y_fit, 'r-', 'LineWidth', 2);
legend('Data', 'Linear Fit');

% Compute the correlation coefficient and display it on the plot
R = corrcoef(summaryTable.HRB_RR, summaryTable.SigmaAmplitude);
text(0.1, 0.9, sprintf('r = %.2f', R(1,2)), 'Units', 'normalized', ...
    'FontSize', 12, 'Color', 'red');
fprintf('Correlation coefficient: %.2f\n', R(1,2));



%% (Optional) Save the resulting table for later use
% Uncomment the following line to save the table as a .mat file
% save(fullfile(dataDir, 'processedData.mat'), 'allData');


%% convert for prism export

mean_RR = mean_RR';
sem_RR  = sem_RR';
mean_delta465 = mean_delta465';
sem_delta465  = sem_delta465';

mean_delta465_ds = mean_delta465(1:10:end);
sem_delta465_ds = sem_delta465(1:10:end);

mean_sigma = mean_sigma';
sem_sigma  = sem_sigma';

% Define common time vectors for plotting (using the fixed expected lengths)
t_RR = t_RR';
t_delta465 = t_delta465';
t_delta465_ds = t_delta465(1:10:end);

t_sigma = t_sigma';

%% HUMAN: Make RR and sigma mean traces

% Define the directory containing the .mat files
dataDir = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\Human_data\F3';
files = dir(fullfile(dataDir, '*.mat'));

% Initialize containers for summary variables and traces
eventSubject    = {};    % to store subject IDs for each event
RR_amplitudes   = [];    % to store RR_amplitude for each event
RR_AUC_vals = [];    % to store AUC for each event
RR_recover_10_vals = [];    % to store AUC for each event
RR_recover_15_vals = [];    % to store AUC for each event
RR_recover_AUC_vals = [];    % to store AUC for each event


sigma_amplitudes= [];    % to store sigma_amplitude for each event
sigma_power_vals= [];    % to store sigma_power for each event
sigma_power_AUC_vals= [];    % to store sigma_power for each event

% Initialize arrays to accumulate all traces from all events
all_RR_traces    = [];
all_sigma_traces = [];

% Create a time vector from -30 to 30 seconds (15361 samples)
time_vector = linspace(-30, 30, 15361);

% Set a tolerance for matching time (to handle floating point precision)
tol = 1e-6;

% Find the index corresponding to time 0
idx_zero = find(abs(time_vector) < tol, 1);

% Find indices for the desired time ranges using logical conditions:
% For RR baseline: time between -15 and -10 seconds
idx_rr_baseline = find(time_vector >= -15 & time_vector <= -10);

idx_rr_event = find(time_vector >= -2.5 & time_vector <= 2.5);
idx_rr_baseline_AUC = find(time_vector >= -15 & time_vector <= -5);

idx_rr_recover_15 = find(time_vector >= 0 & time_vector <= 15);
idx_rr_recover_10 = find(time_vector >= 0 & time_vector <= 10);

idx_rr_recover_AUC_parasymp = find(time_vector >= 5 & time_vector <= 15);
idx_rr_recover_AUC_bl = find(time_vector >= 20 & time_vector <= 30);


% For sigma amplitude: time between -8 and 2 seconds
idx_sigma_peak = find(time_vector >= -8 & time_vector <= 2);

% For sigma baseline (for sigma amplitude): time between 0 and 15 seconds
idx_sigma_baseline = find(time_vector >= 0 & time_vector <= 15);

% For sigma power: mean sigma from time -5 to 0 seconds
idx_sigma_power = find(time_vector >= -5 & time_vector <= 0);

% Loop over each .mat file in the directory

for i = 1:length(files)
    % Get full file name
    fileName = files(i).name;
    filePath = fullfile(dataDir, fileName);
    
    % Extract the subject ID from the filename.
    % The subject ID is found between 'PSTIM_' and '_V'
    subjectID_cell = extractBetween(fileName, 'PSTIM_', '_V');
    if isempty(subjectID_cell)
        warning('Subject ID not found in filename: %s', fileName);
        continue;
    end
    subjectID = subjectID_cell{1};
    
    % Load the .mat file (assumes variable 'result' exists)
    load(filePath, 'result');

       %pivot due to incosistent naming
    if strcmp(subjectID, '716')
        % Extract required variables from ace
        % 1) Extract sigma_bin2 from the 2nd column of binSigma_stg2_F3
        sigma_trace = result.sigma_collector_all_hrb;
        
        % 3) Extract the HRB RR matrix (n events x 5120 timepoints)
        RR_trace = result.rr_collector_all_hrb;
    else
        % Extract traces from the struct
        sigma_trace = result.spindle_collector_nrem_hrb; % [n x 15361]
        RR_trace    = result.rr_collector_nrem_hrb;        % [n x 15361]

    end
    
    % Get the number of events for the current subject
    numEvents = size(RR_trace, 1);
    
    % Loop over each event (row) in the current file
    for j = 1:numEvents
        % --- Compute RR_amplitude ---
        % RR value at time = 0
        rr_at_zero = RR_trace(j, idx_zero);
        % Mean RR from time -15 to -10
        rr_baseline = mean(RR_trace(j, idx_rr_baseline));
        % RR_amplitude for this event
        RR_amp = rr_at_zero - rr_baseline;

                % --- Compute RR_AUC ---
        % RR value at time = 0
        rr_at_zero = trapz(RR_trace(j, idx_rr_event));
        % Mean RR from time -15 to -10
        rr_baseline = trapz(RR_trace(j, idx_rr_baseline_AUC));
        % RR_amplitude for this event
        RR_AUC = rr_at_zero - rr_baseline;

        % --- Compute RR_recover ---
        % RR value at time = 0
        rr_at_zero = RR_trace(j, idx_zero);
        % Mean RR from time -15 to -10
        rr_baseline_10 = max(RR_trace(j, idx_rr_recover_10));
        rr_baseline_15 = max(RR_trace(j, idx_rr_recover_15));
        % RR_amplitude for this event
        RR_recover_10 = rr_baseline_10 - rr_at_zero;
        RR_recover_15 = rr_baseline_15 - rr_at_zero;

                % --- Compute RR_recover_AUC ---
        % RR value at time = 5 to 15
        rr_event_parasymp = trapz(RR_trace(j, idx_rr_recover_AUC_parasymp));
        % Mean RR from time 20 to 30
        rr_baseline_parasymp = trapz(RR_trace(j, idx_rr_recover_AUC_bl));
        % RR_AUC for this event
        RR_recover_AUC = rr_event_parasymp - rr_baseline_parasymp;

        
        % --- Compute sigma_amplitude ---
        % Maximum sigma value from time -8 to 2
        sigma_max = max(sigma_trace(j, idx_sigma_peak));
        % Minimum sigma value from time between 0 and 15 (as per provided code)
        sigma_baseline = min(sigma_trace(j, idx_sigma_baseline));
        % sigma_amplitude for this event (difference between baseline and peak)
        sigma_amp = sigma_baseline - sigma_max;
        
        % --- Compute sigma_power ---
        % Mean sigma from time -5 to 0
        sigma_power = mean(sigma_trace(j, idx_sigma_power));
        % Mean sigma from time -15 to -10 (using the same window as the RR baseline)
        % sigma_baseline_power = mean(sigma_trace(j, idx_rr_baseline));
        % sigma_power for this event
        % sigma_power = sigma_mean_power;

                % --- Compute sigma_power AUC ---
        % Mean sigma from time -5 to 0
        sigma_mean_power = trapz(sigma_trace(j, idx_sigma_power));
        % Mean sigma from time -15 to -10 (using the same window as the RR baseline)
        sigma_baseline_power = trapz(sigma_trace(j, idx_rr_baseline));
        % sigma_power for this event
        sigma_power_AUC = sigma_mean_power - sigma_baseline_power;
        
        % Append results for this event
        eventSubject{end+1,1}     = subjectID;
        RR_amplitudes(end+1,1)    = RR_amp;
        RR_AUC_vals(end+1,1) = RR_AUC;
        RR_recover_10_vals(end+1,1) = RR_recover_10;   
        RR_recover_15_vals(end+1,1) = RR_recover_15;    
        RR_recover_AUC_vals(end+1,1) = RR_recover_AUC;    

        sigma_amplitudes(end+1,1) = sigma_amp;
        sigma_power_vals(end+1,1) = sigma_power;
        sigma_power_AUC_vals(end+1,1) = sigma_power_AUC;
    end
    
    % Accumulate all RR and sigma traces across events
    all_RR_traces = [all_RR_traces; RR_trace];
    all_sigma_traces = [all_sigma_traces; sigma_trace];
end

% Create the summary table for all events
Human_summary_table = table(eventSubject, RR_amplitudes, RR_AUC_vals, RR_recover_10_vals, RR_recover_15_vals, RR_recover_AUC_vals, sigma_amplitudes, sigma_power_vals, sigma_power_AUC_vals, ...
    'VariableNames', {'SubjectID', 'RR_amplitude', 'RR_AUC', 'RR_recover_10', 'RR_recover_15', 'RR_recover_AUC', 'sigma_amplitude', 'sigma_power', 'sigma_power_AUC'});

% --- Compute mean traces and SEM for all events ---
% For RR traces:
mean_RR_trace = mean(all_RR_traces, 1);
SEM_RR_trace = std(all_RR_traces, 0, 1) ./ sqrt(size(all_RR_traces, 1));

% For sigma traces:
mean_sigma_trace = mean(all_sigma_traces, 1);
SEM_sigma_trace = std(all_sigma_traces, 0, 1) ./ sqrt(size(all_sigma_traces, 1));

mean_RR_trace = mean_RR_trace';
mean_sigma_trace = mean_sigma_trace';

SEM_RR_trace = SEM_RR_trace';
SEM_sigma_trace = SEM_sigma_trace';

time_vector = time_vector';

ds_factor = 10;

% Downsample the mean traces
mean_RR_trace_ds    = mean_RR_trace(1:ds_factor:end);
mean_sigma_trace_ds = mean_sigma_trace(1:ds_factor:end);

% Downsample the SEM traces
SEM_RR_trace_ds    = SEM_RR_trace(1:ds_factor:end);
SEM_sigma_trace_ds = SEM_sigma_trace(1:ds_factor:end);

% Downsample the time vector
time_vector_ds = time_vector(1:ds_factor:end);

% --- Plot the Mean Traces with SEM ---
figure;

% Plot for RR trace
subplot(2,1,1);
hold on;
plot(time_vector_ds, mean_RR_trace_ds, 'LineWidth', 2);
% Create a patch for SEM (error band)
patch([time_vector_ds, fliplr(time_vector_ds)], ...
      [mean_RR_trace_ds-mean_sigma_trace_ds, fliplr(mean_RR_trace_ds+mean_sigma_trace_ds)], ...
      'b', 'FaceAlpha', 0.2, 'EdgeColor', 'none');
xlabel('Time (s)');
ylabel('RR Trace');
title('Mean RR Trace with SEM');
hold off;

% Plot for sigma trace
subplot(2,1,2);
hold on;
plot(time_vector_ds, mean_sigma_trace_ds, 'LineWidth', 2);
patch([time_vector_ds, fliplr(time_vector_ds)], ...
      [mean_sigma_trace_ds-SEM_sigma_trace_ds, fliplr(mean_sigma_trace_ds+SEM_sigma_trace_ds)], ...
      'r', 'FaceAlpha', 0.2, 'EdgeColor', 'none');
xlabel('Time (s)');
ylabel('Sigma Trace');
title('Mean Sigma Trace with SEM');
hold off;



% writetable(Human_summary_table, 'Human_summary_table.csv')

%% Human: mean per subject
% Compute the mean RR_amplitude and sigma_amplitude for each unique SubjectID
human_mean_per_subject = groupsummary(Human_summary_table, 'SubjectID', 'mean', ...
    {'RR_amplitude', 'RR_AUC', 'RR_recover_10', 'RR_recover_15', 'RR_recover_AUC', 'sigma_amplitude', 'sigma_power', 'sigma_power_AUC'});

% Optionally, rename the resulting columns for clarity:
human_mean_per_subject.Properties.VariableNames{'mean_RR_amplitude'} = 'Mean_RR_amplitude';
human_mean_per_subject.Properties.VariableNames{'mean_RR_AUC'} = 'Mean_RR_AUC';
human_mean_per_subject.Properties.VariableNames{'mean_RR_recover_10'} = 'Mean_RR_recover_10';
human_mean_per_subject.Properties.VariableNames{'mean_RR_recover_15'} = 'Mean_RR_recover_15';
human_mean_per_subject.Properties.VariableNames{'mean_RR_recover_AUC'} = 'Mean_RR_recover_AUC';

human_mean_per_subject.Properties.VariableNames{'mean_sigma_amplitude'} = 'Mean_sigma_amplitude';
human_mean_per_subject.Properties.VariableNames{'mean_sigma_power'} = 'Mean_sigma_power';
human_mean_per_subject.Properties.VariableNames{'mean_sigma_power_AUC'} = 'Mean_sigma_power_AUC';


writetable(human_mean_per_subject, 'Human_subject_mean_table.csv')
%% HUMAN - Pin-Chuns data

% Set the directory containing the .mat files
dataDir = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\Human_data\Pin-Chun';
files = dir(fullfile(dataDir, '*.mat'));

% Initialize an empty table to collect all event data across files
allData = table();

% Initialize array to store the mean RR trace for each file
allRRtraces = [];

% Create a time vector corresponding to the 5120 samples over -10 to 10 seconds
timeVec = linspace(-10, 10, 5120);

% Pre-calculate indices based on the timeVec for later analysis:

% For HRB time 0, note: since 5120 is even, there is no single sample at 0.
% We take the mean of the two central indices.
idx_zero1 = size(timeVec,2) / 2;      % e.g., 2560
idx_zero2 = idx_zero1 + 1;            % e.g., 2561

% Find indices corresponding to time regions:
idx_neg10_to_neg5 = find(timeVec >= -10 & timeVec <= -5);
idx_neg5_to_0    = find(timeVec > -5  & timeVec <  0);
idx_0_to_10      = find(timeVec >= 0   & timeVec <= 10);
idx_4_to_8   = find(timeVec >= 4 & timeVec <= 8);
idx_neg2_to_2= find(timeVec >= -2 & timeVec <= 2);

% Loop through each file in the directory
for iFile = 1:length(files)
    % Get full filename and load the file; assumes the variable 'ace' is in the file.
    filename = files(iFile).name;
    filepath = fullfile(files(iFile).folder, filename);
    load(filepath, 'ace');  % loads variable ace
    
    % Extract the SubjectID from the filename
    % Assume the filename has underscores and that the SubjectID is between 
    % the 2nd and 3rd underscore.
    % For example, if filename = 'Prefix_1_2345_OtherInfo.mat', then:
    %   parts = {'Prefix', '1', '2345', 'OtherInfo.mat'}
    % and SubjectID is taken as parts{3}.
    parts = strsplit(filename, '_');
    if length(parts) >= 3
        subjectID = regexprep(parts{3}, '\.mat$', ''); % remove .mat extension if present
    else
        warning('Filename "%s" does not have enough parts. Skipping...', filename);
        continue;
    end
    
    % Extract required variables from ace
    % 1) Extract sigma_bin2 from the 2nd column of binSigma_stg2_F3
    sigma_bin2 = ace.binSigma_stg2_F3(:,2);
    
    % 2) Extract the baseline value from blSigma_stg2_F3
    nonace_bl = ace.blSigma_stg2_F3;
    
    % 3) Extract the HRB RR matrix (n events x 5120 timepoints)
    HRB = ace.HRB_stg2;
    nEvents = size(HRB,1);
    
    % Preallocate computed feature vectors (one value per event)
    sigma_bin2_raw = sigma_bin2; 
    sigma_subbase2_approx = (sigma_bin2 - nonace_bl) ./ (sigma_bin2 + nonace_bl);
    non_ace_bl = repmat(nonace_bl, nEvents, 1); % same value for all events in file
    
    RR_ampl         = zeros(nEvents,1);
    RR_AUC          = zeros(nEvents,1);
    RR_recover_ampl = zeros(nEvents,1);
    RR_recover_AUC  = zeros(nEvents,1);
    
    % Compute the HRB RR value at time 0
    % For each event, take the mean of the two values around time = 0.
    HRB0 = mean(HRB(:, [idx_zero1, idx_zero2]), 2);
    
    % Compute the baseline RR as the mean of values from time -10 to -5 (per event)
    baseline = mean(HRB(:, idx_neg10_to_neg5), 2);
    
    % Loop through each event to compute features from the HRB trace
    for jEvent = 1:nEvents
        rrTrace = HRB(jEvent, :);
        
        % RR_ampl: difference between RR at time 0 and the baseline (-10 to -5 sec mean)
        RR_ampl(jEvent) = HRB0(jEvent) - baseline(jEvent);
        
        % RR_AUC: area under curve difference between (-10 to -5) and (-5 to 0) time windows
        auc1 = trapz(timeVec(idx_neg10_to_neg5), rrTrace(idx_neg10_to_neg5));
        auc2 = trapz(timeVec(idx_neg5_to_0), rrTrace(idx_neg5_to_0));
        RR_AUC(jEvent) = auc2 - auc1;
        
        % RR_recover_ampl: difference between the maximum RR in the recovery phase (0 to 10 sec)
        % and the HRB value at time 0.
        RR_recover_ampl(jEvent) = max(rrTrace(idx_0_to_10)) - HRB0(jEvent);
        
        % RR_recover_AUC: difference in the AUC between the time windows 4 to 8 sec 
        % and -2 to 2 sec.
        auc_recover   = trapz(timeVec(idx_4_to_8), rrTrace(idx_4_to_8));
        auc_baseline  = trapz(timeVec(idx_neg2_to_2), rrTrace(idx_neg2_to_2));
        RR_recover_AUC(jEvent) = auc_recover - auc_baseline;
    end
    
    % Create a table for this file's events with the computed measures
    % Convert the subjectID to a string vector; this value is repeated for each event.
    SubjectID = repmat(string(subjectID), nEvents, 1);
    T = table(SubjectID, sigma_bin2_raw, sigma_subbase2_approx, non_ace_bl, ...
        RR_ampl, RR_AUC, RR_recover_ampl, RR_recover_AUC);
    
    % Append the table for the current file to the overall table
    allData = [allData; T];
    
    % Store the mean RR trace (averaging across events) for later plot
    meanRR = mean(HRB, 1); % mean across events (row-wise)
    allRRtraces = [allRRtraces; meanRR];  % each row corresponds to one file
end

% Plot the overall mean RR trace computed from all files
if ~isempty(allRRtraces)
    overallMeanRR = mean(allRRtraces, 1);  % average across files (row-wise)
    figure;
    plot(timeVec, overallMeanRR, 'LineWidth', 1.5);
    xlabel('Time (s)');
    ylabel('Mean RR');
    title('Mean RR Trace (Averaged across all files)');
    grid on;
else
    warning('No valid RR traces were loaded. Check your files and directory.');
end


writetable(allData, 'Pin_Chun_data.csv')
%% Pin-Chun data as subject-level

% Assume that 'allData' is the table created previously, which has the following columns:
% SubjectIDs, sigma_bin2_raw, sigma_subbase2_approx, non_ace_bl, RR_ampl, RR_AUC, RR_recover_ampl, RR_recover_AUC

% Group the table by unique SubjectIDs and compute the mean for each event-derived field:
Pin_Chun_subject_summary = groupsummary(allData, 'SubjectID', 'mean', ...
    {'sigma_bin2_raw', 'sigma_subbase2_approx', 'non_ace_bl', 'RR_ampl', 'RR_AUC', 'RR_recover_ampl', 'RR_recover_AUC'});

% Rename the generated columns for clarity:
Pin_Chun_subject_summary.Properties.VariableNames{'mean_sigma_bin2_raw'} = 'Mean_sigma_bin2_raw';
Pin_Chun_subject_summary.Properties.VariableNames{'mean_sigma_subbase2_approx'} = 'Mean_sigma_subbase2_approx';
Pin_Chun_subject_summary.Properties.VariableNames{'mean_non_ace_bl'} = 'Mean_non_ace_bl';
Pin_Chun_subject_summary.Properties.VariableNames{'mean_RR_ampl'} = 'Mean_RR_ampl';
Pin_Chun_subject_summary.Properties.VariableNames{'mean_RR_AUC'} = 'Mean_RR_AUC';
Pin_Chun_subject_summary.Properties.VariableNames{'mean_RR_recover_ampl'} = 'Mean_RR_recover_ampl';
Pin_Chun_subject_summary.Properties.VariableNames{'mean_RR_recover_AUC'} = 'Mean_RR_recover_AUC';

% Write the summary table to a CSV file:
writetable(Pin_Chun_subject_summary, 'Pin_Chun_subject_mean_table.csv');


%% Corr pllot for human data 

% Create a scatter plot of HRB RR vs. Delta465 Amplitude
figure;
scatter(Human_summary_table.RR_amplitude, Human_summary_table.sigma_amplitude, 'filled');
xlabel('HRB RR Value');
ylabel('Delta465 Amplitude');
title('Correlation between HRB RR and Delta465 Amplitude');
grid on;
hold on;

% Compute a linear regression fit
p = polyfit(Human_summary_table.RR_amplitude, Human_summary_table.sigma_amplitude, 1);
x_fit = linspace(min(Human_summary_table.RR_amplitude), max(Human_summary_table.RR_amplitude), 100);
y_fit = polyval(p, x_fit);
plot(x_fit, y_fit, 'r-', 'LineWidth', 2);
legend('Data', 'Linear Fit');

% Compute the correlation coefficient and display it on the plot
R = corrcoef(Human_summary_table.RR_amplitude, Human_summary_table.sigma_amplitude);
text(0.1, 0.9, sprintf('r = %.2f', R(1,2)), 'Units', 'normalized', ...
    'FontSize', 12, 'Color', 'red');
fprintf('Correlation coefficient: %.2f\n', R(1,2));



%% Get sigma power at times -10 to -5 for memory corr

% --- Compute one mean sigma power value per subject for time bin -10 to -5 ---
% (Only including HRB events that occur during valid sleep: SWS or MA)
%
% Assumptions:
% - EEG data, sampling rate, EEG_time, and HRB_time are stored as variables
%   with names that include the subject ID (suffix).
% - Sleep state vectors are available as:
%   wake_woMA_binary_vector_<suffix>, sws_binary_vector_<suffix>, 
%   MA_binary_vector_<suffix>, REM_binary_vector_<suffix>.
%
% The code below uses the same bin edges as before (from -30 to +30 in 5-sec steps)
% so that the target bin (-10 to -5 sec) is the 5th bin.

% Set bin edges and identify the target bin.
bin_edges = -30:5:30;   % creates bins: [-30,-25], [-25,-20], ... [25,30]
nBins = length(bin_edges) - 1;
targetBins = [4,5];  % Combine bins for -15 to -10 and -10 to -5 (i.e., -15 to -5 sec)

% Preallocate a vector for the per-subject mean sigma value.
Suffix = suffix(:);  % ensure column vector
meanSigmaBin = nan(length(suffix),1);

% Loop over each subject.
for idx = 1:length(suffix)
    uniqueId = num2str(suffix(idx));

        % --- Retrieve laser periods if they exist ---
    % Each laser_periods_<suffix> variable should be an N×2 matrix:
    % [laser_onset, laser_offset]
    laser_var_name = sprintf('laser_periods_%s', uniqueId);
    if evalin('base', sprintf('exist(''%s'', ''var'')', laser_var_name))
        laser_periods = eval(laser_var_name);
    else
        % No laser periods for this mouse
        laser_periods = [];
    end

    % Retrieve EEG data, sampling rate, and time vector.
    EEG = eval(sprintf('EEG_%s', uniqueId));
    EEG_fs = eval(sprintf('EEG_fs_%s', uniqueId));  
    if exist(sprintf('EEG_time_%s', uniqueId), 'var')
        EEG_time = eval(sprintf('EEG_time_%s', uniqueId));
    else
        EEG_time = (0:length(EEG)-1) / EEG_fs;
    end
    
    % Retrieve sleep state vectors (assumed sampled at 1 Hz).
    wake_woMA_binary_vector = eval(sprintf('wake_woMA_binary_vector_%s', uniqueId));
    sws_binary_vector         = eval(sprintf('sws_binary_vector_%s', uniqueId));
    MA_binary_vector          = eval(sprintf('MA_binary_vector_%s', uniqueId));
    REM_binary_vector         = eval(sprintf('REM_binary_vector_%s', uniqueId));
    
    % Combine SWS and MA as valid sleep states.
    validSleep = sws_binary_vector | MA_binary_vector;
    sleep_time = 0:length(validSleep)-1;  % time axis for sleep states
    
    % Get HRB event times for this subject (in seconds).
    HRB_time = eval(sprintf('HRB_time_%s', uniqueId));
    HRB_time = HRB_time(:);  % ensure column vector
    
    % Container for the sigma power values (from the target bin) for each event.
    subject_event_values = [];
    
    % Loop over each HRB event for this subject.
    for event_i = 1:length(HRB_time)
        eventTime = HRB_time(event_i);
        
        % --- Valid Sleep Check ---
        % Ensure the full analysis window (eventTime +/- preTime/postTime) is within sleep.
        if (eventTime - preTime) < sleep_time(1) || (eventTime + postTime) > sleep_time(end)
            fprintf('Subject %s, event %d: skipped (window out of bounds).\n', uniqueId, event_i);
            continue;
        end
        eventIdx_sleep = round(eventTime) + 1;  % since sleep_time starts at 0
        if ~validSleep(eventIdx_sleep)
            fprintf('Subject %s, event %d: skipped (not in valid sleep state).\n', uniqueId, event_i);
            continue;
        end
        % Optional: Check that the event is not too near a state transition.
        blockStart = eventIdx_sleep;
        while blockStart > 1 && validSleep(blockStart-1)
            blockStart = blockStart - 1;
        end
        blockEnd = eventIdx_sleep;
        while blockEnd < length(validSleep) && validSleep(blockEnd+1)
            blockEnd = blockEnd + 1;
        end
        if (eventTime - (blockStart-1) < transitionBuffer) || ((blockEnd-1) - eventTime < transitionBuffer)
            fprintf('Subject %s, event %d: skipped (too close to state transition).\n', uniqueId, event_i);
            continue;
        end

        %         % *** Exclude HRB events that occur during a laser period ***
        % if ~isempty(laser_periods)
        %     % If eventTime lies between any laser_onset and laser_offset, skip it.
        %     if any(eventTime >= laser_periods(:,1) & eventTime <= laser_periods(:,2))
        %         fprintf('Mouse %s, event %d: skipped (laser ON).\n', uniqueId, event_i);
        %         continue;
        %     end
        % end
        % 
        if isempty(laser_periods) || ~any(eventTime >= laser_periods(:,1) & eventTime <= laser_periods(:,2))
            fprintf('Subject %s, event %d: skipped (laser OFF).\n', uniqueId, event_i);
            continue;
        end

        % --- EEG Segment Extraction ---
        % Find the closest index in the EEG_time vector to the HRB event.
        [~, idx_EEG] = min(abs(EEG_time - eventTime));
        % Check boundaries: need 30 sec before and after the event.
        if (idx_EEG - 30*EEG_fs < 1) || (idx_EEG + 30*EEG_fs > length(EEG))
            fprintf('Subject %s, event %d: EEG segment out of bounds, skipped.\n', uniqueId, event_i);
            continue;
        end
        % Extract a 60-sec segment (30 sec before and after the event).
        EEG_segment = EEG(idx_EEG - 30*EEG_fs : idx_EEG + 30*EEG_fs);
        
        % --- Power Analysis ---
        % Run the power analysis on the EEG segment using only the sigma band.
        sigma_band_only = {[8,15]};  % only sigma band
        % Here we call PowerAnalysisEEG with a window size of 5 sec.
        [~, T_EEG, ~, bp_event, ~] = PowerAnalysisEEG(EEG_segment, EEG_fs, frw, 5, sigma_band_only);
        sigma_event = bp_event{1};  % sigma power time series for this event
        
        % Shift the spectrogram time vector so that 0 corresponds to the HRB event.
        T_EEG_shifted = T_EEG - 30;
        
        % --- Binning ---
        % Bin the sigma power values into 5-sec intervals.
        bin_idx = discretize(T_EEG_shifted, bin_edges);
        if any(ismember(bin_idx, targetBins))
            event_val = mean(sigma_event(ismember(bin_idx, targetBins)));
            subject_event_values = [subject_event_values; event_val];
        end
    end
    
    % Compute the mean sigma power for this subject (across all its valid events)
    if ~isempty(subject_event_values)
        meanSigmaBin(idx) = mean(subject_event_values);
    else
        meanSigmaBin(idx) = NaN;
    end
end

% Create a table with the subject ID and the corresponding mean sigma power for time bin -10 to -5.
T_results = table(Suffix, meanSigmaBin, ...
    'VariableNames', {'Suffix', 'MeanSigmaPower_Minus10_to_Minus5'});
disp(T_results);

Suffix = {'387', '399', '392', '403', '412', '414', '416', '418', '486', '408', '420', '468', '477', '484', '015', '079', '089', '013', '019'};
%sigma_power_increase = [0.056842, 0.057477, 0.047644, 0.062896, 0.064325, 0.068995, 0.080907, 0.045944, 0.051554, 0.016309, 0.041683, 0.012267, 0.03086, 0.058014]';
novel_familiar_ratio = [1.12, 1.75, 1.384615, 1.15, 3, 1.5, 2.166667, 0.75, 1.666667, 0, 0.909091, 1.3, 0.272727, 1.444444, 1.5, 1, 2.5, 2.3333, 1.3333]';
Suffix = Suffix';
% Create the table
data_table = table(Suffix, novel_familiar_ratio);

% Convert join keys to string so they match
T_results.Suffix = string(T_results.Suffix);
data_table.Suffix = string(data_table.Suffix);

% Merge the tables by matching 'Subject' from T_results with 'Suffix' from data_table
merged_table = join(T_results, data_table);

% Display the merged table
disp(merged_table);

plot_correlation_memory_arch(merged_table, arch, yfp, 'MeanSigmaPower_Minus10_to_Minus5'); % Change 'AUC_diff' to any other variable as needed

%% Get peak sigma value between -20 to 0 from the sigma trace during laser off
% Parameters and expected lengths
preTime = 30;           % seconds before the HRB event to include
postTime = 30;          % seconds after the HRB event to include
windowTime = preTime + postTime;  % total window length (60 sec)
transitionBuffer = 15;  % minimum seconds away from a state transition

% Fixed sampling frequencies (Hz)
fs_RR = 64;         
fs_sigma = 2;     

% Expected number of samples (using floor to ensure an integer count)
expected_sigma_length = 2 * floor(preTime * fs_sigma) + 1;     % e.g., 30721

% List of mouse IDs (stored as numbers)
suffix = [387, 484, 412, 414, 416, 408, 420, 468];

% Containers for event segments (each row is one event)
all_sigma_segments = [];     

% --- Compute one mean peak sigma power value per subject for time window -20 to 0 ---
% (Only including HRB events that occur during valid sleep (SWS or MA) and outside laser periods)
%
% This code uses the sigma traces (from your 3rd subplot extraction) where
% time 0 corresponds to the HRB event. It then finds the maximum (peak) sigma
% power in the window from -20 to 0 sec for each event, and then averages those
% peaks per subject.

% Preallocate a vector for the per-subject mean peak sigma value.
meanPeakSigma = nan(length(suffix),1);

% Loop over each subject.
for idx = 1:length(suffix)
    uniqueId = num2str(suffix(idx));
    
    % --- Retrieve laser periods if they exist ---
    laser_var_name = sprintf('laser_periods_%s', uniqueId);
    if evalin('base', sprintf('exist(''%s'', ''var'')', laser_var_name))
        laser_periods = eval(laser_var_name);
    else
        laser_periods = [];
    end
    
    % --- Retrieve sleep state vectors (assumed sampled at 1 Hz) ---
    wake_woMA_binary_vector = eval(sprintf('wake_woMA_binary_vector_%s', uniqueId));
    sws_binary_vector         = eval(sprintf('sws_binary_vector_%s', uniqueId));
    MA_binary_vector          = eval(sprintf('MA_binary_vector_%s', uniqueId));
    REM_binary_vector         = eval(sprintf('REM_binary_vector_%s', uniqueId));
    
    % Combine SWS and MA as valid sleep states.
    validSleep = sws_binary_vector | MA_binary_vector;
    sleep_time = 0:length(validSleep)-1;  % time axis for sleep states
    
    % --- Retrieve HRB event times (in seconds) ---
    HRB_time = eval(sprintf('HRB_time_%s', uniqueId));
    HRB_time = HRB_time(:);  % ensure column vector
    
    % --- Retrieve sigma data (from the spectrogram used for subplot 3) ---
    % Here, we assume sigma_power and its corresponding time vector (time_spectrogram_zero)
    % have been computed for this subject.
    band_powers = eval(sprintf('band_powers_%s', uniqueId));
    sigma_power = band_powers{4};  % sigma power (e.g., in dB) as used in subplot 3
    time_spectrogram_zero = eval(sprintf('time_spectrogram_zero_%s', uniqueId));
    
    % Container for the peak sigma values for each valid event.
    subject_event_peaks = [];
    
    % Loop over each HRB event for this subject.
    for event_i = 1:length(HRB_time)
        eventTime = HRB_time(event_i);
        
        % --- Exclude events during a laser period ---
        if ~isempty(laser_periods)
            if any(eventTime >= laser_periods(:,1) & eventTime <= laser_periods(:,2))
                fprintf('Subject %s, event %d: skipped (laser ON).\n', uniqueId, event_i);
                continue;
            end
        end
        
        % --- Valid Sleep Check ---
        if (eventTime - preTime) < sleep_time(1) || (eventTime + postTime) > sleep_time(end)
            fprintf('Subject %s, event %d: skipped (window out of bounds).\n', uniqueId, event_i);
            continue;
        end
        eventIdx_sleep = round(eventTime) + 1;  % since sleep_time starts at 0
        if ~validSleep(eventIdx_sleep)
            fprintf('Subject %s, event %d: skipped (not in valid sleep state).\n', uniqueId, event_i);
            continue;
        end
        % Check contiguous valid sleep block to avoid transitions.
        blockStart = eventIdx_sleep;
        while blockStart > 1 && validSleep(blockStart-1)
            blockStart = blockStart - 1;
        end
        blockEnd = eventIdx_sleep;
        while blockEnd < length(validSleep) && validSleep(blockEnd+1)
            blockEnd = blockEnd + 1;
        end
        if (eventTime - (blockStart-1) < transitionBuffer) || ((blockEnd-1) - eventTime < transitionBuffer)
            fprintf('Subject %s, event %d: skipped (too close to state transition).\n', uniqueId, event_i);
            continue;
        end
        
        % --- Extract sigma data ---
        % Find the closest index in the sigma time vector to the HRB event.
        [~, idx_sigma] = min(abs(time_spectrogram_zero - eventTime));
        if (idx_sigma - floor(preTime*fs_sigma) < 1) || (idx_sigma + floor(preTime*fs_sigma) > length(time_spectrogram_zero))
            fprintf('Subject %s, event %d: skipped (sigma window out of bounds).\n', uniqueId, event_i);
            continue;
        end
        sigma_segment = sigma_power(idx_sigma - floor(preTime*fs_sigma) : idx_sigma + floor(preTime*fs_sigma));
        if length(sigma_segment) ~= expected_sigma_length
            fprintf('Subject %s, event %d: skipped (sigma segment length %d, expected %d).\n',...
                uniqueId, event_i, length(sigma_segment), expected_sigma_length);
            continue;
        end
        
        % --- Create a time vector for the sigma segment ---
        % The segment spans from -preTime to +postTime seconds relative to the event.
        t_sigma_event = linspace(-preTime, postTime, length(sigma_segment));
        
        % --- Determine the peak sigma value in the window from -20 to 0 sec ---
        target_idx = t_sigma_event >= -20 & t_sigma_event <= 0;
        if any(target_idx)
            peak_val = max(sigma_segment(target_idx));
            subject_event_peaks = [subject_event_peaks; peak_val];
        end
    end
    
    % Compute the mean peak sigma value for this subject (averaged across valid events)
    if ~isempty(subject_event_peaks)
        meanPeakSigma(idx) = mean(subject_event_peaks);
    else
        meanPeakSigma(idx) = NaN;
    end
end

% Create a table with the subject ID and the corresponding mean peak sigma value for time window -20 to 0.
T_peak_results = table(string(suffix(:)), meanPeakSigma, ...
    'VariableNames', {'Suffix','PeakSigma_Minus20_to_0'});
disp(T_peak_results);

% --- Merge with your memory table ---
% Provided memory table:
Suffix_list = {'387', '399', '392', '403', '412', '414', '416', '418', '486', '408', '420', '468', '477', '484', '015', '079', '089', '013', '019'}';
novel_familiar_ratio = [1.12, 1.75, 1.384615, 1.15, 3, 1.5, 2.166667, 0.75, 1.666667, 0, 0.909091, 1.3, 0.272727, 1.444444, 1.5, 1, 2.5, 2.3333, 1.3333]';
data_table = table(string(Suffix_list), novel_familiar_ratio, 'VariableNames', {'Suffix','novel_familiar_ratio'});

% Convert join keys to string (already done above) and merge:
merged_table = join(T_peak_results, data_table, 'Keys', 'Suffix');
disp(merged_table);

% Now, call your plotting function using the new variable.
plot_correlation_memory_arch(merged_table, arch, yfp, 'PeakSigma_Minus20_to_0');  % change variable name as needed

%% --- Compute one mean AUC of sigma power per subject for time window -20 to -5 ---
% (Only including HRB events that occur during valid sleep (SWS or MA) and outside laser periods)
%
% This code uses the sigma trace (from your subplot 3 extraction) where
% time 0 corresponds to the HRB event. For each valid event, it computes the
% area under the curve (AUC) using trapz for the sigma trace between -20 and -5 sec.
% These per-event AUCs are then averaged to yield one mean AUC per subject.

% Preallocate a vector for the per-subject mean AUC.
meanAUC = nan(length(suffix),1);

% Loop over each subject.
for idx = 1:length(suffix)
    uniqueId = num2str(suffix(idx));
    
    % --- Retrieve laser periods if they exist ---
    laser_var_name = sprintf('laser_periods_%s', uniqueId);
    if evalin('base', sprintf('exist(''%s'', ''var'')', laser_var_name))
        laser_periods = eval(laser_var_name);
    else
        laser_periods = [];
    end
    
    % --- Retrieve sleep state vectors (assumed sampled at 1 Hz) ---
    wake_woMA_binary_vector = eval(sprintf('wake_woMA_binary_vector_%s', uniqueId));
    sws_binary_vector         = eval(sprintf('sws_binary_vector_%s', uniqueId));
    MA_binary_vector          = eval(sprintf('MA_binary_vector_%s', uniqueId));
    REM_binary_vector         = eval(sprintf('REM_binary_vector_%s', uniqueId));
    
    % Combine SWS and MA as valid sleep states.
    validSleep = sws_binary_vector | MA_binary_vector;
    sleep_time = 0:length(validSleep)-1;  % time axis for sleep states
    
    % --- Retrieve HRB event times for this subject (in seconds) ---
    HRB_time = eval(sprintf('HRB_time_%s', uniqueId));
    HRB_time = HRB_time(:);
    
    % --- Retrieve sigma data (from the spectrogram used in subplot 3) ---
    % We assume the sigma_power and its corresponding time vector (time_spectrogram_zero)
    % have been computed per subject.
    band_powers = eval(sprintf('band_powers_%s', uniqueId));
    sigma_power = band_powers{4};  % sigma power (e.g., in dB)
    time_spectrogram_zero = eval(sprintf('time_spectrogram_zero_%s', uniqueId));
    
    % Container for the AUC values for each valid event.
    subject_event_auc = [];
    
    % Loop over each HRB event for this subject.
    for event_i = 1:length(HRB_time)
        eventTime = HRB_time(event_i);
        
        % --- Exclude events during a laser period ---
        if ~isempty(laser_periods)
            if any(eventTime >= laser_periods(:,1) & eventTime <= laser_periods(:,2))
                fprintf('Subject %s, event %d: skipped (laser ON).\n', uniqueId, event_i);
                continue;
            end
        end
        
        % --- Valid Sleep Check ---
        if (eventTime - preTime) < sleep_time(1) || (eventTime + postTime) > sleep_time(end)
            fprintf('Subject %s, event %d: skipped (window out of bounds).\n', uniqueId, event_i);
            continue;
        end
        eventIdx_sleep = round(eventTime) + 1;
        if ~validSleep(eventIdx_sleep)
            fprintf('Subject %s, event %d: skipped (not in valid sleep state).\n', uniqueId, event_i);
            continue;
        end
        % Check contiguous valid sleep block to avoid transitions.
        blockStart = eventIdx_sleep;
        while blockStart > 1 && validSleep(blockStart-1)
            blockStart = blockStart - 1;
        end
        blockEnd = eventIdx_sleep;
        while blockEnd < length(validSleep) && validSleep(blockEnd+1)
            blockEnd = blockEnd + 1;
        end
        if (eventTime - (blockStart-1) < transitionBuffer) || ((blockEnd-1) - eventTime < transitionBuffer)
            fprintf('Subject %s, event %d: skipped (too close to state transition).\n', uniqueId, event_i);
            continue;
        end
        
        % --- Extract sigma data ---
        [~, idx_sigma] = min(abs(time_spectrogram_zero - eventTime));
        if (idx_sigma - floor(preTime*fs_sigma) < 1) || (idx_sigma + floor(preTime*fs_sigma) > length(time_spectrogram_zero))
            fprintf('Subject %s, event %d: skipped (sigma window out of bounds).\n', uniqueId, event_i);
            continue;
        end
        sigma_segment = sigma_power(idx_sigma - floor(preTime*fs_sigma) : idx_sigma + floor(preTime*fs_sigma));
        if length(sigma_segment) ~= expected_sigma_length
            fprintf('Subject %s, event %d: skipped (sigma segment length %d, expected %d).\n', ...
                uniqueId, event_i, length(sigma_segment), expected_sigma_length);
            continue;
        end
        
        % --- Create a time vector for the sigma segment ---
        % This vector spans from -preTime to +postTime relative to the event.
        t_sigma_event = linspace(-preTime, postTime, length(sigma_segment));
        
        % --- Determine the indices corresponding to the window from -20 to -5 sec ---
        target_idx = t_sigma_event >= -20 & t_sigma_event <= -0;
        if any(target_idx)
            % Compute the area under the curve (AUC) using trapz.
            auc_val = trapz(t_sigma_event(target_idx), sigma_segment(target_idx));
            subject_event_auc = [subject_event_auc; auc_val];
        end
    end
    
    % Compute the mean AUC for this subject (averaged across valid events)
    if ~isempty(subject_event_auc)
        meanAUC(idx) = mean(subject_event_auc);
    else
        meanAUC(idx) = NaN;
    end
end

% Create a table with the subject ID and the corresponding mean AUC for time window -20 to -5.
T_auc_results = table(string(suffix(:)), meanAUC, ...
    'VariableNames', {'Suffix','MeanAUC_Sigma_Minus20_to_Minus5'});
disp(T_auc_results);

%--- Merge with your memory table ---
Suffix_list = {'387', '399', '392', '403', '412', '414', '416', '418', '486', '408', '420', '468', '477', '484', '015', '079', '089', '013', '019'}';
novel_familiar_ratio = [1.12, 1.75, 1.384615, 1.15, 3, 1.5, 2.166667, 0.75, 1.666667, 0, 0.909091, 1.3, 0.272727, 1.444444, 1.5, 1, 2.5, 2.3333, 1.3333]';
data_table = table(string(Suffix_list), novel_familiar_ratio, 'VariableNames', {'Suffix','novel_familiar_ratio'});

% Merge the tables by matching on 'Suffix'.
merged_table = join(T_auc_results, data_table, 'Keys', 'Suffix');
disp(merged_table);

% Call your plotting function using the new variable.
plot_correlation_memory_arch(merged_table, arch, yfp, 'MeanAUC_Sigma_Minus20_to_Minus5');  % adjust variable name as needed

%% --- Compute one mean AUC of RR intervals per subject for time window 0.5 to 5 ---
% (Only including HRB events that occur during valid sleep (SWS or MA) and outside laser periods)
%
% This code uses the RR signal (from your RR extraction) where
% time 0 corresponds to the HRB event. For each valid event, it computes the
% area under the curve (AUC) using trapz for the RR signal between -20 and -5 sec.
% These per-event AUCs are then averaged to yield one mean AUC per subject.

% Preallocate a vector for the per-subject mean AUC.
meanAUC_RR = nan(length(suffix),1);

% Loop over each subject.
for idx = 1:length(suffix)
    uniqueId = num2str(suffix(idx));
    
    % --- Retrieve laser periods if they exist ---
    laser_var_name = sprintf('laser_periods_%s', uniqueId);
    if evalin('base', sprintf('exist(''%s'', ''var'')', laser_var_name))
        laser_periods = eval(laser_var_name);
    else
        laser_periods = [];
    end
    
    % --- Retrieve sleep state vectors (assumed sampled at 1 Hz) ---
    wake_woMA_binary_vector = eval(sprintf('wake_woMA_binary_vector_%s', uniqueId));
    sws_binary_vector         = eval(sprintf('sws_binary_vector_%s', uniqueId));
    MA_binary_vector          = eval(sprintf('MA_binary_vector_%s', uniqueId));
    REM_binary_vector         = eval(sprintf('REM_binary_vector_%s', uniqueId));
    
    % Combine SWS and MA as valid sleep states.
    validSleep = sws_binary_vector | MA_binary_vector;
    sleep_time = 0:length(validSleep)-1;  % time axis for sleep states
    
    % --- Retrieve HRB event times for this subject (in seconds) ---
    HRB_time = eval(sprintf('HRB_time_%s', uniqueId));
    HRB_time = HRB_time(:);
    
    % --- Retrieve RR signal and its time vector ---
    RR = eval(sprintf('RR_%s', uniqueId));         % RR signal (e.g., intervals or RR series)
    RR_time = eval(sprintf('RR_time_%s', uniqueId));   % RR time vector
    
    % Container for the AUC values for each valid event.
    subject_event_auc = [];
    
    % Loop over each HRB event for this subject.
    for event_i = 1:length(HRB_time)
        eventTime = HRB_time(event_i);
        
        % --- Exclude events during a laser period ---
        if isempty(laser_periods) || ~any(eventTime >= laser_periods(:,1) & eventTime <= laser_periods(:,2))
            fprintf('Subject %s, event %d: skipped (laser OFF).\n', uniqueId, event_i);
            continue;
        end

        % --- Valid Sleep Check ---
        if (eventTime - preTime) < sleep_time(1) || (eventTime + postTime) > sleep_time(end)
            fprintf('Subject %s, event %d: skipped (window out of bounds).\n', uniqueId, event_i);
            continue;
        end
        eventIdx_sleep = round(eventTime) + 1;
        if ~validSleep(eventIdx_sleep)
            fprintf('Subject %s, event %d: skipped (not in valid sleep state).\n', uniqueId, event_i);
            continue;
        end
        % Check contiguous valid sleep block to avoid transitions.
        blockStart = eventIdx_sleep;
        while blockStart > 1 && validSleep(blockStart-1)
            blockStart = blockStart - 1;
        end
        blockEnd = eventIdx_sleep;
        while blockEnd < length(validSleep) && validSleep(blockEnd+1)
            blockEnd = blockEnd + 1;
        end
        if (eventTime - (blockStart-1) < transitionBuffer) || ((blockEnd-1) - eventTime < transitionBuffer)
            fprintf('Subject %s, event %d: skipped (too close to state transition).\n', uniqueId, event_i);
            continue;
        end
        
        % --- Extract RR data ---
        [~, idx_RR] = min(abs(RR_time - eventTime));
        if (idx_RR - floor(preTime*fs_RR) < 1) || (idx_RR + floor(preTime*fs_RR) > length(RR_time))
            fprintf('Subject %s, event %d: skipped (RR window out of bounds).\n', uniqueId, event_i);
            continue;
        end
        rr_segment = RR(idx_RR - floor(preTime*fs_RR) : idx_RR + floor(preTime*fs_RR));
        if length(rr_segment) ~= expected_RR_length
            fprintf('Subject %s, event %d: skipped (RR segment length %d, expected %d).\n',...
                uniqueId, event_i, length(rr_segment), expected_RR_length);
            continue;
        end
        
        % --- Create a time vector for the RR segment ---
        % The segment spans from -preTime to +postTime relative to the event.
        t_RR_event = linspace(-preTime, postTime, length(rr_segment));
        
        % --- Determine the indices corresponding to the window from -20 to -5 sec ---
        target_idx = t_RR_event >= 0.5 & t_RR_event <= 5;
        if any(target_idx)
            % Compute the area under the curve (AUC) using trapz.
            auc_val = trapz(t_RR_event(target_idx), rr_segment(target_idx));
            subject_event_auc = [subject_event_auc; auc_val];
        end
    end
    
    % Compute the mean AUC for this subject (averaged across valid events)
    if ~isempty(subject_event_auc)
        meanAUC_RR(idx) = mean(subject_event_auc);
    else
        meanAUC_RR(idx) = NaN;
    end
end

% Create a table with the subject ID and the corresponding mean AUC for time window -20 to -5 for RR.
T_auc_RR_results = table(string(suffix(:)), meanAUC_RR, ...
    'VariableNames', {'Suffix','MeanAUC_RR_Minus20_to_Minus5'});
disp(T_auc_RR_results);

% --- Merge with your memory table ---
Suffix_list = {'387', '399', '392', '403', '412', '414', '416', '418', '486', '408', '420', '468', '477', '484', '015', '079', '089', '013', '019'}';
novel_familiar_ratio = [1.12, 1.75, 1.384615, 1.15, 3, 1.5, 2.166667, 0.75, 1.666667, 0, 0.909091, 1.3, 0.272727, 1.444444, 1.5, 1, 2.5, 2.3333, 1.3333]';
data_table = table(string(Suffix_list), novel_familiar_ratio, 'VariableNames', {'Suffix','novel_familiar_ratio'});

% Merge the tables by matching on 'Suffix'.
merged_table_RR = join(T_auc_RR_results, data_table, 'Keys', 'Suffix');
disp(merged_table_RR);

% Call your plotting function using the new variable.
plot_correlation_memory_arch(merged_table_RR, arch, yfp, 'MeanAUC_RR_Minus20_to_Minus5');  % adjust variable name as needed
%% Get example trace


uniqueId = '420';
    % Access the variables dynamically
    wake_woMA_binary_vector = eval(sprintf('wake_woMA_binary_vector_%s', uniqueId));
    sws_binary_vector = eval(sprintf('sws_binary_vector_%s', uniqueId));
    REM_binary_vector = eval(sprintf('REM_binary_vector_%s', uniqueId));
    MA_binary_vector = eval(sprintf('MA_binary_vector_%s', uniqueId));
    sec_signal_2 = eval(sprintf('sec_signal_2_%s', uniqueId));
    delta465_filt_2 = eval(sprintf('delta465_filt_2_%s', uniqueId));
    sec_signal_EEG = eval(sprintf('sec_signal_EEG_%s', uniqueId));
    EEG = eval(sprintf('EEG_%s', uniqueId));
    EMG = eval(sprintf('EMG_%s', uniqueId));
    sleepscore_time = 0:length(wake_woMA_binary_vector)-1; % Assuming all vectors are the same length
    band_powers = eval(sprintf('band_powers_%s', uniqueId));
    RR = eval(sprintf('RR_%s', uniqueId));
    RR_time = eval(sprintf('RR_time_%s', uniqueId));
    HRB = eval(sprintf('HRB_%s', uniqueId));
    HRB_time = eval(sprintf('HRB_time_%s', uniqueId));

    sigma = band_powers{1, 4} ;
    time_spectrogram_zero = eval(sprintf('time_spectrogram_zero_%s', uniqueId));

% Define the desired time interval (changeable)
time_start = 1540;
time_end   = 1600;

% Filter HRB events to only include those in the desired time interval
hrb_in_interval = HRB_time(HRB_time >= time_start & HRB_time <= time_end);
% Define the desired time interval (changeable)
time_start = 1540;
time_end   = 1600;

% Filter HRB events to only include those in the desired time interval
hrb_in_interval = HRB_time(HRB_time >= time_start & HRB_time <= time_end);

figure;

% --- First subplot: Norepinephrine ---
a = subplot(3, 1, 1);
    plot_sleep(sec_signal_2, delta465_filt_2, sleepscore_time, wake_woMA_binary_vector, sws_binary_vector, REM_binary_vector, MA_binary_vector);
    title('Norepinephrine');
    xlabel('time (s)');
    ylabel('NE (df/f)');
    xlim([time_start, time_end]);
    grid on;

% --- Second subplot: Sigma ---
b = subplot(3, 1, 2);
    plot_sleep(time_spectrogram_zero, sigma, sleepscore_time, wake_woMA_binary_vector, sws_binary_vector, REM_binary_vector, MA_binary_vector);
    title('Sigma');
    xlabel('time (s)');
    ylabel('Sigma (V)');
    xlim([time_start, time_end]);
    grid on;

% --- Third subplot: RR ---
c = subplot(3, 1, 3);
    plot_sleep(RR_time, RR, sleepscore_time, wake_woMA_binary_vector, sws_binary_vector, REM_binary_vector, MA_binary_vector);
    title('RR');
    xlabel('time (s)');
    ylabel('RR');
    xlim([time_start, time_end]);
    grid on;

% Hold on in all subplots to add the vertical lines for HRB events
hold(a, 'on'); 
hold(b, 'on'); 
hold(c, 'on');

% Loop over each HRB event within the desired time interval and add a vertical line in every subplot
for i = 1:length(hrb_in_interval)
    xline(a, hrb_in_interval(i), 'k--', 'LineWidth', 1);
    xline(b, hrb_in_interval(i), 'k--', 'LineWidth', 1);
    xline(c, hrb_in_interval(i), 'k--', 'LineWidth', 1);
end

% Release the hold
hold(a, 'off');
hold(b, 'off');
hold(c, 'off');

% Link axes for synchronized zooming
linkaxes([a, b, c], 'x');



figure;

% --- First subplot: Norepinephrine ---
    plot(sec_signal_2, delta465_filt_2);
    for i = 1:length(hrb_in_interval)
    xline(hrb_in_interval(i), 'k--', 'LineWidth', 1);
    end
    xlim([time_start, time_end]);
figure;

% --- Second subplot: Sigma ---
    plot(time_spectrogram_zero, sigma);
    for i = 1:length(hrb_in_interval)
    xline(hrb_in_interval(i), 'k--', 'LineWidth', 1);
    end
    xlim([time_start, time_end]);
figure;

% --- Third subplot: RR ---
    plot(RR_time, RR);
    for i = 1:length(hrb_in_interval)
    xline(hrb_in_interval(i), 'k--', 'LineWidth', 1);
    end
    xlim([time_start, time_end]);





%% Get HRB plots during laser off
% Parameters and expected lengths
preTime = 30;           % seconds before the HRB event to include
postTime = 30;          % seconds after the HRB event to include
windowTime = preTime + postTime;  % total window length (60 sec)
transitionBuffer = 15;  % minimum seconds away from a state transition

% Fixed sampling frequencies (Hz)
fs_RR = 64;         
fs_sigma = 2;     
fs_delta465 = 1017;

% Expected number of samples (using floor to ensure an integer count)
expected_RR_length = 2 * floor(preTime * fs_RR) + 1;         % e.g., 3841
expected_sigma_length = 2 * floor(preTime * fs_sigma) + 1;     % e.g., 30721
expected_delta465_length = 2 * floor(preTime * fs_delta465) + 1; % e.g., 61021

% List of mouse IDs (stored as numbers)
suffix = [387, 484, 412, 414, 416, 408, 420, 468];

% Containers for event segments (each row is one event)
all_RR_segments = [];          
all_delta465_segments = [];    
all_sigma_segments = [];       

% Process each mouse’s data
for idx = 1:length(suffix)
    uniqueId = num2str(suffix(idx));
    
    % --- Retrieve laser periods if they exist ---
    % Each laser_periods_<suffix> variable should be an N×2 matrix:
    % [laser_onset, laser_offset]
    laser_var_name = sprintf('laser_periods_%s', uniqueId);
    if evalin('base', sprintf('exist(''%s'', ''var'')', laser_var_name))
        laser_periods = eval(laser_var_name);
    else
        % No laser periods for this mouse
        laser_periods = [];
    end
    
    % --- Retrieve sleep state vectors (assumed sampled at 1 Hz) ---
    wake_woMA_binary_vector = eval(sprintf('wake_woMA_binary_vector_%s', uniqueId));
    sws_binary_vector         = eval(sprintf('sws_binary_vector_%s', uniqueId));
    MA_binary_vector          = eval(sprintf('MA_binary_vector_%s', uniqueId));
    REM_binary_vector         = eval(sprintf('REM_binary_vector_%s', uniqueId));
    
    % Combine SWS and MA as valid sleep states
    validSleep = sws_binary_vector;
%    validSleep = sws_binary_vector | MA_binary_vector;    
    sleep_time = 0:length(validSleep)-1;  % time axis for sleep states
    
    % --- Retrieve HRB event times (in seconds) ---
    HRB_time = eval(sprintf('HRB_time_%s', uniqueId));
    HRB_time = HRB_time(:);  % ensure column vector
    
    % --- Retrieve signals and time vectors ---
    RR = eval(sprintf('RR_%s', uniqueId));                  % RR signal
    RR_time = eval(sprintf('RR_time_%s', uniqueId));          % RR time vector
    
    delta465 = eval(sprintf('delta465_filt_2_%s', uniqueId));
    sec_signal_2 = eval(sprintf('sec_signal_2_%s', uniqueId)); % time vector for delta465
    
    band_powers = eval(sprintf('band_powers_%s', uniqueId));
    sigma_power = band_powers{4};  % sigma power from spectrogram
    time_spectrogram_zero = eval(sprintf('time_spectrogram_zero_%s', uniqueId));
    
    fprintf('Processing mouse %s with %d HRB events...\n', uniqueId, length(HRB_time));
    
    % --- Process each HRB event ---
    for event_i = 1:length(HRB_time)
        eventTime = HRB_time(event_i);
        
        % *** Exclude HRB events that occur during a laser period ***
        if ~isempty(laser_periods)
            % If eventTime lies between any laser_onset and laser_offset, skip it.
            if any(eventTime >= laser_periods(:,1) & eventTime <= laser_periods(:,2))
                fprintf('Mouse %s, event %d: skipped (laser ON).\n', uniqueId, event_i);
                continue;
            end
        end
        
        % --- Check if the desired window lies within the sleep time ---
        if (eventTime - preTime) < sleep_time(1) || (eventTime + postTime) > sleep_time(end)
            fprintf('Mouse %s, event %d: skipped (window out of bounds).\n', uniqueId, event_i);
            continue;
        end
        
        % --- Check that the event occurs during valid sleep ---
        eventIdx_sleep = round(eventTime) + 1;  % since sleep_time starts at 0 sec
        if ~validSleep(eventIdx_sleep)
            fprintf('Mouse %s, event %d: skipped (not in valid sleep state).\n', uniqueId, event_i);
            continue;
        end
        
        % --- Check contiguous valid sleep block to avoid transitions ---
        blockStart = eventIdx_sleep;
        while blockStart > 1 && validSleep(blockStart-1)
            blockStart = blockStart - 1;
        end
        blockEnd = eventIdx_sleep;
        while blockEnd < length(validSleep) && validSleep(blockEnd+1)
            blockEnd = blockEnd + 1;
        end
        if (eventTime - (blockStart-1) < transitionBuffer) || ((blockEnd-1) - eventTime < transitionBuffer)
            fprintf('Mouse %s, event %d: skipped (too close to state transition).\n', uniqueId, event_i);
            continue;
        end
        
        % --- Extract RR data (fs_RR) ---
        [~, idx_RR] = min(abs(RR_time - eventTime));
        if (idx_RR - floor(preTime*fs_RR) < 1) || (idx_RR + floor(preTime*fs_RR) > length(RR_time))
            fprintf('Mouse %s, event %d: skipped (RR window out of bounds).\n', uniqueId, event_i);
            continue;
        end
        rr_segment = RR(idx_RR - floor(preTime*fs_RR) : idx_RR + floor(preTime*fs_RR));
        if length(rr_segment) ~= expected_RR_length
            fprintf('Mouse %s, event %d: skipped (RR segment length %d, expected %d).\n',...
                uniqueId, event_i, length(rr_segment), expected_RR_length);
            continue;
        end
        fprintf('Mouse %s, event %d: RR segment length = %d.\n', uniqueId, event_i, length(rr_segment));
        
        % --- Extract delta465 data (fs_delta465) ---
        [~, idx_delta] = min(abs(sec_signal_2 - eventTime));
        if (idx_delta - floor(preTime*fs_delta465) < 1) || (idx_delta + floor(preTime*fs_delta465) > length(sec_signal_2))
            fprintf('Mouse %s, event %d: skipped (delta465 window out of bounds).\n', uniqueId, event_i);
            continue;
        end
        delta_segment = delta465(idx_delta - floor(preTime*fs_delta465) : idx_delta + floor(preTime*fs_delta465));
        if length(delta_segment) ~= expected_delta465_length
            fprintf('Mouse %s, event %d: skipped (delta465 segment length %d, expected %d).\n',...
                uniqueId, event_i, length(delta_segment), expected_delta465_length);
            continue;
        end
        fprintf('Mouse %s, event %d: delta465 segment length = %d.\n', uniqueId, event_i, length(delta_segment));
        
        % --- Extract sigma data (fs_sigma) ---
        [~, idx_sigma] = min(abs(time_spectrogram_zero - eventTime));
        if (idx_sigma - floor(preTime*fs_sigma) < 1) || (idx_sigma + floor(preTime*fs_sigma) > length(time_spectrogram_zero))
            fprintf('Mouse %s, event %d: skipped (sigma window out of bounds).\n', uniqueId, event_i);
            continue;
        end
        sigma_segment = sigma_power(idx_sigma - floor(preTime*fs_sigma) : idx_sigma + floor(preTime*fs_sigma));
        if length(sigma_segment) ~= expected_sigma_length
            fprintf('Mouse %s, event %d: skipped (sigma segment length %d, expected %d).\n',...
                uniqueId, event_i, length(sigma_segment), expected_sigma_length);
            continue;
        end
        fprintf('Mouse %s, event %d: sigma segment length = %d.\n', uniqueId, event_i, length(sigma_segment));
        
        % --- Append the extracted segments ---
        all_RR_segments = [all_RR_segments; rr_segment(:)'];
        all_delta465_segments = [all_delta465_segments; delta_segment(:)'];
        all_sigma_segments = [all_sigma_segments; sigma_segment(:)'];
        fprintf('After mouse %s, event %d: all_RR_segments size: %s\n', uniqueId, event_i, mat2str(size(all_RR_segments)));
    end
end

if isempty(all_RR_segments) || isempty(all_delta465_segments) || isempty(all_sigma_segments)
    error('No valid events found across mice. Check your event selection criteria.');
end

% Compute mean and SEM for each modality (across all events)
mean_RR = mean(all_RR_segments, 1);
sem_RR  = std(all_RR_segments, 0, 1) / sqrt(size(all_RR_segments, 1));
mean_delta465 = mean(all_delta465_segments, 1);
sem_delta465  = std(all_delta465_segments, 0, 1) / sqrt(size(all_delta465_segments, 1));
mean_sigma = mean(all_sigma_segments, 1);
sem_sigma  = std(all_sigma_segments, 0, 1) / sqrt(size(all_sigma_segments, 1));

% Define common time vectors for plotting (based on expected lengths)
t_RR = linspace(-preTime, postTime, expected_RR_length);
t_delta465 = linspace(-preTime, postTime, expected_delta465_length);
t_sigma = linspace(-preTime, postTime, expected_sigma_length);

% --- EEG-derived sigma power histograms ---
% Process each mouse’s EEG data to calculate sigma band power (8–15 Hz)
all_sigma_EEG_bins = [];  % will accumulate binned sigma power for each event

% Define bin edges for 5-sec intervals over a [-30,30] sec window.
bin_edges = -30:5:30;
nBins = length(bin_edges)-1;

for idx = 1:length(suffix)
    uniqueId = num2str(suffix(idx));
    
    % Retrieve the EEG data, sampling rate, and time vector.
    EEG = eval(sprintf('EEG_%s', uniqueId));
    EEG_fs = eval(sprintf('EEG_fs_%s', uniqueId));  
    if evalin('base', sprintf('exist(''EEG_time_%s'', ''var'')', uniqueId))
        EEG_time = eval(sprintf('EEG_time_%s', uniqueId));
    else
        EEG_time = (0:length(EEG)-1) / EEG_fs;
    end
    
    % Retrieve HRB event times for this mouse
    HRB_time = eval(sprintf('HRB_time_%s', uniqueId));
    HRB_time = HRB_time(:);
    
    % Note: We reuse the laser_periods variable from above if applicable.
    % (If not, it remains empty.)
    for event_i = 1:length(HRB_time)
        eventTime = HRB_time(event_i);
        
        % Exclude events during laser periods
        if ~isempty(laser_periods)
            if any(eventTime >= laser_periods(:,1) & eventTime <= laser_periods(:,2))
                fprintf('Mouse %s, event %d (EEG): skipped (laser ON).\n', uniqueId, event_i);
                continue;
            end
        end
        
        % Find the closest index in EEG_time to the HRB event
        [~, idx_EEG] = min(abs(EEG_time - eventTime));
        
        % Check boundaries: need 30 sec before and after the event.
        if (idx_EEG - 30*EEG_fs < 1) || (idx_EEG + 30*EEG_fs > length(EEG))
            fprintf('Mouse %s, event %d (EEG): EEG segment out of bounds, skipped.\n', uniqueId, event_i);
            continue;
        end
        
        % Extract the EEG segment (60 sec total, centered on the event)
        EEG_segment = EEG(idx_EEG - 30*EEG_fs : idx_EEG + 30*EEG_fs);
        
        % Run the power analysis on this segment using only the sigma band.
        sigma_band_only = {[8,15]};  % only sigma band
        [~, T_EEG, ~, bp_event, ~] = PowerAnalysisEEG(EEG_segment, EEG_fs, frw, 5, sigma_band_only);
        sigma_event = bp_event{1};  % sigma power time series for this event
        
        % Shift the spectrogram time vector so that 0 corresponds to the HRB event.
        T_EEG_shifted = T_EEG - 30;
        
        % Bin the sigma power values into 5-sec intervals.
        bin_idx = discretize(T_EEG_shifted, bin_edges);
        event_bins = nan(1, nBins);
        for j = 1:nBins
            if any(bin_idx == j)
                event_bins(j) = mean(sigma_event(bin_idx == j));
            end
        end
        
        % Append this event's binned data (each row is one event)
        all_sigma_EEG_bins = [all_sigma_EEG_bins; event_bins];
    end
end

% Compute the mean and SEM across events for each bin.
mean_sigma_EEG_bins = nanmean(all_sigma_EEG_bins, 1);
sem_sigma_EEG_bins = nanstd(all_sigma_EEG_bins, 0, 1) / sqrt(size(all_sigma_EEG_bins, 1));

% Define bin centers for plotting.
bin_centers = (bin_edges(1:end-1) + bin_edges(2:end)) / 2;

% --- Plotting all modalities ---
figure;

% Subplot 1: RR Trace
subplot(4,1,1); hold on;
plot(t_RR, mean_RR, 'b', 'LineWidth', 2);
fill([t_RR, fliplr(t_RR)], [mean_RR+sem_RR, fliplr(mean_RR-sem_RR)], 'b', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
title('RR Trace'); xlabel('Time (s)'); ylabel('RR');

% Subplot 2: Norepinephrine (delta465)
subplot(4,1,2); hold on;
plot(t_delta465, mean_delta465, 'r', 'LineWidth', 2);
fill([t_delta465, fliplr(t_delta465)], [mean_delta465+sem_delta465, fliplr(mean_delta465-sem_delta465)], 'r', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
title('Norepinephrine (delta465)'); xlabel('Time (s)'); ylabel('dF/F');

% Subplot 3: Sigma Power (from spectrogram)
subplot(4,1,3); hold on;
plot(t_sigma, mean_sigma, 'g', 'LineWidth', 2);
fill([t_sigma, fliplr(t_sigma)], [mean_sigma+sem_sigma, fliplr(mean_sigma-sem_sigma)], 'g', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
title('Sigma Power (from spectrogram)'); xlabel('Time (s)'); ylabel('Power');

% Subplot 4: EEG-derived sigma power histograms (bar graph)
% Compute overall min/max from (mean - SEM) to (mean + SEM)
lowestVal = min(mean_sigma_EEG_bins - sem_sigma_EEG_bins);
highestVal = max(mean_sigma_EEG_bins + sem_sigma_EEG_bins);
rangeVal = highestVal - lowestVal;
margin = 0.1 * rangeVal;  % 10% margin

lowestAxis = lowestVal - margin;
highestAxis = highestVal + margin;

subplot(4,1,4); hold on;
hBar = bar(bin_centers, mean_sigma_EEG_bins, 1, 'FaceColor', [0.7, 0.7, 0.7], 'EdgeColor', 'none');
% Set the bar's BaseValue so that bars extend upward from the baseline.
set(hBar, 'BaseValue', lowestAxis);
% Overlay error bars for SEM.
errorbar(bin_centers, mean_sigma_EEG_bins, sem_sigma_EEG_bins, 'k.', 'LineWidth', 1.5);
ylim([lowestAxis, highestAxis]);
xlim([-preTime, postTime]);
title('Sigma Power (EEG) Histograms in 5-sec bins');
xlabel('Time (s) relative to HRB event');
ylabel('Sigma Power');


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

yfp = { '420', '484', '468', '408'};
arch = {'387', '412', '414', '416'};

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
[table_NE, table_RR, table_SO, table_Delta, table_Theta, table_Sigma_arch, table_Beta, table_Gamma_low, table_Gamma_high] = create_tables_from_results(results);
table_NE_ds = table_NE(1:5:end, :);
table_RR_ds = table_RR(1:5:end, :);
writetable(table_NE, 'arch_NE_traces_ds.csv')
writetable(table_RR_ds, 'arch_RR_traces.csv')
writetable(table_SO, 'arch_table_SO.csv')
writetable(table_Delta, 'arch_table_Delta.csv')
writetable(table_Theta, 'arch_table_Theta.csv')
writetable(table_Sigma_arch, 'arch_table_Sigma.csv')
writetable(table_Beta, 'arch_table_Beta.csv')
writetable(table_Gamma_low, 'arch_table_Gamma_low.csv')
writetable(table_Gamma_high, 'arch_table_Gamma_high.csv')

[NE_table, RR_table, SO_table, Delta_table, Theta_table, Sigma_table, Beta_table, Gamma_low_table, Gamma_high_table] = figure_2_reorganized(results, epoc_start, epoc_end, main_title_arch, titles);
figure_2_reorganized_mean_centered(results, epoc_start, epoc_end, main_title_arch, titles);
figure_2_reorganized(results, epoc_start, epoc_end, main_title_arch, titles);

yfp = {'408', '420', '484', '468', '015' '079', '089'};
arch = {'387', '403', '412', '414', '416', '013', '019'};

%Run figure for single animal
saveDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\arch_yfp\Copy_of_figure_3_data';
results_single = aggregate_event_data_single(saveDirectory, event_var, '015', data_types);
figure_2_reorganized_single(results_single, epoc_start, epoc_end, '015' , titles)
%% AUC !!!

%% AUC diff ARCH/YFP
event_var = {'laser_on_NREM'};
titles = {'Laser On'};
saveDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\arch_yfp\Copy_of_figure_3_data';
outputDirectory = fullfile(saveDirectory, 'AUC');
yfp = {'408', '420', '484', '468', '015' '079', '089'};
arch = {'387', '412', '414', '416', '013', '019'};
yfp = { '420', '484', '468', '408'};
arch = {'387', '412', '414', '416'};
Suffix = {'408', '420', '484', '468', '015' '079', '089', '387', '412', '414', '416', '013', '019'};

yfp = { '420', '484', '468', '408'};
arch = {'387', '412', '414', '416'};

% % Define the times_matrix
% times_matrix_post = struct();
% times_matrix_post.NE.range = [30, 45];
% times_matrix_post.RR.range = [30, 45];
% times_matrix_post.EEG.range = [30, 45];
% 
% times_matrix_pre = struct();
% times_matrix_pre.NE.range = [-25, -10];
% times_matrix_pre.RR.range = [-25, -10];
% times_matrix_pre.EEG.range = [-25, -10];

% Define the times_matrix
times_matrix_post = struct();
times_matrix_post.NE.range = [5, 40];
times_matrix_post.RR.range = [5, 40];
times_matrix_post.EEG.range = [5, 40];

times_matrix_pre = struct();
times_matrix_pre.NE.range = [-40, -5];
times_matrix_pre.RR.range = [-40, -5];
times_matrix_pre.EEG.range = [-40, -5];

% Call the function with the specified time range
%auc_data = extract_auc_and_plot(o, event_var, saveDirectory, times_matrix_post, outputDirectory, titles);

auc_data_yfp = extract_auc_and_plot_3(yfp, event_var, saveDirectory, times_matrix_pre, times_matrix_post); %This is the right one
auc_diff_table_yfp = plot_auc_bar(auc_data_yfp, event_var, yfp, titles);
writetable(auc_diff_table_yfp, 'yfp_auc_table.csv')

auc_data_arch = extract_auc_and_plot_3(arch, event_var, saveDirectory, times_matrix_pre, times_matrix_post); %This is the right one
auc_diff_table_arch = plot_auc_bar(auc_data_arch, event_var, arch, titles);
writetable(auc_diff_table_arch, 'arch_auc_table.csv')

% Update AUC_table

auc_diff_table_combined = [auc_diff_table_yfp; auc_diff_table_arch];

% Assuming auc_diff_table and updated_table from the previous functions are already in the workspace
auc_diff_table_mean = compute_mean_by_subject(auc_diff_table_combined);
% Merge the two tables on the Suffix column
merged_table = outerjoin(auc_diff_table_mean, data_table, 'MergeKeys', true);
%merged_table = outerjoin(average_AUC_table_RR, data_table, 'MergeKeys', true);

average_AUC_table_RR
% Display the merged table
disp(merged_table);

plot_correlation_memory_arch(merged_table, arch, yfp, 'mean_RR'); % Change 'AUC_diff' to any other variable as needed

%Export memory table
writetable(merged_table, 'memory_table.csv')

% AUC will be subtracting -40 to -5 from 5 to 40
%% Export AUC to R

auc_table_arch = condition_column_to_AUC(auc_diff_table_combined, arch, yfp);
writetable(auc_table_arch, 'AUC_for_R_batch_1_old.csv')

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
%% Make sleep (/NREM/REM) periods
% List of suffixes for each animal
suffixes = {'387', '412', '414', '416', '408', '420', '484', '468'}; % Add more suffixes as needed

% Loop through each suffix
for s = 1:length(suffixes)
    suffix = suffixes{s};
    
    % Construct variable names with the current suffix
    sws_varName = ['sws_binary_vector_', suffix];
    MA_varName = ['MA_binary_vector_', suffix];
    REM_varName = ['REM_binary_vector_', suffix];

    % Check if the variables exist in the environment
    if exist(sws_varName, 'var') && exist(MA_varName, 'var') && exist(REM_varName, 'var')
        % Retrieve the variables from the workspace
        sws_binary_vector = eval(sws_varName);
        MA_binary_vector = eval(MA_varName);
        REM_binary_vector = eval(REM_varName);
        
        % Add the binary vectors to create sleep_binary (including SWS, MA, and REM)
        sleep_binary = sws_binary_vector + MA_binary_vector + REM_binary_vector;
        sleep_binary(sleep_binary > 1) = 1; % Ensure it remains binary
        
        % Convert sleep_binary to sleep_periods
        [sleep_onset, sleep_offset] = binaryToOnOff(sleep_binary);
        sleep_periods = [sleep_onset; sleep_offset];
        sleep_periods = sleep_periods';

        % Save the results with a new name
        sleep_binary_name = ['sleep_binary_', suffix];
        sleep_periods_name = ['sleep_periods_', suffix];
        assignin('base', sleep_binary_name, sleep_binary);
        assignin('base', sleep_periods_name, sleep_periods);
    else
        warning('Variables %s, %s, and/or %s do not exist in the workspace.', sws_varName, MA_varName, REM_varName);
    end
end

% Clear temporary variables
clear baseVariables suffixes s suffix sws_varName MA_varName REM_varName sws_binary_vector MA_binary_vector REM_binary_vector sleep_binary sleep_onset sleep_offset sleep_periods sleep_binary_name sleep_periods_name;



%% Get RR from NREMiclMA
suffixes = {'387', '412', '414', '416', '408', '420', '484', '468'}; % Add more suffixes as needed
Suffix = {'408', '420', '484', '468', '015' '079', '089', '387', '412', '414', '416', '013', '019'};

RR_data_NREM_table = process_NREM_with_laser(suffixes);
NE_data_NREM_table = process_NREM_with_laser_NE(suffixes);

RR_data_NREM_table = process_NREM_no_laser(suffixes);
NE_data_NREM_table = process_NREM_no_laser_NE(suffixes);



%% RR PSD plot
yfp = {'408', '420', '484', '468'};
arch = {'387', '412', '414', '416'};
psd_table = plot_PSD_with_laser(RR_data_NREM_table, arch, yfp, 60);
[psd_table_NE, AUC_table_NE, PeakFrequency_table_NE, PeakPower_table_NE]= plot_PSD_with_laser_NE(NE_data_NREM_table, arch, yfp, 60);
[psd_table_RR, AUC_table_RR, PeakFrequency_table_RR, PeakPower_table_RR]= plot_PSD_with_laser_RR(RR_data_NREM_table, arch, yfp, 60, 1);

%Updated PSd with no Laser on/off element added
[psd_table_NE, AUC_table_NE, PeakFrequency_table_NE, PeakPower_table_NE]= PSD_no_laser_NE(NE_data_NREM_table, arch, yfp, 60);
[psd_table_RR, AUC_table_RR, PeakFrequency_table_RR, PeakPower_table_RR]= PSD_no_laser_RR(RR_data_NREM_table, arch, yfp, 60, 0.15);


[psd_table, AUC_table, PeakFrequency_table, PeakPower_table] = plot_PSD_with_laser_combined(NE_data_NREM_table, RR_data_NREM_table, arch, yfp, 60, 60);

filtered_AUC_table_RR = AUC_table_RR(ismember(AUC_table_RR.EventVar, {'Arch_on', 'Yfp_on'}), :);
average_AUC_table_RR = groupsummary(filtered_AUC_table_RR, 'Suffix', 'mean', 'AUC');

%Export traces
writetable(psd_table_NE, 'PSD_traces_NE.csv')
writetable(psd_table_RR, 'PSD_traces_RR.csv')
%% Created weigthed mean/SEM for PSD quantification export

% Define the groups
groups = {'Arch', 'YFP'};

% Initialize arrays to store results
weighted_means = zeros(length(groups), 1);
weighted_sems = zeros(length(groups), 1);

for i = 1:length(groups)
    % Select data for the current group
    group = groups{i};
    idx = strcmp(PeakFrequency_table_NE.EventVar, group);
    data = PeakFrequency_table_NE.PeakFrequency(idx);
    weights = PeakFrequency_table_NE.BoutLength(idx);
    n = sum(idx); % Number of events (rows) in the data for this group
    
    % Calculate weighted mean
    weighted_mean = sum(weights .* data) / sum(weights);
    weighted_means(i) = weighted_mean;
    
    % Calculate weighted variance
    weighted_variance = sum(weights .* (data - weighted_mean).^2) / sum(weights);
    
    % Calculate weighted standard error of the mean (SEM)
    % SEM is the square root of the weighted variance divided by sqrt(n)
    weighted_sem = sqrt(weighted_variance) / sqrt(n);
    weighted_sems(i) = weighted_sem;
end

% Create a table to display the results
result_table = table(groups', weighted_means, weighted_sems, 'VariableNames', {'EventVar', 'WeightedMean', 'WeightedSEM'});

%% Get weighted mean per subject

% Define the suffixes
suffixes = {'387', '412', '414', '416', '408', '420', '484', '468'}; % Add more suffixes as needed

% Initialize arrays to store results
weighted_means = zeros(length(suffixes), 1);
weighted_sems = zeros(length(suffixes), 1);

for i = 1:length(suffixes)
    % Select data for the current suffix
    suffix = suffixes{i};
    idx = strcmp(AUC_table_RR.Suffix, suffix);
    data = AUC_table_RR.AUC(idx);
    weights = AUC_table_RR.BoutLength(idx);
    n = sum(idx); % Number of events (rows) for this suffix
    
    % Check if there is data for this suffix
    if n > 0
        % Calculate weighted mean
        weighted_mean = sum(weights .* data) / sum(weights);
        weighted_means(i) = weighted_mean;
        
        % Calculate weighted variance
        weighted_variance = sum(weights .* (data - weighted_mean).^2) / sum(weights);
        
        % Calculate weighted standard error of the mean (SEM)
        % SEM is the square root of the weighted variance divided by sqrt(n)
        weighted_sem = sqrt(weighted_variance) / sqrt(n);
        weighted_sems(i) = weighted_sem;
    else
        % If no data is available for this suffix, assign NaN
        weighted_means(i) = NaN;
        weighted_sems(i) = NaN;
    end
end

% Create a table to display the results
result_table = table(suffixes', weighted_means, weighted_sems, 'VariableNames', {'Suffix', 'WeightedMean', 'WeightedSEM'});

% Display the results
disp(result_table);


%% Create memory table
% Create the data
Suffix = {'387', '399', '392', '403', '412', '414', '416', '418', '486', '408', '420', '468', '477', '484', '015', '079', '089', '013', '019'};
%sigma_power_increase = [0.056842, 0.057477, 0.047644, 0.062896, 0.064325, 0.068995, 0.080907, 0.045944, 0.051554, 0.016309, 0.041683, 0.012267, 0.03086, 0.058014]';
novel_familiar_ratio = [1.12, 1.75, 1.384615, 1.15, 3, 1.5, 2.166667, 0.75, 1.666667, 0, 0.909091, 1.3, 0.272727, 1.444444, 1.5, 1, 2.5, 2.3333, 1.3333]';
Suffix = Suffix';
% Create the table
data_table = table(Suffix, novel_familiar_ratio);

merged_table = outerjoin(result_table, data_table, 'MergeKeys', true);

plot_correlation_memory_arch(merged_table, arch, yfp, 'WeightedMean'); % Change 'AUC_diff' to any other variable as needed


%% R export of PSD related items

% Update for R export
AUC_table_RR = add_condition_column(AUC_table_RR);
PeakFrequency_table_RR = add_condition_column(PeakFrequency_table_RR);
PeakPower_table_RR = add_condition_column(PeakPower_table_RR);

%Export to R
writetable(AUC_table_RR, 'RR_AUC_PSD_for_R.csv')
writetable(PeakFrequency_table_RR, 'RR_PeakFrequency_table_for_R.csv')
writetable(PeakPower_table_RR, 'RR_PeakPower_table_for_R.csv')

% Update for R export
AUC_table_NE = add_condition_column(AUC_table_NE);
PeakFrequency_table_NE = add_condition_column(PeakFrequency_table_NE);
PeakPower_table_NE = add_condition_column(PeakPower_table_NE);

%Export to R
writetable(AUC_table_NE, 'NE_AUC_PSD_for_R.csv')
writetable(PeakFrequency_table_NE, 'NE_PeakFrequency_table_for_R.csv')
writetable(PeakPower_table_NE, 'NE_PeakPower_table_for_R.csv')

%% Graphpad for no laser

% Extract the AUC values corresponding to 'Arch' and 'YFP'
AUC_Arch = AUC_table_NE.AUC(strcmp(AUC_table_NE.EventVar, 'Arch'));
AUC_YFP = AUC_table_NE.AUC(strcmp(AUC_table_NE.EventVar, 'YFP'));

% Find the length of the longest vector
max_length = max(length(AUC_Arch), length(AUC_YFP));

% Pad the shorter vector with NaNs
if length(AUC_Arch) < max_length
    AUC_Arch = [AUC_Arch; nan(max_length - length(AUC_Arch), 1)];
elseif length(AUC_YFP) < max_length
    AUC_YFP = [AUC_YFP; nan(max_length - length(AUC_YFP), 1)];
end

% Create a new table with two columns for 'Arch' and 'YFP', now padded with NaNs
AUC_split_table_NE = table(AUC_Arch, AUC_YFP, 'VariableNames', {'AUC_Arch', 'AUC_YFP'});




% Extract the AUC values corresponding to 'Arch' and 'YFP'
AUC_Arch = AUC_table_RR.AUC(strcmp(AUC_table_RR.EventVar, 'Arch'));
AUC_YFP = AUC_table_RR.AUC(strcmp(AUC_table_RR.EventVar, 'YFP'));

% Find the length of the longest vector
max_length = max(length(AUC_Arch), length(AUC_YFP));

% Pad the shorter vector with NaNs
if length(AUC_Arch) < max_length
    AUC_Arch = [AUC_Arch; nan(max_length - length(AUC_Arch), 1)];
elseif length(AUC_YFP) < max_length
    AUC_YFP = [AUC_YFP; nan(max_length - length(AUC_YFP), 1)];
end

% Create a new table with two columns for 'Arch' and 'YFP', now padded with NaNs
AUC_split_table_RR = table(AUC_Arch, AUC_YFP, 'VariableNames', {'AUC_Arch', 'AUC_YFP'});



% Extract the PeakFrequency values corresponding to 'Arch' and 'YFP'
PeakFrequency_Arch = PeakFrequency_table_NE.PeakFrequency(strcmp(PeakFrequency_table_NE.EventVar, 'Arch'));
PeakFrequency_YFP = PeakFrequency_table_NE.PeakFrequency(strcmp(PeakFrequency_table_NE.EventVar, 'YFP'));

% Find the length of the longest vector
max_length = max(length(PeakFrequency_Arch), length(PeakFrequency_YFP));

% Pad the shorter vector with NaNs
if length(PeakFrequency_Arch) < max_length
    PeakFrequency_Arch = [PeakFrequency_Arch; nan(max_length - length(PeakFrequency_Arch), 1)];
elseif length(PeakFrequency_YFP) < max_length
    PeakFrequency_YFP = [PeakFrequency_YFP; nan(max_length - length(PeakFrequency_YFP), 1)];
end

% Create a new table with two columns for 'Arch' and 'YFP', now padded with NaNs
PeakFrequency_split_table_NE = table(PeakFrequency_Arch, PeakFrequency_YFP, 'VariableNames', {'PeakFrequency_Arch', 'PeakFrequency_YFP'});




% Extract the PeakFrequency values corresponding to 'Arch' and 'YFP'
PeakFrequency_Arch = PeakFrequency_table_RR.PeakFrequency(strcmp(PeakFrequency_table_RR.EventVar, 'Arch'));
PeakFrequency_YFP = PeakFrequency_table_RR.PeakFrequency(strcmp(PeakFrequency_table_RR.EventVar, 'YFP'));

% Find the length of the longest vector
max_length = max(length(PeakFrequency_Arch), length(PeakFrequency_YFP));

% Pad the shorter vector with NaNs
if length(PeakFrequency_Arch) < max_length
    PeakFrequency_Arch = [PeakFrequency_Arch; nan(max_length - length(PeakFrequency_Arch), 1)];
elseif length(PeakFrequency_YFP) < max_length
    PeakFrequency_YFP = [PeakFrequency_YFP; nan(max_length - length(PeakFrequency_YFP), 1)];
end

% Create a new table with two columns for 'Arch' and 'YFP', now padded with NaNs
PeakFrequency_split_table_RR = table(PeakFrequency_Arch, PeakFrequency_YFP, 'VariableNames', {'PeakFrequency_Arch', 'PeakFrequency_YFP'});





% Extract the PeakFrequency values corresponding to 'Arch' and 'YFP'
PeakPower_Arch = PeakPower_table_NE.PeakPower(strcmp(PeakPower_table_NE.EventVar, 'Arch'));
PeakPower_YFP = PeakPower_table_NE.PeakPower(strcmp(PeakPower_table_NE.EventVar, 'YFP'));

% Find the length of the longest vector
max_length = max(length(PeakPower_Arch), length(PeakPower_YFP));

% Pad the shorter vector with NaNs
if length(PeakPower_Arch) < max_length
    PeakPower_Arch = [PeakPower_Arch; nan(max_length - length(PeakPower_Arch), 1)];
elseif length(PeakPower_YFP) < max_length
    PeakPower_YFP = [PeakPower_YFP; nan(max_length - length(PeakPower_YFP), 1)];
end

% Create a new table with two columns for 'Arch' and 'YFP', now padded with NaNs
PeakPower_split_table_NE = table(PeakPower_Arch, PeakPower_YFP, 'VariableNames', {'PeakPower_Arch', 'PeakPower_YFP'});




% Extract the PeakFrequency values corresponding to 'Arch' and 'YFP'
PeakPower_Arch = PeakPower_table_RR.PeakPower(strcmp(PeakPower_table_RR.EventVar, 'Arch'));
PeakPower_YFP = PeakPower_table_RR.PeakPower(strcmp(PeakPower_table_RR.EventVar, 'YFP'));

% Find the length of the longest vector
max_length = max(length(PeakPower_Arch), length(PeakPower_YFP));

% Pad the shorter vector with NaNs
if length(PeakPower_Arch) < max_length
    PeakPower_Arch = [PeakPower_Arch; nan(max_length - length(PeakPower_Arch), 1)];
elseif length(PeakPower_YFP) < max_length
    PeakPower_YFP = [PeakPower_YFP; nan(max_length - length(PeakPower_YFP), 1)];
end

% Create a new table with two columns for 'Arch' and 'YFP', now padded with NaNs
PeakPower_split_table_RR = table(PeakPower_Arch, PeakPower_YFP, 'VariableNames', {'PeakPower_Arch', 'PeakPower_YFP'});


writetable(AUC_split_table_NE, 'NE_AUC_for_Graphpad.csv')
writetable(AUC_split_table_RR, 'RR_AUC_for_Graphpad.csv')
writetable(PeakFrequency_split_table_NE, 'NE_PeakFrequency_for_Graphpad.csv')
writetable(PeakFrequency_split_table_RR, 'RR_PeakFrequency_for_Graphpad.csv')
writetable(PeakPower_split_table_NE, 'NE_PeakPower_for_Graphpad.csv')
writetable(PeakPower_split_table_RR, 'RR_PeakPower_for_Graphpad.csv')

% Define the six datasets
datasets = {AUC_split_table_NE, AUC_split_table_RR, ...
            PeakFrequency_split_table_NE, PeakFrequency_split_table_RR, ...
            PeakPower_split_table_NE, PeakPower_split_table_RR};

% Titles for each subplot
titles = {'AUC NE', 'AUC RR', 'Peak Frequency NE', 'Peak Frequency RR', 'Peak Power NE', 'Peak Power RR'};

% Prepare figure
figure;

% Loop through each dataset and plot
for i = 1:length(datasets)
    % Extract current dataset
    current_table = datasets{i};
    
    % Extract 'Arch' and 'YFP' data, ignoring NaNs
    arch_data = current_table{:, 1};  % Arch data
    yfp_data = current_table{:, 2};   % YFP data
    
    arch_data = arch_data(~isnan(arch_data));  % Remove NaNs
    yfp_data = yfp_data(~isnan(yfp_data));    % Remove NaNs
    
    % Calculate means and SEM
    mean_arch = mean(arch_data);
    sem_arch = std(arch_data) / sqrt(length(arch_data));
    
    mean_yfp = mean(yfp_data);
    sem_yfp = std(yfp_data) / sqrt(length(yfp_data));
    
    % Create subplot for this dataset
    subplot(2, 3, i);
    
    % Bar plot
    bar_data = [mean_arch, mean_yfp];
    bar(bar_data);
    
    % Hold the current plot to add error bars
    hold on;
    
    % Error bars
    errorbar(1, mean_arch, sem_arch, 'k', 'linestyle', 'none');
    errorbar(2, mean_yfp, sem_yfp, 'k', 'linestyle', 'none');
    
    % Set x-axis labels
    set(gca, 'XTickLabel', {'Arch', 'YFP'});
    
    % Set title
    title(titles{i});
    
    % Set y-axis label
    ylabel('Mean Value');
    
    % Adjust axis for better readability
    ylim([min([mean_arch - sem_arch, mean_yfp - sem_yfp]) - 0.1, ...
          max([mean_arch + sem_arch, mean_yfp + sem_yfp]) + 0.1]);
    
    % Release hold on plot
    hold off;
end

% Set figure title
suptitle('Comparison of Arch and YFP across Datasets');


    %% Export peak frquency to graphpad format
% Define the unique event options
event_options = {'Arch_on', 'Arch_off', 'Yfp_on', 'Yfp_off'};

% Initialize the combined table with PeakFrequency for NE and RR as the first columns
combined_table_graphpad_peak = table(PeakFrequency_table_NE.PeakFrequency, PeakFrequency_table_RR.PeakFrequency, ...
    'VariableNames', {'peakfre_NE', 'peakfre_RR'});

% Loop over the event options for Peak Frequency NE
for i = 1:length(event_options)
    event = event_options{i};

    % Initialize the column for the current event option with NaN
    peakfre_NE_column = NaN(height(PeakFrequency_table_NE), 1);

    % Find the indices for the current event option
    indices = strcmp(PeakFrequency_table_NE.EventVar, event);

    % Assign the PeakFrequency values to the corresponding event option
    peakfre_NE_column(indices) = PeakFrequency_table_NE.PeakFrequency(indices);

    % Add the column to the combined table with the appropriate name
    combined_table_graphpad_peak = [combined_table_graphpad_peak, ...
        table(peakfre_NE_column, 'VariableNames', {['peakfre_NE_' event]})];
end

% Loop over the event options for Peak Frequency RR
for i = 1:length(event_options)
    event = event_options{i};

    % Initialize the column for the current event option with NaN
    peakfre_RR_column = NaN(height(PeakFrequency_table_RR), 1);

    % Find the indices for the current event option
    indices = strcmp(PeakFrequency_table_RR.EventVar, event);

    % Assign the PeakFrequency values to the corresponding event option
    peakfre_RR_column(indices) = PeakFrequency_table_RR.PeakFrequency(indices);

    % Add the column to the combined table with the appropriate name
    combined_table_graphpad_peak = [combined_table_graphpad_peak, ...
        table(peakfre_RR_column, 'VariableNames', {['peakfre_RR_' event]})];
end

% Write the combined table to a CSV file
 writetable(combined_table_graphpad_peak, 'peakfreq_NE_RR_PSD.csv');

%% For AUC Table
%% For AUC Table
% Initialize the combined table with AUC for NE and RR as the first columns
combined_table_graphpad_AUC = table(AUC_table_NE.AUC, AUC_table_RR.AUC, ...
    'VariableNames', {'AUC_NE', 'AUC_RR'});

% Loop over the event options for AUC NE
for i = 1:length(event_options)
    event = event_options{i};

    % Initialize the column for the current event option with NaN
    AUC_NE_column = NaN(height(AUC_table_NE), 1);

    % Find the indices for the current event option
    indices = strcmp(AUC_table_NE.EventVar, event);

    % Assign the AUC values to the corresponding event option
    AUC_NE_column(indices) = AUC_table_NE.AUC(indices);

    % Add the column to the combined table with the appropriate name
    combined_table_graphpad_AUC = [combined_table_graphpad_AUC, ...
        table(AUC_NE_column, 'VariableNames', {['AUC_NE_' event]})];
end

% Loop over the event options for AUC RR
for i = 1:length(event_options)
    event = event_options{i};

    % Initialize the column for the current event option with NaN
    AUC_RR_column = NaN(height(AUC_table_RR), 1);

    % Find the indices for the current event option
    indices = strcmp(AUC_table_RR.EventVar, event);

    % Assign the AUC values to the corresponding event option
    AUC_RR_column(indices) = AUC_table_RR.AUC(indices);

    % Add the column to the combined table with the appropriate name
    combined_table_graphpad_AUC = [combined_table_graphpad_AUC, ...
        table(AUC_RR_column, 'VariableNames', {['AUC_RR_' event]})];
end


% Write the combined table to a CSV file
writetable(combined_table_graphpad_AUC, 'AUC_NE_RR_PSD.csv');

%% For Peak Power Table
% Initialize the combined table with PeakPower for NE and RR as the first columns
combined_table_graphpad_power = table(PeakPower_table_NE.PeakPower, PeakPower_table_RR.PeakPower, ...
    'VariableNames', {'PeakPower_NE', 'PeakPower_RR'});

% Loop over the event options for Peak Power NE
for i = 1:length(event_options)
    event = event_options{i};

    % Initialize the column for the current event option with NaN
    PeakPower_NE_column = NaN(height(PeakPower_table_NE), 1);

    % Find the indices for the current event option
    indices = strcmp(PeakPower_table_NE.EventVar, event);

    % Assign the PeakPower values to the corresponding event option
    PeakPower_NE_column(indices) = PeakPower_table_NE.PeakPower(indices);

    % Add the column to the combined table with the appropriate name
    combined_table_graphpad_power = [combined_table_graphpad_power, ...
        table(PeakPower_NE_column, 'VariableNames', {['PeakPower_NE_' event]})];
end

% Loop over the event options for Peak Power RR
for i = 1:length(event_options)
    event = event_options{i};

    % Initialize the column for the current event option with NaN
    PeakPower_RR_column = NaN(height(PeakPower_table_RR), 1);

    % Find the indices for the current event option
    indices = strcmp(PeakPower_table_RR.EventVar, event);

    % Assign the PeakPower values to the corresponding event option
    PeakPower_RR_column(indices) = PeakPower_table_RR.PeakPower(indices);

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
