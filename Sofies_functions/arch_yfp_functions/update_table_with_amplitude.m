function updated_table = update_table_with_amplitude(RR_amplitude_table, data_table)
    % Calculate mean amplitude for each subject in RR_amplitude_table
    subjects = unique(RR_amplitude_table.Subject);
    mean_amplitude = arrayfun(@(s) mean(RR_amplitude_table.Amplitude(strcmp(RR_amplitude_table.Subject, s))), subjects);

    % Initialize the updated table
    updated_table = data_table;

    % Add MeanAmplitude to the table
    updated_table.MeanAmplitude = NaN(height(data_table), 1);

    for i = 1:height(data_table)
        subject = num2str(data_table.Suffix(i)); % Convert subject to string
        if any(strcmp(subjects, subject))
            idx = strcmp(subjects, subject);
            updated_table.MeanAmplitude(i) = mean_amplitude(idx);
        end
    end
end
