%% 1) Define data - EEG-FP - Sleep deprivatoin

% data structure:
    % 1) FP raw data
    % 2) EEG raw data
    % 3) EEG sleep score
    % 4) 465 channel name
    % 5) 560 channel name
    % 6) Sleep score time correction
%clear all
%close all


% Repeat of experiment (October)
% SD_control_307_I = {'J:\CTN\NedergaardLAB\Personal_folders\Celia Kjaerby\FP\20200721 NE Sleep deprivation\20201027_EEGFP_1_307_2_319' 'Q:\Personal_folders\Celia Kjaerby\Fiber photometry\20200721 NE Sleep deprivation\20201027_EEGFP_1_307_2_319\307_sleep\307_sleep_2020-10-27_12-00-20-260.exp' 'Q:\Personal_folders\Celia Kjaerby\Fiber photometry\20200721 NE Sleep deprivation\20201027_EEGFP_1_307_2_319\307_sleep\20201027_307_control.xlsx' 'x465A' 'x560B' 'x05A'};
% SD_SD_307_I = {'J:\CTN\NedergaardLAB\Personal_folders\Celia Kjaerby\FP\20200721 NE Sleep deprivation\20201028_EEGFP_1_307_2_319_SD' 'Q:\Personal_folders\Celia Kjaerby\Fiber photometry\20200721 NE Sleep deprivation\20201028_EEGFP_1_307_2_319_SD\307_sleep\307_sleep_2020-10-28_12-09-46-265.exp' 'Q:\Personal_folders\Celia Kjaerby\Fiber photometry\20200721 NE Sleep deprivation\20201027_EEGFP_1_307_2_319\307_sleep\307_SD_sleepscore.xlsx' 'x465A' 'x560B' 'x05A' 193.99573};
% 
% SD_control_319_I = {'J:\CTN\NedergaardLAB\Personal_folders\Celia Kjaerby\FP\20200721 NE Sleep deprivation\20201027_EEGFP_1_307_2_319' 'Q:\Personal_folders\Celia Kjaerby\Fiber photometry\20200721 NE Sleep deprivation\20201027_EEGFP_1_307_2_319\319_sleep\319_sleep_2020-10-27_12-00-20-260.exp' 'Q:\Personal_folders\Celia Kjaerby\Fiber photometry\20200721 NE Sleep deprivation\20201027_EEGFP_1_307_2_319\319_sleep\319_sleep_sleepscore.xlsx' 'x465C' 'x560D' 'x05C'};
% SD_SD_319_I = {'J:\CTN\NedergaardLAB\Personal_folders\Celia Kjaerby\FP\20200721 NE Sleep deprivation\20201028_EEGFP_1_307_2_319_SD' 'Q:\Personal_folders\Celia Kjaerby\Fiber photometry\20200721 NE Sleep deprivation\20201027_EEGFP_1_307_2_319\319_sleep\319_sleep_2020-10-28_12-09-46-265.exp' 'Q:\Personal_folders\Celia Kjaerby\Fiber photometry\20200721 NE Sleep deprivation\20201027_EEGFP_1_307_2_319\319_sleep\319_SD_sleepscore.xlsx' 'x465C' 'x560D' 'x05C' 21.265169143676758};
% 
% SD_control_323_I = {'J:\CTN\NedergaardLAB\Personal_folders\Celia Kjaerby\FP\20200721 NE Sleep deprivation\20201029_EEGFP_1_323_2_331_sl' 'Q:\Personal_folders\Celia Kjaerby\Fiber photometry\20200721 NE Sleep deprivation\20201030_1_323_2_331_SD\323_sleep\323_sleep_2020-10-29_11-59-00-080.exp' 'Q:\Personal_folders\Celia Kjaerby\Fiber photometry\20200721 NE Sleep deprivation\20201030_1_323_2_331_SD\323_sleep\323_sleep_sleepscore.xlsx' 'x465A' 'x560B' 'x05A'};
% SD_SD_323_I = {'J:\CTN\NedergaardLAB\Personal_folders\Celia Kjaerby\FP\20200721 NE Sleep deprivation\20201030_1_323_2_331_SD' 'Q:\Personal_folders\Celia Kjaerby\Fiber photometry\20200721 NE Sleep deprivation\20201030_1_323_2_331_SD\323_sleep\323_sleep_2020-10-30_12-06-33-205.exp' 'Q:\Personal_folders\Celia Kjaerby\Fiber photometry\20200721 NE Sleep deprivation\20201030_1_323_2_331_SD\323_sleep\323_SD_sleepscore.xlsx' 'x465A' 'x560B' 'x05A'};
% 
% SD_control_331_I = {'J:\CTN\NedergaardLAB\Personal_folders\Celia Kjaerby\FP\20200721 NE Sleep deprivation\20201102_EEGFP_2_331_sleep' 'Q:\Personal_folders\Celia Kjaerby\Fiber photometry\20200721 NE Sleep deprivation\SD\20201030_1_323_2_331_SD\331_sleep\331_sleep_2020-11-02_12-12-10-254.exp' 'Q:\Personal_folders\Celia Kjaerby\Fiber photometry\20200721 NE Sleep deprivation\20201030_1_323_2_331_SD\331_sleep\331_sleep_sleepscore.xlsx' 'x465C' 'x560D' 'x05C'};
% SD_SD_331_I = {'J:\CTN\NedergaardLAB\Personal_folders\Celia Kjaerby\FP\20200721 NE Sleep deprivation\20201030_1_323_2_331_SD' 'Q:\Personal_folders\Celia Kjaerby\Fiber photometry\20200721 NE Sleep deprivation\20201030_1_323_2_331_SD\331_sleep\331_sleep_2020-10-30_12-06-33-205.exp' 'Q:\Personal_folders\Celia Kjaerby\Fiber photometry\20200721 NE Sleep deprivation\20201030_1_323_2_331_SD\331_sleep\331_SD_sleepscore.xlsx' 'x465C' 'x560D' 'x05C'};


%New
control_307 = {'J:\CTN\NedergaardLAB\Personal_folders\Celia Kjaerby\FP\20200721 NE Sleep deprivation\20201027_EEGFP_1_307_2_319' 'J:\CTN\NedergaardLAB\Personal_folders\Celia Kjaerby\FP\20200721 NE Sleep deprivation\20201027_EEGFP_1_307_2_319\307_sleep\307_sleep_2020-10-27_12-00-20-260.exp' 'x465A' 'x405A' 'red' 'x465C' 'x405C' 'red' 'PtC0' 'x' 'x' 'x' 'x' (1:10000) 'J:\CTN\NedergaardLAB\Personal_folders\Celia Kjaerby\FP\20200721 NE Sleep deprivation\20201027_EEGFP_1_307_2_319\307_sleep\20201027_307_control.xlsx'};
sd_307 = {'J:\CTN\NedergaardLAB\Personal_folders\Celia Kjaerby\FP\20200721 NE Sleep deprivation\20201028_EEGFP_1_307_2_319_SD' 'J:\CTN\NedergaardLAB\Personal_folders\Celia Kjaerby\FP\20200721 NE Sleep deprivation\20201028_EEGFP_1_307_2_319_SD\307_sleep\307_sleep_2020-10-28_12-09-46-265.exp' 'x465A' 'x405A' 'red' 'x465C' 'x405C' 'red' 'PtC0' 'x' 'x' 'x' 'x' (1:10000) 'J:\CTN\NedergaardLAB\Personal_folders\Celia Kjaerby\FP\20200721 NE Sleep deprivation\20201027_EEGFP_1_307_2_319\307_sleep\307_SD_sleepscore.xlsx'};

control_319 = {'J:\CTN\NedergaardLAB\Personal_folders\Celia Kjaerby\FP\20200721 NE Sleep deprivation\20201027_EEGFP_1_307_2_319' 'J:\CTN\NedergaardLAB\Personal_folders\Celia Kjaerby\FP\20200721 NE Sleep deprivation\20201027_EEGFP_1_307_2_319\319_sleep\319_sleep_2020-10-27_12-00-20-260.exp' 'x465A' 'x405A' 'red' 'x465C' 'x405C' 'red' 'PtC0' 'x' 'x' 'x' 'x' (1:10000) 'J:\CTN\NedergaardLAB\Personal_folders\Celia Kjaerby\FP\20200721 NE Sleep deprivation\220201027_EEGFP_1_307_2_319\319_sleep\319_sleep_sleepscore.xlsx'};
sd_319 = {'J:\CTN\NedergaardLAB\Personal_folders\Celia Kjaerby\FP\20200721 NE Sleep deprivation\20201028_EEGFP_1_307_2_319_SD' 'J:\CTN\NedergaardLAB\Personal_folders\Celia Kjaerby\FP\20200721 NE Sleep deprivation\20201027_EEGFP_1_307_2_319\319_sleep\319_sleep_2020-10-28_12-09-46-265.exp' 'x465A' 'x405A' 'red' 'x465C' 'x405C' 'red' 'PtC0' 'x' 'x' 'x' 'x' (1:10000) 'J:\CTN\NedergaardLAB\Personal_folders\Celia Kjaerby\FP\20200721 NE Sleep deprivation\220201027_EEGFP_1_307_2_319\319_sleep\319_SD_sleepscore.xlsx'};

control_323 = {'J:\CTN\NedergaardLAB\Personal_folders\Celia Kjaerby\FP\20200721 NE Sleep deprivation\20201029_EEGFP_1_323_2_331_sl' 'J:\CTN\NedergaardLAB\Personal_folders\Celia Kjaerby\FP\20200721 NE Sleep deprivation\20201030_1_323_2_331_SD\323_sleep\323_sleep_2020-10-29_11-59-00-080.exp' 'x465A' 'x405A' 'red' 'x465C' 'x405C' 'red' 'PtC0' 'x' 'x' 'x' 'x' (1:10000) 'J:\CTN\NedergaardLAB\Personal_folders\Celia Kjaerby\FP\20200721 NE Sleep deprivation\20201030_1_323_2_331_SD\323_sleep\323_sleep_sleepscore.xlsx'};
sd_323 = {'J:\CTN\NedergaardLAB\Personal_folders\Celia Kjaerby\FP\20200721 NE Sleep deprivation\20201030_1_323_2_331_SD' 'J:\CTN\NedergaardLAB\Personal_folders\Celia Kjaerby\FP\20200721 NE Sleep deprivation\20201030_1_323_2_331_SD\323_sleep\323_sleep_2020-10-30_12-06-33-205.exp' 'x465A' 'x405A' 'red' 'x465C' 'x405C' 'red' 'PtC0' 'x' 'x' 'x' 'x' (1:10000) 'J:\CTN\NedergaardLAB\Personal_folders\Celia Kjaerby\FP\20200721 NE Sleep deprivation\20201030_1_323_2_331_SD\323_sleep\323_SD_sleepscore.xlsx'};

control_331 = {'J:\CTN\NedergaardLAB\Personal_folders\Celia Kjaerby\FP\20200721 NE Sleep deprivation\20201102_EEGFP_2_331_sleep' 'J:\CTN\NedergaardLAB\Personal_folders\Celia Kjaerby\FP\20200721 NE Sleep deprivation\20201030_1_323_2_331_SD\331_sleep\331_sleep_2020-11-02_12-12-10-254.exp' 'x465A' 'x405A' 'red' 'x465C' 'x405C' 'red' 'PtC0' 'x' 'x' 'x' 'x' (1:10000) 'J:\CTN\NedergaardLAB\Personal_folders\Celia Kjaerby\FP\20200721 NE Sleep deprivation\20201030_1_323_2_331_SD\331_sleep\331_sleep_sleepscore.xlsx'};
sd_331 = {'J:\CTN\NedergaardLAB\Personal_folders\Celia Kjaerby\FP\20200721 NE Sleep deprivation\20201030_1_323_2_331_SD' 'J:\CTN\NedergaardLAB\Personal_folders\Celia Kjaerby\FP\20200721 NE Sleep deprivation\20201030_1_323_2_331_SD\331_sleep\331_sleep_2020-10-30_12-06-33-205.exp' 'x465A' 'x405A' 'red' 'x465C' 'x405C' 'red' 'PtC0' 'x' 'x' 'x' 'x' (1:10000) 'J:\CTN\NedergaardLAB\Personal_folders\Celia Kjaerby\FP\20200721 NE Sleep deprivation\20201030_1_323_2_331_SD\331_sleep\331_SD_sleepscore.xlsx'};

mouse_ct = control_307;
mouse_sd = sd_307;

data_FPrig_ct = data_FPrig_ct_307;
data_FPrig_sd = data_FPrig_sd_307;

%% load data

data_FPrig = TDTbin2mat(mouse_sd{1}); % FP rig 

%% Change to save data_FP rig
%data_FPrig_ct_307 = data_FPrig
data_FPrig_sd_307 = data_FPrig

%data_FPrig_ct_319 = data_FPrig
%data_FPrig_sd_319 = data_FPrig
%data_FPrig_ct_323 = data_FPrig
%data_FPrig_sd_323 = data_FPrig
%data_FPrig_ct_331 = data_FPrig
%data_FPrig_sd_331 = data_FPrig

%% PROCESS CONTROL DATA

%% extract channels

signal_fs_ct = data_FPrig_ct.streams.(mouse_ct{3}).fs; % sampling frequency for fiber photometry signal
signal_465_1_ct = data_FPrig_ct.streams.(mouse_ct{3}).data; %signal for NE in thalamus
signal_405_1_ct = data_FPrig_ct.streams.(mouse_ct{4}).data; %isosbetstic control
%signal_560_FPrig = data_FPrig_ct.streams.(mouse_ct{5}).data; %red signal

signal_465_2_ct = data_FPrig_ct.streams.(mouse_ct{6}).data; %signal for calcium in LC
signal_405_2_ct = data_FPrig_ct.streams.(mouse_ct{7}).data; %isosbetstic control
%signal_560_FPrig = data_FPrig_ct.streams.(mouse_ct{8}).data; %red signal
%% remove period before TTL pulse

% TTL pusle for FP
TTL_FP = data_FPrig_ct.epocs.(mouse_ct{9}).onset;
first_TTL = TTL_FP(1)*signal_fs_ct;
onset_FP_ct = first_TTL;
if first_TTL<1
    onset_FP_ct = 1;
end


signal_465_1_ct = signal_465_1_ct(onset_FP_ct:end);
signal_405_1_ct = signal_405_1_ct(onset_FP_ct:end);

signal_465_2_ct = signal_465_2_ct(onset_FP_ct:end);
signal_405_2_ct = signal_405_2_ct(onset_FP_ct:end);

%% time signal

fs_signal_1 = 1:1:length(signal_465_1_ct);
sec_signal_1_ct = fs_signal_1/signal_fs_ct; % time vector for fiber photometry signal

fs_signal_2 = 1:1:length(signal_465_2_ct);
sec_signal_2_ct = fs_signal_2/signal_fs_ct; % time vector for fiber photometry signal


%% Normalize
% Here the fluorescence traces are normalised based on a fit of the 405 nm
% channel. This should remove the drift in the 465 nm channel. make sure to
% check the fit in the plot and adjust fitting interval if the fit is not
% working properly.

MeanFilterOrder = 1000; % for smoothing
MeanFilter = ones(MeanFilterOrder,1)/MeanFilterOrder;

MeanFilterOrder1 = 5000; % for smoothing
MeanFilter1 = ones(MeanFilterOrder1,1)/MeanFilterOrder1;

reg = polyfit_R2020a(signal_405_1_ct(round(mouse_ct{14}*signal_fs_ct)), signal_465_1_ct(round(mouse_ct{14}*signal_fs_ct)), 1);
a = reg(1);
b = reg(2);
controlFit_465 = a.*signal_405_1_ct + b;
controlFit_465 =  filtfilt(MeanFilter,1,double(controlFit_465));
normDat = (signal_465_1_ct - controlFit_465)./controlFit_465;
delta_465_1 = normDat * 100;

% smoothing traces
delta465_filt_1_ct = filtfilt(MeanFilter,1,double(delta_465_1));
delta465_filt_1_ct = detrend(delta465_filt_1_ct);
ds_factor_FP = 100; % also used for plotting later (section 9b)

% downsampling traces for plotting
ds_delta465_filt_1_ct = downsample(delta465_filt_1_ct, ds_factor_FP);
ds_sec_signal_1_ct = downsample(sec_signal_1_ct, ds_factor_FP); % for plotting

reg2 = polyfit_R2020a(signal_405_2_ct(round(mouse_ct{14}*signal_fs_ct)), signal_465_2_ct(round(mouse_ct{14}*signal_fs_ct)), 1);
a2 = reg2(1);
b2 = reg2(2);
controlFit_465_2 = a2.*signal_405_2_ct + b2;
controlFit_465_2 =  filtfilt(MeanFilter,1,double(controlFit_465_2));
normDat_2 = (signal_465_2_ct - controlFit_465_2)./controlFit_465_2;
delta_465_2 = normDat_2 * 100;

% smoothing traces
delta465_filt_2_ct = filtfilt(MeanFilter,1,double(delta_465_2));
ds_factor_FP = 100; % also used for plotting later (section 9b)

% downsampling traces for plotting
ds_delta465_filt_2_ct = downsample(delta465_filt_2_ct, ds_factor_FP);
ds_sec_signal_2_ct = downsample(sec_signal_2_ct, ds_factor_FP); % for plotting

% Z-score
delta465_Zscore_1_ct = (delta465_filt_1_ct-mean(delta465_filt_1_ct))/std(delta465_filt_1_ct);
delta465_Zscore_2_ct = (delta465_filt_2_ct-mean(delta465_filt_2_ct))/std(delta465_filt_2_ct);
% 
%% Plot FP traces
figure;

subplot(2,1,1);
plot(ds_sec_signal_2_ct, ds_delta465_filt_2_ct); 
title('Signal 2 - LC calcium');

subplot(2,1,2);
plot(ds_sec_signal_1_ct, ds_delta465_filt_1_ct); 
title('Signal 1 - Thalamus NE');

sgtitle('Control');


%% loading and plotting EEG and EMG raw data
% Here you load the EEG and MEG raw data from the specified .exp file
% Make sure the "ExpToolbox" is added to the matlab path

% Add functions to path
addpath(genpath('J:\CTN\NedergaardLAB\Personal_folders\Mie\EEG data from NH\EEG toolbox'));

% Import EEG raw data to matlab
ViewpointData.FileInfo=loadEXP([mouse_ct{2}],'no'); %          <<<<<< mouse_ct{2} should contain the file path to your .exp file. Make sure to update the index according to your mouse structure.

TimeReldebSec=0; %start extract data from the beginning (first bin)
%TimeRelEndSec=inf; %inf to include data until last bin
TimeRelEndSec=ViewpointData.FileInfo.BinFiles.Duration; %to include all data (also last time bin even if incomplete)

[Data_ct,Time]=ExtractContinuousData([],ViewpointData.FileInfo,[],TimeReldebSec, TimeRelEndSec,[],1);

EMG_rawtrace_ct = Data_ct(1,1:end);
EEG_rawtrace_ct = Data_ct(2,1:end);

%time vector using sampling frequency
sampling_freq_ct = ViewpointData.FileInfo.Fs;
EEG_time_ct = (0:length(EMG_rawtrace_ct)-1)/sampling_freq_ct;

%% load EEG scoring
% Here you load you sleepscore saved in the .H file located in the same
% folder as you .exp file. The scoring should automatically be aligend to
% the raw EE/´G/EMG traces with the time_corerection - so no need to do
% manual alignment.

% loads hypno, ViewpointData needs to be a struct - see above
[FullHypno,TimeScaleAbs,TimeScaleBin,TimeScaleHypno]=ExtractFullHypno(ViewpointData,1);

FullHypno = FullHypno(find(FullHypno~=0,1):end);
time_correction = round(TimeScaleBin(1));
int_sig = zeros(1,time_correction);

wake_binary_vector_ct = [int_sig FullHypno==1];
sws_binary_vector_ct = [int_sig FullHypno==2];
REM_binary_vector_ct = [int_sig FullHypno==4];

[wake_onset_ct, wake_offset_ct] = binary_to_OnOff(wake_binary_vector_ct);
[sws_onset_ct, sws_offset_ct] = binary_to_OnOff(sws_binary_vector_ct);
[REM_onset_ct, REM_offset_ct] = binary_to_OnOff(REM_binary_vector_ct);

wake_duration_ct = wake_offset_ct-wake_onset_ct;
duration_ct_sws = sws_offset_ct-sws_onset_ct;
REM_duration_ct = REM_offset_ct-REM_onset_ct;

sleepscore_time = [TimeScaleHypno TimeScaleHypno(end)+1:1:TimeScaleHypno(end)+time_correction];

% fig = figure;
% a = subplot(2,1,1);
%     plot_sleep(EEG_time_ct, EMG_rawtrace_ct, sleepscore_time, wake_binary_vector_ct, sws_binary_vector_ct, REM_binary_vector_ct);
%     xlabel('time (s)');
%     ylabel('EMG (V)');
% b = subplot(2,1,2);
%     plot_sleep(EEG_time_ct, EEG_rawtrace_ct, sleepscore_time, wake_binary_vector_ct, sws_binary_vector_ct, REM_binary_vector_ct);
%     xlabel('time (s)');
%     ylabel('EEG (V)');
% linkaxes([a,b],'x');
% 
% h = datacursormode(fig);
%     h.UpdateFcn = @DataCursor_custom;
%     h.SnapToDataVertex = 'on';
%     datacursormode on

% 2-column vectors with on- and offsets for each state
wake_periods_ct = [wake_onset_ct wake_onset_ct+wake_duration_ct];
sws_periods_ct = [sws_onset_ct sws_onset_ct+duration_ct_sws];
REM_periods_ct = [REM_onset_ct REM_onset_ct+REM_duration_ct];


%% Dividing wake bouts into microarousals (MA) and wake w/o MA
% Here scored wake bouts with duration below 15 s are redefined as
% micro-arousals (MA). From here on wake bouts excl. MAs are named
% wake_woMA

MA_maxdur = 15; % maximum duration of microarrousal
MA_idx = find(wake_duration_ct < MA_maxdur);
MA_onset_ct = wake_onset_ct(MA_idx);
MA_duration_ct = wake_duration_ct(MA_idx);
MA_binary_vector_ct = zeros([1, (sum([ViewpointData.FileInfo.HypnoFiles.Duration]))]);
%MA_binary_vector_ct = zeros([1, (sum([ViewpointData.FileInfo.HypnoFiles.Duration]))+time_correction]);
for i=1:length(MA_onset_ct) % making time vector for EEG scoring (frequency = 1Hz)
    t = MA_onset_ct(i)+1;
    d = MA_duration_ct(i)-1;
    MA_binary_vector_ct(t:t+d) = 1;
end

% remove micrarrousal from wake vectors
wake_woMA_onset_ct = wake_onset_ct;
wake_woMA_onset_ct(MA_idx) = [];
wake_woMA_duration_ct = wake_duration_ct;
wake_woMA_duration_ct(MA_idx) = [];
wake_woMA_binary_vector_ct = zeros([1, (sum([ViewpointData.FileInfo.HypnoFiles.Duration]))+time_correction]);
for i=1:length(wake_woMA_onset_ct) % making time vector for EEG scoring (frequency = 1Hz)
    t = wake_woMA_onset_ct(i)+1;
    d = wake_woMA_duration_ct(i)-1;
    wake_woMA_binary_vector_ct(t:t+d) = 1;
end

% 2-column vectors with on- and offsets for each state
MA_periods_ct_ct = [MA_onset_ct MA_onset_ct+MA_duration_ct];
wake_woMA_periods_ct = [wake_woMA_onset_ct wake_woMA_onset_ct+wake_woMA_duration_ct];


%%  Alingment of EEG recording and FP recording
% Here you align EEG and EMG traces + sleep scoring according the the first
% TTL pulse from the fiber photometry setup. Data prior to the first TTL
% pulse will be removed, thus all aligned vectors are named with the suffix
% '_cut'

% TTL pulse from FP
TTL_pulse = Data_ct(3,1:end); % 3 indicates the 3rd channel in which TTL pulses are stored
onset_EEG = find(diff(TTL_pulse>1*10^-3));
onset_EEG_time = onset_EEG/sampling_freq_ct;
onset_EEG_time_diff = diff(onset_EEG_time);

TTL_gap_EEG = onset_EEG_time_diff > 6; % as standard TTL pulses are spaced 
if isempty(find(TTL_gap_EEG==1, 1))
    onset_EEG = onset_EEG(1);
else 
    onset_EEG = onset_EEG(find(onset_EEG_time_diff>5)+1);
end

TTL_EEG_onset_ct = onset_EEG/sampling_freq_ct+time_correction;

%Cutting EEG/EMG traces leading up to first TTL 
% Removing first seconds of EEG and EMG raw traces to align with FP trace
EMG_rawtrace_ct_cut = EMG_rawtrace_ct(round(TTL_EEG_onset_ct*sampling_freq_ct):end);
EEG_rawtrace_ct_cut = EEG_rawtrace_ct(round(TTL_EEG_onset_ct*sampling_freq_ct):end);
EEG_time_ct_cut = (1:length(EEG_rawtrace_ct_cut))/sampling_freq_ct;

% Remove first seconds of EEG score to align with FP trace
wake_binary_vector_ct_cut = wake_binary_vector_ct(round(TTL_EEG_onset_ct+1):end);
sws_binary_vector_ct_cut = sws_binary_vector_ct(round(TTL_EEG_onset_ct+1):end);
REM_binary_vector_ct_cut = REM_binary_vector_ct(round(TTL_EEG_onset_ct+1):end);

% Align onset, offset, and duration vectors based on TTL
[wake_onset_ct_cut, wake_offset_ct_cut] = binary_to_OnOff(wake_binary_vector_ct_cut);
wake_duration_ct_cut = wake_offset_ct_cut - wake_onset_ct_cut;

[sws_onset_ct_cut, sws_offset_ct_cut] = binary_to_OnOff(sws_binary_vector_ct_cut);
sws_duration_ct_cut = sws_offset_ct_cut - sws_onset_ct_cut;

[REM_onset_ct_cut, REM_offset_ct_cut] = binary_to_OnOff(REM_binary_vector_ct_cut);
REM_duration_ct_cut = REM_offset_ct_cut - REM_onset_ct_cut;


% Align period arrays according to TTL
wake_periods_ct_cut = [wake_onset_ct_cut wake_offset_ct_cut];
sws_periods_ct_cut = [sws_onset_ct_cut sws_offset_ct_cut];
REM_periods_ct_cut = [REM_onset_ct_cut REM_offset_ct_cut];

% Time vector for sleep scoring (1 Hz)
sleepscore_time_cut = 0:length(wake_binary_vector_ct_cut)-1; % should be same length for wake/sws/REM

% Alingment of MA vectors

% Remove first seconds of EEG score to align with FP trace
MA_binary_vector_ct_cut = MA_binary_vector_ct(round(TTL_EEG_onset_ct+1):end);
wake_woMA_binary_vector_ct_cut = wake_woMA_binary_vector_ct(round(TTL_EEG_onset_ct):end);

% Align onset, offset, and duration vectors based on TTL
[MA_onset_ct_cut, MA_offset_ct_cut] = binary_to_OnOff(MA_binary_vector_ct_cut);
MA_duration_ct_cut = MA_offset_ct_cut - MA_onset_ct_cut;

[wake_woMA_onset_ct_cut, wake_woMA_offset_ct_cut] = binary_to_OnOff(wake_woMA_binary_vector_ct_cut);
wake_woMA_duration_ct_cut = wake_woMA_offset_ct_cut - wake_woMA_onset_ct_cut;

MA_periods_ct_cut = [MA_onset_ct_cut MA_offset_ct_cut];
wake_woMA_periods_ct_cut = [wake_woMA_onset_ct_cut wake_woMA_offset_ct_cut];


%% Re-classify MA as NREM using boutscore_vector
% Here you can pool MAs with NREM sleep which can be beneficial for some
% analyses related to infraslow oscillations (eg. PSD analysis), where you
% don't want to divide your traces into short/pure NREM bouts

%State transitions (uncut vectors)
% Creating one vector with different behaviors represented by unique
% numbers (1=wake, 4=sws, 9=REM, 15=MA) at frequency 1Hz
boutscore_vector = zeros([1, (ViewpointData.FileInfo.HypnoFiles.Duration)+time_correction]);

% Here using the unaligned "uncut" vectors
for i=1:length(wake_woMA_onset_ct)
    t = wake_woMA_onset_ct(i)+1;
    d = wake_woMA_duration_ct(i)-1;
    boutscore_vector(t:t+d) = 1; % wake=1
end

for i=1:length(sws_onset_ct)
    t = sws_onset_ct(i)+1;
    d = duration_ct_sws(i)-1;
    boutscore_vector(t:t+d) = 4; % sws=4
end

if ~isnan(REM_onset_ct)
    for i=1:length(REM_onset_ct)
        t = REM_onset_ct(i)+1;
        d = REM_duration_ct(i)-1;
        boutscore_vector(t:t+d) = 9; %REM=9
    end
end

for i=1:length(MA_onset_ct)
    t = MA_onset_ct(i)+1;
    d = MA_duration_ct(i)-1;
    boutscore_vector(t:t+d) = 15; %MA=15
end

% re-classify MA as NREM
NREMinclMA_binary_vector_ct = boutscore_vector==4 | boutscore_vector==15;
NREMinclMA_binary_vector_ct_cut = NREMinclMA_binary_vector_ct(round(TTL_EEG_onset_ct+1):end);
[NREMinclMA_onset_ct_cut, NREMinclMA_offset_ct_cut] = binary_to_OnOff(NREMinclMA_binary_vector_ct_cut);
NREMinclMA_duration_ct_cut = NREMinclMA_offset_ct_cut-NREMinclMA_onset_ct_cut;
NREMinclMA_periods_ct_cut = [NREMinclMA_onset_ct_cut NREMinclMA_offset_ct_cut];
%% Plotting all traces and scorings together
% plot EEG data and scoring together with FP data

% Time vector for sleep scoring (1 Hz)
sleepscore_time_cut = 0:length(wake_binary_vector_ct_cut)-1; % should be same length for wake/sws/REM

fig = figure;
a = subplot(4,1,1);
    plot_sleep(ds_sec_signal_1_ct, ds_delta465_filt_1_ct, sleepscore_time_cut, wake_woMA_binary_vector_ct_cut, sws_binary_vector_ct_cut, REM_binary_vector_ct_cut, MA_binary_vector_ct_cut);
    title('NE thalamus');
b = subplot(4,1,2);
    plot_sleep(ds_sec_signal_2_ct, ds_delta465_filt_2_ct, sleepscore_time_cut, wake_woMA_binary_vector_ct_cut, sws_binary_vector_ct_cut, REM_binary_vector_ct_cut, MA_binary_vector_ct_cut);
    title('Calcium LC');
c = subplot(4,1,3);
    ds_EEG_rawtrace_ct = downsample(EEG_rawtrace_ct_cut, 10);
    plot_sleep(ds_EEG_time_ct, ds_EEG_rawtrace_ct, sleepscore_time_cut, wake_woMA_binary_vector_ct_cut, sws_binary_vector_ct_cut, REM_binary_vector_ct_cut, MA_binary_vector_ct_cut);
    xlabel('time (s)');
    ylabel('EEG (V)');
d = subplot(4,1,4);
    ds_EEG_time_ct = downsample(EEG_time_ct_cut, 10);
    ds_EMG_rawtrace_ct = downsample(EMG_rawtrace_ct_cut, 10);
    plot_sleep(ds_EEG_time_ct, ds_EMG_rawtrace_ct, sleepscore_time_cut, wake_woMA_binary_vector_ct_cut, sws_binary_vector_ct_cut, REM_binary_vector_ct_cut, MA_binary_vector_ct_cut);
    xlabel('time (s)');
    ylabel('EMG (V)');

linkaxes([a,b,c, d],'x');
%% PROCESS SLEEP DEPRIVED DATA

%% extract channels

signal_fs_sd = data_FPrig_sd.streams.(mouse_sd{3}).fs; % sampling frequency for fiber photometry signal
signal_465_1_sd = data_FPrig_sd.streams.(mouse_sd{3}).data; %signal
signal_405_1_sd = data_FPrig_sd.streams.(mouse_sd{4}).data; %isosbetstic control
%signal_560_FPrig = data_FPrig_sd.streams.(mouse_sd{5}).data; %red signal

signal_465_2_sd = data_FPrig_sd.streams.(mouse_sd{6}).data; %signal
signal_405_2_sd = data_FPrig_sd.streams.(mouse_sd{7}).data; %isosbetstic control
%signal_560_FPrig = data_FPrig_sd.streams.(mouse_sd{8}).data; %red signal
%% remove period before TTL pulse

% TTL pusle for FP
TTL_FP = data_FPrig_sd.epocs.(mouse_sd{9}).onset;
first_TTL = TTL_FP(1)*signal_fs_sd;
onset_FP_sd = first_TTL;
if first_TTL<1
    onset_FP_sd = 1;
end


signal_465_1_sd = signal_465_1_sd(onset_FP_sd:end);
signal_405_1_sd = signal_405_1_sd(onset_FP_sd:end);

signal_465_2_sd = signal_465_2_sd(onset_FP_sd:end);
signal_405_2_sd = signal_405_2_sd(onset_FP_sd:end);



%% time signal

fs_signal_1 = 1:1:length(signal_465_1_sd);
sec_signal_1_sd = fs_signal_1/signal_fs_sd; % time vector for fiber photometry signal

fs_signal_2 = 1:1:length(signal_465_2_sd);
sec_signal_2_sd = fs_signal_2/signal_fs_sd; % time vector for fiber photometry signal


%% Normalize
% Here the fluorescence traces are normalised based on a fit of the 405 nm
% channel. This should remove the drift in the 465 nm channel. make sure to
% check the fit in the plot and adjust fitting interval if the fit is not
% working properly.

MeanFilterOrder = 1000; % for smoothing
MeanFilter = ones(MeanFilterOrder,1)/MeanFilterOrder;

MeanFilterOrder1 = 5000; % for smoothing
MeanFilter1 = ones(MeanFilterOrder1,1)/MeanFilterOrder1;

reg = polyfit_R2020a(signal_405_1_sd(round(mouse_sd{14}*signal_fs_sd)), signal_465_1_sd(round(mouse_sd{14}*signal_fs_sd)), 1);
a = reg(1);
b = reg(2);
controlFit_465 = a.*signal_405_1_sd + b;
controlFit_465 =  filtfilt(MeanFilter,1,double(controlFit_465));
normDat = (signal_465_1_sd - controlFit_465)./controlFit_465;
delta_465_1 = normDat * 100;

% smoothing traces
delta465_filt_1_sd = filtfilt(MeanFilter1,1,double(delta_465_1));
delta465_filt_1_sd = detrend(delta465_filt_1_sd);
ds_factor_FP = 100; % also used for plotting later (section 9b)

% downsampling traces for plotting
ds_delta465_filt_1_sd = downsample(delta465_filt_1_sd, ds_factor_FP);
ds_sec_signal_1_sd = downsample(sec_signal_1_sd, ds_factor_FP); % for plotting

reg2 = polyfit_R2020a(signal_405_2_sd(round(mouse_sd{14}*signal_fs_sd)), signal_465_2_sd(round(mouse_sd{14}*signal_fs_sd)), 1);
a2 = reg2(1);
b2 = reg2(2);
controlFit_465_2 = a2.*signal_405_2_sd + b2;
controlFit_465_2 =  filtfilt(MeanFilter,1,double(controlFit_465_2));
normDat_2 = (signal_465_2_sd - controlFit_465_2)./controlFit_465_2;
delta_465_2 = normDat_2 * 100;

% smoothing traces
delta465_filt_2_sd = filtfilt(MeanFilter,1,double(delta_465_2));
ds_factor_FP = 100; % also used for plotting later (section 9b)

% downsampling traces for plotting
ds_delta465_filt_2_sd = downsample(delta465_filt_2_sd, ds_factor_FP);
ds_sec_signal_2_sd = downsample(sec_signal_2_sd, ds_factor_FP); % for plotting

% Z-score
delta465_Zscore_1_sd = (delta465_filt_1_sd-mean(delta465_filt_1_sd))/std(delta465_filt_1_sd);
delta465_Zscore_2_sd = (delta465_filt_2_sd-mean(delta465_filt_2_sd))/std(delta465_filt_2_sd);
% 
%% 
figure;

subplot(2,1,1);
plot(ds_sec_signal_2_sd, ds_delta465_filt_2_sd); 
title('Signal 2 - LC calcium');

subplot(2,1,2);
plot(ds_sec_signal_1_sd, ds_delta465_filt_1_sd); 
title('Signal 1 - Thalamus NE');

sgtitle('Mouse 331 Sleep Deprived');


%% loading and plotting EEG and EMG raw data
% Here you load the EEG and MEG raw data from the specified .exp file
% Make sure the "ExpToolbox" is added to the matlab path

% Add functions to path
addpath(genpath(['J:\CTN\NedergaardLAB\Personal_folders\Mie\EEG data from NH\EEG toolbox']));

% Import EEG raw data to matlab
ViewpointData.FileInfo=loadEXP([mouse_sd{2}],'no'); %          <<<<<< mouse_sd{2} should contain the file path to your .exp file. Make sure to update the index according to your mouse structure.

TimeReldebSec=0; %start extract data from the beginning (first bin)
%TimeRelEndSec=inf; %inf to include data until last bin
TimeRelEndSec=ViewpointData.FileInfo.BinFiles.Duration; %to include all data (also last time bin even if incomplete)

[Data_sd,Time]=ExtractContinuousData([],ViewpointData.FileInfo,[],TimeReldebSec, TimeRelEndSec,[],1);

EMG_rawtrace_sd = Data_sd(1,1:end);
EEG_rawtrace_sd = Data_sd(2,1:end);

%time vector using sampling frequency
sampling_freq_sd = ViewpointData.FileInfo.Fs;
EEG_time_sd = (0:length(EMG_rawtrace_sd)-1)/sampling_freq_sd;

%% load EEG scoring
% Here you load you sleepscore saved in the .H file located in the same
% folder as you .exp file. The scoring should automatically be aligend to
% the raw EE/´G/EMG traces with the time_corerection - so no need to do
% manual alignment.

% loads hypno, ViewpointData needs to be a struct - see above
[FullHypno,TimeScaleAbs,TimeScaleBin,TimeScaleHypno]=ExtractFullHypno(ViewpointData,1);

FullHypno = FullHypno(find(FullHypno~=0,1):end);
time_correction = round(TimeScaleBin(1));
int_sig = zeros(1,time_correction);

wake_binary_vector_sd = [int_sig FullHypno==1];
sws_binary_vector_sd = [int_sig FullHypno==2];
REM_binary_vector_sd = [int_sig FullHypno==4];

[wake_onset_sd, wake_offset_sd] = binary_to_OnOff(wake_binary_vector_sd);
[sws_onset_sd, sws_offset_sd] = binary_to_OnOff(sws_binary_vector_sd);
[REM_onset_sd, REM_offset_sd] = binary_to_OnOff(REM_binary_vector_sd);

wake_duration_sd = wake_offset_sd-wake_onset_sd;
duration_sd_sws = sws_offset_sd-sws_onset_sd;
REM_duration_sd = REM_offset_sd-REM_onset_sd;

sleepscore_time_sd = [TimeScaleHypno TimeScaleHypno(end)+1:1:TimeScaleHypno(end)+time_correction];

% fig = figure;
% a = subplot(2,1,1);
%     plot_sleep(EEG_time_sd, EMG_rawtrace_sd, sleepscore_time_sd, wake_binary_vector_sd, sws_binary_vector_sd, REM_binary_vector_sd);
%     xlabel('time (s)');
%     ylabel('EMG (V)');
% b = subplot(2,1,2);
%     plot_sleep(EEG_time_sd, EEG_rawtrace_sd, sleepscore_time_sd, wake_binary_vector_sd, sws_binary_vector_sd, REM_binary_vector_sd);
%     xlabel('time (s)');
%     ylabel('EEG (V)');
% linkaxes([a,b],'x');
% 
% h = datacursormode(fig);
%     h.UpdateFcn = @DataCursor_custom;
%     h.SnapToDataVertex = 'on';
%     datacursormode on

% 2-column vectors with on- and offsets for each state
wake_periods_sd = [wake_onset_sd wake_onset_sd+wake_duration_sd];
sws_periods_sd = [sws_onset_sd sws_onset_sd+duration_sd_sws];
REM_periods_sd = [REM_onset_sd REM_onset_sd+REM_duration_sd];


%% Dividing wake bouts into microarousals (MA) and wake w/o MA
% Here scored wake bouts with duration below 15 s are redefined as
% micro-arousals (MA). From here on wake bouts excl. MAs are named
% wake_woMA

MA_maxdur = 15; % maximum duration of microarrousal
MA_idx = find(wake_duration_sd < MA_maxdur);
MA_onset_sd = wake_onset_sd(MA_idx);
MA_duration_sd = wake_duration_sd(MA_idx);
MA_binary_vector_sd = zeros([1, (sum([ViewpointData.FileInfo.HypnoFiles.Duration]))+time_correction]);
for i=1:length(MA_onset_sd) % making time vector for EEG scoring (frequency = 1Hz)
    t = MA_onset_sd(i)+1;
    d = MA_duration_sd(i)-1;
    MA_binary_vector_sd(t:t+d) = 1;
end

% remove micrarrousal from wake vectors
wake_woMA_onset_sd = wake_onset_sd;
wake_woMA_onset_sd(MA_idx) = [];
wake_woMA_duration_sd = wake_duration_sd;
wake_woMA_duration_sd(MA_idx) = [];
wake_woMA_binary_vector_sd = zeros([1, (sum([ViewpointData.FileInfo.HypnoFiles.Duration]))+time_correction]);
for i=1:length(wake_woMA_onset_sd) % making time vector for EEG scoring (frequency = 1Hz)
    t = wake_woMA_onset_sd(i)+1;
    d = wake_woMA_duration_sd(i)-1;
    wake_woMA_binary_vector_sd(t:t+d) = 1;
end

% 2-column vectors with on- and offsets for each state
MA_periods_sd = [MA_onset_sd MA_onset_sd+MA_duration_sd];
wake_woMA_periods_sd = [wake_woMA_onset_sd wake_woMA_onset_sd+wake_woMA_duration_sd];


%%  Alingment of EEG recording and FP recording
% Here you align EEG and EMG traces + sleep scoring according the the first
% TTL pulse from the fiber photometry setup. Data prior to the first TTL
% pulse will be removed, thus all aligned vectors are named with the suffix
% '_cut'


% TTL pulse from FP
TTL_pulse = Data_sd(3,1:end); % 3 indicates the 3rd channel in which TTL pulses are stored
onset_EEG = find(diff(TTL_pulse>1*10^-3));
onset_EEG_time = onset_EEG/sampling_freq_sd;
onset_EEG_time_diff = diff(onset_EEG_time);

TTL_gap_EEG = onset_EEG_time_diff > 6; % as standard TTL pulses are spaced 
if isempty(find(TTL_gap_EEG==1, 1))
    onset_EEG = onset_EEG(1);
else 
    onset_EEG = onset_EEG(find(onset_EEG_time_diff>5)+1);
end

TTL_EEG_onset_sd = onset_EEG/sampling_freq_sd+time_correction;

%Cutting EEG/EMG traces leading up to first TTL 
% Removing first seconds of EEG and EMG raw traces to align with FP trace
EMG_rawtrace_sd_cut = EMG_rawtrace_sd(round(TTL_EEG_onset_sd*sampling_freq_sd):end);
EEG_rawtrace_sd_cut = EEG_rawtrace_sd(round(TTL_EEG_onset_sd*sampling_freq_sd):end);
EEG_time_sd_cut = (1:length(EEG_rawtrace_sd_cut))/sampling_freq_sd;

% Remove first seconds of EEG score to align with FP trace
wake_binary_vector_sd_cut = wake_binary_vector_sd(round(TTL_EEG_onset_sd+1):end);
sws_binary_vector_sd_cut = sws_binary_vector_sd(round(TTL_EEG_onset_sd+1):end);
REM_binary_vector_sd_cut = REM_binary_vector_sd(round(TTL_EEG_onset_sd+1):end);

% Align onset, offset, and duration vectors based on TTL
[wake_onset_sd_cut, wake_offset_sd_cut] = binary_to_OnOff(wake_binary_vector_sd_cut);
wake_duration_sd_cut = wake_offset_sd_cut - wake_onset_sd_cut;

[sws_onset_sd_cut, sws_offset_sd_cut] = binary_to_OnOff(sws_binary_vector_sd_cut);
sws_duration_sd_cut = sws_offset_sd_cut - sws_onset_sd_cut;

[REM_onset_sd_cut, REM_offset_sd_cut] = binary_to_OnOff(REM_binary_vector_sd_cut);
REM_duration_sd_cut = REM_offset_sd_cut - REM_onset_sd_cut;


% Align period arrays according to TTL
wake_periods_sd_cut = [wake_onset_sd_cut wake_offset_sd_cut];
sws_periods_sd_cut = [sws_onset_sd_cut sws_offset_sd_cut];
REM_periods_sd_cut = [REM_onset_sd_cut REM_offset_sd_cut];

% Time vector for sleep scoring (1 Hz)
sleepscore_time_sd_cut = 0:length(wake_binary_vector_sd_cut)-1; % should be same length for wake/sws/REM


% Alingment of MA vectors

% Remove first seconds of EEG score to align with FP trace
MA_binary_vector_sd_cut = MA_binary_vector_sd(round(TTL_EEG_onset_sd+1):end);
wake_woMA_binary_vector_sd_cut = wake_woMA_binary_vector_sd(round(TTL_EEG_onset_sd+1):end);

% Align onset, offset, and duration vectors based on TTL
[MA_onset_sd_cut, MA_offset_sd_cut] = binary_to_OnOff(MA_binary_vector_sd_cut);
MA_duration_sd_cut = MA_offset_sd_cut - MA_onset_sd_cut;

[wake_woMA_onset_sd_cut, wake_woMA_offset_sd_cut] = binary_to_OnOff(wake_woMA_binary_vector_sd_cut);
wake_woMA_duration_sd_cut = wake_woMA_offset_sd_cut - wake_woMA_onset_sd_cut;

MA_periods_sd_cut = [MA_onset_sd_cut MA_offset_sd_cut];
wake_woMA_periods_sd_cut = [wake_woMA_onset_sd_cut wake_woMA_offset_sd_cut];


%% Re-classify MA as NREM using boutscore_vector
% Here you can pool MAs with NREM sleep which can be beneficial for some
% analyses related to infraslow oscillations (eg. PSD analysis), where you
% don't want to divide your traces into short/pure NREM bouts

%State transitions (uncut vectors)
% Creating one vector with different behaviors represented by unique
% numbers (1=wake, 4=sws, 9=REM, 15=MA) at frequency 1Hz
boutscore_vector = zeros([1, (ViewpointData.FileInfo.HypnoFiles.Duration)+time_correction]);

% Here using the unaligned "uncut" vectors
for i=1:length(wake_woMA_onset_sd)
    t = wake_woMA_onset_sd(i)+1;
    d = wake_woMA_duration_sd(i)-1;
    boutscore_vector(t:t+d) = 1; % wake=1
end

for i=1:length(sws_onset_sd)
    t = sws_onset_sd(i)+1;
    d = duration_sd_sws(i)-1;
    boutscore_vector(t:t+d) = 4; % sws=4
end

if ~isnan(REM_onset_sd)
    for i=1:length(REM_onset_sd)
        t = REM_onset_sd(i)+1;
        d = REM_duration_sd(i)-1;
        boutscore_vector(t:t+d) = 9; %REM=9
    end
end

for i=1:length(MA_onset_sd)
    t = MA_onset_sd(i)+1;
    d = MA_duration_sd(i)-1;
    boutscore_vector(t:t+d) = 15; %MA=15
end

% re-classify MA as NREM
NREMinclMA_binary_vector_sd = boutscore_vector==4 | boutscore_vector==15;
NREMinclMA_binary_vector_sd_cut = NREMinclMA_binary_vector_sd(round(TTL_EEG_onset_sd+1):end);
[NREMinclMA_onset_sd_cut, NREMinclMA_offset_sd_cut] = binary_to_OnOff(NREMinclMA_binary_vector_sd_cut);
NREMinclMA_duration_sd_cut = NREMinclMA_offset_sd_cut-NREMinclMA_onset_sd_cut;
NREMinclMA_periods_sd_cut = [NREMinclMA_onset_sd_cut NREMinclMA_offset_sd_cut];
%% Plotting all traces and scorings together
% plot EEG data and scoring together with FP data

% Time vector for sleep scoring (1 Hz)
sleepscore_time_sd_cut = 0:length(wake_binary_vector_sd_cut)-1; % should be same length for wake/sws/REM

fig = figure;
a = subplot(4,1,1);
    plot_sleep(ds_sec_signal_1_sd, ds_delta465_filt_1_sd, sleepscore_time_sd_cut, wake_woMA_binary_vector_sd_cut, sws_binary_vector_sd_cut, REM_binary_vector_sd_cut, MA_binary_vector_sd_cut);
    title('NE Thalamus');
b = subplot(4,1,2);
    plot_sleep(ds_sec_signal_2_sd, ds_delta465_filt_2_sd, sleepscore_time_sd_cut, wake_woMA_binary_vector_sd_cut, sws_binary_vector_sd_cut, REM_binary_vector_sd_cut, MA_binary_vector_sd_cut);
    title('Calcium LC');
c = subplot(4,1,3);
    ds_EEG_time_sd = downsample(EEG_time_sd_cut, 10);
    ds_EEG_rawtrace_sd = downsample(EEG_rawtrace_sd_cut, 10);
    plot_sleep(ds_EEG_time_sd, ds_EEG_rawtrace_sd, sleepscore_time_sd_cut, wake_woMA_binary_vector_sd_cut, sws_binary_vector_sd_cut, REM_binary_vector_sd_cut, MA_binary_vector_sd_cut);
    xlabel('time (s)');
    ylabel('EEG (V)');
linkaxes([a,b,c],'x');
d = subplot(4,1,4);
    ds_EMG_rawtrace_sd = downsample(EMG_rawtrace_sd_cut, 10);
    plot_sleep(ds_EEG_time_sd, ds_EMG_rawtrace_sd, sleepscore_time_sd_cut, wake_woMA_binary_vector_sd_cut, sws_binary_vector_sd_cut, REM_binary_vector_sd_cut, MA_binary_vector_sd_cut);
    xlabel('time (s)');
    ylabel('EMG (V)');


