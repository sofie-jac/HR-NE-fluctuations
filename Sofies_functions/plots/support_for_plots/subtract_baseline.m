    function aligned_data = subtract_baseline(data, time_vector)
        baseline_indices = time_vector >= -40 & time_vector <= -30;
        baseline_mean = mean(data(baseline_indices));
        aligned_data = data - baseline_mean;
    end