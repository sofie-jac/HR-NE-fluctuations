%build-up
name = {'file_destination_FP' 'file_destination_EEG' 'channel_name_blue_1' 'channel_name_violet_1' 'channel_name_red_1' 'channel_name_blue_2' 'channel_name_violet_2' 'channel_name_red_2' 'EEG channel name' 'EEG channel name' 'EMG channel name 1' 'synchronization pulse name FP rig' 'synchronization pulse name EEG rig'  'time period for fitting' };

M117 = {'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\practice data\mouse_117' 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\practice data\mouse_117' 'x465A' 'x405A' 'red' 'x465C' 'x405C' 'red' 'EEGw' 1 'EMG1' 'PtC0' 'PtC0' (1:20000) 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\practice data\mouse_117\117_sleep\6h FP and EEG\Score_117.xlsx'};
M124 = {'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\practice data\mouse_124' 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\practice data\mouse_117' 'Dv2A' 'Dv1A' 'red' 'Dv4C' 'Dv5C' 'red' 'EEGw' 2 'EMG2' 'PtC0' 'PtC0' (1:20000) 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\practice data\mouse_124\124_sleep\6h FP and EEG\Score_124.xlsx'};

mice = {M117, M124};
%% Load FP and EEG data for all mice

% Loop to load data for each mouse
for idx = 1:length(mice)
    mouse = mice{idx};
    
    % Dynamically generate variable names for data_FPrig and data_EEGrig
    data_FPrig_varName = sprintf('data_FPrig_%s', mouse{1}(end-2:end)); % Assumes the unique identifier is the last 3 characters of the first string in mouse array
    data_EEGrig_varName = sprintf('data_EEGrig_%s', mouse{2}(end-2:end)); % Same assumption for EEG rig path
    
    % Load data using TDTbin2mat and assign to dynamically named variables
    eval([data_FPrig_varName, ' = TDTbin2mat(mouse{1});']); % FP rig data
    eval([data_EEGrig_varName, ' = TDTbin2mat(mouse{2});']); % EEG rig data - might be the same as FP rig
end

%% Preprocess FP, EEG and EMG

% Loop to process signals for each mouse and store outputs with dynamic names
for idx = 1:length(mice)
    mouse = mice{idx};
    
    % Dynamically name inputs based on mouse identifiers
    data_FPrig_input = eval(sprintf('data_FPrig_%s', mouse{1}(end-2:end)));
    data_EEGrig_input = eval(sprintf('data_EEGrig_%s', mouse{2}(end-2:end)));
    
    % Call processSignals function with dynamic variable names
    [delta465_filt, sec_signal_2, signal_fs, EEG, EMG, sec_signal_EEG, EEG_fs] = processSignals(mouse, data_FPrig_input, data_EEGrig_input);
    
    % Dynamically save the output variables with mouse-specific names
    eval(sprintf('delta465_filt_2_%s = delta465_filt;', mouse{1}(end-2:end)));
    eval(sprintf('sec_signal_2_%s = sec_signal_2;', mouse{1}(end-2:end)));
    eval(sprintf('signal_fs_%s = signal_fs;', mouse{1}(end-2:end)));
    eval(sprintf('EEG_%s = EEG;', mouse{1}(end-2:end)));
    eval(sprintf('EMG_%s = EMG;', mouse{1}(end-2:end)));
    eval(sprintf('sec_signal_EEG_%s = sec_signal_EEG;', mouse{1}(end-2:end)));
    eval(sprintf('EEG_fs_%s = EEG_fs;', mouse{1}(end-2:end)));
end

%% QC - Check all traces are there

% Number of mice
numMice = length(mice);

% Prepare figure for delta465_filt_2 plots
figure;
sgtitle('Delta465 Filt 2 Signals');
for idx = 1:numMice
    mouse = mice{idx};
    uniqueId = mouse{1}(end-2:end); % Extract unique identifier based on your naming convention
    
    % Load variables dynamically
    delta465_filt_2 = eval(sprintf('delta465_filt_2_%s', uniqueId));
    sec_signal_2 = eval(sprintf('sec_signal_2_%s', uniqueId));
    
    % Plot
    subplot(numMice, 1, idx);
    plot(sec_signal_2, delta465_filt_2);
    title(sprintf('Mouse %s Delta465 Filt 2', uniqueId));
    xlabel('Time (s)');
    ylabel('Delta F/F (%)');
end

% Prepare figure for EEG plots
figure;
sgtitle('EEG Signals');
for idx = 1:numMice
    mouse = mice{idx};
    uniqueId = mouse{1}(end-2:end); % Extract unique identifier
    
    % Load variables dynamically
    EEG = eval(sprintf('EEG_%s', uniqueId));
    sec_signal_EEG = eval(sprintf('sec_signal_EEG_%s', uniqueId));
    
    % Plot
    subplot(numMice, 1, idx);
    plot(sec_signal_EEG, EEG);
    title(sprintf('Mouse %s EEG', uniqueId));
    xlabel('Time (s)');
    ylabel('EEG Signal');
end

% Prepare figure for EMG plots
figure;
sgtitle('EMG Signals');
for idx = 1:numMice
    mouse = mice{idx};
    uniqueId = mouse{1}(end-2:end); % Extract unique identifier
    
    % Load variables dynamically
    EMG = eval(sprintf('EMG_%s', uniqueId));
    sec_signal_EEG = eval(sprintf('sec_signal_EEG_%s', uniqueId));
    
    % Plot
    subplot(numMice, 1, idx);
    plot(sec_signal_EEG, EMG);
    title(sprintf('Mouse %s EMG', uniqueId));
    xlabel('Time (s)');
    ylabel('EMG Signal');
end
%% Downsample FP and filter EEG

% downsampling traces for plotting
ds_factor_FP = 100; % also used for plotting later (section 9b)

ds_delta465_filt_2_117 = downsample(delta465_filt_2_117, ds_factor_FP);
ds_sec_signal_2_117 = downsample(sec_signal_2_117, ds_factor_FP); % for plotting

ds_delta465_filt_2_124 = downsample(delta465_filt_2_124, ds_factor_FP);
ds_sec_signal_2_124 = downsample(sec_signal_2_124, ds_factor_FP); % for plotting

% Design a bandpass filter
bpFilt = designfilt('bandpassfir', 'FilterOrder', 100, ...
    'CutoffFrequency1', 20, 'CutoffFrequency2', 300, ...
    'SampleRate', EEG_fs_117);

% Apply the bandpass filter to your EMG data
filtered_EMG_117 = filtfilt(bpFilt, EMG_117);
filtered_EMG_124 = filtfilt(bpFilt, EMG_124);
%% 

