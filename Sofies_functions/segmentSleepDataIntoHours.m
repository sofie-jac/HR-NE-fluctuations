function hourlySegments = segmentSleepDataIntoHours(sleepData, secSignalHours, startTimeNextHour)
    % Initialize the structure to hold hourly segment data
    hourlySegments = struct();
    
    % Loop through each hour and segment the data
    for i = 1:length(secSignalHours) - 1
        hourStart = secSignalHours(i);
        hourEnd = secSignalHours(i + 1);
        hourFormatted = datestr(startTimeNextHour + hours(i - 1), 'HH');
        
        % Prepend 'h' to make a valid field name
        fieldName = sprintf('h%s', hourFormatted);
        
        % Filter periods that fall within the current hour
        inHourIdx = sleepData(:,1) >= hourStart & sleepData(:,2) <= hourEnd;
        hourlyData = sleepData(inHourIdx, :);
        
        % Add to the structure
        hourlySegments.(fieldName) = hourlyData;
    end
end
