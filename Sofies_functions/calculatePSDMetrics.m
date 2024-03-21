function [metrics] = calculatePSDMetrics(avgPSD, freqs)
    % Calculate peak power and its frequency
    [peakPower, peakIdx] = max(avgPSD);
    peakPowerFreq = freqs(peakIdx);

    % Calculate AUC and total power
    auc = trapz(freqs, avgPSD);
    totalPower = sum(avgPSD);

    % Calculate power distribution quartiles
    cumDist = cumtrapz(freqs, avgPSD) / auc; % Cumulative distribution of power
    Freq25Quartile = interp1(cumDist, freqs, 0.25);
    MedianFrequency = interp1(cumDist, freqs, 0.5);
    Freq75Quartile = interp1(cumDist, freqs, 0.75);
    Freq95Quartile = interp1(cumDist, freqs, 0.95);

    % Store calculated metrics
    metrics = struct('peakPower', peakPower, 'peakPowerFreq', peakPowerFreq, 'Freq25Quartile', Freq25Quartile, 'MedianFrequency', MedianFrequency, 'Freq75Quartile', Freq75Quartile, 'Freq95Quartile', Freq95Quartile, 'AUC', auc, 'totalPower', totalPower);
end