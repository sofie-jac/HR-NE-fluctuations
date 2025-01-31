function sleep_stages_for_sigma_peak_detection(suffixes)
    % Loop over each suffix
    for s = 1:length(suffixes)
        suffix = suffixes{s};
        
        % Construct variable names for the binary vectors
        sws_varName = sprintf('sws_binary_vector_%s', suffix);
        MA_varName = sprintf('MA_binary_vector_%s', suffix);
        wake_varName = sprintf('wake_woMA_binary_vector_%s', suffix);
        REM_varName = sprintf('REM_binary_vector_%s', suffix);
        
        % Check if the variables exist in the workspace
        if evalin('base', sprintf('exist(''%s'', ''var'')', sws_varName)) && ...
           evalin('base', sprintf('exist(''%s'', ''var'')', MA_varName)) && ...
           evalin('base', sprintf('exist(''%s'', ''var'')', wake_varName)) && ...
           evalin('base', sprintf('exist(''%s'', ''var'')', REM_varName))
       
            % Retrieve variables from the workspace
            sws_binary_vector = evalin('base', sws_varName);
            MA_binary_vector = evalin('base', MA_varName);
            wake_binary_vector = evalin('base', wake_varName);
            REM_binary_vector = evalin('base', REM_varName);
            
            % Ensure variables are 1xN doubles
            if ~isnumeric(sws_binary_vector) || ~isnumeric(MA_binary_vector) || ...
               ~isnumeric(wake_binary_vector) || ~isnumeric(REM_binary_vector)
                warning('Variables for suffix %s are not numeric. Skipping.', suffix);
                continue;
            end
            
            % Generate NREMexclMA_periods
            NREMexclMA_binary = sws_binary_vector;
            [NREMexclMA_onset, NREMexclMA_offset] = binaryToOnOff(NREMexclMA_binary);
            
            % Adjust offsets if transitioning into REM
            for i = 1:length(NREMexclMA_offset)
                if NREMexclMA_offset(i) < length(REM_binary_vector) && REM_binary_vector(NREMexclMA_offset(i) + 1) == 1
                    % Remove 30 seconds before REM transition
                    NREMexclMA_offset(i) = max(NREMexclMA_onset(i), NREMexclMA_offset(i) - 30);
                end
            end
            
            NREMexclMA_periods = [NREMexclMA_onset, NREMexclMA_offset];

            % Generate SWS_before_wake and remove REM overlaps
            SWS_before_wake = calculate_pre_periods(sws_binary_vector, wake_binary_vector, 15);
            SWS_before_wake = remove_overlapping_periods(SWS_before_wake, REM_binary_vector);
            
            % **Remove SWS_before_wake periods from NREMexclMA_periods**
            NREMexclMA_periods = remove_overlapping_periods(NREMexclMA_periods, SWS_before_wake);

            % Generate MA_periods
            [MA_onset, MA_offset] = binaryToOnOff(MA_binary_vector);
            MA_periods = [MA_onset, MA_offset];
            
            % **Step 1: Find durations of each MA period**
            if isempty(MA_periods)
                SWS_before_MA_short = [];
                SWS_before_MA_long = [];
            else
                MA_durations = MA_periods(:, 2) - MA_periods(:, 1); % Duration of MA periods

                % **Step 2: Find SWS_before_MA before filtering REM**
                SWS_before_MA = calculate_pre_periods(sws_binary_vector, MA_binary_vector, 15);

                % **Step 3: Filter out SWS_before_MA periods that overlap with REM**
                SWS_before_MA = remove_overlapping_periods(SWS_before_MA, REM_binary_vector);

                % **Step 4: Assign each SWS_before_MA to short or long based on its corresponding MA duration**
                SWS_before_MA_short = [];
                SWS_before_MA_long = [];

                for i = 1:size(SWS_before_MA, 1)
                    % Find the corresponding MA period for this SWS_before_MA
                    corresponding_MA_idx = find((MA_onset <= SWS_before_MA(i, 2)) & (MA_offset >= SWS_before_MA(i, 2)), 1);

                    if ~isempty(corresponding_MA_idx)
                        if MA_durations(corresponding_MA_idx) < 5
                            SWS_before_MA_short = [SWS_before_MA_short; SWS_before_MA(i, :)];
                        else
                            SWS_before_MA_long = [SWS_before_MA_long; SWS_before_MA(i, :)];
                        end
                    end
                end
            end
            
            % **Filter out peaks that fall within REM**
            peak_var_name = sprintf('sigma_peaks_%s', suffix);
            if evalin('base', sprintf('exist(''%s'', ''var'')', peak_var_name))
                peak_data = evalin('base', peak_var_name);
                filtered_peak_data = remove_peaks_in_REM(peak_data, REM_binary_vector);
                assignin('base', peak_var_name, filtered_peak_data);
            end
            
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

function filtered_peak_data = remove_peaks_in_REM(peak_data, REM_binary_vector)
    % Remove peaks that fall within REM periods
    [REM_onsets, REM_offsets] = binaryToOnOff(REM_binary_vector);
    filtered_peak_data = struct();
    
    stage_names = fieldnames(peak_data);
    
    for i = 1:length(stage_names)
        stage = stage_names{i};
        peaks = peak_data.(stage);
        
        % Keep only peaks that are outside REM periods
        valid_peaks = [];
        for j = 1:length(peaks)
            peak_time = peaks(j);
            if ~any((peak_time >= REM_onsets) & (peak_time <= REM_offsets))
                valid_peaks = [valid_peaks; peak_time];
            end
        end
        
        filtered_peak_data.(stage) = valid_peaks;
    end
end

function filtered_periods = remove_overlapping_periods(periods, other_periods)
    % This function removes any periods that overlap with another set of periods.
    
    % Initialize filtered periods
    filtered_periods = [];

    for i = 1:size(periods, 1)
        onset = periods(i, 1);
        offset = periods(i, 2);
        
        % Check if this period overlaps with any other periods
        overlap = any((onset <= other_periods(:, 2)) & (offset >= other_periods(:, 1)));

        % Only keep periods that do NOT overlap
        if ~overlap
            filtered_periods = [filtered_periods; onset, offset];
        end
    end
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
