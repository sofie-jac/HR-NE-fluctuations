function titleStr = formatTitle(uTimeSegment)
    if contains(uTimeSegment, '_5')
        hourStr = strrep(uTimeSegment, '_5', ':30 to ');
        nextHourStr = sprintf('%d:00', str2double(extractBefore(uTimeSegment, '_5')) + 1);
    else
        hourStr = sprintf('%s:00 to ', uTimeSegment);
        nextHourStr = sprintf('%s:30', uTimeSegment);
    end
    titleStr = sprintf('Power Spectral Density: %s%s - Averaged across Mice', hourStr, nextHourStr);
end