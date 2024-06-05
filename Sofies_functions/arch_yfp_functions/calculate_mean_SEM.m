    % Helper function to calculate mean and SEM
    function [mean_PXX, SEM_PXX] = calculate_mean_SEM(PSD_results, f)
        all_weighted_PXX = cell2mat(PSD_results(:, 2));
        all_weighted_PXX_matrix = reshape(all_weighted_PXX, length(f), []);
        mean_PXX = mean(all_weighted_PXX_matrix, 2);
        SEM_PXX = std(all_weighted_PXX_matrix, 0, 2) / sqrt(size(all_weighted_PXX_matrix, 2));
    end