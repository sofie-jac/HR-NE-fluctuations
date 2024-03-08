% Function to check and add periods to the corresponding hourly structure
function addPeriodToHourlyStructure(periodsData, startTime, endTime, hourFormatted, structureName)
    for i = 1:size(periodsData, 1)
        onset = periodsData(i, 1);
        offset = periodsData(i, 2);
        if onset >= startTime && offset <= endTime
            fieldName = sprintf('h%s', hourFormatted);
            currentData = structureName.(fieldName);
            currentData = [currentData; periodsData(i, :)];
            structureName.(fieldName) = currentData;
        end
    end
end