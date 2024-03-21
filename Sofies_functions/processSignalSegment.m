% Function to process each signal segment and calculate PSD
function [detrendedSignal, segmentPSD, freqs, dataPoints] = processSignalSegment(secSignal, deltaSignal, fs, max_freq, sample_pr_sec)
    % Assuming secSignal and deltaSignal are vectors of the same length
    % Detrend deltaSignal, calculate PSD, return PSD and frequency vector
    % Replace the placeholder processing below with your actual processing steps
    
    % Placeholder for actual signal processing - replace with your processing code
    detrendedSignal = detrend(deltaSignal); % Simple detrend example
    [pxx, f] = pwelch(detrendedSignal, [], [], [0:sample_pr_sec:max_freq], fs);
    segmentPSD = pxx;
    freqs = f;
    dataPoints = length(deltaSignal); % Number of data points in this segment
end