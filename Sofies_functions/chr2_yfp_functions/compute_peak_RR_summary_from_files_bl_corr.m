function [summaryTable_blCorr, event_table_blCorr] = ...
    compute_peak_RR_summary_from_files_bl_corr(...
        dataDirectory, chr2, yfp, sec_after, delay, baseRRTable)
% COMPUTE_PEAK_RR_SUMMARY_FROM_FILES_BL_CORR
%   [summaryTable_blCorr, sigmaSummaryTable, event_table_blCorr] =
%   Baseline‐correct peak RR outputs by subtracting the chr2 baseline
%   meanRR (from baseRRTable) from both:
%     • the group‐summary MeanRRpeak
%     • each trial’s RR_peak
%
% Inputs:
%   dataDirectory – folder of your RR & Sigma .mat files
%   chr2, yfp     – cell arrays of subject IDs
%   sec_after     – seconds after laser to search for peak
%   delay         – seconds after laser before RR window starts
%   baseRRTable   – table from compute_RR_summary_from_files, with columns:
%                   {'LaserLevel','Group','MeanRR','SDRR','SEMRR','DataCount'}
%
% Outputs:
%   summaryTable_blCorr – same as compute_peak… summaryTable but only chr2,
%                         with MeanRRpeak ← MeanRRpeak – chr2_baseline
%   sigmaSummaryTable   – pass‐through from compute_peak… (unchanged)
%   event_table_blCorr  – only chr2 trials, plus CorrRR_peak = RR_peak – chr2_baseline

    % 1) get the raw peak outputs
    [summaryTable, ~, ~, event_table] = ...
        compute_peak_RR_summary_from_files_w_sigma( ...
            dataDirectory, chr2, yfp, sec_after, delay);

    % 2) extract chr2 baseline means by laser level
    isChr2Base = strcmp(baseRRTable.Group,'chr2');
    baseChr2   = baseRRTable(isChr2Base,:);
    maxLvl     = max(baseChr2.LaserLevel);
    baselineMean = nan(maxLvl,1);
    for L = 1:maxLvl
        idx = baseChr2.LaserLevel == L;
        if any(idx)
            baselineMean(L) = baseChr2.MeanRR(idx);
        end
    end

    % 3) build baseline‐corrected summaryTable (only chr2 rows)
    isChr2Sum = strcmp(summaryTable.Group,'chr2');
    summaryTable_blCorr = summaryTable(isChr2Sum,:);
    % subtract baseline from the peak‐RR mean
    for i = 1:height(summaryTable_blCorr)
        L = summaryTable_blCorr.LaserLevel(i);
        summaryTable_blCorr.MeanRRpeak(i) = ...
            summaryTable_blCorr.MeanRRpeak(i) - baselineMean(L);
    end

    % 4) build baseline‐corrected event_table (only chr2 trials)
    isChr2Evt = ismember(event_table.SubjectID, chr2);
    event_table_blCorr = event_table(isChr2Evt,:);
    % subtract baseline from each trial’s RR_peak
    event_table_blCorr.CorrRR_peak = nan(height(event_table_blCorr),1);
    for i = 1:height(event_table_blCorr)
        L = event_table_blCorr.LaserLevel(i);
        event_table_blCorr.CorrRR_peak(i) = ...
            event_table_blCorr.RR_peak(i) - baselineMean(L);
    end

end
