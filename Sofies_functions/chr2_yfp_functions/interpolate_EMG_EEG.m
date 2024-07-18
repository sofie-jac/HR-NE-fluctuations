function [EEG_rawtrace, EEG_time] = interpolate_EMG_EEG(EEG_rawtrace, EEG_time)
    % Find NaNs in EEG_rawtrace
    EEG_NaNs = find(isnan(EEG_rawtrace));

    if ~isempty(EEG_NaNs)
        % Process NaNs in EEG_rawtrace
        EEG_nans = isnan(EEG_rawtrace); % identify NaNs
        EEG_nans_n = 1:numel(EEG_rawtrace); % vector of indices, used for indexing below
        EEG_intpl = EEG_rawtrace; % copy of velocity used for interpolation
        EEG_intpl(EEG_nans) = interp1(EEG_nans_n(~EEG_nans), EEG_rawtrace(~EEG_nans), EEG_nans_n(EEG_nans));
        EEG_rawtrace = EEG_intpl;
    end

    % For #403 the last sampling point is a nan and is therefore not
    % interpolated - therefore remove this one
    if isnan(EEG_rawtrace(end))
        EEG_rawtrace = EEG_rawtrace(1:end-1);
        EEG_time = EEG_time(1:end-1);
    end
end
