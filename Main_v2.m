%PLEASE NOTE
%You need to place the FP file in a folder ending in the 3-digit animal id
%(e.g. 'Mouse_xxx' or 'Mxxx' or simply just the 3-digit animal ID).
%Otherwise the code will not run appropriately

%build-up
name = {'file_destination_FP' 'file_destination_EEG' 'channel_name_blue_1' 'channel_name_violet_1' 'channel_name_red_1' 'channel_name_blue_2' 'channel_name_violet_2' 'channel_name_red_2' 'EEG channel name' 'EEG channel name' 'EMG channel name 1' 'synchronization pulse name FP rig' 'synchronization pulse name EEG rig'  'time period for fitting' };

M117 = {'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\practice data\mouse_117' 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\practice data\mouse_117' 'x465A' 'x405A' 'red' 'x465C' 'x405C' 'red' 'EEGw' 1 'EMG1' 'PtC0' 'PtC0' (1:20000) 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\practice data\mouse_117\117_sleep\6h FP and EEG\Score_117.xlsx'};
M124 = {'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\practice data\mouse_124' 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\practice data\mouse_117' 'Dv2A' 'Dv1A' 'red' 'Dv4C' 'Dv5C' 'red' 'EEGw' 2 'EMG2' 'PtC0' 'PtC0' (1:20000) 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\practice data\mouse_124\124_sleep\6h FP and EEG\Score_124.xlsx'};
M168 = {'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\mouse_168' 'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\mouse_168' '' '' '' 'x465A' 'x405A' 'red' 'EEGw' 1 'EMG1' '' '' (1:18000) 'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\mouse_168\168_sleep_data.xlsx'};
M147 = {'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\147_149_5_51_am_sleep_rec\mouse_147' 'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\147_149_5_51_am_sleep_rec\mouse_147' '' '' '' 'x465A' 'x405A' 'red' 'EEGw' 1 'EMG1' '' '' (1:18000) 'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\147_149_5_51_am_sleep_rec\mouse_147\147_sleep_data.xlsx'};
M149 = {'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\147_149_5_51_am_sleep_rec\mouse_149' 'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\147_149_5_51_am_sleep_rec\mouse_149' '' '' '' 'x465C' 'x405C' 'red' 'EEGw' 2 'EMG2' '' '' (1:18000) 'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\147_149_5_51_am_sleep_rec\mouse_149\149_sleep_data.xlsx'};
mice_TTL = {M124, M117};
mice = {M168, M147, M149, M117, M124};
mice_without_TTL = {M168, M147, M149};

% Create a matrix of mice pairs where the first column is the mouse without EEG data
% and the second column is the mouse with EEG data
mice_pairs = {'M124', 'M117'}; % Example given with M124 and M117


mice_without_TTL_IDs = {};

%Extract names of the mice withoutTTL for later use
for idx = 1:length(mice_without_TTL)
    m = mice_without_TTL{idx}; % Assuming mouse is a cell array with relevant data
    ID = sprintf('M%s', m{1}(end-2:end)); % Extract the ID as intended
    mice_without_TTL_IDs{end+1} = ID; % Correctly append ID to the cell array
end

%% Load FP and EEG data for all mice

for idx = 1:length(mice)
    mouse = mice{idx};
    mouseID = sprintf('M%s', mouse{1}(end-2:end)); % Extract the ID
    disp(mouseID)

        % Dynamically generate variable names for data_FPrig and data_EEGrig
    data_FPrig_varName = sprintf('data_FPrig_%s', mouse{1}(end-2:end)); % Assumes the unique identifier is the last 3 characters of the first string in mouse array
        % Load data using TDTbin2mat and assign to dynamically named variables
    eval([data_FPrig_varName, ' = TDTbin2mat(mouse{1});']); % FP rig data

    % Check if this mouse is supposed to skip EEG data loading
    if ~ismember(mouseID, mice_pairs(:, 1))
        % Load EEG data as normal
        data_EEGrig_varName = sprintf('data_EEGrig_%s', mouse{2}(end-2:end));
        eval([data_EEGrig_varName, ' = TDTbin2mat(mouse{2});']); % EEG rig data - might be the same as FP rig
    end
end

%% Preprocess FP, EEG and EMG
for idx = 1:length(mice_TTL)
    mouse = mice_TTL{idx};
    mouseID = sprintf('M%s', mouse{1}(end-2:end)); % Extract the ID
    disp(mouseID)

    data_FPrig_input = eval(sprintf('data_FPrig_%s', mouse{1}(end-2:end)));
        % Check if the current mouse identifier is in the mice_without_TTL list
    if ismember(mouseIdentifier, mice_without_TTL_IDs)
        % Call processSignals_without_TTL function for mice without TTL
        [delta465_filt_2, sec_signal_2, signal_fs, EEG, EMG, sec_signal_EEG, EEG_fs] = processSignals_without_TTL(mouse, data_FPrig_input, data_EEGrig_input);
    else
        % Determine if this mouse needs to pull EEG/EMG data from a partner
        partnerIdx = find(strcmp(mice_pairs(:,1), mouseID));
        if isempty(partnerIdx)
            % This mouse has its own EEG data
            partnerData = eval(sprintf('data_EEGrig_%s', mouse{1}(end-2:end)));
        else
            % This mouse needs to use its partner's EEG data
            partnerID = mice_pairs{partnerIdx, 2};
            % Remove any letters from partnerID, keeping only digits
            partnerID_numeric = regexprep(partnerID, '\D', '');
            disp(partnerID_numeric)
            % Now use the modified partnerID_numeric in eval
            partnerData = eval(sprintf('data_EEGrig_%s', partnerID_numeric));
        end
    
        % Now call processSignals with partnerData
        [delta465_filt_2, sec_signal_2, signal_fs, EEG, EMG, sec_signal_EEG, EEG_fs, onset_FP_EEG] = processSignals(mouse, data_FPrig_input, partnerData);
    end
        % Dynamically save the output variables with mouse-specific names
    eval(sprintf('delta465_filt_2_%s = delta465_filt_2;', mouse{1}(end-2:end)));
    eval(sprintf('sec_signal_2_%s = sec_signal_2;', mouse{1}(end-2:end)));
    eval(sprintf('signal_fs_%s = signal_fs;', mouse{1}(end-2:end)));
    eval(sprintf('EEG_%s = EEG;', mouse{1}(end-2:end)));
    eval(sprintf('EMG_%s = EMG;', mouse{1}(end-2:end)));
    eval(sprintf('sec_signal_EEG_%s = sec_signal_EEG;', mouse{1}(end-2:end)));
    eval(sprintf('EEG_fs_%s = EEG_fs;', mouse{1}(end-2:end)));
    eval(sprintf('onset_FP_EEG_%s = onset_FP_EEG;', mouse{1}(end-2:end)));
end

%% QC - Check all traces are there

for idx = 1:length(mice)
    mouse = mice{idx};
    uniqueId = mouse{1}(end-2:end); % Extract unique identifier
    
    % Creating one figure per mouse
    figure;
    sgtitle(sprintf('Mouse %s', uniqueId)); % Set the figure title with the mouse ID
    
    % Delta465 Filt 2 Signal Plot
    subplot(3,1,1); % Adjust the number of rows as necessary if adding more plots
    delta465_var_name = sprintf('delta465_filt_2_%s', uniqueId);
    sec_signal_2_var_name = sprintf('sec_signal_2_%s', uniqueId);
    delta465_filt_2 = eval(delta465_var_name);
    sec_signal_2 = eval(sec_signal_2_var_name);
    plot(sec_signal_2, delta465_filt_2);
    title('Delta465 Filt 2');
    xlabel('Time (s)');
    ylabel('Delta F/F (%)');
    
    % EEG Signal Plot
    subplot(3,1,2); % Adjust for EEG plot
    EEG_var_name = sprintf('EEG_%s', uniqueId);
    sec_signal_EEG_var_name = sprintf('sec_signal_EEG_%s', uniqueId);
    EEG = eval(EEG_var_name);
    sec_signal_EEG = eval(sec_signal_EEG_var_name);
    plot(sec_signal_EEG, EEG);
    title('EEG');
    xlabel('Time (s)');
    ylabel('EEG Signal');
    
    % EMG Signal Plot (assuming you have EMG variables named similarly)
    subplot(3,1,3); % Adjust for EMG plot
    EMG_var_name = sprintf('EMG_%s', uniqueId);
    sec_signal_EMG_var_name = sprintf('sec_signal_EEG_%s', uniqueId); % Adjust variable naming as necessary
    EMG = eval(EMG_var_name);
    sec_signal_EMG = eval(sec_signal_EMG_var_name); % Use this if you have a separate time signal for EMG
    plot(sec_signal_EMG, EMG);
    title('EMG');
    xlabel('Time (s)');
    ylabel('EMG Signal');
end


%% Downsample FP and filter EEG


    % Normalize fluorescence traces
MeanFilterOrder = 2000; % for smoothing
MeanFilter = ones(MeanFilterOrder,1)/MeanFilterOrder;

% Smoothing traces for trough detection
delta465_filt_2_117 = filtfilt(MeanFilter,1,delta465_filt_2_117);
delta465_filt_2_124 = filtfilt(MeanFilter,1,delta465_filt_2_124);
delta465_filt_2_168 = filtfilt(MeanFilter,1,delta465_filt_2_168);
delta465_filt_2_147 = filtfilt(MeanFilter,1,delta465_filt_2_147);
delta465_filt_2_149 = filtfilt(MeanFilter,1,delta465_filt_2_149);

% downsampling traces for plotting
ds_factor_FP = 100; % also used for plotting later (section 9b)

ds_delta465_filt_2_117 = downsample(delta465_filt_2_117, ds_factor_FP);
ds_sec_signal_2_117 = downsample(sec_signal_2_117, ds_factor_FP); % for plotting

ds_delta465_filt_2_124 = downsample(delta465_filt_2_124, ds_factor_FP);
ds_sec_signal_2_124 = downsample(sec_signal_2_124, ds_factor_FP); % for plotting

ds_delta465_filt_2_168 = downsample(delta465_filt_2_168, ds_factor_FP);
ds_sec_signal_2_168 = downsample(sec_signal_2_168, ds_factor_FP); % for plotting

ds_delta465_filt_2_147 = downsample(delta465_filt_2_147, ds_factor_FP);
ds_sec_signal_2_147 = downsample(sec_signal_2_147, ds_factor_FP); % for plotting

ds_delta465_filt_2_149 = downsample(delta465_filt_2_149, ds_factor_FP);
ds_sec_signal_2_149 = downsample(sec_signal_2_149, ds_factor_FP); % for plotting

% Design a bandpass filter
bpFilt = designfilt('bandpassfir', 'FilterOrder', 100, ...
    'CutoffFrequency1', 20, 'CutoffFrequency2', 300, ...
    'SampleRate', EEG_fs_117);

% Apply the bandpass filter to your EMG data
filtered_EMG_117 = filtfilt(bpFilt, EMG_117);
filtered_EMG_124 = filtfilt(bpFilt, EMG_124);
filtered_EMG_168 = filtfilt(bpFilt, EMG_168);
filtered_EMG_147 = filtfilt(bpFilt, EMG_147);
filtered_EMG_149 = filtfilt(bpFilt, EMG_149);


%% Run sleep analysis
%function will give you the variables needed for plotting, further sleep
%periods, NREM without MA and 
[wake_woMA_binary_vector_117, sws_binary_vector_117, REM_binary_vector_117,MA_binary_vector_117, NREMinclMA_periods_117, NREMexclMA_periods_117, wake_periods_117, REM_periods_117, MA_periods_117, SWS_before_MA_filtered_117, SWS_before_wake_filtered_117, SWS_before_REM_filtered_117, REM_before_wake_filtered_117] = SleepProcess_TTL(M117, sec_signal_EEG_117, EEG_fs_117, onset_FP_EEG_117, 20, 20, 45);
[wake_woMA_binary_vector_124, sws_binary_vector_124, REM_binary_vector_124,MA_binary_vector_124, NREMinclMA_periods_124, NREMexclMA_periods_124, wake_periods_124, REM_periods_124, MA_periods_124, SWS_before_MA_filtered_124, SWS_before_wake_filtered_124, SWS_before_REM_filtered_124, REM_before_wake_filtered_124] = SleepProcess_TTL(M124, sec_signal_EEG_124, EEG_fs_124, onset_FP_EEG_124, 20, 20, 45);
[wake_woMA_binary_vector_168, sws_binary_vector_168, REM_binary_vector_168,MA_binary_vector_168, NREMinclMA_periods_168, NREMexclMA_periods_168, wake_periods_168, REM_periods_168, MA_periods_168, SWS_before_MA_filtered_168, SWS_before_wake_filtered_168, SWS_before_REM_filtered_168, REM_before_wake_filtered_168] = SleepProcess_without_TTL(M168, sec_signal_EEG_168, 20, 20, 45);
[wake_woMA_binary_vector_147, sws_binary_vector_147, REM_binary_vector_147,MA_binary_vector_147, NREMinclMA_periods_147, NREMexclMA_periods_147, wake_periods_147, REM_periods_147, MA_periods_147, SWS_before_MA_filtered_147, SWS_before_wake_filtered_147, SWS_before_REM_filtered_147, REM_before_wake_filtered_147] = SleepProcess_without_TTL(M147, sec_signal_EEG_147, 20, 20, 45);
[wake_woMA_binary_vector_149, sws_binary_vector_149, REM_binary_vector_149,MA_binary_vector_149, NREMinclMA_periods_149, NREMexclMA_periods_149, wake_periods_149, REM_periods_149, MA_periods_149, SWS_before_MA_filtered_149, SWS_before_wake_filtered_149, SWS_before_REM_filtered_149, REM_before_wake_filtered_149] = SleepProcess_without_TTL(M149, sec_signal_EEG_149, 20, 20, 45);

%% QC - plot sleep
% Assuming 'mice' is a list of mouse identifiers like {'168', '149', ...}
for idx = 1:length(M)
    mouse = M{idx};
    uniqueId = mouse{1}(end-2:end); % Extract mouse ID as a string

    % Dynamically generate variable names based on the mouse ID
    wake_woMA_varName = sprintf('wake_woMA_binary_vector_%s', uniqueId);
    sws_varName = sprintf('sws_binary_vector_%s', uniqueId);
    REM_varName = sprintf('REM_binary_vector_%s', uniqueId);
    MA_varName = sprintf('MA_binary_vector_%s', uniqueId);
    ds_sec_signal_2_varName = sprintf('ds_sec_signal_2_%s', uniqueId);
    ds_delta465_filt_2_varName = sprintf('ds_delta465_filt_2_%s', uniqueId);
    sec_signal_EEG_varName = sprintf('sec_signal_EEG_%s', uniqueId);
    EEG_varName = sprintf('EEG_%s', uniqueId);
    EMG_varName = sprintf('EMG_%s', uniqueId);

    % Access the variables dynamically
    wake_woMA_binary_vector = eval(wake_woMA_varName);
    sws_binary_vector = eval(sws_varName);
    REM_binary_vector = eval(REM_varName);
    MA_binary_vector = eval(MA_varName);
    ds_sec_signal_2 = eval(ds_sec_signal_2_varName);
    ds_delta465_filt_2 = eval(ds_delta465_filt_2_varName);
    sec_signal_EEG = eval(sec_signal_EEG_varName);
    EEG = eval(EEG_varName);
    EMG = eval(EMG_varName);
    
    sleepscore_time = 0:length(wake_woMA_binary_vector)-1; % Assuming all vectors are the same length

    % Plot for the current mouse
    figure;
    sgtitle(sprintf('Mouse %s', uniqueId)); % Set the figure title with the mouse ID

    a = subplot(3, 1, 1);
        plot_sleep(ds_sec_signal_2, ds_delta465_filt_2, sleepscore_time, wake_woMA_binary_vector, sws_binary_vector, REM_binary_vector, MA_binary_vector);
        title(['Norepinephrine']);
        xlabel('time (s)');
        ylabel('NE (V)');
        grid on;

    b = subplot(3, 1, 2);
        plot_sleep(sec_signal_EEG, EMG, sleepscore_time, wake_woMA_binary_vector, sws_binary_vector, REM_binary_vector, MA_binary_vector);
        xlabel('time (s)');
        ylabel('EMG (V)');
        title(['EMG']);
        grid on;

    c = subplot(3, 1, 3);
        plot_sleep(sec_signal_EEG, EEG, sleepscore_time, wake_woMA_binary_vector, sws_binary_vector, REM_binary_vector, MA_binary_vector);
        xlabel('time (s)');
        ylabel('EEG (V)');
        title(['EEG']);
        grid on;

    % Linking axes for synchronized zooming
    linkaxes([a, b, c], 'x');
end


%% Power analysis on EEG
power_bands = {[0.5, 1], [1, 4], [4, 8], [8, 15], [15, 30]}; % define SO, delta, theta, sigma, and beta, respectively
frw = 0:0.2:30;
window_in_sec = 1; % sec. 1 for 30 sec

%[mean_spectrogram_117, time_spectrogram_zero_117, F_117, band_powers_117, EEG_bands_fs_117] = PowerAnalysisEEG(EEG_117, EEG_fs_117, frw, window_in_sec, power_bands);
[mean_spectrogram_124, time_spectrogram_zero_124, F_124, band_powers_124, EEG_bands_fs_124] = PowerAnalysisEEG(EEG_124, EEG_fs_124, frw, window_in_sec, power_bands);
%% Find NE troughs in sleep transitions and NREM
SWS_before_MA_pklocs_117 = findPeriodsBeforeTransitionMA(SWS_before_MA_filtered_117, signal_fs_117, delta465_filt_2_117, sec_signal_2_117, MA_periods_117, 15, 15);
SWS_before_MA_pklocs_124 = findPeriodsBeforeTransitionMA(SWS_before_MA_filtered_124, signal_fs_124, delta465_filt_2_124, sec_signal_2_124, MA_periods_124, 15, 15);

NREMexclMA_periods_pklocs_117 = find_NE_troughs(NREMexclMA_periods_117, signal_fs_117, delta465_filt_2_117, sec_signal_2_117, 3); % Change SD multiplyer to 1 for more selective troughs
NREMexclMA_periods_pklocs_124 = find_NE_troughs(NREMexclMA_periods_124, signal_fs_124, delta465_filt_2_124, sec_signal_2_124, 3); % Change SD multiplyer to 1 for more selective troughs

SWS_before_wake_pklocs_124 = findPeaksBeforeTransition(SWS_before_wake_filtered_124, signal_fs_124, delta465_filt_2_124, sec_signal_2_124, 0.1, mean(delta465_filt_2_124)-5, 15);
SWS_before_wake_pklocs_117 = findPeaksBeforeTransition(SWS_before_wake_filtered_117, signal_fs_117, delta465_filt_2_117, sec_signal_2_117, 0.1, mean(delta465_filt_2_117)-5, 15);

REM_before_wake_pklocs_117 = findPeaksBeforeTransition(REM_before_wake_filtered_117, signal_fs_117, delta465_filt_2_117, sec_signal_2_117, 0, 0, 15);
REM_before_wake_pklocs_124 = findPeaksBeforeTransition(REM_before_wake_filtered_124, signal_fs_124, delta465_filt_2_124, sec_signal_2_124, 0, 0, 15);
%% visualize calculated troughs
    sleepscore_time = 0:length(wake_woMA_binary_vector_117)-1; % Assuming all vectors are the same length

figure
plot_sleep(ds_sec_signal_2_117, ds_delta465_filt_2_117, sleepscore_time, wake_woMA_binary_vector_117, sws_binary_vector_117, REM_binary_vector_117, MA_binary_vector_117);
hold on
plot(REM_before_wake_pklocs_117, delta465_filt_2_117(round(REM_before_wake_pklocs_117*signal_fs)), 'r*')
title('NE with selected peaks');

%%% for next animal
    sleepscore_time = 0:length(wake_woMA_binary_vector_124)-1; % Assuming all vectors are the same length

figure
plot_sleep(ds_sec_signal_2_124, ds_delta465_filt_2_124, sleepscore_time, wake_woMA_binary_vector_124, sws_binary_vector_124, REM_binary_vector_124, MA_binary_vector_124);
hold on
plot(NREMexclMA_periods_pklocs_124, delta465_filt_2_124(round(NREMexclMA_periods_pklocs_124*signal_fs)), 'r*')
title('NE with selected peaks');
%% Generate the main plot

event_var = {NREMexclMA_periods_pklocs_124, SWS_before_MA_pklocs_124, SWS_before_wake_pklocs_124, REM_before_wake_pklocs_124};
titles = {'NREM', 'NREM to MA Transition', 'NREM to Wake Transition', 'REM to Wake Transition'};
main_title = 'Averaged Activity During NE Trough (M124)';


MainPlot(event_var, 30, 60, titles, main_title, delta465_filt_2_124, sec_signal_2_124, signal_fs_124, resampled_RR_pchip_124, new_time_vector_124, new_fs_RR_124,  mean_spectrogram_124, F_124, EEG_bands_fs_124)


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
%% Devide hourly NE data into sleep phases if sleep phase is long enough
min_sleep_period_duration = 90;

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
            
            % Check if the sleep period is longer than 120 seconds
            if (offset - onset) > min_sleep_period_duration
                % Indices where sec_signal_2_hourly is within the onset and offset
                indices = find(sec_signal_2_hourly >= onset & sec_signal_2_hourly <= offset);
                

                % Use allIndices to extract the relevant segments
                if ~isempty(indices)
                    filtered_sec_signal_2 = sec_signal_2_hourly(indices);
                    filtered_delta465_filt_2 = delta465_filt_2_hourly(indices);
        
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
    end
end

%Information on updated_mice_data_hours: first collumn is the mouse number,
%2nd collumn is the start of the hour
%3rd collumn is the sleep variable
%4th and 5th holds the name of FP time variable and the actual timestamps
%in seconds
%6th and 7th holds the name of FP data variable and the actual FP data
%% Get PSD for each sleep stage
% Initialization
max_freq = 0.1; % Maximum frequency for PSD analysis
sample_pr_sec = 0.002; % Frequency resolution for PSD

% Initialize the PSD_NE_table_new with headers
PSD_NE_table_new = [{'MouseNumber', 'Hour', 'SleepStage', 'PeakPower', 'PeakPowerFreq', 'Freq25Quartile', 'MedianFrequency', 'Freq75Quartile', 'Freq95Quartile', 'AUC', 'TotalPower'}];
PSD_data = [];
uniqueMouseNumbers = unique(cell2mat(updated_mice_data_hours(:, 1)));
uniqueHours = unique(cell2mat(updated_mice_data_hours(:, 2)));

% Loop through each hour
for uHour = uniqueHours'
    
    % Find all entries for this hour
    hourEntries = updated_mice_data_hours([updated_mice_data_hours{:, 2}] == uHour, :);

    % Loop through each mouse for the current hour
    for uMouseNumber = uniqueMouseNumbers'
        
        % Extract fs for the current mouse using its identifier
        fs_varName = sprintf('signal_fs_%d', uMouseNumber);
        fs = eval(fs_varName); % Assuming fs is defined in the workspace
        
        combinedPSDData = struct(); % Structure to hold combined PSD data for each sleep stage

        % Loop through each sleep stage for the current mouse and hour
        for uSleepStage = sleepStages
            sleepStage = uSleepStage{1}(1:end-8); % Removing '_periods'
            stageEntries = hourEntries(strcmp(hourEntries(:,3), sleepStage), :);

            weightedPSD = [];
            freqs = [];
            totalDataPoints = 0;

            % Process each sleep bout within the stage
            for entry = stageEntries'
                secSignalData = entry{5};
                deltaSignalData = entry{7};

                % Process each signal segment to calculate PSD
                [detrendedSignal, segmentPSD, freqs, segmentDataPoints] = processSignalSegment(secSignalData, deltaSignalData, fs, max_freq, sample_pr_sec);

                % figure
                % set(gcf, 'Position',  [100, 300, 1500, 250])
                % titleStr = sprintf('Sleep Stage: %s, Mouse: %d', sleepStage, uMouseNumber);
                % sgtitle(titleStr); 
                % a = subplot(1,2,1);
                %     %a.Position = [0.1300 0.1100 0.6200 0.8150];
                %     plot(secSignalData,deltaSignalData);
                %     hold on
                %     plot(secSignalData,detrendedSignal);
                %     legend({'raw','fitted'})
                %     hold off
                % b = subplot(1,2,2);
                %     %b.Position = [0.8140 0.1100 0.1533 0.8150];
                %     plot(freqs,segmentPSD);

                if isempty(weightedPSD)
                    weightedPSD = segmentPSD * segmentDataPoints;
                else
                    weightedPSD = weightedPSD + segmentPSD * segmentDataPoints;
                end
                totalDataPoints = totalDataPoints + segmentDataPoints;
            end

            if totalDataPoints > 0
                % Calculate average PSD for this stage
                avgPSD = weightedPSD / totalDataPoints;
                PSD_data = [PSD_data; [uMouseNumber, uHour, sleepStage, {freqs}, {avgPSD}, totalDataPoints]];

                % Calculate additional metrics from avgPSD and freqs
                [metrics] = calculatePSDMetrics(avgPSD, freqs);

                % Append the calculated metrics for this mouse, hour, and sleep stage to PSD_NE_table_new
                PSD_NE_table_new = [PSD_NE_table_new; {uMouseNumber, uHour, sleepStage, metrics.peakPower, metrics.peakPowerFreq, metrics.Freq25Quartile, metrics.MedianFrequency, metrics.Freq75Quartile, metrics.Freq95Quartile, metrics.AUC, metrics.totalPower}];
            end
        end
    end
end
%% Get PSD per hour/stage cross animal

% Initialize a table for averaged PSD data across mice for each sleep stage and hour
avgPSD_data = [];

% Unique hours and sleep stages for grouping
uniqueHours = unique([PSD_data{:, 2}]);
uniqueSleepStages = unique(PSD_data(:, 3));

% Loop through each unique hour and sleep stage to average PSDs
for hourIdx = 1:length(uniqueHours)
    uHour = uniqueHours(hourIdx);

    % Assuming uniqueHours was obtained from a numeric array
    % Find all entries for this hour
    hourEntriesIdx = find(cell2mat(PSD_data(:, 2)) == uHour);

    for stageIdx = 1:length(uniqueSleepStages)
        uSleepStage = uniqueSleepStages{stageIdx};

        % Since uniqueSleepStages comes from a cell array of strings,
        % use cellfun combined with strcmp to compare each element
        stageMatches = cellfun(@(x) strcmp(x, uSleepStage), PSD_data(:, 3));
        
        % Now find the indices where both the hour and the sleep stage match
        % This requires combining the logical arrays for hour and stage
        matchingEntriesIdx = hourEntriesIdx(stageMatches(hourEntriesIdx));
        
        if isempty(matchingEntriesIdx)
            continue; % Skip if no matching entries
        end
        
        % Initialize accumulator for PSD sums and list to store mouse numbers
        PSD_sum = zeros(size(PSD_data{matchingEntriesIdx(1), 5})); % Initialize based on the first entry's PSD size
        numEntries = 0; % Count of matching entries
        mouseNumbersList = []; % To store mouse numbers contributing to the average
        
        % Loop through matching entries to accumulate PSD sums and collect mouse numbers
        for idx = matchingEntriesIdx'
            currentAvgPSD = PSD_data{idx, 5};
            PSD_sum = PSD_sum + currentAvgPSD; % Sum up the PSD values
            numEntries = numEntries + 1; % Increment count
            mouseNumbersList = [mouseNumbersList, PSD_data{idx, 1}]; % Append mouse number
        end
        
        % Calculate the simple average PSD for the current hour and sleep stage
        if numEntries > 0
            avgPSD = PSD_sum / numEntries; % Calculate the simple average
            currentFreqs = PSD_data{matchingEntriesIdx(1), 4}; % Frequencies assumed to be consistent
            % Add the averaged PSD data and the list of mouse numbers to avgPSD_data
            avgPSD_data = [avgPSD_data; {uHour, uSleepStage, currentFreqs, avgPSD, mouseNumbersList}];
        end
    end
end
%% Plot PSD for NREMinclMA per hour
plotPSDBySleepStage(avgPSD_data, 'NREMinclMA')

%% plot PSD per hour per sleepsatge
% Assuming avgPSD_data is not empty and frequencies are consistent across all entries
if isempty(avgPSD_data)
    disp('avgPSD_data is empty. No plots can be generated.');
    return; % Exit if avgPSD_data is empty
end

% Extract frequencies from the first row of avgPSD_data for plotting
universalFreqs = avgPSD_data{1, 3}; % Use the frequencies from the first row for all plots

colors = {'blue', 'red', 'green', 'black'}; % Color for each sleep phase
sleepStages = {'NREMinclMA', 'NREMexclMA', 'REM', 'wake'};
colorMap = containers.Map(sleepStages, colors);

uniqueHours = unique([avgPSD_data{:, 1}]);
uniqueSleepStages = unique(avgPSD_data(:, 2));

% Loop through each unique hour
for hourIdx = 1:length(uniqueHours)
    uHour = uniqueHours(hourIdx);

    figure; % Create a new figure for each unique hour
    hold on; % Hold on to plot multiple lines

    % Initialize a container to collect mouse numbers for the current hour
    mouseNumbersForHour = [];

    % Loop through each unique sleep stage
    for stageIdx = 1:length(uniqueSleepStages)
        uSleepStage = uniqueSleepStages{stageIdx};

        % Manual approach to find the matching entry
        matchingEntryFound = false;
        for i = 1:size(avgPSD_data, 1)
            if avgPSD_data{i, 1} == uHour && strcmp(avgPSD_data{i, 2}, uSleepStage)
                matchingEntryFound = true;
                matchingEntryIdx = i;
                disp(['Match found - Hour: ', num2str(uHour), ', Sleep Stage: ', uSleepStage, ', Row Index: ', num2str(matchingEntryIdx)]);
                break; % Stop looking once a match is found
            end
        end

        % Proceed if a matching entry is found
        if matchingEntryFound
            avgPSD = avgPSD_data{matchingEntryIdx, 4}; % Access nested PSD
            mouseNumbersList = avgPSD_data{matchingEntryIdx, 5}; % Access mouse numbers
            mouseNumbersForHour = union(mouseNumbersForHour, mouseNumbersList); % Accumulate mouse numbers

            plotColor = colorMap(uSleepStage); % Determine the color for the plot
            plot(universalFreqs, avgPSD, 'DisplayName', uSleepStage, 'Color', plotColor);
        end
    end

    % Construct the title string with mouse numbers
    mouseNumbersStr = strjoin(arrayfun(@(x) num2str(x), mouseNumbersForHour, 'UniformOutput', false), ', ');
    titleStr = sprintf('Power Spectral Density from Hour %d - %d. Averaged across Mice %s', uHour, uHour+1, mouseNumbersStr);

    title(titleStr);
    xlabel('Frequency (Hz)');
    ylabel('Weighted Power');
    legend('show');
    grid on;
    hold off;
    set(gcf, 'color', 'white');
end

%% Preprocess %NREM per hour plot

sleepStages = {'NREMinclMA_periods'}; % Only interested in 'NREMinclMA_periods' for the final output
NREM_mice_data_hours = []; % To store the expanded mice_data_hours data

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
            
            % No longer checking if the sleep period is longer than a specific duration.
            % This includes all sleep periods, regardless of their duration.
            indices = find(sec_signal_2_hourly >= onset & sec_signal_2_hourly <= offset);

            if ~isempty(indices)
                filtered_sec_signal_2 = sec_signal_2_hourly(indices);
                filtered_delta465_filt_2 = delta465_filt_2_hourly(indices);
    
                % Save filtered data with new variable names
                newSecSignalName = sprintf('sec_signal_2_%d_%d_%s', mouseNumber, hourSegment, stage{1}(1:end-8)); % Simplify stage name
                newDeltaName = sprintf('delta465_filt_2_%d_%d_%s', mouseNumber, hourSegment, stage{1}(1:end-8));

                eval([newSecSignalName ' = filtered_sec_signal_2;']);
                eval([newDeltaName ' = filtered_delta465_filt_2;']);

                % Update new mice_data_hours array
                NREM_mice_data_hours = [NREM_mice_data_hours; [mouseNumber, hourSegment, {stage{1}(1:end-8)}, {newSecSignalName}, {eval(newSecSignalName)}, {newDeltaName}, {eval(newDeltaName)}]];
            end
        end
    end
end

% Assuming NREM_mice_data_hours is your input matrix or table
% with columns: Mouse ID, Hour, Sleep Stage, Variable Name, sec_signal_2 Data, Variable Name 2, delta465_filt_2 Data

% Convert the first two columns to strings if they are not already
mouseIDs = string(NREM_mice_data_hours(:, 1));
hours = string(NREM_mice_data_hours(:, 2));

% Create a unique key for each combination of Mouse ID and Hour by concatenating
uniqueKeys = mouseIDs + "_" + hours;

% Find unique combinations and their indices
[uniqueCombinations, ~, groupIndices] = unique(uniqueKeys);

% Initialize the output
percent_NREM = [];

for i = 1:length(uniqueCombinations)
    % Find rows belonging to the current combination
    rows = find(groupIndices == i);
    
    % Initialize variables
    totalSeconds = 0;
    durations = []; % To store the durations of NREM bouts for calculating the mean

    for j = rows'
        % Access the sec_signal_2 data
        secSignalData = NREM_mice_data_hours{j, 5};
        
        % Calculate the duration if secSignalData is not empty
        if ~isempty(secSignalData)
            duration = max(secSignalData) - min(secSignalData);
            totalSeconds = totalSeconds + duration;
            durations = [durations; duration]; % Store the duration for later calculation
        end
    end
    
    % Calculate the percentage of an hour and the mean duration
    percentOfHour = (totalSeconds / 3600) * 100;
    meanDuration = mean(durations); % Mean duration of NREM bouts

    % Split the unique combinations to get mouse ID and hour
    mouseHourSplit = split(uniqueCombinations(i), '_');
    mouseID = str2double(mouseHourSplit(1));
    mouseID = int64(mouseID);
    hour = str2double(mouseHourSplit(2));
    hour = int32(hour);

    % Append to the output array
    % Including the count of NREM bouts (length of rows for this combination) and mean duration
    percent_NREM = [percent_NREM; {mouseID, hour-7, percentOfHour, length(rows), meanDuration}];
end

% Convert to table with additional columns for NREM bout count and mean duration
percent_NREM = cell2table(percent_NREM, 'VariableNames', {'MouseID', 'Zeitgeber Time', 'PercentNREMinclMA', 'NREM_bout_n', 'NREM_bout_duration'});

%% Plot %NREM, NREM bout n, and NREM bout duration

plotNREMDataWithShading(percent_NREM, 'Percent NREM per Hour', 'PercentNREMinclMA', '% NREM', true);
plotNREMDataWithShading(percent_NREM, 'Mean NREM Bout Count per Hour', 'NREM_bout_n', 'Mean Bout Count', false);
plotNREMDataWithShading(percent_NREM, 'Mean NREM Bout Duration per Hour', 'NREM_bout_duration', 'Mean Bout Duration (sec)', false);

plotIndividualAnimalData(percent_NREM, 'Percent NREM per Hour', 'PercentNREMinclMA', '% NREM', true);
plotIndividualAnimalData(percent_NREM, 'NREM Bout Count per Hour', 'NREM_bout_n', 'Bout Count', false);
plotIndividualAnimalData(percent_NREM, 'NREM Bout Duration per Hour', 'NREM_bout_duration', 'Bout Duration (sec)', false);

%% Graveyard





%% PSD plots (One line across animals)
PSD_NE_table = [];
% Assuming the second column might not be uniformly numeric
hourColumn = updated_mice_data_hours(:,2);

% If hourColumn is a cell array, ensure it's numeric
if iscell(hourColumn)
    hourColumn = cell2mat(hourColumn);
end

uniqueHours = unique(hourColumn);

% Initialize a map or container to hold the signal_fs for each hour
signal_fs_map = containers.Map('KeyType', 'double', 'ValueType', 'any');

for idx = 1:length(uniqueHours)
    uHour = uniqueHours(idx); % Working with numeric value directly

    % Find all entries for this hour. Since updated_mice_data_hours(:,2) is a cell,
    % and uHour is numeric, we need to convert each cell to numeric temporarily for comparison.
    isCurrentHour = cellfun(@(x) isequal(x, uHour), updated_mice_data_hours(:,2));
    hourEntriesIdx = find(isCurrentHour); % Indices of entries for the current hour
    hourEntries = updated_mice_data_hours(hourEntriesIdx,:);

    if isempty(hourEntries)
        continue; % Skip if no entries for this hour
    end

    % Sorting by mouse number requires ensuring mouse numbers are numeric or handled as strings consistently
    % This example proceeds under the assumption that sorting is not directly impacted by numeric vs. string,
    % but adjust accordingly based on your specific needs and data structure.

    % Extract the first mouse number for this hour
    % (Here, you may need to adjust based on how mouse numbers are stored and used in your dataset)
    firstMouseNumber = hourEntries{1, 1}; % Assuming first entry has the mouse number you need

    % Construct the variable name for signal_fs based on the mouse number
    signal_fs_varName = sprintf('signal_fs_%d', firstMouseNumber);

    % Extract signal_fs for this mouse
    if isKey(signal_fs_map, uHour)
        fs = signal_fs_map(uHour); % Use existing value if already determined
    else
        % Extract from the workspace if not already determined
        fs = evalin('base', signal_fs_varName); 
        signal_fs_map(uHour) = fs; % Store for future reference
    end
    
    % Prepare to collect plot data
    plotData = struct();
    
    % Prepare the PSD_NE_table entries for this hour
    PSD_NE_table_entries = [];

    accumulatedData = struct();
    
    PXX = [];
    PXXlog = [];
    PXX_pk_f = [];
    PXX_pk = [];
    
    for i = 1:size(hourEntries, 1)
        mouseNumber = hourEntries(i, 1);
        sleepStage = hourEntries(i, 3);
        mouseNumber_value = hourEntries{i, 1}; % Assuming this is a numeric value
        sleepStage_value = hourEntries{i, 3}; % Assuming this is also a numeric value

        if iscell(sleepStage)
            sleepStage = sleepStage{1}; % Extracting string from cell
        end
        validSleepStage = matlab.lang.makeValidName(sleepStage);

        % Extract variable names and values from hourEntries
        % Corrected by breaking into two steps to avoid direct chaining
        secSignalCell = hourEntries(i, 4); % This will give you a cell
        deltaSignalCell = hourEntries(i, 5); % Another cell
        deltaSignalValuesCell = hourEntries(i, 7); % Cell containing the actual signal data
    
        % Now extract the actual string or data from the cell
        secSignalName = secSignalCell{1};
        deltaSignalName = deltaSignalCell{1};
        deltaSignalValues = deltaSignalValuesCell{1};
        
        % Assuming fs is common or retrieved per animal/hour. If variable, adjust accordingly.
        
        % Process signal (e.g., detrend, calculate PSD)
        % Extract the actual signal values
        signal_trace = deltaSignalValues; % Your delta signal for the current segment
        
        % Assuming min_period_dur, max_freq, and sample_pr_sec are defined as before
        max_freq = 0.1; % Maximum frequency for PSD
        sample_pr_sec = 0.0005; % Frequency resolution for PSD
        
        % Detrend and center the signal around 0
        [p, s, mu] = polyfit((1:numel(signal_trace))', signal_trace, 5);
        f_y = polyval(p, (1:numel(signal_trace))', [], mu);
        detrended_signal = signal_trace - f_y'; % Detrended data
        
        % Calculate Power Spectral Density (PSD)
        [pxx, f] = pwelch(detrended_signal, [], [], 0:sample_pr_sec:max_freq, fs);
        
        logpxx = 10*log10(pxx);
        FX{i} = f;
        [pxx_pk_psd, max_idx] = max(pxx);
        PXX_pk = [PXX_pk pxx_pk_psd];
        pxx_pk_f = f(max_idx);
        PXX_pk_f = [PXX_pk_f pxx_pk_f];
        %PXXlog = [PXXlog logpxx'];
        PXX = [PXX pxx'];
        
        figure
        set(gcf, 'Position',  [100, 300, 1500, 250])
        titleStr = sprintf('Sleep Stage: %s, Mouse: %d', sleepStage_value, mouseNumber_value);
        sgtitle(titleStr); 
        a = subplot(1,2,1);
            %a.Position = [0.1300 0.1100 0.6200 0.8150];
            plot(deltaSignalName,signal_trace);
            hold on
            plot(deltaSignalName,detrended_signal);
            legend({'raw','fitted'})
            hold off
        b = subplot(1,2,2);
            %b.Position = [0.8140 0.1100 0.1533 0.8150];
            plot(f,pxx);
        % This [pxx, f] can now be used as part of your plot data aggregation and PSD_NE_table entry calculation

        % Accumulate pxx arrays and their lengths for later averaging
        if ~isfield(accumulatedData, validSleepStage)
            accumulatedData.(validSleepStage).pxx = {};
            accumulatedData.(validSleepStage).lengths = [];
        end
        accumulatedData.(validSleepStage).pxx{end+1} = pxx;
        accumulatedData.(validSleepStage).lengths(end+1) = length(deltaSignalValues);
        
        % Collect data for PSD_NE_table
        % Assume you have a function or method to calculate the metrics for each segment
        PSD_NE_table_entries = [PSD_NE_table_entries; calculateMetricsForPSD(f, pxx, mouseNumber, uHour, validSleepStage )];
    end
    
    averagedPxx = struct();
    for stage = fieldnames(accumulatedData).'
        s = stage{1};
        allPxx = accumulatedData.(s).pxx;
        weights = accumulatedData.(s).lengths / sum(accumulatedData.(s).lengths);

        % Initialize averaged pxx array
        averagedPxx.(s) = zeros(size(allPxx{1}));
        
        % Calculate weighted average
        for i = 1:length(allPxx)
            averagedPxx.(s) = averagedPxx.(s) + allPxx{i} * weights(i);
        end
    end

    % Update PSD_NE_table for this hour
    % Assuming PSD_NE_table is initialized outside this loop
    PSD_NE_table = [PSD_NE_table; PSD_NE_table_entries];
end
%% Get full plot

PSD_NE_table = [];
% Assuming the second column might not be uniformly numeric
hourColumn = updated_mice_data_hours(:,2);

% If hourColumn is a cell array, ensure it's numeric
if iscell(hourColumn)
    hourColumn = cell2mat(hourColumn);
end

uniqueHours = unique(hourColumn);

% Initialize a map or container to hold the signal_fs for each hour
signal_fs_map = containers.Map('KeyType', 'double', 'ValueType', 'any');

for idx = 1:length(uniqueHours)
    uHour = uniqueHours(idx); % Working with numeric value directly

    % Find all entries for this hour. Since updated_mice_data_hours(:,2) is a cell,
    % and uHour is numeric, we need to convert each cell to numeric temporarily for comparison.
    isCurrentHour = cellfun(@(x) isequal(x, uHour), updated_mice_data_hours(:,2));
    hourEntriesIdx = find(isCurrentHour); % Indices of entries for the current hour
    hourEntries = updated_mice_data_hours(hourEntriesIdx,:);

    if isempty(hourEntries)
        continue; % Skip if no entries for this hour
    end

    % Sorting by mouse number requires ensuring mouse numbers are numeric or handled as strings consistently
    % This example proceeds under the assumption that sorting is not directly impacted by numeric vs. string,
    % but adjust accordingly based on your specific needs and data structure.

    % Extract the first mouse number for this hour
    % (Here, you may need to adjust based on how mouse numbers are stored and used in your dataset)
    firstMouseNumber = hourEntries{1, 1}; % Assuming first entry has the mouse number you need

    % Construct the variable name for signal_fs based on the mouse number
    signal_fs_varName = sprintf('signal_fs_%d', firstMouseNumber);

    % Extract signal_fs for this mouse
    if isKey(signal_fs_map, uHour)
        fs = signal_fs_map(uHour); % Use existing value if already determined
    else
        % Extract from the workspace if not already determined
        fs = evalin('base', signal_fs_varName); 
        signal_fs_map(uHour) = fs; % Store for future reference
    end
    
    % Prepare to collect plot data
    plotData = struct();
    
    % Prepare the PSD_NE_table entries for this hour
    PSD_NE_table_entries = [];

    accumulatedData = struct();

    figure; % New figure for each hour
    hold on;
    
    for i = 1:size(hourEntries, 1)
        mouseNumber = hourEntries(i, 1);
        sleepStage = hourEntries(i, 3);
        mouseNumber_value = hourEntries{i, 1}; % Assuming this is a numeric value
        sleepStage_value = hourEntries{i, 3}; % Assuming this is also a numeric value

        if iscell(sleepStage)
            sleepStage = sleepStage{1}; % Extracting string from cell
        end
        validSleepStage = matlab.lang.makeValidName(sleepStage);

        % Extract variable names and values from hourEntries
        % Corrected by breaking into two steps to avoid direct chaining
        secSignalCell = hourEntries(i, 4); % This will give you a cell
        deltaSignalCell = hourEntries(i, 5); % Another cell
        deltaSignalValuesCell = hourEntries(i, 7); % Cell containing the actual signal data
    
        % Now extract the actual string or data from the cell
        secSignalName = secSignalCell{1};
        deltaSignalName = deltaSignalCell{1};
        deltaSignalValues = deltaSignalValuesCell{1};
        
        % Assuming fs is common or retrieved per animal/hour. If variable, adjust accordingly.
        
        % Process signal (e.g., detrend, calculate PSD)
        % Extract the actual signal values
        signal_trace = deltaSignalValues; % Your delta signal for the current segment
        
        % Assuming min_period_dur, max_freq, and sample_pr_sec are defined as before
        max_freq = 0.1; % Maximum frequency for PSD
        sample_pr_sec = 0.0005; % Frequency resolution for PSD
        
        % Detrend and center the signal around 0
        [p, s, mu] = polyfit((1:numel(signal_trace))', signal_trace, 5);
        f_y = polyval(p, (1:numel(signal_trace))', [], mu);
        detrended_signal = signal_trace - f_y'; % Detrended data
        
        % Calculate Power Spectral Density (PSD)
        [pxx, f] = pwelch(detrended_signal, [], [], 0:sample_pr_sec:max_freq, fs);

        % Accumulate pxx arrays and their lengths for later averaging
        if ~isfield(accumulatedData, validSleepStage)
            accumulatedData.(validSleepStage).pxx = {};
            accumulatedData.(validSleepStage).lengths = [];
        end
        accumulatedData.(validSleepStage).pxx{end+1} = pxx;
        accumulatedData.(validSleepStage).lengths(end+1) = length(deltaSignalValues);
        
        % Collect data for PSD_NE_table
        % Assume you have a function or method to calculate the metrics for each segment
        PSD_NE_table_entries = [PSD_NE_table_entries; calculateMetricsForPSD(f, pxx, mouseNumber, uHour, validSleepStage )];
    end
    
    averagedPxx = struct();
    for stage = fieldnames(accumulatedData).'
        s = stage{1};
        allPxx = accumulatedData.(s).pxx;
        weights = accumulatedData.(s).lengths / sum(accumulatedData.(s).lengths);

        % Initialize averaged pxx array
        averagedPxx.(s) = zeros(size(allPxx{1}));
        
        % Calculate weighted average
        for i = 1:length(allPxx)
            averagedPxx.(s) = averagedPxx.(s) + allPxx{i} * weights(i);
        end
    end

    % Define a mapping of sleep stages to colors
    colors = {'blue', 'red', 'green', 'black'}; % Color for each sleep phase
    sleepStages = {'NREMinclMA', 'NREMexclMA', 'REM', 'Wake'};
    colorMap = containers.Map(sleepStages, colors);

        % Convert all mouse numbers to strings first
    mouseNumbersStr = cellfun(@(x) num2str(x), hourEntries(:,1), 'UniformOutput', false);

    % Now you can safely use `unique` on the converted strings
    uniqueMouseNumbers = unique(mouseNumbersStr);

    % Construct the title string
    titleStr = sprintf('Power Spectral Density from %d - %d. Averaged across Mouse %s', uHour, uHour+1, strjoin(uniqueMouseNumbers, ', '));

    % Plot for this hour
    for stage = fieldnames(averagedPxx).'
        s = stage{1};
        validSleepStage = matlab.lang.makeValidName(s); % Ensure it matches your colorMap keys
        if isKey(colorMap, s) % Check if the sleep stage has a defined color
            plotColor = colorMap(s);
        else
            plotColor = 'black'; % Default color if not specified
        end
        plot(f, averagedPxx.(s), 'DisplayName', s, 'Color', plotColor);
    end
    title(titleStr);
    xlabel('Frequency (Hz)');
    ylabel(' Weighted Power');
    legend('show');
    grid on;
    hold off;
    set(gcf,'color','white')

    
    % Update PSD_NE_table for this hour
    % Assuming PSD_NE_table is initialized outside this loop
    PSD_NE_table = [PSD_NE_table; PSD_NE_table_entries];
end

%% PSD plots (one line per animal)
PSD_NE_table = [];
% Assuming the second column might not be uniformly numeric
hourColumn = updated_mice_data_hours(:,2);

% If hourColumn is a cell array, ensure it's numeric
if iscell(hourColumn)
    hourColumn = cell2mat(hourColumn);
end

uniqueHours = unique(hourColumn);

% Initialize a map or container to hold the signal_fs for each hour
signal_fs_map = containers.Map('KeyType', 'double', 'ValueType', 'any');

for idx = 1:length(uniqueHours)
    uHour = uniqueHours(idx); % Working with numeric value directly

    % Find all entries for this hour. Since updated_mice_data_hours(:,2) is a cell,
    % and uHour is numeric, we need to convert each cell to numeric temporarily for comparison.
    isCurrentHour = cellfun(@(x) isequal(x, uHour), updated_mice_data_hours(:,2));
    hourEntriesIdx = find(isCurrentHour); % Indices of entries for the current hour
    hourEntries = updated_mice_data_hours(hourEntriesIdx,:);

    if isempty(hourEntries)
        continue; % Skip if no entries for this hour
    end

    % Sorting by mouse number requires ensuring mouse numbers are numeric or handled as strings consistently
    % This example proceeds under the assumption that sorting is not directly impacted by numeric vs. string,
    % but adjust accordingly based on your specific needs and data structure.

    % Extract the first mouse number for this hour
    % (Here, you may need to adjust based on how mouse numbers are stored and used in your dataset)
    firstMouseNumber = hourEntries{1, 1}; % Assuming first entry has the mouse number you need

    % Construct the variable name for signal_fs based on the mouse number
    signal_fs_varName = sprintf('signal_fs_%d', firstMouseNumber);

    % Extract signal_fs for this mouse
    if isKey(signal_fs_map, uHour)
        fs = signal_fs_map(uHour); % Use existing value if already determined
    else
        % Extract from the workspace if not already determined
        fs = evalin('base', signal_fs_varName); 
        signal_fs_map(uHour) = fs; % Store for future reference
    end
    
    % Prepare to collect plot data
    plotData = struct();
    
    % Prepare the PSD_NE_table entries for this hour
    PSD_NE_table_entries = [];
    
    figure; % New figure for each hour
    hold on;
    
    for i = 1:size(hourEntries, 1)
        mouseNumber = hourEntries(i, 1);
        sleepStage = hourEntries(i, 3);

        if iscell(sleepStage)
            sleepStage = sleepStage{1}; % Extracting string from cell
        end
        validSleepStage = matlab.lang.makeValidName(sleepStage);

        % Extract variable names and values from hourEntries
        % Corrected by breaking into two steps to avoid direct chaining
        secSignalCell = hourEntries(i, 4); % This will give you a cell
        deltaSignalCell = hourEntries(i, 5); % Another cell
        deltaSignalValuesCell = hourEntries(i, 7); % Cell containing the actual signal data
    
        % Now extract the actual string or data from the cell
        secSignalName = secSignalCell{1};
        deltaSignalName = deltaSignalCell{1};
        deltaSignalValues = deltaSignalValuesCell{1};
        
        % Assuming fs is common or retrieved per animal/hour. If variable, adjust accordingly.
        
        % Process signal (e.g., detrend, calculate PSD)
        % Extract the actual signal values
        signal_trace = deltaSignalValues; % Your delta signal for the current segment
        
        % Assuming min_period_dur, max_freq, and sample_pr_sec are defined as before
        min_period_dur = 120; % Minimum duration for inclusion in analysis
        max_freq = 0.1; % Maximum frequency for PSD
        sample_pr_sec = 0.0005; % Frequency resolution for PSD
        
        % Detrend and center the signal around 0
        [p, s, mu] = polyfit((1:numel(signal_trace))', signal_trace, 5);
        f_y = polyval(p, (1:numel(signal_trace))', [], mu);
        detrended_signal = signal_trace - f_y'; % Detrended data
        
        % Calculate Power Spectral Density (PSD)
        [pxx, f] = pwelch(detrended_signal, [], [], 0:sample_pr_sec:max_freq, fs);
        
        % This [pxx, f] can now be used as part of your plot data aggregation and PSD_NE_table entry calculation

        % Store or plot the data
        if ~isfield(plotData, validSleepStage )
            plotData.(validSleepStage ) = struct('f', [], 'pxx', []);
        end
        plotData.(validSleepStage ).f = [plotData.(validSleepStage ).f; f]; % Assuming f is the same for all
        plotData.(validSleepStage ).pxx = [plotData.(validSleepStage ).pxx; pxx];
        
        % Collect data for PSD_NE_table
        % Assume you have a function or method to calculate the metrics for each segment
        PSD_NE_table_entries = [PSD_NE_table_entries; calculateMetricsForPSD(f, pxx, mouseNumber, uHour, validSleepStage )];
    end
    
        % Convert all mouse numbers to strings first
    mouseNumbersStr = cellfun(@(x) num2str(x), hourEntries(:,1), 'UniformOutput', false);
    
    % Now you can safely use `unique` on the converted strings
    uniqueMouseNumbers = unique(mouseNumbersStr);
    
    % Construct the title string
    titleStr = sprintf('Hour %d - Animals: %s', uHour, strjoin(uniqueMouseNumbers, ', '));

    % Plot for this hour
    sleepStages = fieldnames(plotData);
    for sIdx = 1:length(sleepStages)
        stage = sleepStages{sIdx};
        plot(plotData.(stage).f, mean(plotData.(stage).pxx, 1), 'DisplayName', stage); % Example mean; adjust as needed
    end
    % Use the constructed title string
    title(titleStr);
    xlabel('Frequency (Hz)');
    ylabel('Power');
    legend('show');
    hold off;
    
    % Update PSD_NE_table for this hour
    % Assuming PSD_NE_table is initialized outside this loop
    PSD_NE_table = [PSD_NE_table; PSD_NE_table_entries];
end

