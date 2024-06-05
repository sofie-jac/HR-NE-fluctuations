    function [weighted_mean_PXX, SEM_PXX] = calculate_weighted_mean_SEM(PXX, period_duration)
        weighted_mean_PXX = sum(period_duration .* PXX, 2) / sum(period_duration);
        SEM_PXX = std(PXX, 0, 2) / sqrt(size(PXX, 2));
    end