function violinplot(data, varargin)
    % Parse input arguments
    p = inputParser;
    addParameter(p, 'Pos', 1, @isnumeric);
    addParameter(p, 'Color', [0.5 0.5 0.5], @(x) isnumeric(x) && length(x) == 3);
    parse(p, varargin{:});
    pos = p.Results.Pos;
    color = p.Results.Color;

    % Calculate the kernel density estimate
    [f, xi] = ksdensity(data, 'Function', 'pdf');
    f = f / max(f) * 0.4; % Scale width of the violin

    % Plot the violin
    fill([pos + f, pos - fliplr(f)], [xi, fliplr(xi)], color, 'FaceAlpha', 0.3, 'EdgeColor', 'none');
end
