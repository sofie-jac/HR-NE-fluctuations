% Helper function to compute mean and SEM and plot:
function plotCategory(titleStr, RR_data, delta_data, sigma_data, t_RR, t_delta465, t_sigma)
    if isempty(RR_data)
        fprintf('No events for category %s.\n', titleStr);
        return;
    end
    mean_RR = mean(RR_data, 1);
    sem_RR = std(RR_data, 0, 1) / sqrt(size(RR_data, 1));
    mean_delta = mean(delta_data, 1);
    sem_delta = std(delta_data, 0, 1) / sqrt(size(delta_data, 1));
    mean_sigma = mean(sigma_data, 1);
    sem_sigma = std(sigma_data, 0, 1) / sqrt(size(sigma_data, 1));
    
    figure;
    subplot(3,1,1); hold on;
    plot(t_RR, mean_RR, 'b', 'LineWidth', 2);
    fill([t_RR, fliplr(t_RR)], [mean_RR+sem_RR, fliplr(mean_RR-sem_RR)], 'b', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
    title([titleStr, ' - RR']); xlabel('Time (s)'); ylabel('RR');
    
    subplot(3,1,2); hold on;
    plot(t_delta465, mean_delta, 'r', 'LineWidth', 2);
    fill([t_delta465, fliplr(t_delta465)], [mean_delta+sem_delta, fliplr(mean_delta-sem_delta)], 'r', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
    title([titleStr, ' - Norepinephrine (delta465)']); xlabel('Time (s)'); ylabel('dF/F');
    
    subplot(3,1,3); hold on;
    plot(t_sigma, mean_sigma, 'g', 'LineWidth', 2);
    fill([t_sigma, fliplr(t_sigma)], [mean_sigma+sem_sigma, fliplr(mean_sigma-sem_sigma)], 'g', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
    title([titleStr, ' - Sigma Power']); xlabel('Time (s)'); ylabel('Power');
end