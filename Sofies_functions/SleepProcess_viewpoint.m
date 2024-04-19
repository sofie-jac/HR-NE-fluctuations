function [wake_woMA_binary_vector_cut, sws_binary_vector_cut, REM_binary_vector_cut, MA_binary_vector_cut, NREMinclMA_periods_cut, NREMexclMA_periods_cut, wake_woMA_periods_cut, REM_periods_cut, MA_periods_cut, SWS_before_MA_filtered, SWS_before_wake_filtered, SWS_before_REM_filtered, REM_before_MA_filtered, REM_before_wake_filtered] = SleepProcess_viewpoint(mouse, sec_signal_EEG, onset_FP_EEG, EEG_fs, time_before_MA_exclusion, NREM_sec_before_transition, REM_sec_before_transition)
    % loads hypno, ViewpointData needs to be a struct - see above
    addpath(genpath(['J:\CTN\NedergaardLAB\Personal_folders\Mie\EEG data from NH\EEG toolbox']));
    ViewpointData.FileInfo=loadEXP([mouse{2}],'no');
    
    [FullHypno,TimeScaleAbs,TimeScaleBin,TimeScaleHypno]=ExtractFullHypno(ViewpointData,1);
    
    FullHypno = FullHypno(find(FullHypno~=0,1):end);
    time_correction = round(TimeScaleBin(1));
    int_sig = zeros(1,time_correction);
    
    wake_binary_vector = [int_sig FullHypno==1];
    sws_binary_vector = [int_sig FullHypno==2];
    REM_binary_vector = [int_sig FullHypno==4];
    
    [wake_onset, wake_offset] = binary_to_OnOff(wake_binary_vector);
    [sws_onset, sws_offset] = binary_to_OnOff(sws_binary_vector);
    [REM_onset, REM_offset] = binary_to_OnOff(REM_binary_vector);
    
    wake_duration = wake_offset-wake_onset;
    duration_sws = sws_offset-sws_onset;
    REM_duration = REM_offset-REM_onset;
    
    sleepscore_time = [TimeScaleHypno TimeScaleHypno(end)+1:1:TimeScaleHypno(end)+time_correction];
    
    % 2-column vectors with on- and offsets for each state
    wake_periods = [wake_onset wake_onset+wake_duration];
    sws_periods = [sws_onset sws_onset+duration_sws];
    REM_periods = [REM_onset REM_onset+REM_duration];


    
    %SLEEP: 5b) Dividing wake bouts into microarousals (MA) and wake w/o MA
    
    MA_maxdur = 15; % maximum duration of microarrousal
    MA_idx = find(wake_duration < MA_maxdur);
    MA_onset = wake_onset(MA_idx);
    MA_duration = wake_duration(MA_idx);
    MA_binary_vector = zeros([1, (sum([ViewpointData.FileInfo.HypnoFiles.Duration]))+time_correction]);
    for i=1:length(MA_onset) % making time vector for EEG scoring (frequency = 1Hz)
        t = MA_onset(i)+1;
        d = MA_duration(i)-1;
        MA_binary_vector(t:t+d) = 1;
    end
    
    % remove micrarrousal from wake vectors
    wake_woMA_onset = wake_onset;
    wake_woMA_onset(MA_idx) = [];
    wake_woMA_duration = wake_duration;
    wake_woMA_duration(MA_idx) = [];
    wake_woMA_binary_vector = zeros([1, (sum([ViewpointData.FileInfo.HypnoFiles.Duration]))+time_correction]);
    for i=1:length(wake_woMA_onset) % making time vector for EEG scoring (frequency = 1Hz)
        t = wake_woMA_onset(i)+1;
        d = wake_woMA_duration(i)-1;
        wake_woMA_binary_vector(t:t+d) = 1;
    end
    
    % 2-column vectors with on- and offsets for each state
    MA_periods = [MA_onset MA_onset+MA_duration];
    wake_woMA_periods = [wake_woMA_onset wake_woMA_onset+wake_woMA_duration];

    
    %SLEEP: 6) Alingment of EEG recording and FP recording
    
    TTL_EEG_onset = onset_FP_EEG; 
    
    % Remove first seconds of EEG score to align with FP trace
    wake_binary_vector_cut = wake_binary_vector(round(TTL_EEG_onset):end);
    sws_binary_vector_cut = sws_binary_vector(round(TTL_EEG_onset):end);
    REM_binary_vector_cut = REM_binary_vector(round(TTL_EEG_onset):end);
    MA_binary_vector_cut = MA_binary_vector(round(TTL_EEG_onset):end);
    wake_woMA_binary_vector_cut = wake_woMA_binary_vector(round(TTL_EEG_onset):end);
    

    % Align onset, offset, and duration vectors based on TTL
    [wake_onset_cut, wake_offset_cut] = binary_to_OnOff(wake_binary_vector_cut);
    wake_duration_cut = wake_offset_cut - wake_onset_cut;
    
    [sws_onset_cut, sws_offset_cut] = binary_to_OnOff(sws_binary_vector_cut);
    sws_duration_cut = sws_offset_cut - sws_onset_cut;
    
    if ~isnan(REM_onset)
        [REM_onset_cut, REM_offset_cut] = binary_to_OnOff(REM_binary_vector_cut);
        REM_duration_cut = REM_offset_cut - REM_onset_cut;
    else
        REM_onset_cut = NaN;    % in case of no REM bouts
        REM_offset_cut = NaN;
        REM_duration_cut = NaN;
    end
    
        [MA_onset_cut, MA_offset_cut] = binary_to_OnOff(MA_binary_vector_cut);
        MA_duration_cut = MA_offset_cut - MA_onset_cut;
    
        [wake_woMA_onset_cut, wake_woMA_offset_cut] = binary_to_OnOff(wake_woMA_binary_vector_cut);
        wake_woMA_duration_cut = wake_woMA_offset_cut - wake_woMA_onset_cut;
    
    % Align period arrays according to TTL
    wake_periods_cut = [wake_onset_cut wake_offset_cut];
    sws_periods_cut = [sws_onset_cut sws_offset_cut];
    REM_periods_cut = [REM_onset_cut REM_offset_cut];
    MA_periods_cut = [MA_onset_cut MA_offset_cut];
    wake_woMA_periods_cut = [wake_woMA_onset_cut wake_woMA_offset_cut];
    
    %Re-classify MA as NREM using boutscore_vector
    % Here you can pool MAs with NREM sleep which can be beneficial for some
    % analyses related to infraslow oscillations (eg. PSD analysis), where you
    % don't want to divide your traces into short/pure NREM bouts
    
    %State transitions (uncut vectors)
    % Creating one vector with different behaviors represented by unique
    % numbers (1=wake, 4=sws, 9=REM, 15=MA) at frequency 1Hz
    boutscore_vector = zeros([1, round(sec_signal_EEG(end))+200]);
    
    % Here using the unaligned "uncut" vectors
    for i=1:length(wake_woMA_onset)
        t = wake_woMA_onset(i)+1;
        d = wake_woMA_duration(i)-1;
        boutscore_vector(t:t+d) = 1; % wake=1
    end
    
    for i=1:length(sws_onset)
        t = sws_onset(i)+1;
        d = duration_sws(i)-1;
        boutscore_vector(t:t+d) = 4; % sws=4
    end
    
    if ~isnan(REM_onset)
        for i=1:length(REM_onset)
            t = REM_onset(i)+1;
            d = REM_duration(i)-1;
            boutscore_vector(t:t+d) = 9; %REM=9
        end
    end
    
    for i=1:length(MA_onset)
        t = MA_onset(i)+1;
        d = MA_duration(i)-1;
        boutscore_vector(t:t+d) = 15; %MA=15
    end
    
    % re-classify MA as NREM
    NREMinclMA_binary_vector = boutscore_vector==4 | boutscore_vector==15;
    NREMinclMA_binary_vector_cut = NREMinclMA_binary_vector(round(TTL_EEG_onset+1):end);
    [NREMinclMA_onset_cut, NREMinclMA_offset_cut] = binary_to_OnOff(NREMinclMA_binary_vector_cut);
    NREMinclMA_duration_cut = NREMinclMA_offset_cut-NREMinclMA_onset_cut;
    NREMinclMA_periods_cut = [NREMinclMA_onset_cut NREMinclMA_offset_cut];






    % Creating one vector with different behaviors represented by unique
    % numbers (1=wake, 4=sws, 9=REM, 15=MA) at frequency 1Hz
    boutscore_vector = zeros([1, round(sec_signal_EEG(end))+200]);
    
    % Here using the aligned "cut" vectors
    for i=1:length(wake_woMA_onset_cut)
        t = wake_woMA_onset_cut(i)+1;
        d = wake_woMA_duration_cut(i)-1;
        boutscore_vector(t:t+d) = 1; % wake=1
    end
    
    for i=1:length(sws_onset_cut)
        t = sws_onset_cut(i)+1;
        d = sws_duration_cut(i)-1;
        boutscore_vector(t:t+d) = 4; % sws=4
    end
    
    % Check if REM_onset_cut and REM_duration_cut contain finite values before attempting to use them
    if ~isempty(REM_onset_cut) && all(isfinite(REM_onset_cut)) && all(isfinite(REM_duration_cut))
        for i = 1:length(REM_onset_cut)
            t = REM_onset_cut(i) + 1;
            d = REM_duration_cut(i) - 1;
            boutscore_vector(t:t+d) = 9; %REM=9
        end
    end
    
    for i=1:length(MA_onset_cut)
        t = MA_onset_cut(i)+1;
        d = MA_duration_cut(i)-1;
        boutscore_vector(t:t+d) = 15; %MA=15
    end
    
    % Vectors indicate time of transitions in seconds
    transition_sws_wake =  find(diff(boutscore_vector)== -3);
    transition_wake_sws =  find(diff(boutscore_vector)== 3);
    transition_REM_wake =  find(diff(boutscore_vector)== -8);
    transition_sws_MA =  find(diff(boutscore_vector)== 11);
    transition_REM_sws =  find(diff(boutscore_vector)== -5);
    transition_sws_REM =  find(diff(boutscore_vector)== 5);
    transition_REM_MA =  find(diff(boutscore_vector)== 6);
    % Adjust the transition_REM_arousal calculation to ignore MAs within REM
    transition_REM_arousal = [];
    for i = 2:length(boutscore_vector)-1
        if (boutscore_vector(i-1) == 9 && boutscore_vector(i) == 15 && boutscore_vector(i+1) == 9)
            % If an MA (15) is surrounded by REM (9), ignore this MA for arousal transition purposes
            continue; % Skip to the next iteration, effectively ignoring this pattern
        elseif (diff(boutscore_vector(i-1:i)) == 6 || diff(boutscore_vector(i-1:i)) == -8)
            % Add the transition point if it's a genuine REM to arousal transition
            transition_REM_arousal = [transition_REM_arousal, i-1];
        end
    end
    

    % Calculate the total duration of the signal
    totalDuration = length(boutscore_vector);
    
    % Identify periods before transitions
    SWS_before_MA_periods = findPeriodsBeforeTransition(transition_sws_MA, NREM_sec_before_transition, totalDuration);
    SWS_before_wake_periods = findPeriodsBeforeTransition(transition_sws_wake, NREM_sec_before_transition, totalDuration);
    SWS_before_REM_periods = findPeriodsBeforeTransition(transition_sws_REM, NREM_sec_before_transition, totalDuration);
    REM_before_MA_periods = findPeriodsBeforeTransition(transition_REM_MA, REM_sec_before_transition, totalDuration);
    REM_before_wake_periods = findPeriodsBeforeTransition(transition_REM_wake, REM_sec_before_transition, totalDuration);

    
    % Filter the identified periods to ensure they are within actual SWS periods
    SWS_before_MA_filtered = filterSWSPeriods(SWS_before_MA_periods, NREMinclMA_periods_cut);
    SWS_before_wake_filtered = filterSWSPeriods(SWS_before_wake_periods, NREMinclMA_periods_cut);
    SWS_before_REM_filtered = filterSWSPeriods(SWS_before_REM_periods, NREMinclMA_periods_cut);
    REM_before_MA_filtered = filterSWSPeriods(REM_before_MA_periods, REM_periods_cut);
    REM_before_wake_filtered = filterSWSPeriods(REM_before_wake_periods, REM_periods_cut);


    % Define NREMexclMA_periods_cut
    
    % Initialize NREMexclMA_periods_cut
    NREMexclMA_periods_cut = [];
    
    % Using boutscore_vector to identify SWS periods excluding MAs
    for i = 1:length(sws_onset_cut)
        current_onset = sws_onset_cut(i);
        current_offset = sws_offset_cut(i);
        
        % Check for any transition to MA within this period and adjust the offset accordingly
        transition_to_MA_within_period = transition_sws_MA(transition_sws_MA >= current_onset & transition_sws_MA < current_offset);
        
        if ~isempty(transition_to_MA_within_period)
            % If there's a transition to MA, adjust the period to end before the exclusion interval
            for j = 1:length(transition_to_MA_within_period)
                transition_point = transition_to_MA_within_period(j);
                adjusted_offset = transition_point - time_before_MA_exclusion;
                
                % Only add the period if the adjusted offset is after the onset
                if adjusted_offset > current_onset
                    NREMexclMA_periods_cut = [NREMexclMA_periods_cut; [current_onset, adjusted_offset]];
                end
                
                % Adjust the onset for the next period to be after the current transition, if applicable
                current_onset = transition_point + 1;
            end
        else
            % If no transitions to MA, add the period as is
            NREMexclMA_periods_cut = [NREMexclMA_periods_cut; [current_onset, current_offset]];
        end
    end
    
    REM_lead_up = [];
    for i = 1:length(REM_onset_cut)
        REM_start = max(1, REM_onset_cut(i) - time_before_MA_exclusion);
        REM_end = REM_onset_cut(i) + REM_duration_cut(i) - 1;
        REM_lead_up = [REM_lead_up; [REM_start, REM_end]];
    end
    
    wake_lead_up = [];
    for i = 1:length(wake_onset_cut)
        wake_start = max(1, wake_onset_cut(i) - time_before_MA_exclusion);
        wake_end = wake_onset_cut(i) + wake_duration_cut(i) - 1;
        wake_lead_up = [wake_lead_up; [wake_start, wake_end]];
    end
    
    % Use the function to remove overlaps from NREMexclMA_periods_cut
    NREMexclMA_periods_cut = removeOverlaps(NREMexclMA_periods_cut, REM_lead_up);
    NREMexclMA_periods_cut = removeOverlaps(NREMexclMA_periods_cut, wake_lead_up);