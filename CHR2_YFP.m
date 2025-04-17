% Load the time stamps
% TDT recording time for changing threshold to:
% -15     -10;     -5;     0;     +5;     No stim

%ChR2
laser_shift_489 = {'2:50:55' '3:51:55' '4:52:20' '5:52:57' '6:50:52' '7:50:50'}; %
laser_shift_480 = {'03:46:16' '04:46:16' '05:46:16' '06:46:16' '7:53:15' '8:55:07'};
laser_shift_491 = {'3:05:05' '4:05:08' '5:05:50' '6:06:30' '7:05:07' '8:06:37'}; %
laser_shift_497 = {'02:52:09' '03:52:09' '04:52:09' '05:52:09' '06:52:09' '07:52:10'}; %
laser_shift_511 = {'2:26:30' '3:30:59' '4:26:29' '5:26:25' '6:26:23' '7:26:22'}; %
laser_shift_522 = {'2:43:00' '3:50:00' '4:50:00' '5:48:00' '6:48:00' '7:48:00'}; %

%control
laser_shift_584 = {'2:31:00' '3:32:05' '4:32:30' '5:33:10' '6:33:25' '7:32:40'}; %
laser_shift_577 = {'3:02:25' '4:02:58' '05:03:37' '06:03:58' '07:04:30' '8:05:51'}; %
laser_shift_586 = {'2:49:33' '3:49:47' '4:50:06' '5:49:35' '6:49:35' '7:49:34'}; %
laser_shift_512 = {'2:43:49' '3:43:51' '4:43:49' '5:44:18' '6:44:12' '7:44:20'}; %
laser_shift_513 = {'2:43:00' '3:50:00' '4:50:00' '5:48:00' '6:48:00' '7:48:00'}; %

% thrshldtime_optoChR2_20211220_509_YFP = {'2:26:30' ' 3:30:59' '4:26:29' '5:26:25' '6:26:23' '7:26:22'};
% thrshldtime_optoChR2_20211221_514_ChR2 = {'2:43:49' '3:43:51' '4:43:49' '5:44:18' '6:44:12' '7:44:20'};
%thrshldtime_optoChR2_20210826_493_ChR2 = {'3:00:02' '4:00:50' '5:01:07' '6:02:00' '7:00:02' ''};
%% Check time to fall asleep
yfp = {'584', '577', '512', '513'};
chr2 = {'489', '480', '491', '497', '511', '522'};
o = {'205', '207', '209', '420', '588', '201', '213'};
t = {'124', '115', '122'};
sleep_onset_table = identify_first_sleep_onset(o, t);

%% Interp the saved EEG/EMG
% Directory where the original EEG traces are stored
sourceDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\Traces';

% Directory where the processed EEG traces will be saved
dataDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\Traces\EEG_filt';

% Ensure the save directory exists
if ~exist(dataDirectory, 'dir')
    mkdir(dataDirectory);
end

% Unique IDs for the EEG files
uniqueIDs = {'480', '489', '491', '497', '511', '512', '513', '522', '577', '584', '586'};

% Loop through each unique ID and process the corresponding EEG file
for i = 1:length(uniqueIDs)
    % Construct the filenames for the EEG, EEG_fs, and sec_signal_EEG files
    eegFileName = fullfile(sourceDirectory, ['EEG_', uniqueIDs{i}, '.mat']);
    secSignalFileName = fullfile(sourceDirectory, ['sec_signal_EEG_', uniqueIDs{i}, '.mat']);
    
    % Check if the files exist
    if exist(eegFileName, 'file') && exist(secSignalFileName, 'file')
        % Load the EEG, and sec_signal_EEG files
        load(eegFileName, ['EEG_', uniqueIDs{i}]);
        load(secSignalFileName, ['sec_signal_EEG_', uniqueIDs{i}]);
        
        % Extract the loaded variables
        EEG_rawtrace = eval(['EEG_', uniqueIDs{i}]);
        sec_signal_EEG = eval(['sec_signal_EEG_', uniqueIDs{i}]);
        
        % Generate EEG_time based on the EEG_fs
        
        % Run the interpolation function on the loaded data
        [EEG_rawtrace, EEG_time] = interpolate_EMG_EEG(EEG_rawtrace, sec_signal_EEG);
        
        % Assign the processed data to variables with the unique ID
        eval(['EEG_', uniqueIDs{i}, ' = EEG_rawtrace;']);
        eval(['sec_signal_EEG_', uniqueIDs{i}, ' = EEG_time;']);
        
        % Create the new filenames for saving
        newEEGFileName = fullfile(dataDirectory, ['EEG_', uniqueIDs{i}, '.mat']);
        newSecSignalFileName = fullfile(dataDirectory, ['sec_signal_EEG_', uniqueIDs{i}, '.mat']);
        
        % Save the processed EEG data to the new file
        save(newEEGFileName, ['EEG_', uniqueIDs{i}]);
        save(newSecSignalFileName, ['sec_signal_EEG_', uniqueIDs{i}]);
        
        % Clear the variables from the workspace
        clear(['EEG_', uniqueIDs{i}]);
        clear(['sec_signal_EEG_', uniqueIDs{i}]);
        clear EEG_rawtrace EEG_time sec_signal_EEG;
    else
        warning('File %s, %s, or %s does not exist.', eegFileName, eegFsFileName, secSignalFileName);
    end
end
%% Check all variables are there 

% Unique IDs for the files
uniqueIDs = {'480', '489', '491', '497', '511', '512', '513', '522', '577', '584', '586'};

% Directory where the RR and delta465_filt_2 files are stored
rrDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\RR';
deltaDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\Traces';

% Loop through each unique ID and create plots
for i = 1:length(uniqueIDs)
    % Construct the filenames for the RR and delta465_filt_2 files
    rrFileName = fullfile(rrDirectory, ['RR_', uniqueIDs{i}, '.mat']);
    rrTimeFileName = fullfile(rrDirectory, ['RR_time_', uniqueIDs{i}, '.mat']);
    deltaFileName = fullfile(deltaDirectory, ['delta465_filt_2_', uniqueIDs{i}, '.mat']);
    secSignalFileName = fullfile(deltaDirectory, ['sec_signal_2_', uniqueIDs{i}, '.mat']);
    
    % Check if the files exist
    if exist(rrFileName, 'file') && exist(rrTimeFileName, 'file') && exist(deltaFileName, 'file') && exist(secSignalFileName, 'file')
        % Load the RR and delta465_filt_2 files
        load(rrFileName, ['RR_', uniqueIDs{i}]);
        load(rrTimeFileName, ['RR_time_', uniqueIDs{i}]);
        load(deltaFileName, ['delta465_filt_2_', uniqueIDs{i}]);
        load(secSignalFileName, ['sec_signal_2_', uniqueIDs{i}]);
        
        % Extract the loaded variables
        RR = eval(['RR_', uniqueIDs{i}]);
        RR_time = eval(['RR_time_', uniqueIDs{i}]);
        delta465_filt = eval(['delta465_filt_2_', uniqueIDs{i}]);
        sec_signal = eval(['sec_signal_2_', uniqueIDs{i}]);
        
        % Create a figure with 2 subplots
        figure;
        
        % Plot RR and RR_time in the first subplot
        subplot(2, 1, 1);
        plot(RR_time, RR);
        xlabel('Time');
        ylabel('RR');
        title(['RR and Delta465 for ID ', uniqueIDs{i}]);
        
        % Plot delta465_filt and sec_signal in the second subplot
        subplot(2, 1, 2);
        plot(sec_signal, delta465_filt);
        xlabel('Time');
        ylabel('Signal');
        legend('Delta465', 'Sec Signal');
        hold off;
        
        linkaxes([subplot(2, 1, 1), subplot(2, 1, 2)], 'x');

        % Clear the variables from the workspace
        clear(['RR_', uniqueIDs{i}]);
        clear(['RR_time_', uniqueIDs{i}]);
        clear(['delta465_filt_2_', uniqueIDs{i}]);
        clear(['sec_signal_2_', uniqueIDs{i}]);
        clear RR RR_time delta465_filt sec_signal;
    else
        warning('File %s, %s, %s, or %s does not exist.', rrFileName, rrTimeFileName, deltaFileName, secSignalFileName);
    end
end


%% Save 584 data
% Define the base variables and the new names
% Define the base variables and the new names
baseVariables = {'delta465_filt', 'sec_signal', 'signal_fs', 'EEG_rawtrace_cut', 'EMG_rawtrace_cut', 'EEG_time_cut', 'sampling_freq', 'laser_binary_vector'};
names = {'delta465_filt_2_584', 'sec_signal_2_584', 'signal_fs_584', 'EEG_584', 'EMG_584', 'sec_signal_EEG_584', 'EEG_fs_584', 'laser_binary_584' };

% Directory where you want to save the .mat files
saveDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\Traces';

% Loop through each base variable and save it with the corresponding new name
for i = 1:length(baseVariables)
    % Check if the base variable exists in the workspace
    if evalin('base', sprintf('exist(''%s'', ''var'')', baseVariables{i}))
        % Retrieve the variable from the base workspace
        variableData = evalin('base', baseVariables{i});
        
        % Rename the variable dynamically
        eval([names{i}, ' = variableData;']);
        
        % Create the full path for the .mat file
        savePath = fullfile(saveDirectory, [names{i}, '.mat']);
        
        % Save the renamed variable
        save(savePath, names{i});
    else
        warning('Variable %s does not exist in the base workspace.', baseVariables{i});
    end
end
clear baseVariables suffixes saveDirectory i j fullVarName filename
%% Save sleep for 584
% Define the base variables and the new names
baseVariables = {'wake_binary_vector_cut', 'sws_binary_vector_cut', 'REM_binary_vector_cut', 'MA_binary_vector_cut'};
names = {'wake_woMA_binary_vector_584', 'sws_binary_vector_584', 'REM_binary_vector_584', 'MA_binary_vector_584' };

% Directory where you want to save the .mat files
saveDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\Sleep';

% Loop through each base variable and save it with the corresponding new name
for i = 1:length(baseVariables)
    % Check if the base variable exists in the workspace
    if evalin('base', sprintf('exist(''%s'', ''var'')', baseVariables{i}))
        % Retrieve the variable from the base workspace
        variableData = evalin('base', baseVariables{i});
        
        % Rename the variable dynamically
        eval([names{i}, ' = variableData;']);
        
        % Create the full path for the .mat file
        savePath = fullfile(saveDirectory, [names{i}, '.mat']);
        
        % Save the renamed variable
        save(savePath, names{i});
    else
        warning('Variable %s does not exist in the base workspace.', baseVariables{i});
    end
end
clear baseVariables suffixes saveDirectory i j fullVarName filename

%% Get NREMinclMA for 584

% Define the unique IDs
uniqueIDs = {'584'};

% Directory where the sws and MA files are stored
sleepDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\Sleep';

% Loop through each unique ID and process the corresponding sws and MA files
for i = 1:length(uniqueIDs)
    suffix = uniqueIDs{i};
    
    % Construct the filenames for the sws and MA files
    swsFileName = fullfile(sleepDirectory, ['sws_binary_vector_', suffix, '.mat']);
    MAFileName = fullfile(sleepDirectory, ['MA_binary_vector_', suffix, '.mat']);
    
    % Check if the files exist
    if exist(swsFileName, 'file') && exist(MAFileName, 'file')
        % Load the sws and MA files
        load(swsFileName, ['sws_binary_vector_', suffix]);
        load(MAFileName, ['MA_binary_vector_', suffix]);
        
        % Retrieve the variables
        sws_binary_vector = eval(['sws_binary_vector_', suffix]);
        MA_binary_vector = eval(['MA_binary_vector_', suffix]);
        
        % Add the binary vectors to create NREMinclMA_binary
        NREMinclMA_binary = sws_binary_vector + MA_binary_vector;
        NREMinclMA_binary(NREMinclMA_binary > 1) = 1; % Ensure it remains binary
        
        % Convert NREMinclMA_binary to NREMinclMA_periods
        [NREMinclMA_onset, NREMinclMA_offset] = binaryToOnOff(NREMinclMA_binary);
        NREMinclMA_periods = [NREMinclMA_onset; NREMinclMA_offset]';
        
        eval(['NREMinclMA_periods_', suffix, ' = NREMinclMA_periods;']);

        % Save the results with a new name
        NREMinclMA_periods_name = ['NREMinclMA_periods_', suffix];

        save(fullfile(sleepDirectory, ['NREMinclMA_periods_', suffix, '.mat']), ['NREMinclMA_periods_', suffix]);
        
        % Clear the variables from the workspace
        clear(['sws_binary_vector_', suffix]);
        clear(['MA_binary_vector_', suffix]);
        clear sws_binary_vector MA_binary_vector NREMinclMA_binary NREMinclMA_onset NREMinclMA_offset NREMinclMA_periods;
    else
        warning('File %s or %s does not exist.', swsFileName, MAFileName);
    end
end

% Clear temporary variables
clear uniqueIDs sleepDirectory i suffix swsFileName MAFileName;

%% GET DATA FILES 
%% Seperate binary laser
% Define the unique IDs
% Define the unique IDs
% Define the unique IDs
uniqueIDs = {'480', '489', '491', '497', '511', '512', '513', '522', '577', '584', '586'};

% Define the laser_shift timestamps
laser_shift_480 = {'03:46:16', '04:46:16', '05:46:16', '06:46:16', '7:53:15', '8:55:07'};
laser_shift_489 = {'2:50:55', '3:51:55', '4:52:20', '5:52:57', '6:50:52', '7:50:50'};
laser_shift_491 = {'3:05:05', '4:05:08', '5:05:50', '6:06:30', '7:05:07', '8:06:37'};
laser_shift_497 = {'02:52:09', '03:52:09', '04:52:09', '05:52:09', '06:52:09', '07:52:10'};
laser_shift_511 = {'2:26:30', '3:30:59', '4:26:29', '5:26:25', '6:26:23', '7:26:22'};
laser_shift_522 = {'2:43:00', '3:50:00', '4:50:00', '5:48:00', '6:48:00', '7:48:00'};
laser_shift_577 = {'3:02:25', '4:02:58', '05:03:37', '06:03:58', '07:04:30', '8:05:51'};
laser_shift_584 = {'2:31:00', '3:32:05', '4:32:30', '5:33:10', '6:33:25', '7:32:40'};
laser_shift_586 = {'2:49:33', '3:49:47', '4:50:06', '5:49:35', '6:49:35', '7:49:34'};
laser_shift_512 = {'2:43:49', '3:43:51', '4:43:49', '5:44:18', '6:44:12', '7:44:20'};
laser_shift_513 = {'2:43:00', '3:50:00', '4:50:00', '5:48:00', '6:48:00', '7:48:00'};

% Convert laser shift timestamps to seconds
convertToSeconds = @(t) cellfun(@(x) sum(sscanf(x, '%d:%d:%d').*[3600; 60; 1]), t);

laser_shift_seconds = struct();
laser_shift_seconds.('M480') = convertToSeconds(laser_shift_480);
laser_shift_seconds.('M489') = convertToSeconds(laser_shift_489);
laser_shift_seconds.('M491') = convertToSeconds(laser_shift_491);
laser_shift_seconds.('M497') = convertToSeconds(laser_shift_497);
laser_shift_seconds.('M511') = convertToSeconds(laser_shift_511);
laser_shift_seconds.('M522') = convertToSeconds(laser_shift_522);
laser_shift_seconds.('M577') = convertToSeconds(laser_shift_577);
laser_shift_seconds.('M584') = convertToSeconds(laser_shift_584);
laser_shift_seconds.('M586') = convertToSeconds(laser_shift_586);
laser_shift_seconds.('M512') = convertToSeconds(laser_shift_512);
laser_shift_seconds.('M513') = convertToSeconds(laser_shift_513);

% Directory where the laser_binary and signal_fs files are stored
laserBinaryDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\Traces';

% Loop through each unique ID and process the corresponding laser binary file
for i = 1:length(uniqueIDs)
    id = uniqueIDs{i};
    id_with_M = ['M', id];
    
    % Construct the filenames for the laser_binary and signal_fs files
    laserFileName = fullfile(laserBinaryDirectory, ['laser_binary_', id, '.mat']);
    signalFsFileName = fullfile(laserBinaryDirectory, ['signal_fs_', id, '.mat']);
    
    % Check if the files exist
    if exist(laserFileName, 'file') && exist(signalFsFileName, 'file')
        % Load the laser_binary and signal_fs files
        load(laserFileName, ['laser_binary_', id]);
        load(signalFsFileName, ['signal_fs_', id]);
        
        % Extract the loaded variables
        laser_binary = eval(['laser_binary_', id]);
        signal_fs = eval(['signal_fs_', id]);
        
        % Get the laser shift times in seconds
        shiftTimes = laser_shift_seconds.(id_with_M);
        
        % Convert shift times from seconds to sample indices
        shiftIndices = round(shiftTimes * signal_fs);
        
        % Identify the laser on times (when laser_binary shifts from 0 to 1)
        laser_on_times = find(diff(laser_binary) == 1) / signal_fs;
        
        % Process laser on times to find burst starts and stops
        for j = 1:5
            section_name = sprintf('laser_%d', j);
            start_time = shiftTimes(j );
            end_time = shiftTimes(j + 1);
            times_in_section = laser_on_times(laser_on_times >= start_time & laser_on_times < end_time);
            
            % Initialize a matrix to store the burst periods
            burst_periods = [];
            
            if ~isempty(times_in_section)
                % Initialize burst start and end times
                burst_start = times_in_section(1);
                
                for k = 1:length(times_in_section) - 1
                    if times_in_section(k + 1) - times_in_section(k) > 0.1
                        burst_end = times_in_section(k);
                        burst_periods = [burst_periods; burst_start, burst_end];
                        burst_start = times_in_section(k + 1);  % Start a new burst
                    end
                end
                
                % Handle the last burst
                burst_end = times_in_section(end);
                burst_periods = [burst_periods; burst_start, burst_end];
                laser.(section_name).(id_with_M) = burst_start;
            end
            
            % Save the burst periods to a .mat file
            burst_periods_varname = sprintf('burst_periods_%s_%s', section_name, id);
            eval([burst_periods_varname ' = burst_periods;']);
            save(fullfile(laserBinaryDirectory, [burst_periods_varname '.mat']), burst_periods_varname);
        end
        
        % Clear the variables from the workspace
        clear(['laser_binary_', id]);
        clear(['signal_fs_', id]);
        clear laser_binary signal_fs burst_periods_varname burst_periods;
    else
        warning('File %s or %s does not exist.', laserFileName, signalFsFileName);
    end
end

% Turn warnings back on
warning('on','all')


%% Plot laser subdevision

% Define the unique IDs
uniqueIDs = {'480', '489', '491', '497', '511', '512', '513', '522', '577', '584', '586'};

% Directory where the data files are stored
dataDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\Traces';
burstDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\Burst_periods';
% Loop through each unique ID and create plots
for i = 1:length(uniqueIDs)
    id = uniqueIDs{i};
    id_with_M = ['M', id];
    
    % Construct the filenames for the necessary files
    laserFileName = fullfile(dataDirectory, ['laser_binary_', id, '.mat']);
    deltaFileName = fullfile(dataDirectory, ['delta465_filt_2_', id, '.mat']);
    secSignalFileName = fullfile(dataDirectory, ['sec_signal_2_', id, '.mat']);
    
    % Check if the files exist
    if exist(laserFileName, 'file') && exist(deltaFileName, 'file') && exist(secSignalFileName, 'file')
        % Load the laser_binary, delta465_filt_2, sec_signal_2, and signal_fs files
        load(laserFileName, ['laser_binary_', id]);
        load(deltaFileName, ['delta465_filt_2_', id]);
        load(secSignalFileName, ['sec_signal_2_', id]);
        
        % Extract the loaded variables
        laser_binary = eval(['laser_binary_', id]);
        delta465_filt = eval(['delta465_filt_2_', id]);
        sec_signal = eval(['sec_signal_2_', id]);
                
        % Create a figure with 2 subplots
        figure;
        
        % Plot delta465_filt_2 in the first subplot
        subplot(2, 1, 1);
        plot(sec_signal, delta465_filt);
        xlabel('Time (s)');
        ylabel('Delta465 Filt');
        title(['Delta465 Filt and Laser Binary for ID ', id]);
        
        % Plot laser_binary in the second subplot
        subplot(2, 1, 2);
        plot(sec_signal, laser_binary);
        hold on;
        
        % Scatter plot for the burst starts and ends
        for j = 1:5
            section_name = sprintf('laser_%d', j);
            burst_periods_varname = sprintf('burst_periods_%s_%s', section_name, id);
            burst_periods_file = fullfile(burstDirectory, [burst_periods_varname '.mat']);
            
            if exist(burst_periods_file, 'file')
                load(burst_periods_file, burst_periods_varname);
                burst_periods = eval(burst_periods_varname);
                
                burst_starts = burst_periods(:, 1);
                burst_ends = burst_periods(:, 2);
                
                % Plot burst starts in green and burst ends in red
                scatter(burst_starts, ones(size(burst_starts)), 'g', 'filled');
                scatter(burst_ends, ones(size(burst_ends)), 'r', 'filled');
            end
        end
        
        xlabel('Time (s)');
        ylabel('Laser Binary');
        hold off;
        
        % Clear the variables from the workspace
        clear(['laser_binary_', id]);
        clear(['delta465_filt_2_', id]);
        clear(['sec_signal_2_', id]);
        clear laser_binary delta465_filt sec_signal burst_periods burst_periods_varname burst_starts burst_ends;
    else
        warning('File %s, %s, or %s does not exist.', laserFileName, deltaFileName, secSignalFileName);
    end
end

% Turn warnings back on
warning('on','all')


%% Power EEG
% Define the unique IDs
uniqueIDs = {'480', '489', '491', '497', '511', '512', '513', '522', '577', '584', '586'};

% Define power bands
power_bands = {[0.5, 1], [1, 4], [4, 8], [8, 15], [15, 30], [60, 80], [80, 100]};
frw = 0:0.2:100;
window_in_sec = 1; % sec. 1 for 30 sec

% Directory where the data files are stored
dataDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\Traces';
saveDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\EEG_power';

% Loop through each unique ID and process the corresponding EEG file
for i = 1:length(uniqueIDs)
    id = uniqueIDs{i};
    
    % Construct the filenames for the EEG, EEG_fs, and sec_signal_EEG files
    eegFileName = fullfile(dataDirectory, ['EEG_', id, '.mat']);
    eegFsFileName = fullfile(dataDirectory, ['EEG_fs_', id, '.mat']);
    eegTimeFileName = fullfile(dataDirectory, ['sec_signal_EEG_', id, '.mat']);
    
    % Check if the files exist
    if exist(eegFileName, 'file') && exist(eegFsFileName, 'file') && exist(eegTimeFileName, 'file')
        % Load the EEG, EEG_fs, and sec_signal_EEG files
        load(eegFileName, ['EEG_', id]);
        load(eegFsFileName, ['EEG_fs_', id]);
        load(eegTimeFileName, ['sec_signal_EEG_', id]);
        
        % Extract the loaded variables
        EEG = eval(['EEG_', id]);
        EEG_fs = eval(['EEG_fs_', id]);
        sec_signal_EEG = eval(['sec_signal_EEG_', id]);
        
        % Check for NaNs in the EEG data
        if any(isnan(EEG))
            % Run interpolation on the EEG data
            [EEG, sec_signal_EEG] = interpolate_EMG_EEG(EEG, sec_signal_EEG);
        end
        
        % Run the PowerAnalysisEEG function
        [mean_spectrogram, time_spectrogram_zero, F, band_powers, EEG_bands_fs] = PowerAnalysisEEG(EEG, EEG_fs, frw, window_in_sec, power_bands);
        
        % Rename the variables with the ID
        eval(['mean_spectrogram_', id, ' = mean_spectrogram;']);
        eval(['time_spectrogram_zero_', id, ' = time_spectrogram_zero;']);
        eval(['F_', id, ' = F;']);
        eval(['band_powers_', id, ' = band_powers;']);
        eval(['EEG_bands_fs_', id, ' = EEG_bands_fs;']);
        
        % Save the output to a .mat file
        save(fullfile(saveDirectory, ['PowerAnalysisEEG_', id, '.mat']), ...
             ['mean_spectrogram_', id], ['time_spectrogram_zero_', id], ['F_', id], ['band_powers_', id], ['EEG_bands_fs_', id]);
        
        % Clear the variables from the workspace
        clear(['EEG_', id]);
        clear(['EEG_fs_', id]);
        clear(['sec_signal_EEG_', id]);
        clear(['mean_spectrogram_', id]);
        clear(['time_spectrogram_zero_', id]);
        clear(['F_', id]);
        clear EEG EEG_fs sec_signal_EEG mean_spectrogram time_spectrogram_zero F band_powers EEG_bands_fs;
    else
        warning('File %s, %s, or %s does not exist.', eegFileName, eegFsFileName, eegTimeFileName);
    end
end


%% Get laser on during NREM
% Define the unique IDs
uniqueIDs = {'480', '489', '491', '497', '511', '512', '513', '522', '577', '584', '586'};

% Directory where the NREMinclMA files are stored
sleepDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\Sleep';
% Directory where the event markers will be saved
eventMarkersDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\Event_markers';

% Loop through each unique ID and process the corresponding NREMinclMA file
for i = 1:length(uniqueIDs)
    id = uniqueIDs{i};
    id_with_M = ['M', id];
    
    % Construct the filename for the NREMinclMA_periods file
    nremFileName = fullfile(sleepDirectory, ['NREMinclMA_periods_', id, '.mat']);
    
    % Check if the file exists
    if exist(nremFileName, 'file')
        % Load the NREMinclMA_periods file
        load(nremFileName, ['NREMinclMA_periods_', id]);
        
        % Retrieve the NREMinclMA_periods variable
        NREMinclMA_periods = eval(['NREMinclMA_periods_', id]);
        
        % Initialize variables for storing laser bursts during NREM periods
        laser_1_NREM = [];
        laser_2_NREM = [];
        laser_3_NREM = [];
        laser_4_NREM = [];
        laser_5_NREM = [];
        
        % Loop through each laser type (laser_1 to laser_5)
        for j = 1:5
            section_name = sprintf('laser_%d', j);
            if isfield(laser.(section_name), id_with_M)
                burst_starts = laser.(section_name).(id_with_M);
                
                for k = 1:length(burst_starts)
                    burst_onset = burst_starts(k);
                    
                    % Check if the burst onset happens within NREMinclMA periods
                    for l = 1:size(NREMinclMA_periods, 1)
                        NREM_onset = NREMinclMA_periods(l, 1);
                        NREM_offset = NREMinclMA_periods(l, 2);
                        
                        % Criteria: NREM starts minimally 30s before burst onset
                        % and extends minimally 30s after burst onset
                        if (NREM_onset <= (burst_onset - 30)) && ((burst_onset + 30) <= NREM_offset)
                            switch j
                                case 1
                                    laser_1_NREM = [laser_1_NREM; burst_onset];
                                case 2
                                    laser_2_NREM = [laser_2_NREM; burst_onset];
                                case 3
                                    laser_3_NREM = [laser_3_NREM; burst_onset];
                                case 4
                                    laser_4_NREM = [laser_4_NREM; burst_onset];
                                case 5
                                    laser_5_NREM = [laser_5_NREM; burst_onset];
                            end
                            break;
                        end
                    end
                end
            end
        end
        
        % Save the results for the current ID
        save(fullfile(eventMarkersDirectory, ['laser_1_NREM_', id, '.mat']), 'laser_1_NREM');
        save(fullfile(eventMarkersDirectory, ['laser_2_NREM_', id, '.mat']), 'laser_2_NREM');
        save(fullfile(eventMarkersDirectory, ['laser_3_NREM_', id, '.mat']), 'laser_3_NREM');
        save(fullfile(eventMarkersDirectory, ['laser_4_NREM_', id, '.mat']), 'laser_4_NREM');
        save(fullfile(eventMarkersDirectory, ['laser_5_NREM_', id, '.mat']), 'laser_5_NREM');
        
        % Clear the variables from the workspace
        clear(['NREMinclMA_periods_', id]);
        clear NREMinclMA_periods laser_1_NREM laser_2_NREM laser_3_NREM laser_4_NREM laser_5_NREM;
    else
        warning('File %s does not exist.', nremFileName);
    end
end

% Clear temporary variables
clear uniqueIDs sleepDirectory eventMarkersDirectory i id id_with_M nremFileName;

%% Get data files for figure 3
warning('off','all')
warning

% Define the unique IDs and event variables
uniqueIDs = {'480', '489', '491', '497', '511', '512', '513', '522', '577', '584', '586'};
event_var = {'laser_1_NREM', 'laser_2_NREM', 'laser_3_NREM', 'laser_4_NREM', 'laser_5_NREM'};
epoc_start = 60;
epoc_end = 60; 
saveDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\Figure_4_data';

% Directories where the files are stored
eventMarkersDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\Event_markers';
tracesDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\Traces';
RRDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\RR';

% Loop over each event type
for stage_idx = 1:length(event_var)
    event_type_name = event_var{stage_idx};  % Get the current event type name

    % Loop over each subject
    for idx = 1:length(uniqueIDs)
        uniqueId = uniqueIDs{idx};  % Get the current subject ID

        % Load the event marker file for the current event type and subject
        eventFileName = fullfile(eventMarkersDirectory, sprintf('%s_%s.mat', event_type_name, uniqueId));
        
        if ~exist(eventFileName, 'file')
            disp(['No event file found for ', event_type_name, ' and subject ', uniqueId]);
            continue;
        end
        
        loadedData = load(eventFileName);
        
        % Assuming the variable loaded from the file matches the event_type_name
        event_type = loadedData.(event_type_name);
        
        if isempty(event_type)
            disp(['Skipping ', event_type_name, ' for subject ', uniqueId, ' due to no events.']);
            continue;
        end
        
        % Load other necessary data for this subject
        load(fullfile(tracesDirectory, sprintf('sec_signal_2_%s.mat', uniqueId)));
        load(fullfile(tracesDirectory, sprintf('delta465_filt_2_%s.mat', uniqueId)));
        load(fullfile(RRDirectory, sprintf('RR_%s.mat', uniqueId)));
        load(fullfile(RRDirectory, sprintf('RR_time_%s.mat', uniqueId)));
        load(fullfile(tracesDirectory, sprintf('signal_fs_%s.mat', uniqueId)));
        
        sec_signal_2 = eval(sprintf('sec_signal_2_%s', uniqueId));
        delta465_filt_2 = eval(sprintf('delta465_filt_2_%s', uniqueId));
        RR = eval(sprintf('RR_%s', uniqueId));
        RR_time = eval(sprintf('RR_time_%s', uniqueId));
        NE_fs = eval(sprintf('signal_fs_%s', uniqueId));
        EEG_bands_fs = eval(sprintf('EEG_bands_fs_%s', uniqueId));
        band_powers = eval(sprintf('band_powers_%s', uniqueId));
        
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

            RR_epoc = RR(:, (find(RR_time > HRB_i, 1) - (64 * epoc_start):find(RR_time > HRB_i, 1) + (64 * epoc_end)));
            RR_collector = [RR_collector; RR_epoc];
            
            % Extract epochs for EEG bands
            for b = 1:length(band_powers)
                EEG_band_epoc_i = band_powers{b}(:, (NEpk_i - epoc_start) * EEG_bands_fs:(NEpk_i + epoc_end) * EEG_bands_fs);
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

% Turn warnings back on
warning('on','all')

clear uniqueIDs event_var epoc_start epoc_end saveDirectory eventMarkersDirectory tracesDirectory stage_idx event_type_name idx uniqueId eventFiles event_type sec_signal_2 delta465_filt_2 RR RR_time NE_fs EEG_bands_fs band_powers NE_collector RR_collector SO_collector Delta_collector Theta_collector Sigma_collector Beta_collector Gamma_low_collector Gamma_high_collector i NEpk_i HRB_i NEpk_epoc_i RR_epoc b EEG_band_epoc_i data_types collectors j variable_name;

%% Generate figure 3 (single animal)
o = {'512'};
burstPeriodsDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\Event_markers';
for idx = 1:length(o)
    uniqueId = o{idx};
    disp(uniqueId)

    % Access the variables dynamically
    band_powers = eval(sprintf('band_powers_%s', uniqueId));
    EEG_bands_fs = eval(sprintf('EEG_bands_fs_%s', uniqueId));
    load(fullfile(burstPeriodsDirectory, sprintf('laser_1_NREM_%s.mat', uniqueId)));
    load(fullfile(burstPeriodsDirectory, sprintf('laser_2_NREM_%s.mat', uniqueId)));
    load(fullfile(burstPeriodsDirectory, sprintf('laser_3_NREM_%s.mat', uniqueId)));
    load(fullfile(burstPeriodsDirectory, sprintf('laser_4_NREM_%s.mat', uniqueId)));
    load(fullfile(burstPeriodsDirectory, sprintf('laser_5_NREM_%s.mat', uniqueId)));

event_var = {laser_1_NREM, laser_2_NREM, laser_3_NREM, laser_4_NREM, laser_5_NREM};

figure_3_chr2(o, event_var, epoc_start, epoc_end, EEG_bands_fs, band_powers)
end
clear idx uniqueId event_var titles main_title NREMexclMA_periods_pklocs NREM_before_MA_short NREM_before_MA_long SWS_before_wake_pklocs REM_before_wake_pklocs REM_before_MA_pklocs sec_signal_2 delta465_filt_2 RR RR_time EEG_bands_fs F mean_spectrogram NE_fs

%% Get figure 3 (all traces)
data_types = {'NE', 'RR', 'SO', 'Delta', 'Theta', 'Sigma', 'Beta', 'Gamma_low', 'Gamma_high'};
titles = {'Laser -15', 'Laser -10', 'Laser -5', 'Laser 0', 'Laser 5'};
main_title = ('Averaged Activity During Laser onset for control');
yfp = {'584', '577', '512', '513'};
chr2 = {'489', '480', '491', '497', '511', '522'};
event_var = {'laser_1_NREM', 'laser_2_NREM', 'laser_3_NREM', 'laser_4_NREM', 'laser_5_NREM'};

saveDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\Figure_4_data';
epoc_start = 60;
epoc_end = 60; 

results_yfp = aggregate_event_data(saveDirectory, event_var, yfp, data_types);
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

results_chr2 = aggregate_event_data(saveDirectory, event_var, chr2, data_types);
[NE_table, RR_table, SO_table, Delta_table, Theta_table, Sigma_table, Beta_table, Gamma_low_table, Gamma_high_table] = figure_2_reorganized(results, epoc_start, epoc_end, main_title, titles);
figure_2_reorganized_mean_centered(results, epoc_start, epoc_end, main_title, titles);

writetable(NE_table, 'chr2_NE_traces_ds.csv')
writetable(RR_table, 'chr2_RR_traces.csv')
writetable(table_SO, 'chr2_table_SO.csv')
writetable(table_Delta, 'chr2_table_Delta.csv')
writetable(table_Theta, 'chr2_table_Theta.csv')
writetable(table_Sigma, 'chr2_table_Sigma.csv')
writetable(table_Beta, 'chr2_table_Beta.csv')
writetable(table_Gamma_low, 'chr2_table_Gamma_low.csv')
writetable(table_Gamma_high, 'chr2_table_Gamma_high.csv')

%Run figure for single animal
results_single = aggregate_event_data_single(saveDirectory, event_var, '403', data_types);
figure_2_reorganized_single(results_single, epoc_start, epoc_end, '403' , titles)

%% AUC diff chr2
event_var = {'laser_1_NREM', 'laser_2_NREM', 'laser_3_NREM', 'laser_4_NREM', 'laser_5_NREM'};
titles = {'Laser -15', 'Laser -10', 'Laser -5', 'Laser 0', 'Laser 5'};
saveDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\Figure_4_data';
outputDirectory = fullfile(saveDirectory, 'AUC');
chr2 = {'489', '480', '491', '497', '511', '522'};
yfp = {'584', '577', '512', '513'};
yfp = {'584', '577', '512', '513'};
chr2 = {'489', '480', '491', '497', '511', '522'};
% Define the times_matrix
times_matrix_post = struct();
times_matrix_post.NE.range = [-20, 0];
times_matrix_post.RR.range = [-20, 0];
times_matrix_post.EEG.range = [-20, 0];

times_matrix_pre = struct();
times_matrix_pre.NE.range = [-40, -20];
times_matrix_pre.RR.range = [-40, -20];
times_matrix_pre.EEG.range = [-40, -20];

% Call the function with the specified time range
%auc_data = extract_auc_and_plot(o, event_var, saveDirectory, times_matrix_post, outputDirectory, titles);

auc_data_yfp = extract_auc_and_plot_3(chr2, event_var, saveDirectory, times_matrix_pre, times_matrix_post); %This is the right one
auc_diff_table = plot_auc_bar(auc_data_yfp, event_var, chr2, titles);
writetable(auc_diff_table, 'chr2_auc_diff_pre_table.csv')

% PRE is -20 to 0 with -40 to -20 baseline
%POST is 0 to 20 with 20 to 40 as baseline
%Taking from -20 to 20 doesn't work

%% continued - change table to graphpad format

    % Define the file path
    file_path = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\yfp data\AUC recalculated\chr2_auc_diff_post_table.csv';
    
    % Load the CSV file into a table
    data_table = readtable(file_path);
    
    % Convert SubjectID to strings for consistent comparison
    data_table.SubjectID = string(data_table.SubjectID);
    
    % List of columns to process
    data_columns = {'Delta', 'Theta', 'Sigma', 'Beta', 'Gamma_high'};
        
    % Define the output directory
    output_dir = fullfile('C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\yfp data', 'AUC recalculated');
    
    % Create the directory if it doesn't exist
    if ~exist(output_dir, 'dir')
        mkdir(output_dir);
    end
    
    % Process each data column
    for i = 1:length(data_columns)
        column_name = data_columns{i};
        
        % Filter data for chr2 subjects
        chr2_data = data_table(ismember(data_table.SubjectID, chr2), :);
        
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
        output_file = fullfile(output_dir, sprintf('%s_combined_post_chr2.csv', column_name));
        writetable(combined_table, output_file);
    end

    %% Make a pre-post table
    % Define the pre and post file paths
pre_file_path = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\yfp data\AUC recalculated\chr2_auc_diff_pre_table.csv';
post_file_path = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\yfp data\AUC recalculated\chr2_auc_diff_post_table.csv';

% Load the CSV files into tables
pre_data_table = readtable(pre_file_path);
post_data_table = readtable(post_file_path);

% Convert SubjectID to strings for consistent comparison
pre_data_table.SubjectID = string(pre_data_table.SubjectID);
post_data_table.SubjectID = string(post_data_table.SubjectID);

% List of columns to process
data_columns = {'Delta', 'Theta', 'Sigma', 'Beta', 'Gamma_high'};

% Define the output directory
output_dir = fullfile('C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\yfp data', 'AUC recalculated');

% Create the directory if it doesn't exist
if ~exist(output_dir, 'dir')
    mkdir(output_dir);
end

% Process each data column
for i = 1:length(data_columns)
    column_name = data_columns{i};
    
    % Load pre and post tables for each data type
    pre_table_path = fullfile(output_dir, sprintf('%s_combined_pre_chr2.csv', column_name));
    post_table_path = fullfile(output_dir, sprintf('%s_combined_post_chr2.csv', column_name));
    
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
    output_file = fullfile(output_dir, sprintf('%s_chr2_combined_both_table.csv', column_name));
    writetable(combined_table, output_file);
end

%% Supplementary figure: Get mean/SD RR values for chr2/yfp during NREM for each laser level
uniqueIDs = {'480', '489', '491', '497', '511', '522', '512', '513', '577', '584'};
RR_intervals = extract_RR_intervals_chr2(uniqueIDs);
chr2 = {'489', '480', '491', '497', '511', '522'};
yfp = {'584', '577', '512', '513'};

summaryTable = compute_RR_summary(RR_intervals, chr2, yfp);

dataDirectory = 'C:\\Users\\trb938\\OneDrive - University of Copenhagen\\MATLAB\\chr2_yfp\\Figure_4_data';
summaryTable_laserfiles = compute_RR_summary_from_files(dataDirectory, chr2, yfp);
summaryTable_RR_varriance = compute_RR_varriance_summary_from_files(dataDirectory, chr2, yfp);
summaryTable_PeakRR = compute_peak_RR_summary_from_files(dataDirectory, chr2, yfp, 5, 2);

[summaryTable_PeakRR_new, sigmaSummaryTable, sigma_peak_RR_table] = compute_peak_RR_summary_from_files_w_sigma(dataDirectory, chr2, yfp, 5, 2);
%writetable(sigma_peak_RR_table, 'sigma_peak_RR_table.csv')

    %% PSD prep
%% Extract RR during NREM for each laser level (new PSD version)
uniqueIDs = {'480', '489', '491', '497', '511', '522', '512', '513', '577', '584'};
RR_intervals = extract_RR_intervals_chr2(uniqueIDs);
[AUC_RR_PSD_chr2_all, AUC_RR_PSD_yfp_all] = PSD_RR_chr2_all_NREM(RR_intervals, chr2, yfp);
[AUC_table_RR, PeakFrequency_table_RR, PeakPower_table_RR, mean_psd_chr2_table_RR, sem_psd_chr2_table_RR, mean_psd_yfp_table_RR, sem_psd_yfp_table_RR, f] = PSD_RR_chr2_all_NREM(RR_intervals, chr2, yfp);

f = f'
NE_intervals = extract_NE_intervals_chr2(uniqueIDs);
[AUC_NE_PSD_chr2_all, AUC_NE_PSD_yfp_all] = PSD_NE_chr2_all_NREM(NE_intervals, chr2, yfp);

plot_relative_perc_auc_chr2(AUC_RR_PSD_chr2_all, AUC_RR_PSD_yfp_all, 'AUC of PSD RR for chr2 and yfp');
plot_relative_perc_auc_chr2(AUC_NE_PSD_chr2_all, AUC_NE_PSD_yfp_all, 'AUC of PSD NE for chr2 and yfp');

writetable(AUC_table_RR, 'RR_psd_AUC.csv')
writetable(PeakFrequency_table_RR, 'RR_psd_freq.csv')
writetable(PeakPower_table_RR, 'RR_psd_peak.csv')

%% Created weigthed mean/SEM for PSD quantification export

% Assuming 'AUC_table_RR' is your data table with columns:
% - 'AUC': The variable you want to calculate the weighted mean and SEM for
% - 'EventVar': The first grouping variable with values like 'Arch' and 'YFP'
% - 'LaserLevel': The second grouping variable, integer values from 0 to 5
% - 'BoutLength': The weights for each observation

% Get the unique groups for 'EventVar' and 'LaserLevel'
eventVars = unique(PeakPower_table_RR.group);
laserLevels = unique(PeakPower_table_RR.LaserLevel);

% Initialize a table to store the results
result_table = table();

% Counter for rows in the result table
row_counter = 1;

% Loop over each combination of 'EventVar' and 'LaserLevel'
for i = 1:length(eventVars)
    for j = 1:length(laserLevels)
        % Get current group values
        eventVar = eventVars{i};
        laserLevel = laserLevels(j);
        
        % Select data for the current group combination
        idx = strcmp(PeakPower_table_RR.group, eventVar) & PeakPower_table_RR.LaserLevel == laserLevel;
        
        % Check if there is data for this combination
        if sum(idx) > 0
            data = PeakPower_table_RR.PeakPower(idx);
            weights = PeakPower_table_RR.BoutLength(idx);
            n = sum(idx); % Number of events (rows) in the data for this group
            
            % Calculate weighted mean
            weighted_mean = sum(weights .* data) / sum(weights);
            
            % Calculate weighted variance
            weighted_variance = sum(weights .* (data - weighted_mean).^2) / sum(weights);
            
            % Calculate weighted standard error of the mean (SEM)
            % SEM is the square root of the weighted variance divided by sqrt(n)
            weighted_sem = sqrt(weighted_variance) / sqrt(n);
            
            % Store the results in the table
            result_table(row_counter, :) = {eventVar, laserLevel, weighted_mean, weighted_sem, n};
            row_counter = row_counter + 1;
        end
    end
end

% Assign variable names to the result table
result_table.Properties.VariableNames = {'EventVar', 'LaserLevel', 'WeightedMean', 'WeightedSEM', 'N'};

% Display the results
disp(result_table);


%% Reshape mean/SEM traces

% Get the number of rows expected in the final table
numRows = length(mean_psd_chr2_table_RR{1, 1}{1});

% Unnest mean_psd_chr2_table_RR
unnested_mean_psd_chr2_table_RR = table();  % Create an empty table to store the results
for i = 1:width(mean_psd_chr2_table_RR)
    nestedData = mean_psd_chr2_table_RR{1, i}{1};  % Extract the 1501x1 array from the nested cell
    unnested_mean_psd_chr2_table_RR(:, i) = array2table(nestedData);  % Store in the new table
end

% Unnest sem_psd_chr2_table_RR
unnested_sem_psd_chr2_table_RR = table();  % Create an empty table to store the results
for i = 1:width(sem_psd_chr2_table_RR)
    nestedData = sem_psd_chr2_table_RR{1, i}{1};  % Extract the 1501x1 array from the nested cell
    unnested_sem_psd_chr2_table_RR(:, i) = array2table(nestedData);  % Store in the new table
end

% Unnest mean_psd_yfp_table_RR
unnested_mean_psd_yfp_table_RR = table();  % Create an empty table to store the results
for i = 1:width(mean_psd_yfp_table_RR)
    nestedData = mean_psd_yfp_table_RR{1, i}{1};  % Extract the 1501x1 array from the nested cell
    unnested_mean_psd_yfp_table_RR(:, i) = array2table(nestedData);  % Store in the new table
end

% Unnest sem_psd_yfp_table_RR
unnested_sem_psd_yfp_table_RR = table();  % Create an empty table to store the results
for i = 1:width(sem_psd_yfp_table_RR)
    nestedData = sem_psd_yfp_table_RR{1, i}{1};  % Extract the 1501x1 array from the nested cell
    unnested_sem_psd_yfp_table_RR(:, i) = array2table(nestedData);  % Store in the new table
end
%% Resharpe AUC, peak, peak hz

AUC_table_RR = sortrows(AUC_table_RR, {'LaserLevel', 'group'});

% Get unique combinations of LaserLevel and group
[uniqueComb, ~, idx] = unique([AUC_table_RR.LaserLevel, string(AUC_table_RR.group)], 'rows');

% Initialize a structure to store results
grouped_AUC = struct();

% Loop through unique combinations and store the AUC values in each group
for i = 1:size(uniqueComb, 1)
    % Get the current combination
    laserLevel = uniqueComb(i, 1);
    groupType = uniqueComb(i, 2);
    
    % Create a field name based on the combination
    fieldName = strcat('LaserLevel_', string(laserLevel), '_', groupType);
    
    % Find the corresponding rows in the original table
    AUC_values = AUC_table_RR.AUC(idx == i);
    
    % Store the AUC values in the structure under this field name
    grouped_AUC.(fieldName) = AUC_values;
end

PeakFrequency_table_RR = sortrows(PeakFrequency_table_RR, {'LaserLevel', 'group'});

% Get unique combinations of LaserLevel and group
[uniqueComb, ~, idx] = unique([PeakFrequency_table_RR.LaserLevel, string(PeakFrequency_table_RR.group)], 'rows');

% Initialize a structure to store results
grouped_hz = struct();

% Loop through unique combinations and store the AUC values in each group
for i = 1:size(uniqueComb, 1)
    % Get the current combination
    laserLevel = uniqueComb(i, 1);
    groupType = uniqueComb(i, 2);
    
    % Create a field name based on the combination
    fieldName = strcat('LaserLevel_', string(laserLevel), '_', groupType);
    
    % Find the corresponding rows in the original table
    peak_hz = PeakFrequency_table_RR.PeakFrequency(idx == i);
    
    % Store the AUC values in the structure under this field name
    grouped_hz.(fieldName) = peak_hz;
end

PeakPower_table_RR = sortrows(PeakPower_table_RR, {'LaserLevel', 'group'});

% Get unique combinations of LaserLevel and group
[uniqueComb, ~, idx] = unique([PeakPower_table_RR.LaserLevel, string(PeakPower_table_RR.group)], 'rows');

% Initialize a structure to store results
grouped_power = struct();

% Loop through unique combinations and store the AUC values in each group
for i = 1:size(uniqueComb, 1)
    % Get the current combination
    laserLevel = uniqueComb(i, 1);
    groupType = uniqueComb(i, 2);
    
    % Create a field name based on the combination
    fieldName = strcat('LaserLevel_', string(laserLevel), '_', groupType);
    
    % Find the corresponding rows in the original table
    peak_power = PeakPower_table_RR.PeakPower(idx == i);
    
    % Store the AUC values in the structure under this field name
    grouped_power.(fieldName) = peak_power;
end

%% Continued - 'new' PSD AUC plot for RR
num_laser_levels = 6;

% Calculate means and SEMs for chr2
means_chr2 = zeros(num_laser_levels, 1);
sems_chr2 = zeros(num_laser_levels, 1);
for i = 0:num_laser_levels-1
    data = AUC_RR_PSD_chr2_all.AUC(AUC_RR_PSD_chr2_all.LaserLevel == i);
    means_chr2(i+1) = mean(data);
    sems_chr2(i+1) = std(data) / sqrt(length(data));
end

% Calculate means and SEMs for yfp
means_yfp = zeros(num_laser_levels, 1);
sems_yfp = zeros(num_laser_levels, 1);
for i = 0:num_laser_levels-1
    data = AUC_RR_PSD_yfp_all.AUC(AUC_RR_PSD_yfp_all.LaserLevel == i);
    means_yfp(i+1) = mean(data);
    sems_yfp(i+1) = std(data) / sqrt(length(data));
end

% Create a bar plot
figure;
hold on;

% Define the bar width
barWidth = 0.35;

% Define x positions for the bars
x = 0:num_laser_levels-1;

% Plot bars for chr2
bar1 = bar(x - barWidth/2, means_chr2, barWidth, 'FaceColor', [0 0.4470 0.7410], 'DisplayName', 'chr2');

% Plot bars for yfp
bar2 = bar(x + barWidth/2, means_yfp, barWidth, 'FaceColor', [0.8500 0.3250 0.0980], 'DisplayName', 'yfp');

% Plot error bars for chr2
errorbar(x - barWidth/2, means_chr2, sems_chr2, 'k', 'LineStyle', 'none', 'LineWidth', 1.5);

% Plot error bars for yfp
errorbar(x + barWidth/2, means_yfp, sems_yfp, 'k', 'LineStyle', 'none', 'LineWidth', 1.5);

% Customize the plot
set(gca, 'XTick', x);
set(gca, 'XTickLabel', {'Laser Level 0', 'Laser Level 1', 'Laser Level 2', 'Laser Level 3', 'Laser Level 4', 'Laser Level 5'});
xlabel('Laser Levels');
ylabel('Area Under the Curve (AUC)');
title('AUC of PSD RR for chr2 and yfp');
legend('show');
grid on;

% Set figure background color to white
set(gcf, 'Color', 'w');

hold off;

%% Continued - 'new' PSD AUC plot for NE
num_laser_levels = 6;

% Calculate means and SEMs for chr2
means_chr2 = zeros(num_laser_levels, 1);
sems_chr2 = zeros(num_laser_levels, 1);
for i = 0:num_laser_levels-1
    data = AUC_NE_PSD_chr2_all.AUC(AUC_NE_PSD_chr2_all.LaserLevel == i);
    means_chr2(i+1) = mean(data);
    sems_chr2(i+1) = std(data) / sqrt(length(data));
end

% Calculate means and SEMs for yfp
means_yfp = zeros(num_laser_levels, 1);
sems_yfp = zeros(num_laser_levels, 1);
for i = 0:num_laser_levels-1
    data = AUC_NE_PSD_yfp_all.AUC(AUC_NE_PSD_yfp_all.LaserLevel == i);
    means_yfp(i+1) = mean(data);
    sems_yfp(i+1) = std(data) / sqrt(length(data));
end

% Create a bar plot
figure;
hold on;

% Define the bar width
barWidth = 0.35;

% Define x positions for the bars
x = 0:num_laser_levels-1;

% Plot bars for chr2
bar1 = bar(x - barWidth/2, means_chr2, barWidth, 'FaceColor', [0 0.4470 0.7410], 'DisplayName', 'chr2');

% Plot bars for yfp
bar2 = bar(x + barWidth/2, means_yfp, barWidth, 'FaceColor', [0.8500 0.3250 0.0980], 'DisplayName', 'yfp');

% Plot error bars for chr2
errorbar(x - barWidth/2, means_chr2, sems_chr2, 'k', 'LineStyle', 'none', 'LineWidth', 1.5);

% Plot error bars for yfp
errorbar(x + barWidth/2, means_yfp, sems_yfp, 'k', 'LineStyle', 'none', 'LineWidth', 1.5);

% Customize the plot
set(gca, 'XTick', x);
set(gca, 'XTickLabel', {'Laser Level 0', 'Laser Level 1', 'Laser Level 2', 'Laser Level 3', 'Laser Level 4', 'Laser Level 5'});
xlabel('Laser Levels');
ylabel('Area Under the Curve (AUC)');
title('AUC of PSD NE for chr2 and yfp');
legend('show');
grid on;

% Set figure background color to white
set(gcf, 'Color', 'w');

hold off;


%% Get RRs during NREM for different lasers
% List of unique IDs for each subject
uniqueIDs = {'480', '489', '491', '497', '511', '512', '513', '522', '577', '584', '586'};

% Initialize the cell array to store results
RR_data_NREM_laser = {};

% Loop through each unique ID
for u = 1:length(uniqueIDs)
    uniqueId = uniqueIDs{u};
    id_with_M = ['M', uniqueId];

    % Load NREMinclMA_periods for the current subject
    sleepDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\Sleep';
    NREMinclMA_periods_file = fullfile(sleepDirectory, sprintf('NREMinclMA_periods_%s.mat', uniqueId));
    if exist(NREMinclMA_periods_file, 'file')
        load(NREMinclMA_periods_file, sprintf('NREMinclMA_periods_%s', uniqueId));
        NREMinclMA_periods = eval(sprintf('NREMinclMA_periods_%s', uniqueId));
    else
        warning('NREMinclMA_periods file for subject %s does not exist.', uniqueId);
        continue;
    end
    
    % Load RR and RR_time for the current subject
    rrDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\RR';
    RR_file = fullfile(rrDirectory, sprintf('RR_%s.mat', uniqueId));
    RR_time_file = fullfile(rrDirectory, sprintf('RR_time_%s.mat', uniqueId));
    if exist(RR_file, 'file') && exist(RR_time_file, 'file')
        load(RR_file, sprintf('RR_%s', uniqueId));
        load(RR_time_file, sprintf('RR_time_%s', uniqueId));
        RR = eval(sprintf('RR_%s', uniqueId));
        RR_time = eval(sprintf('RR_time_%s', uniqueId));
    else
        warning('RR and/or RR_time files for subject %s do not exist.', uniqueId);
        continue;
    end

    % Get the laser shift times in seconds
    shiftTimes = laser_shift_seconds.(id_with_M);
    
    % Loop through each laser level
    for laser_level = 1:5
        start_time = shiftTimes(laser_level);
        end_time = shiftTimes(laser_level + 1);
        
        % Loop through each period in NREMinclMA_periods
        for i = 1:size(NREMinclMA_periods, 1)
            NREM_startTime = NREMinclMA_periods(i, 1);
            NREM_endTime = NREMinclMA_periods(i, 2);
            
            % Find overlapping periods between NREM and laser periods
            overlap_startTime = max(NREM_startTime, start_time);
            overlap_endTime = min(NREM_endTime, end_time);
            
            if overlap_startTime < overlap_endTime
                % Find indices in RR_time corresponding to the overlapping period
                periodIndices = find(RR_time >= overlap_startTime & RR_time <= overlap_endTime);
                
                % Extract the corresponding RR values
                RR_values = RR(periodIndices);
                
                % Store the suffix, laser level, and the extracted RR values in the cell array
                RR_data_NREM_laser{end+1, 1} = uniqueId;   % Store unique ID
                RR_data_NREM_laser{end, 2} = RR_values;    % Store the extracted RR values
                RR_data_NREM_laser{end, 3} = laser_level;  % Store the laser level
            end
        end
    end
end

% Convert the cell array to a table for better visualization (optional)
RR_data_NREM_laser_table = cell2table(RR_data_NREM_laser, 'VariableNames', {'MouseID', 'RR_Values', 'Laser_level'});

% Clear temporary variables
clear uniqueIDs u uniqueId id_with_M sleepDirectory NREMinclMA_periods_file rrDirectory RR_file RR_time_file;
clear NREMinclMA_periods RR RR_time shiftTimes start_time end_time overlap_startTime overlap_endTime;
clear periodIndices RR_values laser_level i;

%% Get BPM for baseline
% Define unique IDs for chr2 and yfp
uniqueIDs_chr2 = {'489', '480', '491', '497', '511', '522'};
uniqueIDs_yfp = {'584', '577', '512', '513'};

% Directories for RR and sleep data
RRDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\RR';
sleepDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\Sleep';

% Define the laser shift timestamps
laser_shift_480 = {'03:46:16', '04:46:16', '05:46:16', '06:46:16', '07:53:15', '08:55:07'};
laser_shift_489 = {'02:50:55', '03:51:55', '04:52:20', '05:52:57', '06:50:52', '07:50:50'};
laser_shift_491 = {'03:05:05', '04:05:08', '05:05:50', '06:06:30', '07:05:07', '08:06:37'};
laser_shift_497 = {'02:52:09', '03:52:09', '04:52:09', '05:52:09', '06:52:09', '07:52:10'};
laser_shift_511 = {'02:26:30', '03:30:59', '04:26:29', '05:26:25', '06:26:23', '07:26:22'};
laser_shift_522 = {'02:43:00', '03:50:00', '04:50:00', '05:48:00', '06:48:00', '07:48:00'};
laser_shift_577 = {'03:02:25', '04:02:58', '05:03:37', '06:03:58', '07:04:30', '08:05:51'};
laser_shift_584 = {'02:31:00', '03:32:05', '04:32:30', '05:33:10', '06:33:25', '07:32:40'};
laser_shift_586 = {'02:49:33', '03:49:47', '04:50:06', '05:49:35', '06:49:35', '07:49:34'};
laser_shift_512 = {'02:43:49', '03:43:51', '04:43:49', '05:44:18', '06:44:12', '07:44:20'};
laser_shift_513 = {'02:43:00', '03:50:00', '04:50:00', '05:48:00', '06:48:00', '07:48:00'};

% Convert laser shift timestamps to seconds
convertToSeconds = @(t) cellfun(@(x) sum(sscanf(x, '%d:%d:%d').*[3600; 60; 1]), t);

laser_shift_seconds = struct();
laser_shift_seconds.('M480') = convertToSeconds(laser_shift_480);
laser_shift_seconds.('M489') = convertToSeconds(laser_shift_489);
laser_shift_seconds.('M491') = convertToSeconds(laser_shift_491);
laser_shift_seconds.('M497') = convertToSeconds(laser_shift_497);
laser_shift_seconds.('M511') = convertToSeconds(laser_shift_511);
laser_shift_seconds.('M522') = convertToSeconds(laser_shift_522);
laser_shift_seconds.('M577') = convertToSeconds(laser_shift_577);
laser_shift_seconds.('M584') = convertToSeconds(laser_shift_584);
laser_shift_seconds.('M586') = convertToSeconds(laser_shift_586);
laser_shift_seconds.('M512') = convertToSeconds(laser_shift_512);
laser_shift_seconds.('M513') = convertToSeconds(laser_shift_513);

% Initialize result containers for baseline RR intervals
RR_chr2_baseline = [];
RR_yfp_baseline = [];

% Process ChR2 group
for i = 1:length(uniqueIDs_chr2)
    uniqueId = uniqueIDs_chr2{i};
    RRFile = fullfile(RRDirectory, sprintf('RR_%s.mat', uniqueId));
    RRTimeFile = fullfile(RRDirectory, sprintf('RR_time_%s.mat', uniqueId));
    sleepFile = fullfile(sleepDirectory, sprintf('NREMinclMA_periods_%s.mat', uniqueId));

    if exist(RRFile, 'file') && exist(RRTimeFile, 'file') && exist(sleepFile, 'file')
        RR_data = load(RRFile);
        RR_time_data = load(RRTimeFile);
        sleep_data = load(sleepFile);

        RR = RR_data.(sprintf('RR_%s', uniqueId));
        RR_time = RR_time_data.(sprintf('RR_time_%s', uniqueId));
        NREM_periods = sleep_data.(sprintf('NREMinclMA_periods_%s', uniqueId));

        % Get laser shifts for the current subject
        laser_shifts = laser_shift_seconds.(sprintf('M%s', uniqueId));

        % Pre-laser and post-laser baseline extraction
        start_time_pre = 0; % Start time (before first laser)
        end_time_pre = laser_shifts(1); % First laser starts
        start_time_post = laser_shifts(end); % End of last laser
        end_time_post = RR_time(end); % End of recording

        % Extract RR intervals in pre-laser period
        for j = 1:size(NREM_periods, 1)
            onset = NREM_periods(j, 1);
            offset = NREM_periods(j, 2);
            if onset < end_time_pre && offset > start_time_pre
                RR_segment_pre = RR(RR_time >= max(onset, start_time_pre) & RR_time <= min(offset, end_time_pre));
                RR_chr2_baseline = [RR_chr2_baseline; RR_segment_pre']; %#ok<AGROW>
            end
        end

    end
end

% Process YFP group
for i = 1:length(uniqueIDs_yfp)
    uniqueId = uniqueIDs_yfp{i};
    RRFile = fullfile(RRDirectory, sprintf('RR_%s.mat', uniqueId));
    RRTimeFile = fullfile(RRDirectory, sprintf('RR_time_%s.mat', uniqueId));
    sleepFile = fullfile(sleepDirectory, sprintf('NREMinclMA_periods_%s.mat', uniqueId));

    if exist(RRFile, 'file') && exist(RRTimeFile, 'file') && exist(sleepFile, 'file')
        RR_data = load(RRFile);
        RR_time_data = load(RRTimeFile);
        sleep_data = load(sleepFile);

        RR = RR_data.(sprintf('RR_%s', uniqueId));
        RR_time = RR_time_data.(sprintf('RR_time_%s', uniqueId));
        NREM_periods = sleep_data.(sprintf('NREMinclMA_periods_%s', uniqueId));

        % Get laser shifts for the current subject
        laser_shifts = laser_shift_seconds.(sprintf('M%s', uniqueId));

        % Pre-laser and post-laser baseline extraction
        start_time_pre = 0; % Start time (before first laser)
        end_time_pre = laser_shifts(1); % First laser starts
        start_time_post = laser_shifts(end); % End of last laser
        end_time_post = RR_time(end); % End of recording

        % Extract RR intervals in pre-laser period
        for j = 1:size(NREM_periods, 1)
            onset = NREM_periods(j, 1);
            offset = NREM_periods(j, 2);
            if onset < end_time_pre && offset > start_time_pre
                RR_segment_pre = RR(RR_time >= max(onset, start_time_pre) & RR_time <= min(offset, end_time_pre));
                RR_yfp_baseline = [RR_yfp_baseline; RR_segment_pre']; %#ok<AGROW>
            end
        end
    end
end

% Calculate mean and SD for RR intervals and BPM for ChR2
mean_RR_chr2 = mean(RR_chr2_baseline);
std_RR_chr2 = std(RR_chr2_baseline);
mean_BPM_chr2 = 60 / mean_RR_chr2;
std_BPM_chr2 = (60 / mean_RR_chr2) * (std_RR_chr2 / mean_RR_chr2);

% Calculate mean and SD for RR intervals and BPM for YFP
mean_RR_yfp = mean(RR_yfp_baseline);
std_RR_yfp = std(RR_yfp_baseline);
mean_BPM_yfp = 60 / mean_RR_yfp;
std_BPM_yfp = (60 / mean_RR_yfp) * (std_RR_yfp / mean_RR_yfp);

% Print the results
fprintf('ChR2 Baseline Mean RR: %.2f, SD RR: %.2f\n', mean_RR_chr2, std_RR_chr2);
fprintf('ChR2 Baseline Mean BPM: %.2f, SD BPM: %.2f\n', mean_BPM_chr2, std_BPM_chr2);

fprintf('YFP Baseline Mean RR: %.2f, SD RR: %.2f\n', mean_RR_yfp, std_RR_yfp);
fprintf('YFP Baseline Mean BPM: %.2f, SD BPM: %.2f\n', mean_BPM_yfp, std_BPM_yfp);



%% Get mean/SD RR/BPM for each laser level

[results_chr2_table, results_yfp_table] = extract_and_calculate_RR();

chr2 = {'489', '480', '491', '497', '511', '522'};
yfp = {'584', '577', '512', '513'};

% Initialize result tables
results_chr2 = [];
results_yfp = [];

% Function to calculate the mean and SD for RR and BPM
calculateStats = @(RR_values) struct('mean_RR', mean(RR_values), ...
                                     'std_RR', std(RR_values), ...
                                     'mean_BPM', 60./mean(RR_values), ...
                                     'std_BPM', 60./mean(RR_values) * std(RR_values)/mean(RR_values));

% Calculate baseline data (before laser level 1 and after laser level 5)
baseline_chr2 = RR_data_NREM_laser_table(ismember(RR_data_NREM_laser_table.MouseID, chr2) & ...
                                         (RR_data_NREM_laser_table.Laser_level == 0 | ...
                                          RR_data_NREM_laser_table.Laser_level == 6), :);
baseline_yfp = RR_data_NREM_laser_table(ismember(RR_data_NREM_laser_table.MouseID, yfp) & ...
                                        (RR_data_NREM_laser_table.Laser_level == 0 | ...
                                         RR_data_NREM_laser_table.Laser_level == 6), :);

% Calculate statistics for baseline chr2
if ~isempty(baseline_chr2)
    RR_values_baseline_chr2 = [];
    for idx = 1:height(baseline_chr2)
        RR_values_baseline_chr2 = [RR_values_baseline_chr2; baseline_chr2.RR_Values{idx}'];
    end
    
    stats_baseline_chr2 = calculateStats(RR_values_baseline_chr2);
    results_chr2 = [results_chr2; {0, stats_baseline_chr2.mean_RR, stats_baseline_chr2.std_RR, stats_baseline_chr2.mean_BPM, stats_baseline_chr2.std_BPM}];
end

% Calculate statistics for baseline yfp
if ~isempty(baseline_yfp)
    RR_values_baseline_yfp = [];
    for idx = 1:height(baseline_yfp)
        RR_values_baseline_yfp = [RR_values_baseline_yfp; baseline_yfp.RR_Values{idx}'];
    end
    
    stats_baseline_yfp = calculateStats(RR_values_baseline_yfp);
    results_yfp = [results_yfp; {0, stats_baseline_yfp.mean_RR, stats_baseline_yfp.std_RR, stats_baseline_yfp.mean_BPM, stats_baseline_yfp.std_BPM}];
end

% Loop through each laser level (1 to 5)
for laser_level = 1:5
    % Filter data for the current laser level
    data_chr2 = RR_data_NREM_laser_table(ismember(RR_data_NREM_laser_table.MouseID, chr2) & ...
                                         RR_data_NREM_laser_table.Laser_level == laser_level, :);
    data_yfp = RR_data_NREM_laser_table(ismember(RR_data_NREM_laser_table.MouseID, yfp) & ...
                                        RR_data_NREM_laser_table.Laser_level == laser_level, :);
    
    % Calculate statistics for chr2
    if ~isempty(data_chr2)
        % Concatenate RR values handling different lengths
        RR_values_chr2 = [];
        for idx = 1:height(data_chr2)
            RR_values_chr2 = [RR_values_chr2; data_chr2.RR_Values{idx}'];
        end
        
        stats_chr2 = calculateStats(RR_values_chr2);
        results_chr2 = [results_chr2; {laser_level, stats_chr2.mean_RR, stats_chr2.std_RR, stats_chr2.mean_BPM, stats_chr2.std_BPM}];
    end
    
    % Calculate statistics for yfp
    if ~isempty(data_yfp)
        % Concatenate RR values handling different lengths
        RR_values_yfp = [];
        for idx = 1:height(data_yfp)
            RR_values_yfp = [RR_values_yfp; data_yfp.RR_Values{idx}'];
        end
        
        stats_yfp = calculateStats(RR_values_yfp);
        results_yfp = [results_yfp; {laser_level, stats_yfp.mean_RR, stats_yfp.std_RR, stats_yfp.mean_BPM, stats_yfp.std_BPM}];
    end
end

% Convert the results to tables for better readability
results_chr2_table = cell2table(results_chr2, 'VariableNames', {'Laser_Level', 'Mean_RR', 'SD_RR', 'Mean_BPM', 'SD_BPM'});
results_yfp_table = cell2table(results_yfp, 'VariableNames', {'Laser_Level', 'Mean_RR', 'SD_RR', 'Mean_BPM', 'SD_BPM'});

% Display the results
disp('Results for chr2 group:');
disp(results_chr2_table);

disp('Results for yfp group:');
disp(results_yfp_table);

% Clear temporary variables
clear chr2 yfp data_chr2 data_yfp RR_values_chr2 RR_values_yfp stats_chr2 stats_yfp;



%% Plot PSD
chr2 = {'489', '480', '491', '497', '511', '522'};
yfp = {'584', '577', '512', '513'};

[PXX_NE_chr2, PXX_NE_yfp, f_NE, mean_sem_NE_PSD_chr2, mean_sem_NE_PSD_yfp] = PSD_chr2_NE(chr2, yfp);
[PXX_RR_chr2, PXX_RR_yfp, f_RR, mean_sem_RR_PSD_chr2, mean_sem_RR_PSD_yfp, RR_table_chr2, RR_table_yfp] = PSD_chr2(chr2, yfp);

[RR_values, PSD_values] = Get_example_PSD_laser();
writetable(RR_values, 'RR_values.csv')
writetable(PSD_values, 'PSD_values.csv')

%test
PXX_group = cell(5, 2);
[PXX_group, f, PXX_bouts] = process_group_RR_30sec(chr2, 'chr2', PXX_group);
%% Make PSD into table for Graphpad export

% % Process the nested cells for chr2 and yfp
% resultTable_chr2_NE = processNestedCellsChr2(PXX_NE_chr2, [f_NE], 'chr2');
% resultTable_chr2_RR = processNestedCellsChr2(PXX_RR_chr2, f_RR, 'chr2');

%this table is defined in the process_group_RR_30sec function and is just
%saved here for convenience
writetable(RR_table, 'RR_distributions_chr2.csv')
writetable(RR_table, 'RR_distributions_yfp.csv')

writetable(mean_sem_NE_PSD_chr2, 'chr2_NE_PSD_trace.csv')
writetable(mean_sem_RR_PSD_chr2, 'chr2_RR_PSD_trace.csv')
writetable(mean_sem_NE_PSD_yfp, 'yfp_NE_PSD_trace.csv')
writetable(mean_sem_RR_PSD_yfp, 'yfp_RR_PSD_trace.csv')
%% AUC PSD NE
[AUC_table_chr2, peak_psd_chr2, PeakPower_chr2_NE] = process_group_NE_AUC_30sec(chr2, 0.2);
[AUC_table_yfp, peak_psd_yfp, PeakPower_yfp_NE] = process_group_NE_AUC_30sec(yfp, 0.2);

    %% AUC PSD RR

[AUC_table_chr2_RR, peak_freq_chr2_RR, PeakPower_chr2_RR] = process_group_RR_AUC_30sec(chr2, 0.00, 0.15);
[AUC_table_yfp_RR, peak_freq_yfp_RR, PeakPower_yfp_RR] = process_group_RR_AUC_30sec(yfp, 0.00, 0.15);

average_AUC_by_suffix_chr2 = groupsummary(AUC_table_chr2_RR, 'Suffix', 'mean', 'AUC');
average_AUC_by_suffix_yfp = groupsummary(AUC_table_yfp_RR, 'Suffix', 'mean', 'AUC');

% Rename the 'AUC' column to 'PSD_RR_AUC' for the chr2 table
average_AUC_by_suffix_chr2.Properties.VariableNames{'mean_AUC'} = 'PSD_RR_AUC';

% Rename the 'AUC' column to 'PSD_RR_AUC' for the yfp table
average_AUC_by_suffix_yfp.Properties.VariableNames{'mean_AUC'} = 'PSD_RR_AUC';

%% Combine AUC PSD tables for R export

% Add 'GT' column to peak_psd_chr2 table
peak_psd_chr2.GT = repmat({'chr2'}, height(peak_psd_chr2), 1);

% Add 'GT' column to peak_psd_yfp table
peak_psd_yfp.GT = repmat({'yfp'}, height(peak_psd_yfp), 1);

% Add 'GT' column to peak_freq_chr2_RR table
peak_freq_chr2_RR.GT = repmat({'chr2'}, height(peak_freq_chr2_RR), 1);

% Add 'GT' column to peak_freq_yfp_RR table
peak_freq_yfp_RR.GT = repmat({'yfp'}, height(peak_freq_yfp_RR), 1);

% Combine the peak_psd_chr2 and peak_psd_yfp tables
combined_peak_psd_table = [peak_psd_chr2; peak_psd_yfp];

% Combine the peak_freq_chr2_RR and peak_freq_yfp_RR tables
combined_peak_freq_RR_table = [peak_freq_chr2_RR; peak_freq_yfp_RR];

writetable(combined_peak_psd_table, 'combined_NE_peakfreq_psd.csv');
writetable(combined_peak_freq_RR_table, 'combined_RR_peakfreq_psd.csv');

% Add 'GT' column to peak_psd_chr2 table
PeakPower_chr2_NE.GT = repmat({'chr2'}, height(PeakPower_chr2_NE), 1);

% Add 'GT' column to peak_psd_yfp table
PeakPower_yfp_NE.GT = repmat({'yfp'}, height(PeakPower_yfp_NE), 1);

% Add 'GT' column to peak_freq_chr2_RR table
PeakPower_chr2_RR.GT = repmat({'chr2'}, height(PeakPower_chr2_RR), 1);

% Add 'GT' column to peak_freq_yfp_RR table
PeakPower_yfp_RR.GT = repmat({'yfp'}, height(PeakPower_yfp_RR), 1);

% Combine the peak_psd_chr2 and peak_psd_yfp tables
combined_peak_psd_table = [PeakPower_chr2_NE; PeakPower_yfp_NE];

% Combine the peak_freq_chr2_RR and peak_freq_yfp_RR tables
combined_peak_freq_RR_table = [PeakPower_chr2_RR; PeakPower_yfp_RR];

writetable(combined_peak_psd_table, 'combined_NE_peakPower_psd.csv');
writetable(combined_peak_freq_RR_table, 'combined_RR_peakPower_psd.csv');

% Add 'GT' column to AUC_table_chr2 table
AUC_table_chr2.GT = repmat({'chr2'}, height(AUC_table_chr2), 1);

% Add 'GT' column to AUC_table_yfp table
AUC_table_yfp.GT = repmat({'yfp'}, height(AUC_table_yfp), 1);

% Add 'GT' column to AUC_table_chr2_RR table
AUC_table_chr2_RR.GT = repmat({'chr2'}, height(AUC_table_chr2_RR), 1);

% Add 'GT' column to AUC_table_yfp_RR table
AUC_table_yfp_RR.GT = repmat({'yfp'}, height(AUC_table_yfp_RR), 1);

% Combine the AUC_table_chr2 and AUC_table_yfp tables
combined_AUC_table_table = [AUC_table_chr2; AUC_table_yfp];

% Combine the AUC_table_chr2_RR and AUC_table_yfp_RR tables
combined_AUC_table_RR_table = [AUC_table_chr2_RR; AUC_table_yfp_RR];

writetable(combined_AUC_table_table, 'combined_NE_AUC_psd.csv');
writetable(combined_AUC_table_RR_table, 'combined_RR_AUC_psd.csv');

%% Plot AUC for NE PSD

    % Number of laser levels
    num_laser_levels = 5;
    
    % Calculate means and SEMs for chr2
    means_chr2 = zeros(num_laser_levels, 1);
    sems_chr2 = zeros(num_laser_levels, 1);
    for i = 1:num_laser_levels
        data = AUC_table_chr2.AUC(AUC_table_chr2.LaserLevel == i);
        means_chr2(i) = mean(data);
        sems_chr2(i) = std(data) / sqrt(length(data));
    end
    
    % Calculate means and SEMs for yfp
    means_yfp = zeros(num_laser_levels, 1);
    sems_yfp = zeros(num_laser_levels, 1);
    for i = 1:num_laser_levels
        data = AUC_table_yfp.AUC(AUC_table_yfp.LaserLevel == i);
        means_yfp(i) = mean(data);
        sems_yfp(i) = std(data) / sqrt(length(data));
    end
    
    % Create a bar plot
    figure;
    hold on;

    % Define the bar width
    barWidth = 0.35;

    % Define x positions for the bars
    x = 1:num_laser_levels;

    % Plot bars for chr2
    bar1 = bar(x - barWidth/2, means_chr2, barWidth, 'FaceColor', [0 0.4470 0.7410], 'DisplayName', 'chr2');

    % Plot bars for yfp
    bar2 = bar(x + barWidth/2, means_yfp, barWidth, 'FaceColor', [0.8500 0.3250 0.0980], 'DisplayName', 'yfp');

    % Plot error bars for chr2
    errorbar(x - barWidth/2, means_chr2, sems_chr2, 'k', 'LineStyle', 'none', 'LineWidth', 1.5);

    % Plot error bars for yfp
    errorbar(x + barWidth/2, means_yfp, sems_yfp, 'k', 'LineStyle', 'none', 'LineWidth', 1.5);

    % Customize the plot
    set(gca, 'XTick', x);
    set(gca, 'XTickLabel', {'Laser Level 1', 'Laser Level 2', 'Laser Level 3', 'Laser Level 4', 'Laser Level 5'});
    xlabel('Laser Levels');
    ylabel('Area Under the Curve (AUC)');
    title('AUC of PSD NE for chr2 and yfp');
    legend('show');
    grid on;

    % Set figure background color to white
    set(gcf, 'Color', 'w');

    hold off;


%% Plot RR PSD AUC

    % Number of laser levels
    num_laser_levels = 5;
    
    % Calculate means and SEMs for chr2
    means_chr2 = zeros(num_laser_levels, 1);
    sems_chr2 = zeros(num_laser_levels, 1);
    for i = 1:num_laser_levels
        data = AUC_table_chr2_RR.AUC(AUC_table_chr2_RR.LaserLevel == i);
        means_chr2(i) = mean(data);
        sems_chr2(i) = std(data) / sqrt(length(data));
    end
    
    % Calculate means and SEMs for yfp
    means_yfp = zeros(num_laser_levels, 1);
    sems_yfp = zeros(num_laser_levels, 1);
    for i = 1:num_laser_levels
        data = AUC_table_yfp_RR.AUC(AUC_table_yfp_RR.LaserLevel == i);
        means_yfp(i) = mean(data);
        sems_yfp(i) = std(data) / sqrt(length(data));
    end
    
    % Create a bar plot
    figure;
    hold on;

    % Define the bar width
    barWidth = 0.35;

    % Define x positions for the bars
    x = 1:num_laser_levels;

    % Plot bars for chr2
    bar1 = bar(x - barWidth/2, means_chr2, barWidth, 'FaceColor', [0 0.4470 0.7410], 'DisplayName', 'chr2');

    % Plot bars for yfp
    bar2 = bar(x + barWidth/2, means_yfp, barWidth, 'FaceColor', [0.8500 0.3250 0.0980], 'DisplayName', 'yfp');

    % Plot error bars for chr2
    errorbar(x - barWidth/2, means_chr2, sems_chr2, 'k', 'LineStyle', 'none', 'LineWidth', 1.5);

    % Plot error bars for yfp
    errorbar(x + barWidth/2, means_yfp, sems_yfp, 'k', 'LineStyle', 'none', 'LineWidth', 1.5);

    % Customize the plot
    set(gca, 'XTick', x);
    set(gca, 'XTickLabel', {'Laser Level 1', 'Laser Level 2', 'Laser Level 3', 'Laser Level 4', 'Laser Level 5'});
    xlabel('Laser Levels');
    ylabel('Area Under the Curve (AUC)');
    title('AUC of PSD RR for chr2 and yfp');
    legend('show');
    grid on;

    % Set figure background color to white
    set(gcf, 'Color', 'w');

    hold off;

    %% Export peak psd to graphpad format
    
% [AUC_table_chr2, peak_psd_chr2, PeakPower_chr2_NE] = process_group_NE_AUC_30sec(chr2, 0.2);
% [AUC_table_yfp, peak_psd_yfp, PeakPower_yfp_NE] = process_group_NE_AUC_30sec(yfp, 0.2);
% 
% 
% [AUC_table_chr2_RR, peak_freq_chr2_RR, PeakPower_chr2_RR] = process_group_RR_AUC_30sec(chr2, 0.00, 0.15);
% [AUC_table_yfp_RR, peak_freq_yfp_RR, PeakPower_yfp_RR] = process_group_RR_AUC_30sec(yfp, 0.00, 0.15);


    % Initialize the combined table with AUC_NE_relative as the first column
    combined_table_graphpad_peak = table(peak_psd_chr2.PeakFrequency, peak_freq_chr2_RR.PeakFrequency, 'VariableNames', {'peakfre_NE_chr2', 'peakfre_RR_chr2'});
    
    % Loop over laser levels 1 to 5
    for level = 1:5
        % Initialize the column for the current laser level with NaN
        peakfre_RR_column = NaN(height(peak_freq_chr2_RR), 1);
        
        % Find the indices for the current laser level
        indices = peak_freq_chr2_RR.LaserLevel == level;
        
        % Convert the AUC values to relative percentages and place them in the column
        peakfre_RR_column(indices) = peak_freq_chr2_RR.PeakFrequency(indices);
        
        % Add the column to the combined table with the appropriate name
        combined_table_graphpad_peak = [combined_table_graphpad_peak, table(peakfre_RR_column, 'VariableNames', {['peakfre_RR_LaserLevel_' num2str(level)]})];
    end

        % Loop over laser levels 1 to 5
    for level = 1:5
        % Initialize the column for the current laser level with NaN
        peakfre_NE_column = NaN(height(peak_psd_chr2), 1);
        
        % Find the indices for the current laser level
        indices = peak_psd_chr2.LaserLevel == level;
        
        % Convert the AUC values to relative percentages and place them in the column
        peakfre_NE_column(indices) = peak_psd_chr2.PeakFrequency(indices);
        
        % Add the column to the combined table with the appropriate name
        combined_table_graphpad_peak = [combined_table_graphpad_peak, table(peakfre_NE_column, 'VariableNames', {['peakfre_NE_LaserLevel_' num2str(level)]})];
    end

    writetable(combined_table_graphpad_peak, 'chr2_peakfreq_NE_RR_PSD.csv')

      %% Export peak power to graphpad format
    
    % Initialize the combined table with AUC_NE_relative as the first column
combined_table_graphpad_peak = table(PeakPower_yfp_NE.PeakPower, PeakPower_yfp_RR.PeakPower, 'VariableNames', {'PeakPower_NE_yfp', 'PeakPower_RR_yfp'});

% Loop over laser levels 1 to 5 for RR
for level = 1:5
    % Initialize the column for the current laser level with NaN
    peakPower_RR_column = NaN(height(PeakPower_yfp_RR), 1);
    
    % Find the indices for the current laser level
    indices = PeakPower_yfp_RR.LaserLevel == level;
    
    % Place the peak power values in the column
    peakPower_RR_column(indices) = PeakPower_yfp_RR.PeakPower(indices);
    
    % Add the column to the combined table with the appropriate name
    combined_table_graphpad_peak = [combined_table_graphpad_peak, table(peakPower_RR_column, 'VariableNames', {['PeakPower_RR_LaserLevel_' num2str(level)]})];
end

% Loop over laser levels 1 to 5 for NE
for level = 1:5
    % Initialize the column for the current laser level with NaN
    peakPower_NE_column = NaN(height(PeakPower_yfp_NE), 1);
    
    % Find the indices for the current laser level
    indices = PeakPower_yfp_NE.LaserLevel == level;
    
    % Place the peak power values in the column
    peakPower_NE_column(indices) = PeakPower_yfp_NE.PeakPower(indices);
    
    % Add the column to the combined table with the appropriate name
    combined_table_graphpad_peak = [combined_table_graphpad_peak, table(peakPower_NE_column, 'VariableNames', {['PeakPower_NE_LaserLevel_' num2str(level)]})];
end

writetable(combined_table_graphpad_peak, 'yfp_peakpower_NE_RR_PSD.csv')
%% Export AUC to Graphpad

% [AUC_table_chr2, peak_psd_chr2, PeakPower_chr2_NE] = process_group_NE_AUC_30sec(chr2, 0.2);
% [AUC_table_yfp, peak_psd_yfp, PeakPower_yfp_NE] = process_group_NE_AUC_30sec(yfp, 0.2);
% 
% 
% [AUC_table_chr2_RR, peak_freq_chr2_RR, PeakPower_chr2_RR] = process_group_RR_AUC_30sec(chr2, 0.00, 0.15);
% [AUC_table_yfp_RR, peak_freq_yfp_RR, PeakPower_yfp_RR] = process_group_RR_AUC_30sec(yfp, 0.00, 0.15);

    % Initialize the combined table with AUC_NE_relative as the first column
    combined_table_graphpad_AUC = table(AUC_table_yfp.AUC, AUC_table_yfp_RR.AUC, 'VariableNames', {'AUC_NE_yfp', 'AUC_RR_yfp'});
    
    % Loop over laser levels 1 to 5
    for level = 1:5
        % Initialize the column for the current laser level with NaN
        AUC_RR_column = NaN(height(AUC_table_yfp_RR), 1);
        
        % Find the indices for the current laser level
        indices = AUC_table_yfp_RR.LaserLevel == level;
        
        % Convert the AUC values to relative percentages and place them in the column
        AUC_RR_column(indices) = AUC_table_yfp_RR.AUC(indices);
        
        % Add the column to the combined table with the appropriate name
        combined_table_graphpad_AUC = [combined_table_graphpad_AUC, table(AUC_RR_column, 'VariableNames', {['AUC_RR_LaserLevel_' num2str(level)]})];
    end

        % Loop over laser levels 1 to 5
    for level = 1:5
        % Initialize the column for the current laser level with NaN
        AUC_NE_column = NaN(height(AUC_table_yfp), 1);
        
        % Find the indices for the current laser level
        indices = AUC_table_yfp.LaserLevel == level;
        
        % Convert the AUC values to relative percentages and place them in the column
        AUC_NE_column(indices) = AUC_table_yfp.AUC(indices);
        
        % Add the column to the combined table with the appropriate name
        combined_table_graphpad_AUC = [combined_table_graphpad_AUC, table(AUC_NE_column, 'VariableNames', {['AUC_NE_LaserLevel_' num2str(level)]})];
    end

    writetable(combined_table_graphpad_AUC, 'yfp_AUC_NE_RR_PSD.csv')

    %% Plot relative % RR/NE PSD AUC (with burst onset data)
plot_relative_auc_chr2_no_baseline(AUC_table_chr2_RR, AUC_table_yfp_RR, 'AUC of PSD RR for chr2 and yfp');
plot_relative_auc_chr2_no_baseline(AUC_table_chr2, AUC_table_yfp, 'AUC of PSD NE for chr2 and yfp');
    %% Combine RR and NE PSD AUC tables
 % Ensure the tables have the same number of rows and the same other columns
    if height(AUC_table_yfp) == height(AUC_table_yfp_RR) && isequal(AUC_table_yfp(:, 2:end), AUC_table_yfp_RR(:, 2:end))
        % Calculate the baseline for AUC_NE as the mean of all level 1 laser values
        AUC_NE_base = mean(AUC_table_yfp.AUC(AUC_table_yfp.LaserLevel == 1));
        AUC_NE_relative = (AUC_table_yfp.AUC / AUC_NE_base) * 100;

        % Calculate the baseline for AUC_RR as the mean of all level 1 laser values
        AUC_RR_base = mean(AUC_table_yfp_RR.AUC(AUC_table_yfp_RR.LaserLevel == 1));
        AUC_RR_relative = (AUC_table_yfp_RR.AUC / AUC_RR_base) * 100;
        
        % Create the combined table
        combined_table = AUC_table_yfp;
        combined_table.AUC_NE = AUC_NE_relative;
        combined_table.AUC_RR = AUC_RR_relative;
        
        % Remove the original AUC column
        combined_table.AUC = [];
    else
        error('The tables have different dimensions or different other columns.');
    end




    % Version for graphpad with new collumn for each laser level





     % Calculate the baseline for AUC_NE as the mean of all level 1 laser values
    AUC_NE_base = mean(AUC_table_yfp.AUC(AUC_table_yfp.LaserLevel == 1));
    AUC_NE_relative = (AUC_table_yfp.AUC / AUC_NE_base) * 100;

         % Calculate the baseline for AUC_NE as the mean of all level 1 laser values
    AUC_RR_base = mean(AUC_table_yfp_RR.AUC(AUC_table_yfp_RR.LaserLevel == 1));
    AUC_RR_relative = (AUC_table_yfp_RR.AUC / AUC_RR_base) * 100;
    
    % Initialize the combined table with AUC_NE_relative as the first column
    combined_table_graphpad = table(AUC_NE_relative, AUC_RR_relative, 'VariableNames', {'AUC_NE', 'AUC_RR'});
    
    % Loop over laser levels 1 to 5
    for level = 1:5
        % Initialize the column for the current laser level with NaN
        AUC_RR_column = NaN(height(AUC_table_yfp_RR), 1);
        
        % Find the indices for the current laser level
        indices = AUC_table_yfp_RR.LaserLevel == level;
        
        % Convert the AUC values to relative percentages and place them in the column
        AUC_RR_column(indices) = (AUC_table_yfp_RR.AUC(indices) / AUC_RR_base) * 100;
        
        % Add the column to the combined table with the appropriate name
        combined_table_graphpad = [combined_table_graphpad, table(AUC_RR_column, 'VariableNames', {['AUC_RR_LaserLevel_' num2str(level)]})];
    end

        % Loop over laser levels 1 to 5
    for level = 1:5
        % Initialize the column for the current laser level with NaN
        AUC_NE_column = NaN(height(AUC_table_yfp), 1);
        
        % Find the indices for the current laser level
        indices = AUC_table_yfp.LaserLevel == level;
        
        % Convert the AUC values to relative percentages and place them in the column
        AUC_NE_column(indices) = (AUC_table_yfp.AUC(indices) / AUC_NE_base) * 100;
        
        % Add the column to the combined table with the appropriate name
        combined_table_graphpad = [combined_table_graphpad, table(AUC_NE_column, 'VariableNames', {['AUC_NE_LaserLevel_' num2str(level)]})];
    end

    %% Continued - save this combined table
    writetable(combined_table, 'yfp_PSD_AUC_NE_RR_combined_table.csv')
    writetable(combined_table_graphpad, 'yfp_PSD_AUC_NE_RR_with_levels_combined_table.csv')


%% Correlation plot between RR and NE PSD AUC

    % Extract the values
    x = AUC_table_chr2_RR.AUC;
    y = AUC_table_chr2.AUC;
    
    % Create a scatter plot
    figure;
    scatter(x, y, 'filled');
    hold on;
    
    % Fit a linear regression line
    p = polyfit(x, y, 1);
    yfit = polyval(p, x);
    plot(x, yfit, '-r', 'LineWidth', 1.5);
    
    % Calculate the correlation coefficient
    R = corrcoef(x, y);
    R_squared = R(1,2)^2;
    
    % Customize the plot
    xlabel('AUC chr2 RR');
    ylabel('AUC chr2');
    title(sprintf('Correlation Plot (R^2 = %.2f)', R_squared));
    grid on;
    
    % Set figure background color to white
    set(gcf, 'Color', 'w');
    
    hold off;
%% Example trace for figure
    %% 588 figure 2 

    uniqueId = '412'; % Extract mouse ID as a string

    % Dynamically generate variable names based on the mouse ID
    % Access the variables dynamically
    wake_woMA_binary_vector = eval(sprintf('wake_woMA_binary_vector_%s', uniqueId));
    sws_binary_vector = eval(sprintf('sws_binary_vector_%s', uniqueId));
    REM_binary_vector = eval(sprintf('REM_binary_vector_%s', uniqueId));
    MA_binary_vector = eval(sprintf('MA_binary_vector_%s', uniqueId));
    ds_sec_signal_2 = eval(sprintf('ds_sec_signal_2_%s', uniqueId));
    sec_signal_2 = eval(sprintf('sec_signal_2_%s', uniqueId));
    ds_delta465_filt_2_smooth = eval(sprintf('ds_delta465_filt_2_%s_smooth', uniqueId));
    sec_signal_EEG = eval(sprintf('sec_signal_EEG_%s', uniqueId));
    EEG = eval(sprintf('EEG_%s', uniqueId));
    EMG = eval(sprintf('EMG_%s', uniqueId));
    RR = eval(sprintf('RR_%s', uniqueId));
    RR_time = eval(sprintf('RR_time_%s', uniqueId));
    % Rpeaks = eval(sprintf('Rpeaks_%s', uniqueId));
    % Rpeaks_time = eval(sprintf('Rpeaks_time_%s', uniqueId));
    signal_fs = eval(sprintf('signal_fs_%s', uniqueId));
    laser_binary = eval(sprintf('laser_binary_%s', uniqueId));
    % mean_spectrogram = eval(sprintf('mean_spectrogram_%s', uniqueId));
    % F = eval(sprintf('F_%s', uniqueId));
    % EEG_bands_fs = eval(sprintf('EEG_bands_fs_%s', uniqueId));
    % MA_binary_vector = [MA_binary_vector, zeros(1, 2)];  % Append zeros horizontally
    % wake_woMA_binary_vector = [wake_woMA_binary_vector_403, zeros(1, 2)];  % Append zeros horizontally
    % 
    % 
    power_bands = {[0.5, 1], [1, 4], [4, 8], [8, 15], [15, 30], [60, 80], [80, 100]}; % define SO, delta, theta, sigma, and beta, respectively

    EEG_bands_time = (1:size(mean_spectrogram, 2))/EEG_bands_fs;

    sleepscore_time = 0:length(wake_woMA_binary_vector)-1; % Assuming all vectors are the same length
    uniqueIdStr = string(uniqueId);

    MeanFilterOrder = 100; % Order for smoothing
    MeanFilter = ones(MeanFilterOrder, 1) / MeanFilterOrder; % Define the mean filter
    RR = filtfilt(MeanFilter, 1, RR);

    % Define x-axis range
    x_start = 15290;
    x_end = 15380;

    figure;
        a = subplot(4, 1, 1);
        hold on
        plot_sleep(ds_sec_signal_2, ds_delta465_filt_2_smooth, sleepscore_time, wake_woMA_binary_vector, sws_binary_vector, REM_binary_vector, MA_binary_vector);    
        %plot(Rpeaks_time, Rpeaks, 'ro');
        hold off
        grid on
        xlabel('Time (s)');
        ylabel('EMG (V)');
    b = subplot(4, 1, 2);
        hold on
        plot_sleep(sec_signal_EEG, EMG, sleepscore_time, wake_woMA_binary_vector, sws_binary_vector, REM_binary_vector, MA_binary_vector);    
        %plot(Rpeaks_time, Rpeaks, 'ro');
        hold off
        grid on
        xlabel('Time (s)');
        ylabel('EMG (V)');
    c = subplot(4, 1, 3);
        plot(RR_time, RR, 'k-');
        hold on;
        grid on
        xlabel('Time (s)');
        ylabel('R-R Intervals');
    d = subplot(4, 1, 4);
        plot(sec_signal_2, laser_binary, 'k-');
        hold on;
        grid on
        xlabel('Time (s)');
        ylabel('Laser');
        %scatter(HRB_time, HRB, 'bo'); % Plotting HRB
        hold off;
 e = subplot(4, 1, 2);
        hold on
        plot_sleep(sec_signal_EEG, EMG, sleepscore_time, wake_woMA_binary_vector, sws_binary_vector, REM_binary_vector, MA_binary_vector);    
        %plot(Rpeaks_time, Rpeaks, 'ro');
        hold off
        grid on
        xlabel('Time (s)');
        ylabel('EMG (V)');

        set(gcf,'color','white')

    % Linking axes for synchronized zooming
    linkaxes([a, b, c, d], 'x');
    
    % Plot EEG data
    figure;
    plot(sec_signal_EEG, EEG, 'k-');
    xlim([x_start, x_end]);
    set(gcf,'color','white');

    % Plot EMG and sleep state data
    figure;
    hold on
    plot(sec_signal_EEG, -emg_fhp);   
    hold off
    xlim([x_start, x_end]);
    set(gcf,'color','white');

    % Plot RR interval data
    figure;
    plot(RR_time, RR, 'k-');
    xlim([x_start, x_end]);
    set(gcf,'color','white');

        % Plot RR interval data
    figure;
    plot(ds_sec_signal_2, ds_delta465_filt_2_smooth);    
    xlim([x_start, x_end]);
    set(gcf,'color','white');

        figure;
    plot_sleep(sec_signal_2, laser_binary, sleepscore_time, wake_woMA_binary_vector, zeros(1, 36437), REM_binary_vector, MA_binary_vector);    
    xlim([x_start, x_end]);
    set(gcf,'color','white');

    % % Plot for the current mouse
    % figure;
    % % 
    % a = subplot(4, 1, 1);
    %     plot(sec_signal_EEG, EEG);    
    % 
    % b = subplot(4, 1, 2);
    %     plot_sleep(ds_sec_signal_2, ds_delta465_filt_2_smooth, sleepscore_time, wake_woMA_binary_vector, sws_binary_vector, REM_binary_vector, MA_binary_vector);
    % 
    % c = subplot(4, 1, 3);
    %     hold on
    %     plot(sec_signal_EEG, emg_fhp);    
    %     scatter(Rpeaks_time, Rpeaks, 'r', 'filled');
    %     hold off
    % 
    % d = subplot(4, 1, 4);
    %     plot(RR_time, RR);
    % 
    %     set(gcf,'color','white')
    % 
    % % Linking axes for synchronized zooming
    % linkaxes([a, b, c, d], 'x');
