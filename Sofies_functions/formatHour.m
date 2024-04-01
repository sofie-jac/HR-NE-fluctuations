% Auxiliary function to format hour
function formattedHour = formatHour(timeSegment)
    parts = split(timeSegment, ':');
    hourPart = parts{1};
    minutePart = parts{2};
    if strcmp(minutePart, '00')
        formattedHour = hourPart; % On the hour
    else
        formattedHour = [hourPart, '_5']; % Half past
    end
end