%PLEASE NOTE
%You need to place the FP file in a folder ending in the 3-digit animal id
%(e.g. 'Mouse_xxx' or 'Mxxx' or simply just the 3-digit animal ID).
%Otherwise the code will not run appropriately

% M399 = preprocess_sleep_data('', '', 'BuBo', 'V_Bo', 'Pu2_', (100:7000), 'save_path', '');
% M392 = preprocess_sleep_data('', '', 'BuBo', 'V_Bo', 'Pu2_', (100:7000), 'save_path', ''); 
% M403 = preprocess_sleep_data('', '', 'BuBo', 'V_Bo', 'Pu2_', (100:7000), 'save_path', '');
% M412 = preprocess_sleep_data('', '', 'BuBo', 'V_Bo', 'Pu2_', (100:7000), 'save_path', '');
% M414 = preprocess_sleep_data('', '', 'BuBo', 'V_Bo', 'Pu2_', (100:7000), 'save_path', '');
% M416 = preprocess_sleep_data('', '', 'BuBo', 'V_Bo', 'Pu2_', (100:7000), 'save_path', '');
% M418 = preprocess_sleep_data('', '', 'BuBo', 'V_Bo', 'Pu2_', (100:7000), 'save_path', '');
% M486 = preprocess_sleep_data('', '', 'BuBo', 'V_Bo', 'PtC1', (100:7000), 'save_path', '');
% M408 = preprocess_sleep_data('', '', 'BuBo', 'V_Bo', 'Pu2_', (100:7000), 'save_path', '');
% M420 = preprocess_sleep_data('', '', 'BuBo', 'V_Bo', 'Pu2_', (100:7000), 'save_path', '');

%timecorrctions
% recording_ID	time_correction_in_s
% 387_Arch	2
% 399_Arch	2
% 392_Arch	4
% 403_Arch	3
% 412_Arch	4
% 414_Arch	3
% 416_Arch	4
% 418_Arch	5
% 486_Arch	2
% 408_YFP	    1
% 420_YFP	    0
% 468_YFP	    3
% 477_YFP	    1
% 484_YFP	    1

%build-up
name = {'file_destination_FP' 'file_destination_EEG' 'channel_name_blue_1' 'channel_name_violet_1' 'channel_name_red_1' 'channel_name_blue_2' 'channel_name_violet_2' 'channel_name_red_2' 'EEG channel name' 'EEG channel name' 'EMG channel name 1' 'synchronization pulse name FP rig' 'synchronization pulse name EEG rig'  'time period for fitting' };
%For viewpoint files, load in .exp file in the 2nd place
%Animal muner is now in the 3rd place and time correction in the 4th

M387 = {'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\387_arch' 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\387_arch\387_Arch_NOR\387_Arch_NOR_2021-03-12_11-52-27-496.exp' '387' '2' '' 'BuBo', 'V_Bo' '' '' '' '' 'Pu2_' 'Pu2_'  (1:15000) 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\387_arch\387_Arch_NOR\387_NOR_sleepscore.xlsx'};
M399 = {'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\399_arch' 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\399_arch\399_Arch_NOR\399_Arch_NOR_2021-03-12_14-46-42-245.exp' '399' '2' '' 'BuBo', 'V_Bo' '' '' '' '' 'Pu2_' 'Pu2_'  (1:15000) 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\399_arch\399_Arch_NOR\399_NOR_sleepscore.xlsx'};
M392 = {'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\392_arch' 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\392_arch\392_Arch_NOR\392_Arch_NOR_2021-03-10_10-31-55-535.exp' '392' '4' '' 'BuBo', 'V_Bo' '' '' '' '' 'Pu2_' 'Pu2_'  (1:15000) 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\387_arch\387_Arch_NOR\387_NOR_sleepscore.xlsx'};
M403 = {'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\403_arch' 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\403_arch\403_Arch_NOR\403_Arch_NOR_2021-03-12_08-56-13-288.exp' '403' '3' '' 'BuBo', 'V_Bo' '' '' '' '' 'Pu2_' 'Pu2_'  (1:15000) 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\387_arch\387_Arch_NOR\387_NOR_sleepscore.xlsx'};
M412 = {'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\412_arch' 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\412_arch\412_Arch_NOR\412_Arch_NOR_2021-03-08_13-27-00-781.exp' '412' '4' '' 'BuBo', 'V_Bo' '' '' '' '' 'Pu2_' 'Pu2_'  (1:15000) 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\387_arch\387_Arch_NOR\387_NOR_sleepscore.xlsx'};
M414 = {'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\414_arch' 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\414_arch\414_Arch_NOR\414_Arch_NOR_2021-03-10_13-19-57-296.exp' '414' '3' '' 'BuBo', 'V_Bo' '' '' '' '' 'Pu2_' 'Pu2_'  (1:15000) 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\387_arch\387_Arch_NOR\387_NOR_sleepscore.xlsx'};
M416 = {'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\416_arch' 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\416_arch\416_Arch_NOR\416_Arch_NOR_2021-03-09_10-14-39-452.exp' '416' '4' '' 'BuBo', 'V_Bo' '' '' '' '' 'Pu2_' 'Pu2_'  (1:15000) 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\399_arch\399_Arch_NOR\399_NOR_sleepscore.xlsx'};
M418 = {'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\418_arch' 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\418_arch\418_Arch_NOR\418_Arch_NOR_2021-03-09_13-02-50-098.exp' '418' '5' '' 'BuBo', 'V_Bo' '' '' '' '' 'Pu2_' 'Pu2_'  (1:15000) 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\399_arch\399_Arch_NOR\399_NOR_sleepscore.xlsx'};
M486 = {'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\486_arch' 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\486_arch\486_Arch_NOR\NOR_486_Arch_2021-07-07_12-53-47-510.exp' '486' '2' '' 'BuBo', 'V_Bo' '' '' '' '' 'Pu2_' 'PtC1'  (1:15000) 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\399_arch\399_Arch_NOR\399_NOR_sleepscore.xlsx'};
M420 = {'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\420_YFP' 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\420_YFP\420_YFP_NOR\420_YFP_NOR_2021-03-09_15-53-26-919.exp' '420' '0' '' 'BuBo', 'V_Bo' '' '' '' '' 'Pu2_' 'Pu2_'  (1:15000) 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\399_arch\399_Arch_NOR\399_NOR_sleepscore.xlsx'};

M117 = {'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\practice data\mouse_117' 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\practice data\mouse_117' '117' '' '' 'x465C' 'x405C' 'red' 'EEGw' 1 'EMG1' 'PtC0' 'PtC0' (1:20000) 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\practice data\mouse_117\117_sleep\6h FP and EEG\Score_117.xlsx'};
M124 = {'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\practice data\mouse_124' 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\practice data\mouse_117' '124' '' '' 'Dv4C' 'Dv5C' 'red' 'EEGw' 2 'EMG2' 'PtC0' 'PtC0' (1:20000) 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\practice data\mouse_124\124_sleep\6h FP and EEG\Score_124.xlsx'};
M168 = {'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\mouse_168' 'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\mouse_168' '168' '' '' 'x465A' 'x405A' 'red' 'EEGw' 1 'EMG1' '' '' (1:18000) 'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\mouse_168\168_sleep_data.xlsx'};
M147 = {'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\147_149_5_51_am_sleep_rec\mouse_147' 'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\147_149_5_51_am_sleep_rec\mouse_147' '147' '' '' 'x465A' 'x405A' 'red' 'EEGw' 1 'EMG1' '' '' (1:18000) 'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\147_149_5_51_am_sleep_rec\mouse_147\147_sleep_data.xlsx'};
M149 = {'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\147_149_5_51_am_sleep_rec\mouse_149' 'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\147_149_5_51_am_sleep_rec\mouse_149' '149' '' '' 'x465C' 'x405C' 'red' 'EEGw' 2 'EMG2' '' '' (1:18000) 'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\147_149_5_51_am_sleep_rec\mouse_149\149_sleep_data.xlsx'};

mice_TTL = {M124, M117};
mice = {M168, M147, M149, M117, M124, M387, M392, M403, M412, M414, M416, M418, M486, M420};
mice_without_TTL = {M168, M147, M149};
viewpoint_mice = {'M387', 'M399', 'M392', 'M403', 'M412', 'M414', 'M416', 'M418', 'M486', 'M420'};
v = {M387, M392};
synapse_mice = {M168, M147, M149, M117, M124};

% Create a matrix of mice pairs where the first column is the mouse without EEG data
% and the second column is the mouse with EEG data
mice_pairs = {'M124', 'M117', 'M149', 'M147'}; % Example given with M124 and M117

% Reshape mice_pairs into a two-column format
num_pairs = numel(mice_pairs) / 2;
mice_pairs = reshape(mice_pairs, 2, num_pairs).';

mice_without_TTL_IDs = {};

%Extract names of the mice withoutTTL for later use
for idx = 1:length(mice_without_TTL)
    m = mice_without_TTL{idx}; % Assuming mouse is a cell array with relevant data
    ID = sprintf('M%s', m{1}(end-2:end)); % Extract the ID as intended
    mice_without_TTL_IDs{end+1} = ID; % Correctly append ID to the cell array
end


%% Load FP and EEG data for all mice

for idx = 1:length(v)
    mouse = v{idx};
    % Since mouse{3} contains the ID for all mice, directly use it to create the mouseID
    mouseID = sprintf('M%s', mouse{3}); % mouse{3} is directly used, making mouseID a char array
    
    % Debugging print to verify mouseID
    disp(mouseID);
    
    % Define the FP and EEG variable names based on the mouse ID
    data_FPrig_varName = sprintf('data_FPrig_%s', mouse{3});
    
    % Load FP rig data for all mice
    eval([data_FPrig_varName, ' = TDTbin2mat(mouse{1});']);

    % Skip loading EEG data for viewpoint mice by comparing the string directly
    if ~ismember(mouseID, viewpoint_mice) && ~ismember(mouseID, mice_pairs(:, 1))
        % Note: Since mouseID is a char, we use it directly without braces
        data_EEGrig_varName = sprintf('data_EEGrig_%s', mouse{3});
        eval([data_EEGrig_varName, ' = TDTbin2mat(mouse{2});']); % Load EEG rig data if conditions are met
    end
    % Viewpoint EEG is handled in a separate function later
end
%% Preprocess FP, EEG and EMG
%For each mouse, check if they are part of the group with out a TTL pulse
%Either way, check if they have a partner ID with the EEG data, if yes: use
%the EEG rig from that animal and extract channel 2. If not, use it's own
%ID for the EEG rig.

for idx = 1:length(v)
    mouse = v{idx};
    mouseID = sprintf('M%s', mouse{3}); % Extract the ID
    disp(mouseID)

    data_FPrig_input = eval(sprintf('data_FPrig_%s', mouse{3}));
        % Check if the current mouse identifier is in the mice_without_TTL list
    if ismember(mouseID, mice_without_TTL_IDs)
                % Determine if this mouse needs to pull EEG/EMG data from a partner
        partnerIdx = find(strcmp(mice_pairs(:,1), mouseID));
        if isempty(partnerIdx)
            % This mouse has its own EEG data
            partnerData = eval(sprintf('data_EEGrig_%s', mouse{3}));
        else
            % This mouse needs to use its partner's EEG data
            partnerID = mice_pairs{partnerIdx, 2};
            % Remove any letters from partnerID, keeping only digits
            partnerID_numeric = regexprep(partnerID, '\D', '');
            disp(partnerID_numeric)
            % Now use the modified partnerID_numeric in eval
            partnerData = eval(sprintf('data_EEGrig_%s', partnerID_numeric));
        end
        % Call processSignals_without_TTL function for mice without TTL
        [delta465_filt_2, sec_signal_2, signal_fs, EEG, EMG, sec_signal_EEG, EEG_fs] = processSignals_without_TTL(mouse, data_FPrig_input, partnerData);

    elseif ismember(mouseID, viewpoint_mice)
        %Process viewpoint data with TTL in it's own way
        [delta465_filt_2, sec_signal_2, signal_fs, EEG, EMG, sec_signal_EEG, EEG_fs, onset_FP_EEG, EEG_rig] = processSignals_Viewpoint_with_TTL(mouse, data_FPrig_input);
        eval(sprintf('data_EEGrig_%s = EEG_rig;', mouse{3}));
        eval(sprintf('onset_FP_EEG_%s = onset_FP_EEG;', mouse{3}));
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
    eval(sprintf('delta465_filt_2_%s = delta465_filt_2;', mouse{3}));
    eval(sprintf('sec_signal_2_%s = sec_signal_2;', mouse{3}));
    eval(sprintf('signal_fs_%s = signal_fs;', mouse{3}));
    eval(sprintf('EEG_%s = EEG;', mouse{3}));
    eval(sprintf('EMG_%s = EMG;', mouse{3}));
    eval(sprintf('sec_signal_EEG_%s = sec_signal_EEG;', mouse{3}));
    eval(sprintf('EEG_fs_%s = EEG_fs;', mouse{3}));
    eval(sprintf('onset_FP_EEG_%s = onset_FP_EEG;', mouse{3}));
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
delta465_filt_2_117_smooth = filtfilt(MeanFilter,1,delta465_filt_2_117);
delta465_filt_2_124_smooth = filtfilt(MeanFilter,1,delta465_filt_2_124);
delta465_filt_2_168_smooth = filtfilt(MeanFilter,1,delta465_filt_2_168);
delta465_filt_2_147_smooth = filtfilt(MeanFilter,1,delta465_filt_2_147);
delta465_filt_2_149_smooth = filtfilt(MeanFilter,1,delta465_filt_2_149);
delta465_filt_2_387_smooth = filtfilt(MeanFilter,1,delta465_filt_2_387);
delta465_filt_2_392_smooth = filtfilt(MeanFilter,1,delta465_filt_2_392);

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

ds_delta465_filt_2_387 = downsample(delta465_filt_2_387, ds_factor_FP);
ds_sec_signal_2_387 = downsample(sec_signal_2_387, ds_factor_FP); % for plotting

ds_delta465_filt_2_392 = downsample(delta465_filt_2_392, ds_factor_FP);
ds_sec_signal_2_392 = downsample(sec_signal_2_392, ds_factor_FP); % for plotting

ds_delta465_filt_2_117_smooth = downsample(delta465_filt_2_117_smooth, ds_factor_FP);
ds_delta465_filt_2_124_smooth = downsample(delta465_filt_2_124_smooth, ds_factor_FP);
ds_delta465_filt_2_168_smooth = downsample(delta465_filt_2_168_smooth, ds_factor_FP);
ds_delta465_filt_2_147_smooth = downsample(delta465_filt_2_147_smooth, ds_factor_FP);
ds_delta465_filt_2_149_smooth = downsample(delta465_filt_2_149_smooth, ds_factor_FP);
ds_delta465_filt_2_387_smooth = downsample(delta465_filt_2_387_smooth, ds_factor_FP);
ds_delta465_filt_2_392_smooth = downsample(delta465_filt_2_392_smooth, ds_factor_FP);

% Design a bandpass filter
% bpFilt = designfilt('bandpassfir', 'FilterOrder', 100, ...
%     'CutoffFrequency1', 20, 'CutoffFrequency2', 300, ...
%     'SampleRate', EEG_fs_117);
% 
% % Apply the bandpass filter to your EMG data
% filtered_EMG_117 = filtfilt(bpFilt, EMG_117);
% filtered_EMG_124 = filtfilt(bpFilt, EMG_124);
% filtered_EMG_168 = filtfilt(bpFilt, EMG_168);
% filtered_EMG_147 = filtfilt(bpFilt, EMG_147);
% filtered_EMG_149 = filtfilt(bpFilt, EMG_149);


%% Run sleep analysis
%function will give you the variables needed for plotting, further sleep
%periods, NREM without MA and 
[wake_woMA_binary_vector_117, sws_binary_vector_117, REM_binary_vector_117, MA_binary_vector_117, NREMinclMA_periods_117, NREMexclMA_periods_117, wake_periods_117, REM_periods_117, MA_periods_117, SWS_before_MA_filtered_117, SWS_before_wake_filtered_117, SWS_before_REM_filtered_117, REM_before_arousal_filtered_117] = SleepProcess_TTL(M117, sec_signal_EEG_117, EEG_fs_117, onset_FP_EEG_117, 20, 20, 15);
[wake_woMA_binary_vector_124, sws_binary_vector_124, REM_binary_vector_124, MA_binary_vector_124, NREMinclMA_periods_124, NREMexclMA_periods_124, wake_periods_124, REM_periods_124, MA_periods_124, SWS_before_MA_filtered_124, SWS_before_wake_filtered_124, SWS_before_REM_filtered_124, REM_before_arousal_filtered_124] = SleepProcess_TTL(M124, sec_signal_EEG_124, EEG_fs_124, onset_FP_EEG_124, 20, 20, 15);
[wake_woMA_binary_vector_168, sws_binary_vector_168, REM_binary_vector_168, MA_binary_vector_168, NREMinclMA_periods_168, NREMexclMA_periods_168, wake_periods_168, REM_periods_168, MA_periods_168, SWS_before_MA_filtered_168, SWS_before_wake_filtered_168, SWS_before_REM_filtered_168, REM_before_arousal_filtered_168] = SleepProcess_without_TTL(M168, sec_signal_EEG_168, 20, 20, 15);
[wake_woMA_binary_vector_147, sws_binary_vector_147, REM_binary_vector_147, MA_binary_vector_147, NREMinclMA_periods_147, NREMexclMA_periods_147, wake_periods_147, REM_periods_147, MA_periods_147, SWS_before_MA_filtered_147, SWS_before_wake_filtered_147, SWS_before_REM_filtered_147, REM_before_arousal_filtered_147] = SleepProcess_without_TTL(M147, sec_signal_EEG_147, 20, 20, 15);
[wake_woMA_binary_vector_149, sws_binary_vector_149, REM_binary_vector_149, MA_binary_vector_149, NREMinclMA_periods_149, NREMexclMA_periods_149, wake_periods_149, REM_periods_149, MA_periods_149, SWS_before_MA_filtered_149, SWS_before_wake_filtered_149, SWS_before_REM_filtered_149, REM_before_arousal_filtered_149] = SleepProcess_without_TTL(M149, sec_signal_EEG_149, 20, 20, 15);
[wake_woMA_binary_vector_387, sws_binary_vector_387, REM_binary_vector_387, MA_binary_vector_387, NREMinclMA_periods_387, NREMexclMA_periods_387, wake_periods_387, REM_periods_387, MA_periods_387, SWS_before_MA_filtered_387, SWS_before_wake_filtered_387, SWS_before_REM_filtered_387, REM_before_arousal_filtered_387] = SleepProcess_viewpoint(M387, sec_signal_EEG_387, onset_FP_EEG_387, EEG_fs_387, 20, 20, 15);
[wake_woMA_binary_vector_392, sws_binary_vector_392, REM_binary_vector_392, MA_binary_vector_392, NREMinclMA_periods_392, NREMexclMA_periods_392, wake_periods_392, REM_periods_392, MA_periods_392, SWS_before_MA_filtered_392, SWS_before_wake_filtered_392, SWS_before_REM_filtered_392, REM_before_arousal_filtered_392] = SleepProcess_viewpoint(M392, sec_signal_EEG_392, onset_FP_EEG_392, EEG_fs_392, 20, 20, 15);

%% QC - plot sleep
% Assuming 'mice' is a list of mouse identifiers like {'168', '149', ...}
for idx = 1:length(v)
    mouse = v{idx};
    uniqueId = mouse{3}; % Extract mouse ID as a string

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
    uniqueIdStr = string(uniqueId);

    % Plot for the current mouse
    figure;
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
%% Get RR intervals
[RR_387, RR_time_387, RR_fs_387] = GetRRIntervals(M387, -EMG_387, sec_signal_EEG_387, EEG_fs_387);
[RR_124, RR_time_124, RR_fs_124] = GetRRIntervals(M124, EMG_124, sec_signal_EEG_124, EEG_fs_124);
[RR_399, RR_time_399, RR_fs_399] = GetRRIntervals(M399, -EMG_399, sec_signal_EEG_399, EEG_fs_399);


%% Get HRB
[HRB, HRB_time] = findHRB(RR_time_124, RR_124);

figure;
plot_sleep(new_time_vector, resampled_RR_pchip, sleepscore_time, wake_woMA_binary_vector_124, sws_binary_vector_124, REM_binary_vector_124, MA_binary_vector_124);
hold on;
scatter(HRB_time, HRB, 'b', 'filled'); % Plotting HRB
hold off;
xlabel('Time (s)');
ylabel('RR intervals');
title('HRV p-chip (M124)');
grid on;
%% Power analysis on EEG
power_bands = {[0.5, 1], [1, 4], [4, 8], [8, 15], [15, 30]}; % define SO, delta, theta, sigma, and beta, respectively
frw = 0:0.2:30;
window_in_sec = 1; % sec. 1 for 30 sec

%[mean_spectrogram_117, time_spectrogram_zero_117, F_117, band_powers_117, EEG_bands_fs_117] = PowerAnalysisEEG(EEG_117, EEG_fs_117, frw, window_in_sec, power_bands);
[mean_spectrogram_124, time_spectrogram_zero_124, F_124, band_powers_124, EEG_bands_fs_124] = PowerAnalysisEEG(EEG_124, EEG_fs_124, frw, window_in_sec, power_bands);
%% Find NE troughs in sleep transitions and NREM
SWS_before_MA_pklocs_117 = findPeriodsBeforeTransitionMA(SWS_before_MA_filtered_117, signal_fs_117, delta465_filt_2_117_smooth, sec_signal_2_117, MA_periods_117, 15, 15);
SWS_before_MA_pklocs_124 = findPeriodsBeforeTransitionMA(SWS_before_MA_filtered_124, signal_fs_124, delta465_filt_2_124_smooth, sec_signal_2_124, MA_periods_124, 15, 15);

NREMexclMA_periods_pklocs_117 = find_NE_troughs(NREMexclMA_periods_117, signal_fs_117, delta465_filt_2_117_smooth, sec_signal_2_117, 3); % Change SD multiplyer to 1 for more selective troughs
NREMexclMA_periods_pklocs_124 = find_NE_troughs(NREMexclMA_periods_124, signal_fs_124, delta465_filt_2_124_smooth, sec_signal_2_124, 3); % Change SD multiplyer to 1 for more selective troughs

SWS_before_wake_pklocs_124 = findPeaksBeforeTransition(SWS_before_wake_filtered_124, signal_fs_124, delta465_filt_2_124_smooth, sec_signal_2_124, 0.1, mean(delta465_filt_2_124)-5, 15, 15);
SWS_before_wake_pklocs_117 = findPeaksBeforeTransition(SWS_before_wake_filtered_117, signal_fs_117, delta465_filt_2_117_smooth, sec_signal_2_117, 0.1, mean(delta465_filt_2_117)-5, 15, 15);

REM_before_wake_pklocs_117 = findPeaksBeforeTransition(REM_before_arousal_filtered_117, signal_fs_117, delta465_filt_2_117_smooth, sec_signal_2_117, 0, 0, 0, 15);
REM_before_wake_pklocs_124 = findPeaksBeforeTransition(REM_before_arousal_filtered_124, signal_fs_124, delta465_filt_2_124_smooth, sec_signal_2_124, 0, 0, 0, 0);

% Logical condition for values not in the ranges 18950 to 19000 and 5400 to 5450
not_in_range = ~(REM_before_wake_pklocs_124 > 18950 & REM_before_wake_pklocs_124 < 19000) & ~(REM_before_wake_pklocs_124 > 5400 & REM_before_wake_pklocs_124 < 5450);

% Apply logical indexing to keep only values not in the specified ranges
REM_before_wake_pklocs_124 = REM_before_wake_pklocs_124(not_in_range);
SWS_before_MA_pklocs_124 = SWS_before_MA_pklocs_124';
NREMexclMA_periods_pklocs_124 = NREMexclMA_periods_pklocs_124';
%% 
% Find the maximum length among the variables
maxLen = max([length(SWS_before_MA_pklocs_124), length(NREMexclMA_periods_pklocs_124), ...
              length(SWS_before_wake_pklocs_124), length(REM_before_wake_pklocs_124)]);

% Preallocate arrays of NaNs to the maximum length
SWS_before_MA_124_padded = NaN(maxLen, 1);
NREMexclMA_periods_124_padded = NaN(maxLen, 1);
SWS_before_wake_124_padded = NaN(maxLen, 1);
REM_before_wake_124_padded = NaN(maxLen, 1);

% Fill the preallocated arrays with actual data
SWS_before_MA_124_padded(1:length(SWS_before_MA_pklocs_124)) = SWS_before_MA_pklocs_124;
NREMexclMA_periods_124_padded(1:length(NREMexclMA_periods_pklocs_124)) = NREMexclMA_periods_pklocs_124;
SWS_before_wake_124_padded(1:length(SWS_before_wake_pklocs_124)) = SWS_before_wake_pklocs_124;
REM_before_wake_124_padded(1:length(REM_before_wake_pklocs_124)) = REM_before_wake_pklocs_124;

% Calculate the differences between consecutive observations
Diff_SWS_before_MA_124 = [NaN; diff(SWS_before_MA_124_padded)];
Diff_NREMexclMA_periods_124 = [NaN; diff(NREMexclMA_periods_124_padded)];
Diff_SWS_before_wake_124 = [NaN; diff(SWS_before_wake_124_padded)];
Diff_REM_before_wake_124 = [NaN; diff(REM_before_wake_124_padded)];

% Compile into a structure for easy access
NE_trough_locs = struct('SWS_before_MA_pklocs_124', round(SWS_before_MA_124_padded), ...
                   'Diff_SWS_before_MA_124', round(Diff_SWS_before_MA_124), ...
                   'NREMexclMA_periods_pklocs_124', round(NREMexclMA_periods_124_padded), ...
                   'Diff_NREMexclMA_periods_124', round(Diff_NREMexclMA_periods_124), ...
                   'SWS_before_wake_pklocs_124', round(SWS_before_wake_124_padded), ...
                   'Diff_SWS_before_wake_124', round(Diff_SWS_before_wake_124), ...
                   'REM_before_wake_pklocs_124', round(REM_before_wake_124_padded), ...
                   'Diff_REM_before_wake_124', round(Diff_REM_before_wake_124));

% Accessing data example:
% dataFrame.SWS_before_MA_pklocs_124


%% 
% Initialize an array to hold the furthest peak time and its distance from offset for each bout
peak_info = []; % Each row: [peak time, distance to offset]

% Iterate through each bout
for i = 1:size(REM_before_arousal_filtered_124, 1)
    bout_onset = REM_before_arousal_filtered_124(i, 1);
    bout_offset = REM_before_arousal_filtered_124(i, 2);
    
    % Find peaks that fall within this bout
    peaks_in_bout = REM_before_wake_pklocs_124(REM_before_wake_pklocs_124 >= bout_onset & REM_before_wake_pklocs_124 <= bout_offset);
    
    % Calculate distances of these peaks from the bout's offset
    distances = bout_offset - peaks_in_bout;
    
    % Find the peak furthest from the offset
    if ~isempty(distances)
        [max_distance, idx] = max(distances);
        furthest_peak = peaks_in_bout(idx);
        peak_info = [peak_info; furthest_peak, max_distance];
    end
end

% Sort the peak_info array by distance to offset, descending
[~, sortIdx] = sort(peak_info(:, 2), 'descend');
sorted_peak_info = peak_info(sortIdx, :);

% Display the top 3 peaks furthest from their bout's offset
num_peaks_to_display = min(3, size(sorted_peak_info, 1)); % Ensure we don't exceed the number of found peaks
for i = 1:num_peaks_to_display
    fprintf('Peak time: %f, Distance to offset: %f\n', sorted_peak_info(i, 1), sorted_peak_info(i, 2));
end

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
plot_sleep(ds_sec_signal_2_124, ds_delta465_filt_2_124_smooth, sleepscore_time, wake_woMA_binary_vector_124, sws_binary_vector_124, REM_binary_vector_124, MA_binary_vector_124);
hold on
plot(SWS_before_wake_pklocs_124, delta465_filt_2_124_smooth(round(SWS_before_wake_pklocs_124*signal_fs)), 'r*')
title('NE with selected peaks');

%% Percent HRB assocaitated troughs

% Assuming HRB_time and the trough variables are defined
trough_variables = {
    'NREM (M124)', NREMexclMA_periods_pklocs_124;
    'NREM to MA transition (M124)', SWS_before_MA_pklocs_124;
    'NREM to wake transition (M124)', SWS_before_wake_pklocs_124;
    'REM to MA/wake transition (M124)', REM_before_wake_pklocs_124
};

% Combine all trough times for checking consecutive troughs
all_trough_times = sort([NREMexclMA_periods_pklocs_124; SWS_before_MA_pklocs_124; SWS_before_wake_pklocs_124; REM_before_wake_pklocs_124]);

resultsTable = NETroughToHRBAssociation(trough_variables, all_trough_times, HRB_time);

%% 

[NE_associated_HRB_time, HRB_times_no_troughs] = separateHRBAssociatedTroughs(trough_variables, all_trough_times, HRB_time);

% Assuming 'NE_associated_HRB_time' and 'HRB_times_no_troughs' are available
% and contain the HRB times that are associated and not associated with NE troughs, respectively.
% And assuming HRB_time and HRB variables contain all HRB events and their times.

    sleepscore_time = 0:length(wake_woMA_binary_vector_124)-1; % Assuming all vectors are the same length

% Corrected color specifications using RGB triplets
figure;
plot_sleep(new_time_vector, resampled_RR_pchip, sleepscore_time, wake_woMA_binary_vector_124, sws_binary_vector_124, REM_binary_vector_124, MA_binary_vector_124);
hold on;

% Scatter plot for HRBs that are associated with NE troughs in green
scatter(NE_associated_HRB_time, HRB(ismember(HRB_time, NE_associated_HRB_time)), 'g', 'filled');

% Scatter plot for HRBs that aren't associated with NE troughs in red
scatter(HRB_times_no_troughs, HRB(ismember(HRB_time, HRB_times_no_troughs)), 'r', 'filled');

xlabel('Time (s)');
ylabel('RR intervals');
title('HRV p-chip (M124)');
grid on;

% NREM_M124__HRB in black
for i = 1:length(NREM_M124__HRB)
    xline(NREM_M124__HRB(i), '--', 'Color', 'k');
end

% NREM_M124__no_HRB in gray
for i = 1:length(NREM_M124__no_HRB)
    xline(NREM_M124__no_HRB(i), '--', 'Color', [0.5 0.5 0.5]);
end

% NREMToMATransition_M124__HRB in orange
for i = 1:length(NREMToMATransition_M124__HRB)
    xline(NREMToMATransition_M124__HRB(i), '--', 'Color', 'yellow');
end

% NREMToMATransition_M124__no_HRB in yellow
for i = 1:length(NREMToMATransition_M124__no_HRB)
    xline(NREMToMATransition_M124__no_HRB(i), '--', 'Color', 'white');
end

% NREMToWakeTransition_M124__HRB in dark green
for i = 1:length(NREMToWakeTransition_M124__HRB)
    xline(NREMToWakeTransition_M124__HRB(i), '--', 'Color', [0, 0.5, 0]);
end

% NREMToWakeTransition_M124__no_HRB in light green
for i = 1:length(NREMToWakeTransition_M124__no_HRB)
    xline(NREMToWakeTransition_M124__no_HRB(i), '--', 'Color', [0.5647, 0.9333, 0.5647]);
end

% REMToMA_wakeTransition_M124__HRB in dark blue
for i = 1:length(REMToMA_wakeTransition_M124__HRB)
    xline(REMToMA_wakeTransition_M124__HRB(i), '--', 'Color', [0.6784, 0.8471, 0.9020]);
end

% REMToMA_wakeTransition_M124__no_HRB in light blue
for i = 1:length(REMToMA_wakeTransition_M124__no_HRB)
    xline(REMToMA_wakeTransition_M124__no_HRB(i), '--', 'Color', [0, 0, 0.6]);
end

hold off; % Release the plot for further commands

%% Split HRB no through by sleep stage

[NREMinclMA_HRB_124, NREMexclMA_HRB_124, wake_HRB_124, REM_HRB_124] = categorizeHRBBySleepStage(HRB_times_no_troughs, NREMinclMA_periods_124, NREMexclMA_periods_124, wake_periods_124, REM_periods_124);

figure;
plot_sleep(new_time_vector, resampled_RR_pchip, sleepscore_time, wake_woMA_binary_vector_124, sws_binary_vector_124, REM_binary_vector_124, MA_binary_vector_124);
hold on;

% Assuming 'HRB' is an array with HRB markers, and 'HRB_time' is the corresponding time array
% Note: You may need to adjust the 'HRB' array access to match the specific values you wish to plot for each category.

% Scatter plot for NREMinclMA_HRB_124 in yellow
scatter(NREMinclMA_HRB_124, HRB(ismember(HRB_time, NREMinclMA_HRB_124)), 'y', 'filled');

% Scatter plot for NREMexclMA_HRB_124 in red
scatter(NREMexclMA_HRB_124, HRB(ismember(HRB_time, NREMexclMA_HRB_124)), 'r', 'filled');

% Scatter plot for REM_HRB_124 in green
scatter(REM_HRB_124, HRB(ismember(HRB_time, REM_HRB_124)), 'g', 'filled');

% Scatter plot for wake_HRB_124 in blue
scatter(wake_HRB_124, HRB(ismember(HRB_time, wake_HRB_124)), 'b', 'filled');

xlabel('Time (s)');
ylabel('RR intervals');
title('HRV p-chip (M124)');
grid on;
hold off;

%% Generate the main plot

event_var = {NREMexclMA_periods_pklocs_124, SWS_before_MA_pklocs_124, SWS_before_wake_pklocs_124, REM_before_wake_pklocs_124};
titles = {'NREM', 'NREM to MA Transition', 'NREM to Wake Transition', 'REM to Wake/MA Transition'};
main_title = 'Averaged Activity During NE Trough (M124)';

MainPlot(event_var, 30, 60, titles, main_title, delta465_filt_2_124_smooth, sec_signal_2_124, signal_fs_124, resampled_RR_pchip_124, new_time_vector_124, new_fs_RR_124,  mean_spectrogram_124, F_124, EEG_bands_fs_124)

%% Generate the main plot for HRB associated NE vs HRB not associated NE vs HRB not associated with NE

event_var = {NREM_M124__HRB, NREMToMATransition_M124__HRB, NREMToWakeTransition_M124__HRB, REMToMA_wakeTransition_M124__HRB};
titles = {'NREM', 'NREM to MA Transition', 'NREM to Wake Transition', 'REM to Wake/MA Transition'};
main_title = 'Averaged Activity During NE Troughs That Are HRB Related (M124)';
MainPlot(event_var, 30, 60, titles, main_title, delta465_filt_2_124_smooth, sec_signal_2_124, signal_fs_124, resampled_RR_pchip_124, new_time_vector_124, new_fs_RR_124,  mean_spectrogram_124, F_124, EEG_bands_fs_124)

event_var = {NREM_M124__no_HRB, NREMToMATransition_M124__no_HRB, NREMToWakeTransition_M124__no_HRB, REMToMA_wakeTransition_M124__no_HRB};
titles = {'NREM', 'NREM to MA Transition', 'NREM to Wake Transition', 'REM to Wake/MA Transition'};
main_title = 'Averaged Activity During NE Troughs That Are Not HRB Related (M124)';
MainPlot(event_var, 30, 60, titles, main_title, delta465_filt_2_124_smooth, sec_signal_2_124, signal_fs_124, resampled_RR_pchip_124, new_time_vector_124, new_fs_RR_124,  mean_spectrogram_124, F_124, EEG_bands_fs_124)

event_var = {NREMexclMA_HRB_124, NREMinclMA_HRB_124, wake_HRB_124, REM_HRB_124};
filteredEventVars = FilterHRBperSleepStageForPlottings(event_var, 30, 60, sec_signal_2_124);
titles = {'NREM excl. MA', 'NREM incl. MA', 'Wake', 'REM'};
main_title = 'Averaged Activity During HRBs Which Are Not NE Trough Related (M124)';
MainPlot(filteredEventVars, 30, 60, titles, main_title, delta465_filt_2_124_smooth, sec_signal_2_124, signal_fs_124, resampled_RR_pchip_124, new_time_vector_124, new_fs_RR_124,  mean_spectrogram_124, F_124, EEG_bands_fs_124)

%% QC plot for NE troughs
pklocs_variables_117 = {NREMexclMA_periods_pklocs_117, SWS_before_MA_pklocs_117, SWS_before_wake_pklocs_117, REM_before_wake_pklocs_117};
titles_117 = {'NREM - M117', 'NREM to MA Transition - M117', 'NREM to Wake Transition - M117', 'REM to Wake Transition - M117'};
QC_plot_all_NE_troughs(pklocs_variables_117, titles_117, ds_delta465_filt_2_117, ds_sec_signal_2_117, signal_fs_117)


pklocs_variables_124 = {NREMexclMA_periods_pklocs_124, SWS_before_MA_pklocs_124, SWS_before_wake_pklocs_124, REM_before_wake_pklocs_124};
titles_124 = {'NREM - M124', 'NREM to MA Transition - M124', 'NREM to Wake Transition - M124', 'REM to Wake/MA Transition - M124'};
maintitle = 'RR Activity Around Troughs';
ylab = 'RR Intervals';
QC_plot_all_NE_troughs(pklocs_variables_124, titles_124, maintitle, ylab, resampled_RR_pchip_124, new_time_vector_124, new_fs_RR_124)

% Assume REM_before_wake_pklocs_124, ds_delta465_filt_2, and ds_sec_signal_2 are defined
pklocs = REM_before_wake_pklocs_124; % Trough times
event_count = length(pklocs); % Number of troughs

for i = 1:event_count
    pkloc_time = pklocs(i);
    % Find the index of pkloc_time in ds_sec_signal_2
    [~, closest_index] = min(abs(ds_sec_signal_2_124 - pkloc_time));
    start_index = max(1, closest_index - round(30 * signal_fs_124));
    end_index = min(length(ds_delta465_filt_2_124_smooth), closest_index + round(60 * signal_fs_124));
    
    % Create a new figure for each trough
    figure; % Create a new figure window for each plot to make it one by one
    hold on;
    
    % Plot the NE trace for this event, ensuring the time axis is centered at the trough
    plot_time = ds_sec_signal_2_124(start_index:end_index) - ds_sec_signal_2_124(closest_index);
    plot(plot_time, ds_delta465_filt_2_124_smooth(start_index:end_index));
    
    % Formatting the plot
    title(['Trough ' num2str(i) ' NE Activity']);
    xlabel('Time (s) relative to trough');
    ylabel('NE Activity');
    xlim([-30, 60]); % 30 seconds before to 60 seconds after the trough
    grid on;
    hold off;
    
    % Pause and wait for the user to close the figure or press a key to continue to the next plot
    waitforbuttonpress; % Wait for a button press to continue
    % Alternatively, use pause; and manually close the figure to move to the next one
end

%% QC plot for HRB events - not run yet!
sleep_stage_periods_117 = {NREMexclMA_periods_117, NREMinclMA_periods_117, wake_periods_117, REM_periods_117};
sleep_stages_117 = {'NREM excl MA - M117', 'NREM incl MA - M117', 'Wake - M117', 'REM - M117'};
QC_plot_all_HRB(sleep_stage_periods_117, sleep_stages_117, HRB_117, HRB_time_117)

sleep_stage_periods_124 = {NREMexclMA_periods_124, NREMinclMA_periods_124, wake_periods_124, REM_periods_124};
sleep_stages_124 = {'NREM excl MA - M124', 'NREM incl MA - M124', 'Wake - M124', 'REM - M124'};
QC_plot_all_HRB(sleep_stage_periods_124, sleep_stages_124, HRB_124, HRB_time_124)

%% Split NE into hours for each mouse and store the information

mice_data_hours = []; % To store mouse numbers and their corresponding data hours

for idx = 1:length(synapse_mice)
    mouse = synapse_mice{idx};
    mouseNumber = mouse{3}; % Extract unique mouse identifier
    
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

% At this point, 'mice_data_hours' will have 2 columns: mouse number and hour segments

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


% Convert hours from cells to a numeric array and subtract 6.5 to get Zeitgeber Time
% Assuming NREM_mice_data_hours(:, 2) contains the 'hours' data

if iscell(NREM_mice_data_hours(:, 2))
    % Extract numeric values from cells
    hoursNumeric = cell2mat(NREM_mice_data_hours(:, 2));
else
    % If 'hours' is already a numeric array, we don't need to convert it
    hoursNumeric = NREM_mice_data_hours(:, 2);
end

% Subtract 6.5 to get the Zeitgeber Time
zeitgeberTimes = hoursNumeric - 6.5;

% Verify if zeitgeberTimes contains NaN values
if any(isnan(zeitgeberTimes))
    warning('NaN values found after subtraction in "zeitgeberTimes"');
end

% Convert the first two columns to strings if they are not already
mouseIDs = string(NREM_mice_data_hours(:, 1));

% Create a unique key for each combination of Mouse ID and Hour by concatenating
uniqueKeys = mouseIDs + "_" + hoursNumeric;

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
    
    % Use the pre-calculated Zeitgeber Time for the current rows
    % Adjust the index to match the rows from unique combinations
    hourIndex = find(mouseIDs == mouseHourSplit(1) & hoursNumeric == str2double(mouseHourSplit(2)));
    hour = zeitgeberTimes(hourIndex(1));

    % Append to the output array
    % Including the count of NREM bouts (length of rows for this combination) and mean duration
    percent_NREM = [percent_NREM; {mouseID, hour, percentOfHour, length(rows), meanDuration}];
end

% Convert to table with additional columns for NREM bout count and mean duration
percent_NREM = cell2table(percent_NREM, 'VariableNames', {'MouseID', 'Zeitgeber Time', 'PercentNREMinclMA', 'NREM_bout_n', 'NREM_bout_duration'});

%% Plot %NREM, NREM bout n, and NREM bout duration

plotNREMDataWithShading(percent_NREM, 'Percent NREM per Hour', 'PercentNREMinclMA', '% NREM', true, true);
plotNREMDataWithShading(percent_NREM, 'Mean NREM Bout Count per Hour', 'NREM_bout_n', 'Mean Bout Count', false, true);
plotNREMDataWithShading(percent_NREM, 'Mean NREM Bout Duration per Hour', 'NREM_bout_duration', 'Mean Bout Duration (sec)', false, true);

plotIndividualAnimalData(percent_NREM, 'Percent NREM per Hour', 'PercentNREMinclMA', '% NREM', true, true);
plotIndividualAnimalData(percent_NREM, 'NREM Bout Count per Hour', 'NREM_bout_n', 'Bout Count', false, true);
plotIndividualAnimalData(percent_NREM, 'NREM Bout Duration per Hour', 'NREM_bout_duration', 'Mean Bout Duration (sec)', false, true);
%% Cut NE data into 30 min
mice_data_half_hours = []; % Initialize for storing mouse numbers and their corresponding data hours in 30-min segments

for idx = 1:length(synapse_mice)
    mouse = synapse_mice{idx};
    mouseNumber = mouse{3}; % Extract unique mouse identifier

    % Dynamically access the data_FPrig variable for the current mouse
    data_FPrig_varName = sprintf('data_FPrig_%s', mouseNumber);
    data_FPrig = eval(data_FPrig_varName);

    % Extract start and end times from data_FPrig
    startTimeStr = data_FPrig.info.utcStartTime;
    endTimeStr = data_FPrig.info.utcStopTime;

    % Convert to datetime in UTC timezone and adjust for local time zone
    startTime = datetime(startTimeStr, 'InputFormat', 'HH:mm:ss', 'TimeZone', 'UTC') + hours(1);
    endTime = datetime(endTimeStr, 'InputFormat', 'HH:mm:ss', 'TimeZone', 'UTC') + hours(1);

    % Adjust startTime to the nearest half-hour forward or on the hour if it's exactly on the half-hour
    minutePart = minute(startTime);
    if minutePart < 30
        startTime.Minute = 30;
    elseif minutePart > 30
        startTime = dateshift(startTime + hours(1), 'start', 'hour');
    end

    % Adjust endTime to the nearest half-hour back
    minutePart = minute(endTime);
    if minutePart > 30
        endTime.Minute = 30;
    elseif minutePart < 30 && minutePart > 0
        endTime = dateshift(endTime, 'start', 'hour');
    end

    % Access signal frequency for the current mouse
    signal_fs_varName = sprintf('signal_fs_%s', mouseNumber);
    signal_fs = eval(signal_fs_varName);

    % Access the FP data for the current mouse
    delta465_filt_2_varName = sprintf('delta465_filt_2_%s', mouseNumber);
    delta465_filt_2 = eval(delta465_filt_2_varName);

    % Determine number of 30-minute intervals between startTime and endTime
    totalFullHalfHours = hours(endTime - startTime) * 2;
    currentSegmentStart = startTime;

    for i = 1:totalFullHalfHours
        % Use datevec to get the numeric components of the datetime
        [year, month, day, hourSegment, min_segment, sec] = datevec(currentSegmentStart);
        disp(hourSegment)
    
        segmentStartSec = seconds(currentSegmentStart - startTime);
        segmentEndSec = segmentStartSec + 1800; % +30 minutes in seconds
    
        % Calculate indices for the segment
        segmentStartIndex = round(segmentStartSec * signal_fs) + 1;
        segmentEndIndex = min(round(segmentEndSec * signal_fs), length(delta465_filt_2));
    
        % Extract segments
        segmentDelta = delta465_filt_2(segmentStartIndex:segmentEndIndex);
        segmentTime = ((segmentStartIndex:segmentEndIndex) - segmentStartIndex + 1) / signal_fs;
    
        % Naming and saving segments dynamically with 30min suffix
        eval(sprintf('delta465_filt_2_%s_%d_%d = segmentDelta;', mouseNumber, hourSegment, min_segment));
        eval(sprintf('sec_signal_2_%s_%d_%d = segmentTime + segmentStartSec;', mouseNumber, hourSegment, min_segment));
    
        % Store mouse number and half-hour of data segment, formatted as 'HH:MM'
        mice_data_half_hours = [mice_data_half_hours; {mouseNumber, sprintf('%02d:%02d', hourSegment, min_segment), '30min'}];
    
        % Advance to the next half-hour segment
        currentSegmentStart = currentSegmentStart + minutes(30);
    end
end

% Convert to table with additional columns for 30-min segments
mice_data_half_hours_table = cell2table(mice_data_half_hours, 'VariableNames', {'MouseNumber', 'TimeSegment', 'Duration'});

%% Add on the sleep phases for the 30 min data
min_sleep_period_duration = 90;

sleepStages = {'NREMinclMA_periods', 'NREMexclMA_periods', 'wake_periods', 'REM_periods'};
updated_mice_data_half_hours = []; % To store the expanded data for 30-min segments

for i = 1:size(mice_data_half_hours_table, 1)
    mouseNumber = mice_data_half_hours_table.MouseNumber{i};
    timeSegment = mice_data_half_hours_table.TimeSegment{i}; % This will be something like '14:30'
    % Parse the timeSegment to extract the hour and minutes for variable naming
    timeParts = split(timeSegment, ':');
    hourSegment = str2double(timeParts{1});
    minSegment = str2double(timeParts{2});

    % Dynamic variable names for sec_signal_2 and delta465_filt_2 data
    sec_signal_2_varName = sprintf('sec_signal_2_%s_%d_%d', mouseNumber, hourSegment, minSegment);
    delta465_filt_2_varName = sprintf('delta465_filt_2_%s_%d_%d', mouseNumber, hourSegment, minSegment);
    
    % Check if the variables exist to handle cases where they might not due to filtering or other reasons
    if exist(sec_signal_2_varName, 'var') && exist(delta465_filt_2_varName, 'var')
        sec_signal_2_halfhourly = eval(sec_signal_2_varName);
        delta465_filt_2_halfhourly = eval(delta465_filt_2_varName);

        for stage = sleepStages
            sleepVarName = sprintf('%s_%s', stage{1}, mouseNumber);
            if exist(sleepVarName, 'var')
                sleepPeriods = eval(sleepVarName); % Load sleep periods data

                allIndices = []; % Initialize empty array to collect all relevant indices

                % Collect indices for all periods within this sleep stage
                for periodIndex = 1:size(sleepPeriods, 1)
                    onset = sleepPeriods(periodIndex, 1);
                    offset = sleepPeriods(periodIndex, 2);
                    
                    % Check if the sleep period is longer than 90 seconds
                    if (offset - onset) > min_sleep_period_duration
                        indices = find(sec_signal_2_halfhourly >= onset & sec_signal_2_halfhourly <= offset);

                        if ~isempty(indices)
                            filtered_sec_signal_2 = sec_signal_2_halfhourly(indices);
                            filtered_delta465_filt_2 = delta465_filt_2_halfhourly(indices);
            
                            % Save filtered data with new variable names
                            newSecSignalName = sprintf('sec_signal_2_%s_%d_%d_%s_30min', mouseNumber, hourSegment, minSegment, stage{1}(1:end-8)); % Simplify stage name
                            newDeltaName = sprintf('delta465_filt_2_%s_%d_%d_%s_30min', mouseNumber, hourSegment, minSegment, stage{1}(1:end-8));
            
                            eval([newSecSignalName ' = filtered_sec_signal_2;']);
                            eval([newDeltaName ' = filtered_delta465_filt_2;']);
            
                            % Update new mice_data_half_hours array
                            updated_mice_data_half_hours = [updated_mice_data_half_hours; {mouseNumber, timeSegment, stage{1}(1:end-8), newSecSignalName, filtered_sec_signal_2, newDeltaName, filtered_delta465_filt_2}];
                        end
                    end
                end
            end
        end
    end
end

%% Get PSD for 30 min data


% Initialization
max_freq = 0.1; % Maximum frequency for PSD analysis
sample_pr_sec = 0.002; % Frequency resolution for PSD


% Loop through each entry in the updated_mice_data_half_hours
% Initialization and function definitions are assumed to be as you provided.

% Revised main loop structure:
uniqueSleepStages = unique(updated_mice_data_half_hours(:, 3));
uniqueTimeSegments = unique(updated_mice_data_half_hours(:, 2));

% Create a unique identifier for each combination of MouseNumber, TimeSegment, and SleepStage
combinationIDs = strcat(updated_mice_data_half_hours(:,1), '_', updated_mice_data_half_hours(:,2), '_', updated_mice_data_half_hours(:,3));

% Find unique combinations
[uniqueCombinationIDs, idx] = unique(combinationIDs);

% Initialize your PSD table
PSD_NE_table_new_30min = [{'MouseNumber', 'Hour', 'SleepStage', 'PeakPower', 'PeakPowerFreq', 'Freq25Quartile', 'MedianFrequency', 'Freq75Quartile', 'Freq95Quartile', 'AUC', 'TotalPower', 'avgPSD', 'Freqs'}];

% Loop over unique combinations
for i = 1:length(uniqueCombinationIDs)
    % Extract the index of the current unique combination from the original data
    currentIdx = idx(i);
    mouseNumber = updated_mice_data_half_hours{currentIdx, 1};
    timeSegment = updated_mice_data_half_hours{currentIdx, 2};
    sleepStage = updated_mice_data_half_hours{currentIdx, 3};
    
    % Filter entries for the current combination
    entries = updated_mice_data_half_hours(strcmp(combinationIDs, uniqueCombinationIDs{i}), :);
    
    % Initialize variables for combining PSD data
    weightedPSD = [];
    freqs = [];
    totalDataPoints = 0;
    
    % Process each entry for the current combination
    for j = 1:size(entries, 1)
        secSignalData = entries{j, 5};
        deltaSignalData = entries{j, 7};
        
        % Assume fs is defined for each mouse and doesn't change
        fs_varName = sprintf('signal_fs_%s', mouseNumber);
        fs = eval(fs_varName);

        [detrendedSignal, segmentPSD, freqs, segmentDataPoints] = processSignalSegment(secSignalData, deltaSignalData, fs, max_freq, sample_pr_sec);
        
        if isempty(weightedPSD)
            weightedPSD = segmentPSD * segmentDataPoints;
        else
            weightedPSD = weightedPSD + segmentPSD * segmentDataPoints; % Accumulate weighted PSD
        end
        
        totalDataPoints = totalDataPoints + segmentDataPoints; % Accumulate total data points
    end

    % After processing all entries for the current combination, calculate and store metrics
    if totalDataPoints > 0
        avgPSD = weightedPSD / totalDataPoints;
        
        [metrics] = calculatePSDMetrics(avgPSD, freqs);
        
        % Extract hour and minute from timeSegment and format it
        formattedHour = formatHour(timeSegment);

        PSD_NE_table_new_30min = [PSD_NE_table_new_30min; {mouseNumber, formattedHour, sleepStage, metrics.peakPower, metrics.peakPowerFreq, metrics.Freq25Quartile, metrics.MedianFrequency, metrics.Freq75Quartile, metrics.Freq95Quartile, metrics.AUC, metrics.totalPower, avgPSD, freqs}];
    end
end

%% mean PSD per hour/sleep stage for 30 min data

% Initialize the new dataframe with headers
mean_PSD_by_hour_and_stage = {'Hour', 'SleepStage', 'MeanPSD', 'Freqs'};

uniqueHours = unique(PSD_NE_table_new_30min(2:end, 2)); % Excluding header row
uniqueSleepStages = unique(PSD_NE_table_new_30min(2:end, 3));

for i = 1:length(uniqueHours)
    for j = 1:length(uniqueSleepStages)
        currentHour = uniqueHours{i};
        currentSleepStage = uniqueSleepStages{j};

        % Initialize sumPSD and count for each combination of hour and sleep stage
        sumPSD = [];
        count = 0;
        freqs = [];

        % Iterate through the PSD_NE_table_new_30min to find matching entries
        for k = 2:size(PSD_NE_table_new_30min, 1) % Skip header row
            hour = PSD_NE_table_new_30min{k, 2};
            sleepStage = PSD_NE_table_new_30min{k, 3};
            if strcmp(hour, currentHour) && strcmp(sleepStage, currentSleepStage)
                avgPSD = PSD_NE_table_new_30min{k, 12};
                if isempty(sumPSD)
                    sumPSD = avgPSD;
                    freqs = PSD_NE_table_new_30min{k, 13};
                else
                    % Element-wise addition of the avgPSD to the sumPSD
                    sumPSD = sumPSD + avgPSD; % Assumes avgPSD and sumPSD have the same size
                end
                count = count + 1;
            end
        end

        if count > 0
            % Calculate the mean PSD
            meanPSD = sumPSD / count;
            % Append the results to the new dataframe
            mean_PSD_by_hour_and_stage = [mean_PSD_by_hour_and_stage; {currentHour, currentSleepStage, meanPSD, freqs}];
        end
    end
end

if isempty(mean_PSD_by_hour_and_stage)
    disp('mean_PSD_by_hour_and_stage is empty. No plots can be generated.');
    return; % Exit if mean_PSD_by_hour_and_stage is empty
end

% Define colors and sleep stages for plotting
colors = {'blue', 'red', 'green', 'black'}; % Color for each sleep phase
sleepStages = {'NREMinclMA', 'NREMexclMA', 'REM', 'wake'};
colorMap = containers.Map(sleepStages, colors);

% Extract unique time segments for plotting
uniqueTimeSegments = unique(mean_PSD_by_hour_and_stage(2:end, 1)); % Skipping header row

% Loop through each unique time segment
for i = 1:length(uniqueTimeSegments)
    uTimeSegment = uniqueTimeSegments{i};
    figure; % Create a new figure for each time segment
    hold on; % Hold on to plot multiple lines

    % Extract frequencies from the first row for plotting (assuming consistency across rows)
    universalFreqs = mean_PSD_by_hour_and_stage{2, 4}; % Directly access the frequencies array

    % Loop through each sleep stage for plotting
    for j = 1:length(sleepStages)
        uSleepStage = sleepStages{j};
        color = colorMap(uSleepStage);

        % Initialize a flag to check if the stage is found for plotting
        stageFound = false;

        % Find matching rows for current time segment and sleep stage
        for k = 2:size(mean_PSD_by_hour_and_stage, 1) % Skip header row
            if strcmp(mean_PSD_by_hour_and_stage{k, 1}, uTimeSegment) && strcmp(mean_PSD_by_hour_and_stage{k, 2}, uSleepStage)
                avgPSD = mean_PSD_by_hour_and_stage{k, 3}; % Directly access avgPSD
                plot(universalFreqs, avgPSD, 'DisplayName', uSleepStage, 'Color', color);
                stageFound = true;
                break; % Break after finding the first match, assuming one row per sleep stage per time segment
            end
        end

        % Check if the stage was not found for the current segment
        if ~stageFound
            disp(['No data found for ', uTimeSegment, ' - ', uSleepStage]);
        end
    end

    titleStr = formatTitle(uTimeSegment);
    title(titleStr);
    xlabel('Frequency (Hz)');
    ylabel('Power Spectral Density');
    legend('show');
    grid on;
    hold off;
    set(gcf, 'color', 'white');
end
%% Preprocess NREM plots
% Initialize for storing processed data including actual data arrays
sleepStages = {'NREMinclMA_periods'}; % Only interested in 'NREMinclMA_periods' for the final output
NREM_mice_data_half_hours = [];

for i = 1:size(mice_data_half_hours_table, 1)
    mouseNumber = mice_data_half_hours_table.MouseNumber{i};
    timeSegment = mice_data_half_hours_table.TimeSegment{i}; % 'HH:MM' format
    
    % Split the timeSegment into hours and minutes
    [hoursPart, minutesPart] = strtok(timeSegment, ':');
    minutesPart = strrep(minutesPart, ':', ''); % Remove colon
    
    % Remove leading zeros from the hour part
    hoursPart = num2str(str2double(hoursPart));
    
    % Adjust minutes formatting
    if strcmp(minutesPart, '00')
        minutesFormatted = '0'; % For "00" minutes, format as "_0"
    elseif strcmp(minutesPart, '30')
        minutesFormatted = '30'; % Keep "30" minutes as "_30"
    else
        minutesFormatted = ['0', minutesPart]; % For non-standard cases, assuming correction
    end
    
    % Combine the adjusted hour and minute parts
    timeSegmentFormatted = [hoursPart, '_', minutesFormatted];
        
    % Dynamic variable names for sec_signal_2 and delta465_filt_2 data
    sec_signal_2_varName = sprintf('sec_signal_2_%s_%s', mouseNumber, timeSegmentFormatted);
    delta465_filt_2_varName = sprintf('delta465_filt_2_%s_%s', mouseNumber, timeSegmentFormatted);

    
    % Check if variables exist using the who function to avoid eval's overhead
    if ismember(sec_signal_2_varName, who()) && ismember(delta465_filt_2_varName, who())
        sec_signal_2_data = eval(sec_signal_2_varName);
        delta465_filt_2_data = eval(delta465_filt_2_varName);

        % Process sleep stages
        for stage = sleepStages
            sleepVarName = sprintf('%s_%s', stage{1}, mouseNumber);
            if ismember(sleepVarName, who())
                sleepPeriods = eval(sleepVarName); % Fetch sleep periods data
                
                for periodIndex = 1:size(sleepPeriods, 1)
                    onset = sleepPeriods(periodIndex, 1);
                    offset = sleepPeriods(periodIndex, 2);

                    indices = find(sec_signal_2_data >= onset & sec_signal_2_data <= offset);

                    if ~isempty(indices)
                        filtered_sec_signal_2 = sec_signal_2_data(indices);
                        filtered_delta465_filt_2 = delta465_filt_2_data(indices);
                        
                        % Store actual filtered data arrays directly
                        NREM_mice_data_half_hours = [NREM_mice_data_half_hours; ...
                                                     {mouseNumber, timeSegment, stage{1}(1:end-8), filtered_sec_signal_2, filtered_delta465_filt_2}];
                    end
                end
            end
        end
    end
end

% Convert to table format, with variable names indicating the data they contain
NREM_mice_data_half_hours_table = cell2table(NREM_mice_data_half_hours, ...
                                             'VariableNames', {'MouseNumber', 'TimeSegment', 'SleepStage', 'FilteredSecSignal2Data', 'FilteredDelta465Filt2Data'});

% Adjust 'HH:MM' to decimal hours correctly for Zeitgeber Time
zeitgeberTimes = cellfun(@(x) str2double(x(1:2)) + (str2double(x(4:5)) == 30)*0.5, NREM_mice_data_half_hours_table.TimeSegment) - 6.75;

% Ensure MouseNumber is a string for concatenation
mouseIDs = string(NREM_mice_data_half_hours_table.MouseNumber);

% Create unique keys for combinations of MouseID and Zeitgeber Time
uniqueKeys = mouseIDs + "_" + string(zeitgeberTimes);

% Find unique combinations and their indices
[uniqueCombinations, ~, groupIndices] = unique(uniqueKeys);

% Initialize the output array
percent_NREM = [];

for i = 1:length(uniqueCombinations)
    % Find rows belonging to the current combination
    rows = find(groupIndices == i);

    totalSeconds = 0;
    durations = []; % To store durations of NREM bouts for calculating the mean

    for j = rows'
        % Access the sec_signal_2 data directly
        secSignalData = NREM_mice_data_half_hours_table.FilteredSecSignal2Data{j};
        
        % Check for non-empty and numeric type directly
        if ~isempty(secSignalData) && isnumeric(secSignalData)
            duration = max(secSignalData) - min(secSignalData);
            totalSeconds = totalSeconds + duration;
            durations = [durations; duration]; % Store the duration
        end
    end
    
    percentOfHour = (totalSeconds / (3600/2)) * 100;
    meanDuration = mean(durations);

    % Extract MouseID and Zeitgeber Time from the combination
    comboParts = split(uniqueCombinations(i), '_');
    mouseID = str2double(comboParts{1});
    zeitgeberTime = str2double(comboParts{2}); % Extract numeric part directly

    % Append to the output array
    percent_NREM = [percent_NREM; {mouseID, zeitgeberTime, percentOfHour, numel(rows), meanDuration}];
end

% Convert to table with appropriate column names
percent_NREM_30min = cell2table(percent_NREM, 'VariableNames', {'MouseID', 'Zeitgeber Time', 'PercentNREMinclMA', 'NREM_bout_n', 'NREM_bout_duration'});

%% Plot 30 min of %NREM, NREM bout n, and NREM bout duration

plotNREMDataWithShading(percent_NREM_30min, 'Percent NREM per Hour', 'PercentNREMinclMA', '% NREM', true, false);
plotNREMDataWithShading_30min(percent_NREM_30min, 'Mean NREM Bout Count per Hour', 'NREM_bout_n', 'Mean Bout Count', false, false);
plotNREMDataWithShading_30min(percent_NREM_30min, 'Mean NREM Bout Duration per Hour', 'NREM_bout_duration', 'Mean Bout Duration (sec)', false, false);

plotIndividualAnimalData(percent_NREM_30min, 'Percent NREM per Hour', 'PercentNREMinclMA', '% NREM', true, false);
plotIndividualAnimalData(percent_NREM_30min, 'NREM Bout Count per Hour', 'NREM_bout_n', 'Bout Count', false, false);
plotIndividualAnimalData(percent_NREM_30min, 'NREM Bout Duration per Hour', 'NREM_bout_duration', 'Mean Bout Duration (sec)', false, false);


