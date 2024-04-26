function [delta465_filt_2, sec_signal_2, signal_fs, EEG, EMG, sec_signal_EEG, EEG_fs] = processSignals_without_TTL(mouse, data_FPrig, data_EEGrig)
    % Extract signals
    signal_fs = data_FPrig.streams.(mouse{6}).fs; % sampling frequency for fiber photometry signal
    signal_465_2 = data_FPrig.streams.(mouse{6}).data; %signal
    signal_405_2 = data_FPrig.streams.(mouse{7}).data; %isosbestic control

    EEG_fs = data_EEGrig.streams.(mouse{9}).fs; %sampling frequency for EEG signal 
    EEG_all = data_EEGrig.streams.(mouse{9}).data; %EEG signal
    EEG = EEG_all(mouse{10},:); %add channel (1 or 2)
    EMG = data_EEGrig.streams.(mouse{11}).data; %EMG 

    TTL_FP = data_FPrig.epocs.(mouse{12}).onset;
    first_TTL = TTL_FP(1)*signal_fs;
    onset_FP = max(first_TTL, 1);

    % For EEG
    first_TTL_EEG = TTL_FP(1)*EEG_fs;
    onset_FP_EEG = max(first_TTL_EEG, 1);

    signal_465_2 = signal_465_2(onset_FP:end);
    signal_405_2 = signal_405_2(onset_FP:end);

    EEG = EEG(onset_FP_EEG:end);
    EMG = EMG(onset_FP_EEG:end);
       % Calculate the number of samples to remove (equivalent to 1 second)

    samplesToRemove_EEG_EMG = EEG_fs; % Number of samples in 1 second for EEG and EMG
    samplesToRemove_FP = signal_fs; % Number of samples in 1 second for photometry signals

    % Directly trim the first second from EEG and EMG
    EEG = EEG(samplesToRemove_EEG_EMG:end);
    EMG = EMG(samplesToRemove_EEG_EMG:end);

    % Directly trim the first second from signal_405_2 and signal_465_2
    signal_405_2 = signal_405_2(samplesToRemove_FP:end);
    signal_465_2 = signal_465_2(samplesToRemove_FP:end);
    % Calculate the number of samples to remove (equivalent to 1 second)

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
    uniqueId = mouse{1}(end-2:end); % Extract unique identifier based on your naming convention

    figure
    sgtitle(sprintf('Delta465 Filt 2 - Mouse %s', uniqueId));
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
