function plotCategorizedHRBBySleepStage(suffixes)
    for s = 1:length(suffixes)
        suffix = suffixes{s};

        % Construct variable names with the current suffix
        RR_time_name = ['RR_time_', suffix];
        RR_name = ['RR_', suffix];
        wake_woMA_binary_vector_name = ['wake_woMA_binary_vector_', suffix];
        sws_binary_vector_name = ['sws_binary_vector_', suffix];
        REM_binary_vector_name = ['REM_binary_vector_', suffix];
        MA_binary_vector_name = ['MA_binary_vector_', suffix];
        HRB_time_NREM_name = ['HRB_time_NREM_', suffix];
        HRB_value_NREM_name = ['HRB_value_NREM_', suffix];
        HRB_time_MA_name = ['HRB_time_MA_', suffix];
        HRB_value_MA_name = ['HRB_value_MA_', suffix];

        % Check if the variables exist in the environment
        if evalin('base', ['exist(''' RR_time_name ''', ''var'')']) && ...
           evalin('base', ['exist(''' RR_name ''', ''var'')']) && ...
           evalin('base', ['exist(''' wake_woMA_binary_vector_name ''', ''var'')']) && ...
           evalin('base', ['exist(''' sws_binary_vector_name ''', ''var'')']) && ...
           evalin('base', ['exist(''' REM_binary_vector_name ''', ''var'')']) && ...
           evalin('base', ['exist(''' MA_binary_vector_name ''', ''var'')']) && ...
           evalin('base', ['exist(''' HRB_time_NREM_name ''', ''var'')']) && ...
           evalin('base', ['exist(''' HRB_value_NREM_name ''', ''var'')']) && ...
           evalin('base', ['exist(''' HRB_time_MA_name ''', ''var'')']) && ...
           evalin('base', ['exist(''' HRB_value_MA_name ''', ''var'')'])
       
            % Retrieve the variables from the workspace
            RR_time = evalin('base', RR_time_name);
            RR = evalin('base', RR_name);
            wake_woMA_binary_vector = evalin('base', wake_woMA_binary_vector_name);
            sws_binary_vector = evalin('base', sws_binary_vector_name);
            REM_binary_vector = evalin('base', REM_binary_vector_name);
            MA_binary_vector = evalin('base', MA_binary_vector_name);
            HRB_time_NREM = evalin('base', HRB_time_NREM_name);
            HRB_value_NREM = evalin('base', HRB_value_NREM_name);
            HRB_time_MA = evalin('base', HRB_time_MA_name);
            HRB_value_MA = evalin('base', HRB_value_MA_name);

            % Find the maximum length of the binary vectors
            maxLength = max([length(wake_woMA_binary_vector), length(sws_binary_vector), ...
                             length(REM_binary_vector), length(MA_binary_vector)]);
                         
            % Zero-pad the binary vectors to the same length
            wake_woMA_binary_vector = padVector(wake_woMA_binary_vector, maxLength);
            sws_binary_vector = padVector(sws_binary_vector, maxLength);
            REM_binary_vector = padVector(REM_binary_vector, maxLength);
            MA_binary_vector = padVector(MA_binary_vector, maxLength);

            % Create sleep score time vector
            sleepscore_time = 0:maxLength-1; % Assuming all vectors are the same length

            % Plot the data
            figure;
            plot_sleep(RR_time, RR, sleepscore_time, wake_woMA_binary_vector, sws_binary_vector, REM_binary_vector, MA_binary_vector);
            hold on;
            % Plot HRB for NREM
            scatter(HRB_time_NREM, HRB_value_NREM, 'g', 'filled'); % Green dots for HRB in NREM
            % Plot HRB for MA
            scatter(HRB_time_MA, HRB_value_MA, 'b', 'filled'); % Blue dots for HRB in MA
            hold off;
            xlabel('Time (s)');
            ylabel('RR intervals');
            title(['HRV p-chip (M', suffix, ')']);
            grid on;
            
            % Clear unnecessary variables
            clear RR_time RR wake_woMA_binary_vector sws_binary_vector REM_binary_vector MA_binary_vector HRB_time_NREM HRB_value_NREM HRB_time_MA HRB_value_MA sleepscore_time;
        else
            warning('Variables %s, %s, %s, %s, %s, %s, %s, %s, %s, and/or %s do not exist in the workspace.', ...
                RR_time_name, RR_name, wake_woMA_binary_vector_name, sws_binary_vector_name, REM_binary_vector_name, MA_binary_vector_name, HRB_time_NREM_name, HRB_value_NREM_name, HRB_time_MA_name, HRB_value_MA_name);
        end
    end
    clear suffixes s suffix RR_time_name RR_name wake_woMA_binary_vector_name sws_binary_vector_name REM_binary_vector_name MA_binary_vector_name HRB_time_NREM_name HRB_value_NREM_name HRB_time_MA_name HRB_value_MA_name;
end
