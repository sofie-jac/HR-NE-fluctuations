function RR_intervals = extract_and_calculate_RR(RR, RR_time, NREM_periods, start_time, end_time)
    RR_intervals = [];

    for i = 1:size(NREM_periods, 1)
        onset = NREM_periods(i, 1);
        offset = NREM_periods(i, 2);

        if onset < end_time && offset > start_time
            RR_segment = RR(RR_time >= max(onset, start_time) & RR_time <= min(offset, end_time));
            if ~isempty(RR_segment)
                RR_intervals = [RR_intervals; RR_segment];
            end
        end
    end
end