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
    [delta465_filt, sec_signal_2, signal_fs, EEG, EMG, sec_signal_EEG, EEG_fs, onset_FP_EEG] = processSignals(mouse, data_FPrig_input, data_EEGrig_input);
    
    % Dynamically save the output variables with mouse-specific names
    eval(sprintf('delta465_filt_2_%s = delta465_filt;', mouse{1}(end-2:end)));
    eval(sprintf('sec_signal_2_%s = sec_signal_2;', mouse{1}(end-2:end)));
    eval(sprintf('signal_fs_%s = signal_fs;', mouse{1}(end-2:end)));
    eval(sprintf('EEG_%s = EEG;', mouse{1}(end-2:end)));
    eval(sprintf('EMG_%s = EMG;', mouse{1}(end-2:end)));
    eval(sprintf('sec_signal_EEG_%s = sec_signal_EEG;', mouse{1}(end-2:end)));
    eval(sprintf('EEG_fs_%s = EEG_fs;', mouse{1}(end-2:end)));
    eval(sprintf('onset_FP_EEG_%s = onset_FP_EEG;', mouse{1}(end-2:end)));
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
%% Run sleep analysis
%function will give you the variables needed for plotting, further sleep
%periods, NREM without MA and 
[wake_woMA_binary_vector_117, sws_binary_vector_117, REM_binary_vector_117,MA_binary_vector_117, NREMinclMA_periods_117, NREMexclMA_periods_117, wake_periods_117, REM_periods_117, SWS_before_MA_filtered_117, SWS_before_wake_filtered_117, SWS_before_REM_filtered_117, REM_before_wake_filtered_117] = SleepProcess_TTL(M117, sec_signal_EEG_117, EEG_fs_117, onset_FP_EEG_117, 10, 10, 20);
[wake_woMA_binary_vector_124, sws_binary_vector_124, REM_binary_vector_124,MA_binary_vector_124, NREMinclMA_periods_124, NREMexclMA_periods_124, wake_periods_124, REM_periods_124, SWS_before_MA_filtered_124, SWS_before_wake_filtered_124, SWS_before_REM_filtered_124, REM_before_wake_filtered_124] = SleepProcess_TTL(M124, sec_signal_EEG_124, EEG_fs_124, onset_FP_EEG_124, 10, 10, 20);


%% Power analysis on EEG
power_bands = {[0.5, 1], [1, 4], [4, 8], [8, 15], [15, 30]}; % define SO, delta, theta, sigma, and beta, respectively
frw = 0:0.2:30;
window_in_sec = 1; % sec. 1 for 30 sec

[mean_spectrogram_117, time_spectrogram_zero_117, F_117, band_powers_117, EEG_bands_fs_117] = PowerAnalysisEEG(EEG_117, EEG_fs_117, frw, window_in_sec, power_bands);
[mean_spectrogram_124, time_spectrogram_zero_124, F_124, band_powers_124, EEG_bands_fs_124] = PowerAnalysisEEG(EEG_124, EEG_fs_124, frw, window_in_sec, power_bands);
%% Find NE troughs in sleep transitions and NREM
NREMexclMA_periods_pklocs_117 = find_NE_troughs(NREMexclMA_periods_117, signal_fs_117, delta465_filt_2_117, sec_signal_2_117, 0.3);
SWS_before_MA_pklocs_117 = find_NE_troughs_transistions(SWS_before_MA_filtered_117, signal_fs_117, delta465_filt_2_117, sec_signal_2_117, 0.3);
SWS_before_wake_pklocs_117 = find_NE_troughs_transistions(SWS_before_wake_filtered_117, signal_fs_117, delta465_filt_2_117, sec_signal_2_117, 0.3);
REM_before_wake_pklocs_117 = find_NE_troughs_transistions(REM_before_wake_filtered_117, signal_fs_117, delta465_filt_2_117, sec_signal_2_117, 0.3);

NREMexclMA_periods_pklocs_124 = find_NE_troughs(NREMexclMA_periods_124, signal_fs_124, delta465_filt_2_124, sec_signal_2_124, 0.3);
SWS_before_MA_pklocs_124 = find_NE_troughs_transistions(SWS_before_MA_filtered_124, signal_fs_124, delta465_filt_2_124, sec_signal_2_124, 0.3);
SWS_before_wake_pklocs_124 = find_NE_troughs_transistions(SWS_before_wake_filtered_124, signal_fs_124, delta465_filt_2_124, sec_signal_2_124, 0.3);
REM_before_wake_pklocs_124 = find_NE_troughs_transistions(REM_before_wake_filtered_124, signal_fs_124, delta465_filt_2_124, sec_signal_2_124, 0.3);
%% QC plot for NE troughs
pklocs_variables_117 = {NREMexclMA_periods_pklocs_117, SWS_before_MA_pklocs_117, SWS_before_wake_pklocs_117, REM_before_wake_pklocs_117};
titles_117 = {'NREM - M117', 'NREM to MA Transition - M117', 'NREM to Wake Transition - M117', 'REM to Wake Transition - M117'};
QC_plot_all_NE_troughs(pklocs_variables_117, titles_117, ds_delta465_filt_2_117, ds_sec_signal_2_117, signal_fs_117)


pklocs_variables_124 = {NREMexclMA_periods_pklocs_124, SWS_before_MA_pklocs_124, SWS_before_wake_pklocs_124, REM_before_wake_pklocs_124};
titles_124 = {'NREM - M124', 'NREM to MA Transition - M124', 'NREM to Wake Transition - M124', 'REM to Wake Transition - M124'};
QC_plot_all_NE_troughs(pklocs_variables_124, titles_124, ds_delta465_filt_2_124, ds_sec_signal_2_124, signal_fs_124)
%% QC plot for HRB events - not run yet!
sleep_stage_periods_117 = {NREMexclMA_periods_117, NREMinclMA_periods_117, wake_periods_117, REM_periods_117};
sleep_stages_117 = {'NREM excl MA - M117', 'NREM incl MA - M117', 'Wake - M117', 'REM - M117'};
QC_plot_all_HRB(sleep_stage_periods_117, sleep_stages_117, HRB_117, HRB_time_117)

sleep_stage_periods_124 = {NREMexclMA_periods_124, NREMinclMA_periods_124, wake_periods_124, REM_periods_124};
sleep_stages_124 = {'NREM excl MA - M124', 'NREM incl MA - M124', 'Wake - M124', 'REM - M124'};
QC_plot_all_HRB(sleep_stage_periods_124, sleep_stages_124, HRB_124, HRB_time_124)

%% Split NE into hours for each mouse and store the information

mice_data_hours = []; % To store mouse numbers and their corresponding data hours

for idx = 1:length(mice)
    mouse = mice{idx};
    mouseNumber = mouse{1}(end-2:end); % Extract unique mouse identifier
    
    % Assuming data_FPrig contains the start and end time information for each mouse
    data_FPrig_varName = sprintf('data_FPrig_%s', mouseNumber);
    data_FPrig = eval(data_FPrig_varName); % Dynamically access the data_FPrig variable for the current mouse
    
        % Extract start and end times from data_FPrig
    startTimeStr = data_FPrig.info.utcStartTime;
    endTimeStr = data_FPrig.info.utcStopTime;

    % Convert to datetime in UTC timezone
    startTime = datetime(startTimeStr, 'InputFormat', 'HH:mm:ss', 'TimeZone', 'UTC');
    endTime = datetime(endTimeStr, 'InputFormat', 'HH:mm:ss', 'TimeZone', 'UTC');
    
    % Adjust startTime and endTime by adding one hour for local time zone
    startTime = startTime + hours(1);
    endTime = endTime + hours(1);

    % Now adjust to full hours for segmentation, using the local time
    startTimeNextHour = dateshift(startTime, 'start', 'hour', 'next');
    endTimePreviousHour = dateshift(endTime, 'end', 'hour', 'previous');
    
    % Calculate total full hours and segment data
    totalFullHours = hours(endTimePreviousHour - startTimeNextHour);
    currentSegmentStart = startTimeNextHour;

    signal_fs_varName = sprintf('signal_fs_%s', mouseNumber);
    signal_fs = eval(signal_fs_varName); % Access signal frequency for the current mouse
    
    delta465_filt_2_varName = sprintf('delta465_filt_2_%s', mouseNumber);
    sec_signal_2_varName = sprintf('sec_signal_2_%s', mouseNumber);
    delta465_filt_2 = eval(delta465_filt_2_varName); % Access the FP data for the current mouse
    
    for i = 1:totalFullHours
        % Segment naming incorporating mouse number and hour
        hourSegment = hour(currentSegmentStart);
        
        segmentStartSec = seconds(currentSegmentStart - startTime);
        segmentEndSec = segmentStartSec + 3600; % +1 hour in seconds
        
        % Indices for the segment
        segmentStartIndex = round(segmentStartSec * signal_fs) + 1;
        segmentEndIndex = min(round(segmentEndSec * signal_fs), length(delta465_filt_2)); % Ensure it does not exceed the signal length
        
        % Extract the segments
        segmentDelta = delta465_filt_2(segmentStartIndex:segmentEndIndex);
        segmentTime = ((segmentStartIndex:segmentEndIndex) - segmentStartIndex + 1) / signal_fs;
        
        % Naming and saving segments dynamically
        eval(sprintf('delta465_filt_2_%s_%d = segmentDelta;', mouseNumber, hourSegment));
        eval(sprintf('sec_signal_2_%s_%d = segmentTime + segmentStartSec;', mouseNumber, hourSegment));
        
        % Store mouse number and hour of data segment
        mice_data_hours = [mice_data_hours; str2double(mouseNumber), hourSegment];
        
        % Move to the next hour segment
        currentSegmentStart = currentSegmentStart + hours(1);
    end
end

% At this point, 'mice_data_hours' will have 2 columns: mouse number and hour segments with data
%% Devide hourly NE data into sleep phases




sleepStages = {'NREMinclMA_periods', 'NREMexclMA_periods', 'wake_periods', 'REM_periods'};
updated_mice_data_hours = []; % To store the expanded mice_data_hours data

for i = 1:size(mice_data_hours, 1)
    mouseNumber = mice_data_hours(i, 1);
    hourSegment = mice_data_hours(i, 2);

    % Dynamic variable names for sec_signal_2 and delta465_filt_2 data
    sec_signal_2_varName = sprintf('sec_signal_2_%d_%d', mouseNumber, hourSegment);
    delta465_filt_2_varName = sprintf('delta465_filt_2_%d_%d', mouseNumber, hourSegment);
    
    sec_signal_2_hourly = eval(sec_signal_2_varName);
    delta465_filt_2_hourly = eval(delta465_filt_2_varName);

    for stage = sleepStages
        sleepVarName = sprintf('%s_%d', stage{1}, mouseNumber);
        sleepPeriods = eval(sleepVarName); % Load sleep periods data

        allIndices = []; % Initialize empty array to collect all relevant indices

        % Collect indices for all periods within this sleep stage
        for periodIndex = 1:size(sleepPeriods, 1)
            onset = sleepPeriods(periodIndex, 1);
            offset = sleepPeriods(periodIndex, 2);
            
            % Indices where sec_signal_2_hourly is within the onset and offset
            indices = find(sec_signal_2_hourly >= onset & sec_signal_2_hourly <= offset);
            
            allIndices = [allIndices; indices(:)]; % Ensure indices are a column vector before concatenation
        end

        % Use allIndices to extract the relevant segments
        if ~isempty(allIndices)
            filtered_sec_signal_2 = sec_signal_2_hourly(allIndices);
            filtered_delta465_filt_2 = delta465_filt_2_hourly(allIndices);

            % Save filtered data with new variable names
            newSecSignalName = sprintf('sec_signal_2_%d_%d_%s', mouseNumber, hourSegment, stage{1}(1:end-8)); % Simplify stage name
            newDeltaName = sprintf('delta465_filt_2_%d_%d_%s', mouseNumber, hourSegment, stage{1}(1:end-8));

            eval([newSecSignalName ' = filtered_sec_signal_2;']);
            eval([newDeltaName ' = filtered_delta465_filt_2;']);

            % Update new mice_data_hours array
            updated_mice_data_hours = [updated_mice_data_hours; [mouseNumber, hourSegment, {stage{1}(1:end-8)}, {newSecSignalName}, {eval(newSecSignalName)}, {newDeltaName}, {eval(newDeltaName)}]];
        end
    end
end

%Information on updated_mice_data_hours: first collumn is the mouse number,
%2nd collumn is the start of the hour
%3rd collumn is the sleep variable
%4th and 5th holds the name of FP time variable and the actual timestamps
%in seconds
%6th and 7th holds the name of FP data variable and the actual FP data