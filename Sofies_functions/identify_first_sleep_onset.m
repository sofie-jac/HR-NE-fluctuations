function sleep_onset_table = identify_first_sleep_onset(yfp, arch)
    suffixes = [yfp, arch];
    sleep_onset_data = cell(length(suffixes), 2);
    
    for i = 1:length(suffixes)
        suffix = suffixes{i};
        variable_name = sprintf('wake_woMA_binary_vector_%s', suffix);
        
        if evalin('base', sprintf('exist(''%s'', ''var'')', variable_name))
            binary_vector = evalin('base', variable_name);
            first_sleep_onset = find_first_sleep_onset(binary_vector);
            sleep_onset_data{i, 1} = suffix;
            sleep_onset_data{i, 2} = first_sleep_onset;
        else
            warning('Variable %s does not exist in the workspace.', variable_name);
            sleep_onset_data{i, 1} = suffix;
            sleep_onset_data{i, 2} = 'Variable not found';
        end
    end
    
    % Convert the data to a table
    sleep_onset_table = cell2table(sleep_onset_data, 'VariableNames', {'Suffix', 'FirstSleepOnset'});
end

function first_sleep_onset = find_first_sleep_onset(binary_vector)
    % Find sequences of 0's that last for more than 20 seconds
    min_sleep_duration = 20; % seconds
    
    sleep_start_indices = find(diff([0, binary_vector == 0, 0]) == 1);
    sleep_end_indices = find(diff([0, binary_vector == 0, 0]) == -1) - 1;
    
    for j = 1:length(sleep_start_indices)
        sleep_duration = sleep_end_indices(j) - sleep_start_indices(j) + 1;
        if sleep_duration > min_sleep_duration
            % Convert the index to hour:minute:second format
            [hours, minutes, seconds] = convert_to_time_format(sleep_start_indices(j));
            first_sleep_onset = sprintf('%02d:%02d:%02d', hours, minutes, seconds);
            return;
        end
    end
    % If no sleep onset is found
    first_sleep_onset = 'Not found';
end

function [hours, minutes, seconds] = convert_to_time_format(index)
    seconds = mod(index, 60);
    minutes = mod(floor(index / 60), 60);
    hours = floor(index / 3600);
end
