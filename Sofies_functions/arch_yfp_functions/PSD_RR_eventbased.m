function [PXX_arch, PXX_yfp, f, resultTable] = PSD_RR_eventbased(arch, yfp)
    fs = 64; % Specify sampling frequency of your signal trace
    sampling_hz = 0.002;
    dataDirectory = 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\arch_yfp\Copy_of_figure_3_data';

    % Initialize arrays to hold PSD data
    PXX_arch = {};
    PXX_yfp = {};
    f = [];  % Initialize f as an empty array
    
    % Process arch group
    [PXX_arch, f] = process_group_RR_eventbased(arch, 'arch', PXX_arch);
    % Process yfp group
    [PXX_yfp, f] = process_group_RR_eventbased(yfp, 'yfp', PXX_yfp);
    
    % Initialize table for returning mean and SEM
    if isempty(f)
        % Assign a default value for f if it wasn't properly assigned
        f = linspace(0, 3, 100);  % Adjust the number of points as necessary
    end
    
    resultTable = table(f(:), 'VariableNames', {'f'});
    
    % Plot the results
    figure;
    hold on;

    % Define the frequency ranges for shading
    vlf_range = [0, 0.15];
    lf_range = [0.15, 1.5];
    hf_range = [1.5, 3];

    % Plot mean PSD and SEM for YFP
    if ~isempty(PXX_yfp)
        mean_PXX_yfp = PXX_yfp{1, 1};
        SEM_PXX_yfp = PXX_yfp{1, 2};
        h_yfp = shadedErrorBar(f, mean_PXX_yfp, SEM_PXX_yfp, '-b');
        set(h_yfp.mainLine, 'DisplayName', 'YFP');
        % Hide the SEM line from the legend
        set(get(get(h_yfp.patch, 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
        set(get(get(h_yfp.edge(1), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
        set(get(get(h_yfp.edge(2), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
        
        % Add the mean and SEM to the result table
        resultTable = [resultTable, table(mean_PXX_yfp(:), SEM_PXX_yfp(:), 'VariableNames', ...
            {'Mean_YFP', 'SEM_YFP'})];
    else
        % Add NaNs if no data is present
        resultTable = [resultTable, table(NaN(length(f), 1), NaN(length(f), 1), 'VariableNames', ...
            {'Mean_YFP', 'SEM_YFP'})];
    end

    % Plot mean PSD and SEM for arch
    if ~isempty(PXX_arch)
        mean_PXX_arch = PXX_arch{1, 1};
        SEM_PXX_arch = PXX_arch{1, 2};
        h_arch = shadedErrorBar(f, mean_PXX_arch, SEM_PXX_arch, '-r');
        set(h_arch.mainLine, 'DisplayName', 'arch');
        % Hide the SEM line from the legend
        set(get(get(h_arch.patch, 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
        set(get(get(h_arch.edge(1), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
        set(get(get(h_arch.edge(2), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
        
        % Add the mean and SEM to the result table
        resultTable = [resultTable, table(mean_PXX_arch(:), SEM_PXX_arch(:), 'VariableNames', ...
            {'Mean_arch', 'SEM_arch'})];
    else
        % Add NaNs if no data is present
        resultTable = [resultTable, table(NaN(length(f), 1), NaN(length(f), 1), 'VariableNames', ...
            {'Mean_arch', 'SEM_arch'})];
    end

    % Set the axis limits and plot titles
    ylim([0, max([mean_PXX_yfp + SEM_PXX_yfp, mean_PXX_arch + SEM_PXX_arch]) * 1.1]);
    xlim([0, max(f)]);
    title('arch vs YFP - RR Intervals');
    xlabel('Frequency (Hz)');
    ylabel('Power Spectral Density (PSD)');
    legend('show', 'Location', 'northeast');
    hold off;

    % Set figure background color to white
    set(gcf, 'Color', 'w');

    % Clear temporary variables
    clear fs sampling_hz dataDirectory mean_PXX_arch SEM_PXX_arch mean_PXX_yfp SEM_PXX_yfp;
end
