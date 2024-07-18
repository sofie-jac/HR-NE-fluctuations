 function NE_intervals = extract_NE_intervals_chr2(uniqueIDs)
    % Directories
    NEDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\Traces';
    sleepDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\chr2_yfp\Sleep';

    % Define the laser shift timestamps
    laser_shift_480 = {'03:46:16', '04:46:16', '05:46:16', '06:46:16', '7:53:15', '8:55:07'};
    laser_shift_489 = {'2:50:55', '3:51:55', '4:52:20', '5:52:57', '6:50:52', '7:50:50'};
    laser_shift_491 = {'3:05:05', '4:05:08', '5:05:50', '6:06:30', '7:05:07', '8:06:37'};
    laser_shift_497 = {'02:52:09', '03:52:09', '04:52:09', '05:52:09', '06:52:09', '07:52:10'};
    laser_shift_511 = {'2:26:30', '3:30:59', '4:26:29', '5:26:25', '6:26:23', '7:26:22'};
    laser_shift_522 = {'2:43:00', '3:50:00', '4:50:00', '5:48:00', '6:48:00', '7:48:00'};
    laser_shift_577 = {'3:02:25', '4:02:58', '05:03:37', '06:03:58', '07:04:30', '8:05:51'};
    laser_shift_584 = {'2:31:00', '3:32:05', '4:32:30', '5:33:10', '6:33:25', '7:32:40'};
    laser_shift_586 = {'2:49:33', '3:49:47', '4:50:06', '5:49:35', '6:49:35', '7:49:34'};
    laser_shift_512 = {'2:43:49', '3:43:51', '4:43:49', '5:44:18', '6:44:12', '7:44:20'};
    laser_shift_513 = {'2:43:00', '3:50:00', '4:50:00', '5:48:00', '6:48:00', '7:48:00'};

    % Convert laser shift timestamps to seconds
    convertToSeconds = @(t) cellfun(@(x) sum(sscanf(x, '%d:%d:%d').*[3600; 60; 1]), t);

    laser_shift_seconds = struct();
    laser_shift_seconds.('M480') = convertToSeconds(laser_shift_480);
    laser_shift_seconds.('M489') = convertToSeconds(laser_shift_489);
    laser_shift_seconds.('M491') = convertToSeconds(laser_shift_491);
    laser_shift_seconds.('M497') = convertToSeconds(laser_shift_497);
    laser_shift_seconds.('M511') = convertToSeconds(laser_shift_511);
    laser_shift_seconds.('M522') = convertToSeconds(laser_shift_522);
    laser_shift_seconds.('M577') = convertToSeconds(laser_shift_577);
    laser_shift_seconds.('M584') = convertToSeconds(laser_shift_584);
    laser_shift_seconds.('M586') = convertToSeconds(laser_shift_586);
    laser_shift_seconds.('M512') = convertToSeconds(laser_shift_512);
    laser_shift_seconds.('M513') = convertToSeconds(laser_shift_513);

    % Initialize cell array to store results
    NE_intervals = {};

    for idx = 1:length(uniqueIDs)
        uniqueId = uniqueIDs{idx};
        id_with_M = ['M', uniqueId];

        % Load NE and NREM periods
        NEFile = fullfile(NEDirectory, sprintf('delta465_filt_2_%s.mat', uniqueId));
        NETimeFile = fullfile(NEDirectory, sprintf('sec_signal_2_%s.mat', uniqueId));
        sleepFile = fullfile(sleepDirectory, sprintf('NREMinclMA_periods_%s.mat', uniqueId));
        if exist(NEFile, 'file') && exist(NETimeFile, 'file') && exist(sleepFile, 'file')
            NE_data = load(NEFile);
            NE = NE_data.(sprintf('delta465_filt_2_%s', uniqueId));
            NE_time_data = load(NETimeFile);
            NE_time = NE_time_data.(sprintf('sec_signal_2_%s', uniqueId));
            sleep_data = load(sleepFile);
            NREM_periods = sleep_data.(sprintf('NREMinclMA_periods_%s', uniqueId));
        else
            disp(['File not found for subject ', uniqueId]);
            continue;
        end

        % Get laser shift times for the cuNEent subject
        laser_shifts = laser_shift_seconds.(id_with_M);

        % Add pre and post laser periods (laser_0)
        laser_shifts = [0, laser_shifts, NE_time(end)]; %#ok<AGROW>

        % Extract NE intervals for each laser level during NREM periods
        for laser_level = 0:5
            if laser_level == 0
                start_time = laser_shifts(1);
                end_time = laser_shifts(2);
                start_time2 = laser_shifts(end-1);
                end_time2 = laser_shifts(end);
                for i = 1:size(NREM_periods, 1)
                    onset = NREM_periods(i, 1);
                    offset = NREM_periods(i, 2);
                    if onset < end_time && offset > start_time
                        NE_interval = NE(NE_time >= max(onset, start_time) & NE_time <= min(offset, end_time));
                        if ~isempty(NE_interval)
                            NE_intervals = [NE_intervals; {NE_interval, uniqueId, laser_level}];
                        end
                    end
                    if onset < end_time2 && offset > start_time2
                        NE_interval = NE(NE_time >= max(onset, start_time2) & NE_time <= min(offset, end_time2));
                        if ~isempty(NE_interval)
                            NE_intervals = [NE_intervals; {NE_interval, uniqueId, laser_level}];
                        end
                    end
                end
            else
                start_time = laser_shifts(laser_level+1);
                end_time = laser_shifts(laser_level+2);
                for i = 1:size(NREM_periods, 1)
                    onset = NREM_periods(i, 1);
                    offset = NREM_periods(i, 2);
                    if onset < end_time && offset > start_time
                        NE_interval = NE(NE_time >= max(onset, start_time) & NE_time <= min(offset, end_time));
                        if ~isempty(NE_interval)
                            NE_intervals = [NE_intervals; {NE_interval, uniqueId, laser_level}];
                        end
                    end
                end
            end
        end
    end
end
