function [delta465_filt_2, sec_signal_2, signal_fs, EEG, EMG, sec_signal_EEG, EEG_fs, TTL_EEG_onset, Data] = processSignals_Viewpoint_with_TTL(mouse, data_FPrig)
    addpath(genpath(['J:\CTN\NedergaardLAB\Personal_folders\Mie\EEG data from NH\EEG toolbox']));
    ViewpointData.FileInfo=loadEXP([mouse{2}],'no');
    TimeReldebSec=0; %start extract data from the beginning (first bin)
    %TimeRelEndSec=inf; %inf to include data until last bin
    TimeRelEndSec=ViewpointData.FileInfo.BinFiles.Duration; %to include all data (also last time bin even if incomplete)

    [Data,Time]=ExtractContinuousData([],ViewpointData.FileInfo,[],TimeReldebSec, TimeRelEndSec,[],1);
    EMG_raw = Data(1,1:end);
    EEG_raw = Data(2,1:end);
    
    %time vector using sampling frequency
    EEG_fs = ViewpointData.FileInfo.Fs;

    TTL_pulse = Data(3,1:end); % 3 indicates the 3rd channel in which TTL pulses are stored
    onset_EEG = find(diff(TTL_pulse>1*10^-3));
    onset_EEG_time = onset_EEG/EEG_fs;
    onset_EEG_time_diff = diff(onset_EEG_time);
    
    TTL_gap_EEG = onset_EEG_time_diff > 6; % as standard TTL pulses are spaced 
    if isempty(find(TTL_gap_EEG==1, 1))
        onset_EEG = onset_EEG(1);
    else 
        onset_EEG = onset_EEG(find(onset_EEG_time_diff>5)+1);
    end
    
    TTL_EEG_onset = onset_EEG/EEG_fs;
    % this used to be added to the line above: +mouse{4}; %mouse{4} has the time correction
    
    %Cutting EEG/EMG traces leading up to first TTL 
    % Removing first seconds of EEG and EMG raw traces to align with FP trace
    EMG = EMG_raw(round(TTL_EEG_onset*EEG_fs):end);
    EEG = EEG_raw(round(TTL_EEG_onset*EEG_fs):end);
    sec_signal_EEG = (1:length(EMG))/EEG_fs;

    % Extract signals
    signal_fs = data_FPrig.streams.(mouse{6}).fs; % sampling frequency for fiber photometry signal
    signal_465_2 = data_FPrig.streams.(mouse{6}).data; %signal
    signal_405_2 = data_FPrig.streams.(mouse{7}).data; %isosbestic control

    % Remove period before TTL pulse
    % For FP
    TTL_FP = data_FPrig.epocs.(mouse{12}).onset;
    first_TTL = TTL_FP(1)*signal_fs;
    %onset_FP = max(first_TTL, 1);

    signal_465_2 = signal_465_2(round(first_TTL):end);
    signal_405_2 = signal_405_2(round(first_TTL):end);

    % Time signal
    fs_signal_2 = 1:length(signal_465_2);
    sec_signal_2 = fs_signal_2/signal_fs; % time vector for fiber photometry signal

    fs_signal_EEG = 1:length(EEG);
    sec_signal_EEG = fs_signal_EEG/EEG_fs; % time vector for EEG signal

    % Normalize fluorescence traces
    MeanFilterOrder = 1000; % for smoothing
    MeanFilter = ones(MeanFilterOrder,1)/MeanFilterOrder;

    reg2 = polyfit_R2020a(signal_405_2, signal_465_2, 1);
    a2 = reg2(1);
    b2 = reg2(2);
    controlFit_465_2 = a2.*signal_405_2 + b2;
    controlFit_465_2 =  filtfilt(MeanFilter,1,double(controlFit_465_2));
    normDat_2 = (signal_465_2 - controlFit_465_2)./controlFit_465_2;
    delta_465_2 = normDat_2 * 100;

    % Smoothing traces
    delta465_filt_2 = filtfilt(MeanFilter,1,double(delta_465_2));

    figure
    sgtitle(sprintf('Delta465 Filt 2 - Mouse %s', mouse{3}));
    a = subplot(4,1,1);
    plot(sec_signal_2, signal_405_2);
    title('raw control');
    b = subplot(4,1,2);
    plot(sec_signal_2, signal_465_2);
    title('raw signal');
    c = subplot(4,1,3);
    plot(sec_signal_2, signal_465_2);
    hold on
    plot(sec_signal_2, controlFit_465_2);
    title('fitted control');
    d = subplot(4,1,4);
    plot(sec_signal_2, delta465_filt_2);
    title('normalized signal 465');
    linkaxes([a,b,c,d],'x'); 
end