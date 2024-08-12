function [mean_spectrogram, time_spectrogram_zero, F, band_powers, EEG_bands_fs] = PowerAnalysisEEG(EEG, EEG_fs, frw, window_in_sec, power_bands)
    % Assuming EEG, sec_signal_EEG, and EEG_fs are defined in your workspace
    Data_EEG = EEG; % EEG data vector
    
    % Check if Data_EEG is a vector
    if ~isvector(Data_EEG)
        error('Data_EEG must be a vector.');
    end
    
    frq = EEG_fs; % sampling frequency of EEG data
    
    % Print diagnostic information
    disp('EEG data length:');
    disp(length(Data_EEG));
    disp('Sampling frequency:');
    disp(frq);
    disp('Window length in samples:');
    disp(round(frq * window_in_sec));
    
    % Compute spectrogram
    [transition_spectrogram, F, T] = spectrogram(Data_EEG, round(frq * window_in_sec), [], frw, frq, 'yaxis');
    mean_spectrogram = log(abs(transition_spectrogram));
    
    % Handle potential -Inf values
    small_positive_value = 1e-10;
    mean_spectrogram(isinf(mean_spectrogram)) = small_positive_value;
    
    time_spectrogram_zero = T;
    
    % Create a Gaussian filter manually
    sigma = 1; % Adjust the sigma as needed
    filter_size = 5; % Adjust the size as needed
    gaussian_filter = exp(-(1:filter_size).^2 / (2 * sigma^2));
    gaussian_filter = gaussian_filter / sum(gaussian_filter);
    
    % Use conv to apply the filter
    filtered_mean_spectrogram = conv2(mean_spectrogram, gaussian_filter, 'same');

    band_powers = cell(1, length(power_bands));
    for b = 1:length(power_bands)
        freq_range = power_bands{b};
        band_powers{b} = mean(mean_spectrogram(F >= freq_range(1) & F <= freq_range(2), :), 1);
    end

    EEG_bands_fs = length(T) / T(end); % for EEG bands
end