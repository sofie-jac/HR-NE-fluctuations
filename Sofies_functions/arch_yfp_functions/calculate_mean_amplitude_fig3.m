function mean_amplitude_table = calculate_mean_amplitude_fig3(RR_amplitude_table)
    % Calculate the mean amplitude per subject
    subjects = unique(RR_amplitude_table.Subject);
    mean_amplitude_data = cell(length(subjects), 3);

    for i = 1:length(subjects)
        subject = subjects{i};
        % Filter data for the current subject
        subject_data = RR_amplitude_table(strcmp(RR_amplitude_table.Subject, subject), :);
        
        % Calculate the mean amplitude for the subject
        mean_amplitude = mean(subject_data.Amplitude);
        
        % Store the result in the cell array
        mean_amplitude_data{i, 1} = subject;
        mean_amplitude_data{i, 2} = unique(subject_data.Group);
        mean_amplitude_data{i, 3} = mean_amplitude;
    end

    % Convert the cell array to a table
    mean_amplitude_table = cell2table(mean_amplitude_data, 'VariableNames', {'Subject', 'Group', 'MeanAmplitude'});
end
