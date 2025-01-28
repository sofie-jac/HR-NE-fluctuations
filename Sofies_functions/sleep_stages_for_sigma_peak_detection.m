function sleep_stages_for_sigma_peak_detection(suffixes)
    % Loop over each suffix
    for s = 1:length(suffixes)
        suffix = suffixes{s};
        
        % Construct variable names for the binary vectors
        sws_varName = sprintf('sws_binary_vector_%s', suffix);
        MA_varName = sprintf('MA_binary_vector_%s', suffix);
        wake_varName = sprintf('wake_woMA_binary_vector_%s', suffix);
        
        % Check if the variables exist in the workspace
        if evalin('base', sprintf('exist(''%s'', ''var'')', sws_varName)) && ...
           evalin('base', sprintf('exist(''%s'', ''var'')', MA_varName)) && ...
           evalin('base', sprintf('exist(''%s'', ''var'')', wake_varName))
       
            % Retrieve variables from the workspace
            sws_binary_vector = evalin('base', sws_varName);
            MA_binary_vector = evalin('base', MA_varName);
            wake_binary_vector = evalin('base', wake_varName);
            
            % Ensure variables are 1xN doubles
            if ~isnumeric(sws_binary_vector) || ~isnumeric(MA_binary_vector) || ~isnumeric(wake_binary_vector)
                warning('Variables for suffix %s are not numeric. Skipping.', suffix);
                continue;
            end
            
            % Generate NREMexclMA_periods
            NREMexclMA_binary = sws_binary_vector;
            [NREMexclMA_onset, NREMexclMA_offset] = binaryToOnOff(NREMexclMA_binary);
            NREMexclMA_periods = [NREMexclMA_onset, NREMexclMA_offset - 15]; % Subtract 15 seconds from offset
            
            % Generate MA_periods
            [MA_onset, MA_offset] = binaryToOnOff(MA_binary_vector);
            MA_periods = [MA_onset, MA_offset];
            
            % Generate SWS_before_MA and split into short and long
            SWS_before_MA = calculate_pre_periods(sws_binary_vector, MA_binary_vector, 15);
            
            % Split SWS_before_MA into short and long periods
            MA_durations = MA_periods(:, 2) - MA_periods(:, 1); % Duration of MA periods
            short_indices = MA_durations < 5; % MA periods shorter than 5 seconds
            long_indices = MA_durations >= 5; % MA periods 5 seconds or longer
            
            SWS_before_MA_short = SWS_before_MA(short_indices, :);
            SWS_before_MA_long = SWS_before_MA(long_indices, :);
            
            % Generate SWS_before_wake
            SWS_before_wake = calculate_pre_periods(sws_binary_vector, wake_binary_vector, 15);
            
            % Save results back to the workspace
            assignin('base', sprintf('NREMexclMA_periods_%s', suffix), NREMexclMA_periods);
            assignin('base', sprintf('MA_periods_%s', suffix), MA_periods);
            assignin('base', sprintf('SWS_before_MA_short_%s', suffix), SWS_before_MA_short);
            assignin('base', sprintf('SWS_before_MA_long_%s', suffix), SWS_before_MA_long);
            assignin('base', sprintf('SWS_before_wake_%s', suffix), SWS_before_wake);
        else
            warning('Variables for suffix %s are missing in the workspace. Skipping.', suffix);
        end
    end
end

function [onsets, offsets] = binaryToOnOff(binary_vector)
    % Identify changes in binary vector to find onsets and offsets
    transitions = diff([0; binary_vector(:); 0]);
    onsets = find(transitions == 1);
    offsets = find(transitions == -1);
end

function pre_periods = calculate_pre_periods(sws_binary, target_binary, pre_seconds)
    % Calculate pre-periods for a given binary vector
    fs = 1; % Sampling frequency is 1 Hz
    pre_samples = pre_seconds * fs;
    
    [target_onsets, ~] = binaryToOnOff(target_binary);
    pre_onsets = target_onsets - pre_samples;
    pre_offsets = target_onsets;
    
    % Ensure onsets do not go below 1 and offsets do not exceed length
    pre_onsets(pre_onsets < 1) = 1;
    pre_offsets(pre_offsets > length(sws_binary)) = length(sws_binary);
    
    pre_periods = [pre_onsets, pre_offsets];
end
