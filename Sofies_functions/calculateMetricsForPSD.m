function entry = calculateMetricsForPSD(f, pxx, mouseNumber, hour, sleepStage)
    % Calculate Peak Power Value and its corresponding Frequency
    [peakPowerValue, peakIdx] = max(pxx);
    peakFrequency = f(peakIdx);
    
    % Calculate Min Frequency (where pxx is first above 0)
    minFrequencyIdx = find(pxx > 0, 1, 'first');
    minFrequency = f(minFrequencyIdx);
    
    % Calculate Max Frequency (where pxx is last above 0)
    maxFrequencyIdx = find(pxx > 0, 1, 'last');
    maxFrequency = f(maxFrequencyIdx);
    
    % Calculate the Area Under the Curve (AUC) for the power spectral density
    auc = trapz(f, pxx);
    
    % Calculate Total Power as the sum of pxx
    totalPower = sum(pxx);
    
    % Calculate Frequency Quartiles based on the cumulative distribution of power
    cumulativePower = cumtrapz(f, pxx);
    totalCumulativePower = cumulativePower(end);
    quartileValues = [0.25, 0.5, 0.75, 0.95] * totalCumulativePower;
    freqQuartiles = arrayfun(@(x) interp1(cumulativePower, f, x), quartileValues);
    
    % Assigning Quartiles
    freq25Quartile = freqQuartiles(1);
    medianFrequency = freqQuartiles(2);
    freq75Quartile = freqQuartiles(3);
    freq95Quartile = freqQuartiles(4);
    
    % Create an entry for the table
    entry = table(mouseNumber, hour, {sleepStage}, peakPowerValue, peakFrequency, minFrequency, freq25Quartile, medianFrequency, freq75Quartile, freq95Quartile, maxFrequency, auc, totalPower, ...
                  'VariableNames', {'MouseNumber', 'Hour', 'SleepStage', 'PeakPowerValue', 'PeakFrequency', 'MinFrequency', 'Freq25Quartile', 'MedianFrequency', 'Freq75Quartile', 'Freq95Quartile', 'MaxFrequency', 'AUC', 'TotalPower'});
end
