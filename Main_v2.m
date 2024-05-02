%% Load your data

% M399 = preprocess_sleep_data('', '', 'BuBo', 'V_Bo', 'Pu2_', (100:7000), 'save_path', '');
% M392 = preprocess_sleep_data('', '', 'BuBo', 'V_Bo', 'Pu2_', (100:7000), 'save_path', ''); 
% M403 = preprocess_sleep_data('', '', 'BuBo', 'V_Bo', 'Pu2_', (100:7000), 'save_path', '');
% M412 = preprocess_sleep_data('', '', 'BuBo', 'V_Bo', 'Pu2_', (100:7000), 'save_path', '');
% M414 = preprocess_sleep_data('', '', 'BuBo', 'V_Bo', 'Pu2_', (100:7000), 'save_path', '');
% M416 = preprocess_sleep_data('', '', 'BuBo', 'V_Bo', 'Pu2_', (100:7000), 'save_path', '');
% M418 = preprocess_sleep_data('', '', 'BuBo', 'V_Bo', 'Pu2_', (100:7000), 'save_path', '');
% M486 = preprocess_sleep_data('', '', 'BuBo', 'V_Bo', 'PtC1', (100:7000), 'save_path', '');
% M408 = preprocess_sleep_data('', '', 'BuBo', 'V_Bo', 'Pu2_', (100:7000), 'save_path', '');
% M420 = preprocess_sleep_data('', '', 'BuBo', 'V_Bo', 'Pu2_', (100:7000), 'save_path', '');

%timecorrctions
% recording_ID	time_correction_in_s
% 387_Arch	2
% 399_Arch	2
% 392_Arch	4
% 403_Arch	3
% 412_Arch	4
% 414_Arch	3
% 416_Arch	4
% 418_Arch	5
% 486_Arch	2
% 408_YFP	    1
% 420_YFP	    0
% 468_YFP	    3
% 477_YFP	    1
% 484_YFP	    1

%build-up
%name = {'file_destination_FP' 'file_destination_EEG' 'animal number' 'time correction if needed' '' 'NE data' 'FP control' '' 'EEG channel name' 'EEG channel name' 'EMG channel name 1' 'synchronization pulse name FP rig' 'synchronization pulse name EEG rig'  'time period for fitting' 'sleep data'};
%For viewpoint files, load in .exp file in the 2nd place
%Animal muner is now in the 3rd place and time correction in the 4th

M387 = {'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\387_arch' 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\387_arch\387_Arch_NOR\387_Arch_NOR_2021-03-12_11-52-27-496.exp' '387' '2' '' 'BuBo', 'V_Bo' '' '' '' '' 'Pu2_' 'Pu2_'  (1:15000) 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\387_arch\387_Arch_NOR\387_NOR_sleepscore.xlsx'};
%M399 = {'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\399_arch' 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\399_arch\399_Arch_NOR\399_Arch_NOR_2021-03-12_14-46-42-245.exp' '399' '2' '' 'BuBo', 'V_Bo' '' '' '' '' 'Pu2_' 'Pu2_'  (1:15000) 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\399_arch\399_Arch_NOR\399_NOR_sleepscore.xlsx'};
%M392 = {'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\392_arch' 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\392_arch\392_Arch_NOR\392_Arch_NOR_2021-03-10_10-31-55-535.exp' '392' '4' '' 'BuBo', 'V_Bo' '' '' '' '' 'Pu2_' 'Pu2_'  (1:15000) 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\387_arch\387_Arch_NOR\387_NOR_sleepscore.xlsx'};
%M403 = {'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\403_arch' 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\403_arch\403_Arch_NOR\403_Arch_NOR_2021-03-12_08-56-13-288.exp' '403' '3' '' 'BuBo', 'V_Bo' '' '' '' '' 'Pu2_' 'Pu2_'  (1:15000) 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\387_arch\387_Arch_NOR\387_NOR_sleepscore.xlsx'};
%M412 = {'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\412_arch' 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\412_arch\412_Arch_NOR\412_Arch_NOR_2021-03-08_13-27-00-781.exp' '412' '4' '' 'BuBo', 'V_Bo' '' '' '' '' 'Pu2_' 'Pu2_'  (1:15000) 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\387_arch\387_Arch_NOR\387_NOR_sleepscore.xlsx'};
%M414 = {'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\414_arch' 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\414_arch\414_Arch_NOR\414_Arch_NOR_2021-03-10_13-19-57-296.exp' '414' '3' '' 'BuBo', 'V_Bo' '' '' '' '' 'Pu2_' 'Pu2_'  (1:15000) 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\387_arch\387_Arch_NOR\387_NOR_sleepscore.xlsx'};
%M416 = {'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\416_arch' 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\416_arch\416_Arch_NOR\416_Arch_NOR_2021-03-09_10-14-39-452.exp' '416' '4' '' 'BuBo', 'V_Bo' '' '' '' '' 'Pu2_' 'Pu2_'  (1:15000) 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\399_arch\399_Arch_NOR\399_NOR_sleepscore.xlsx'};
%M418 = {'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\418_arch' 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\418_arch\418_Arch_NOR\418_Arch_NOR_2021-03-09_13-02-50-098.exp' '418' '5' '' 'BuBo', 'V_Bo' '' '' '' '' 'Pu2_' 'Pu2_'  (1:15000) 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\399_arch\399_Arch_NOR\399_NOR_sleepscore.xlsx'};
%M468 = {'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\468_YFP' 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\468_YFP\NOR_468_YFP\NOR_468_YFP_2021-07-08_10-12-51-316.exp' '468' '3' '' 'BuBo', 'V_Bo' '' '' '' '' 'PtC1' 'PtC1'  (1:15000) 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\399_arch\399_Arch_NOR\399_NOR_sleepscore.xlsx'};
M420 = {'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\420_YFP' 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\420_YFP\420_YFP_NOR\420_YFP_NOR_2021-03-09_15-53-26-919.exp' '420' '0' '' 'BuBo', 'V_Bo' '' '' '' '' 'Pu2_' 'Pu2_'  (1:15000) 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\399_arch\399_Arch_NOR\399_NOR_sleepscore.xlsx'};
%M477 = {'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\477_YFP' 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\477_YFP\NOR_477_YFP\NOR_477_YFP_2021-07-08_13-03-24-035.exp' '477' '1' '' 'BuBo', 'V_Bo' '' '' '' '' 'PtC1' 'PtC1'  (1:15000) 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\399_arch\399_Arch_NOR\399_NOR_sleepscore.xlsx'};
%M484 = {'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\484_YFP' 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\484_YFP\NOR_484_YFP\NOR_484_YFP_2021-07-07_10-04-57-598.exp' '484' '1' '' 'BuBo', 'V_Bo' '' '' '' '' 'PtC1' 'PtC1'  (1:15000) 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\opto_NOR\399_arch\399_Arch_NOR\399_NOR_sleepscore.xlsx'};

%saline
%M015 = {'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\saline injection\15_sal\20221013_ACh_DPH_15_21' 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\saline injection\15_sal\15_ACh_sal\15_ACh_sal_2022-10-13_10-34-10-557.exp' '015' '4' '' 'x465A', 'x405A' '' '' '' '' 'Pu1_' 'Pu1_'  (1:15000) 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\saline injection\15_sal\15_ACh_sal\15_ACh_sal_sleepscore.xlsx'};
M084 = {'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\saline injection\484_sal\20210716_EEGFP_484_sal' 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\saline injection\484_sal\484_sal\484_sal_2021-07-16_09-25-48-573.exp' '084' '0' '' 'BuBo' 'V_Bo' '' '' '' '' 'PtC0' 'PtC0'  (1:15000) 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\saline injection\484_sal\484_sal\484_sal_sleepscore_1s.xlsx'}; %Renamed to not be the same as the other one
%M569 = {'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\saline injection\569_sal\20220807_DPH_580_569' 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\saline injection\569_sal\569_sal\569_sal_2022-08-07_10-34-40-287.exp' '569' '1' '' 'x465C' 'x405C' '' '' '' '' 'Pu1_' 'Pu1_'  (1:15000) 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\saline injection\569_sal\569_sal\569_sal_sleepscore.xlsx'};
%M578 = {'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\saline injection\578_sal\20220807_DPH_578_584' 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\saline injection\578_sal\578_sal\578_sal_2022-08-07_06-48-50-071.exp' '578' '2' '' 'x465A', 'x405A' '' '' '' '' 'Pu1_' 'Pu1_'  (1:15000) 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\saline injection\578_sal\578_sal\578_sleepscore.xlsx'};
M580 = {'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\saline injection\580_sal\20220810_DPH_580_569' 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\saline injection\580_sal\580_sal\580_sal_2022-08-10_10-24-28-685.exp' '580' '4' '' 'x465A', 'x405A' '' '' '' '' 'Pu1_' 'Pu1_'  (1:15000) 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\saline injection\580_sal\580_sal\850_sal_sleepcsore.xlsx'}; %sleepscore file named incorreclty in drive
M588 = {'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\saline injection\588_sal\20220809_DPH_588_592' 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\saline injection\588_sal\588_sal\588_sal_2022-08-09_10-31-22-994.exp' '588' '1' '' 'x465A', 'x405A' '' '' '' '' 'Pu1_' 'Pu1_'  (1:15000) 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\saline injection\588_sal\588_sal\588_sal_sleepscore.xlsx'}; 
%M592 = {'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\saline injection\592_sal\20220806_diphenH_588_592' 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\saline injection\592_sal\592_sal\592_sal_2022-08-06_10-37-48-796.exp' '592' '1' '' 'x465C' 'x405C' '' '' '' '' 'Pu1_' 'Pu1_'  (1:15000) 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\saline injection\592_sal\592_sal\592_sal_sleepscore.xlsx'};
M600 = {'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\saline injection\600_sal\20220806_diphenH_602_600' 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\saline injection\600_sal\600\600_2022-08-06_06-52-56-321.exp' '600' '0' '' 'x465C' 'x405C' '' '' '' '' 'Pu1_' 'Pu1_'  (1:15000) 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\saline injection\600_sal\600_sal\600_sal_sleepscore.xlsx'};
M602 = {'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\saline injection\602_sal\20220809_DPH_600_602' 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\saline injection\602_sal\602_sal\602_sal_2022-08-09_06-54-24-717.exp' '602' '2' '' 'x465C' 'x405C' '' '' '' '' 'Pu1_' 'Pu1_'  (1:15000) 'J:\CTN\NedergaardLAB\Personal_folders\VU\U19 Datacore example data\Mie_newdata\saline injection\602_sal\602_sal\602_sal_sleepscore.xlsx'};

%Acetylecholine extra files
%M007 = {'J:\CTN\NedergaardLAB\Personal_folders\Tessa\ACh3.0_group1\FP_EEG\FP\20220228_007_ACh_1_NE_2_take3' 'J:\CTN\NedergaardLAB\Personal_folders\Tessa\ACh3.0_group1\FP_EEG\EEG\20220228_007_EEG_EMG_take2_scored/20220228_007_EEG_EMG_take2_2022-02-28_14-45-39-008.exp' '007' '2' '' 'x65C' 'x05C' '' '' '' '' 'Pu1_' 'Pu1_' (1000:12000) 'J:\CTN\NedergaardLAB\Personal_folders\Tessa\ACh3.0_group1\FP_EEG\EEG\20220228_007_EEG_EMG_take2_scored/007_sleepscore.xlsx' };
%M003 = {'J:\CTN\NedergaardLAB\Personal_folders\Tessa\ACh3.0_group1\FP_EEG\FP\20220304_003_final_ACh_1' 'J:\CTN\NedergaardLAB\Personal_folders\Tessa\ACh3.0_group1\FP_EEG\EEG\20220304_003_final/20220304_003_final_2022-03-04_09-34-05-362.exp' '003' '5' '' 'x65C' 'x05C' '' '' '' '' 'Pu1_' 'Pu1_' (500:750)  'J:\CTN\NedergaardLAB\Personal_folders\Tessa\ACh3.0_group1\FP_EEG\EEG\20220304_003_final/003_sleepscore.xlsx'}; %cut FP 94 s
%M015 = {'J:\CTN\NedergaardLAB\Personal_folders\Tessa\ACh_NE_albumin_group2\sleep\FP\20220523_015_1_ACh_f' 'J:\CTN\NedergaardLAB\Personal_folders\Tessa\ACh_NE_albumin_group2\sleep\EEG\20220523_015_box3_scored\20220523_015_box3_2022-05-23_10-08-39-331.exp'  '015' '0' '' 'x465C' 'x405C' '' '' '' '' 'Pu1_' 'Pu1_' '' 'J:\CTN\NedergaardLAB\Personal_folders\Tessa\ACh_NE_albumin_group2\sleep\EEG\20220523_015_box3_scored/015_sleepscore.xlsx'};
%M017 = {'J:\CTN\NedergaardLAB\Personal_folders\Tessa\ACh_NE_albumin_group2\sleep\FP\20220602_017_1_ACh_2_NE' 'J:\CTN\NedergaardLAB\Personal_folders\Tessa\ACh_NE_albumin_group2\sleep\EEG\20220602_017_EEG_EMG_scored\20220602_017_EEG_EMG_2022-06-02_14-00-09-032.exp' '017' '0' '' 'x465C' 'x405C' '' '' '' '' 'Pu1_' 'Pu1_' '''J:\CTN\NedergaardLAB\Personal_folders\Tessa\ACh_NE_albumin_group2\sleep\EEG\20220602_017_EEG_EMG_scored/017_ACh_sleepscore.xlsx' }; 
%M019 = {'J:\CTN\NedergaardLAB\Personal_folders\Tessa\ACh_NE_albumin_group2\sleep\FP\20220602_019_1_ACh_2_NE' 'J:\CTN\NedergaardLAB\Personal_folders\Tessa\ACh_NE_albumin_group2\sleep\EEG\20220602_019_EEG_EMG_scored\20220602_019_EEG_EMG_2022-06-02_10-14-19-397.exp' '019' '0' '' 'x465C' 'x405C' '' '' '' '' 'Pu1_' 'Pu1_' '''J:\CTN\NedergaardLAB\Personal_folders\Tessa\ACh_NE_albumin_group2\sleep\EEG\20220602_019_EEG_EMG_scored/019_sleepscore.xlsx' }; %use deltafit4
%M021 = {'J:\CTN\NedergaardLAB\Personal_folders\Tessa\ACh_NE_albumin_group2\sleep\FP\20220523_021_1_ACh_2_NE' 'J:\CTN\NedergaardLAB\Personal_folders\Tessa\ACh_NE_albumin_group2\sleep\EEG\20220523_021_EEG_TTL_scored\20220523_021_EEG_TTL_2022-05-23_14-15-14-291.exp' '021' '0' '' 'x465C' 'x405C' '' '' '' '' 'Pu1_' 'Pu1_' '''J:\CTN\NedergaardLAB\Personal_folders\Tessa\ACh_NE_albumin_group2\sleep\EEG\20220523_021_EEG_TTL_scored/021_sleepscore.xlsx' }; 
%M023 = {'J:\CTN\NedergaardLAB\Personal_folders\Tessa\ACh_NE_albumin_group2\sleep\FP\20220603_023_1_ACh_2_NE' 'J:\CTN\NedergaardLAB\Personal_folders\Tessa\ACh_NE_albumin_group2\sleep\EEG\20220603_023_EEG_EMG_scored\20220603_023_EEG_EMG_2022-06-03_11-12-03-064.exp' '023' '0' '' 'x465C' 'x405C' '' '' '' '' 'Pu1_' 'Pu1_' '''J:\CTN\NedergaardLAB\Personal_folders\Tessa\ACh_NE_albumin_group2\sleep\EEG\20220603_023_EEG_EMG_scored/023_sleepscore.xlsx'}; 
M025 = {'J:\CTN\NedergaardLAB\Personal_folders\Tessa\ACh_NE_albumin_group2\sleep\FP\20220601_025_1_ACh_2_NE' 'J:\CTN\NedergaardLAB\Personal_folders\Tessa\ACh_NE_albumin_group2\sleep\EEG\20220601_025_EEG_EMG_scored_4h\20220601_025_EEG_EMG_2022-06-01_10-08-18-249_SJ.exp' '025' '0' '' 'x465C' 'x405C' '' '' '' '' 'Pu1_' 'Pu1_' '''J:\CTN\NedergaardLAB\Personal_folders\Tessa\ACh_NE_albumin_group2\sleep\EEG\20220601_025_EEG_EMG_scored_4h/025_sleepscore_2024.xlsx'}; 

%Dopamine extra files
%no TTL pulse (cut FP trace by 130), DA and NE good (NE needs to be normalized to median)
%M003 = {'J:\CTN\NedergaardLAB\Personal_folders\Tessa\DA_group5\sleep\FP\20220920_1_DA_2_NE_003' 'J:\CTN\NedergaardLAB\Personal_folders\Tessa\DA_group5\sleep\EEG\20220920_DA_003_scored/20220920_DA_003_2022-09-20_13-36-33-425.exp' '003' '0' '' 'x465C' 'x405C' '' '' '' '' 'PtC0' 'PtC0' (200:1800) 'J:\CTN\NedergaardLAB\Personal_folders\Tessa\DA_group5\sleep\EEG\20220920_DA_003_scored/003_sleepscore.xlsx'}; %cut 130 s from the beginning
%DA (oscillates with high amplitude) and NE oscillate nicely, but NE needs to be normalized to median
%M005 = {'J:\CTN\NedergaardLAB\Personal_folders\Tessa\DA_group5\sleep\FP\20220922_1_DA_2_NE_005_take2' 'J:\CTN\NedergaardLAB\Personal_folders\Tessa\DA_group5\sleep\EEG\20220921_DA_005_take2_scored/20220921_DA_005_take2_2022-09-22_14-02-12-395.exp' '005' '0' '' 'x465A' 'x405A' '' '' '' '' 'PtC0' 'PtC0' (200:1400) 'J:\CTN\NedergaardLAB\Personal_folders\Tessa\DA_group5\sleep\EEG\20220921_DA_005_take2_scored/005_sleepscore.xlsx'}; 

%Histamine extra files
M026 = {'J:\CTN/NedergaardLAB/Personal_folders/Tessa/His_group4/sleep/FP/20220714_His_025' 'J:\CTN\NedergaardLAB\Personal_folders\Tessa\His_group4\sleep\EEG\20220714_His_025_scored\20220714_His_025_2022-07-14_13-08-20-709.exp' '026' '0' '' 'x465C' 'x405C' '' '' '' '' 'PtC0' 'PtC0' 0 (10:2000) 'J:\CTN/NedergaardLAB/Personal_folders/Tessa/His_group4/sleep/EEG/20220714_His_025/His_025_xlsx.xlsx'}; %cut 250 s from the beginning
M015 = {'J:\CTN/NedergaardLAB/Personal_folders/Tessa/His_group4/sleep/FP/20220712_His_015' 'J:\CTN\NedergaardLAB\Personal_folders\Tessa\His_group4\sleep\EEG\20220712_His_015_scored_no_REM/20220712_His_015_2022-07-12_13-40-09-809.exp' '015' '0' '' 'x465C' 'x405C' '' '' '' '' 'PtC0' 'PtC0' 0 (10:2000)}; 
%M017 = {'J:\CTN/NedergaardLAB/Personal_folders/Tessa/His_group4/sleep/FP/20220711_His_017' 'J:\CTN/NedergaardLAB/Personal_folders/Tessa/His_group4/sleep/EEG/20220709_his_017_scored/20220709_his_015_2022-07-11_09-15-36-124.exp' '017' '0' '' 'x465C' 'x405C' '' '' '' '' 'PtC0' 'PtC0' 0 (10:2000)}; %cut 380 s from the beggining
%M021 = {'J:\CTN/NedergaardLAB/Personal_folders/Tessa/His_group4/sleep/FP/20220713_His_021' 'J:\CTN\NedergaardLAB\Personal_folders\Tessa\His_group4\sleep\EEG\20220713_His_021_scored\20220713_His_021_2022-07-13_12-47-12-647.exp' '021' '0' '' 'x465C' 'x405C' '' '' '' '' 'PtC0' 'PtC0' 0 (10:2000)}; 
%M023 = {'J:\CTN/NedergaardLAB/Personal_folders/Tessa/His_group4/sleep/FP/20220713_His_023' 'J:\CTN\NedergaardLAB\Personal_folders\Tessa\His_group4\sleep\EEG\20220712_His_023_scored\20220712_His_023_2022-07-12_17-45-11-892.exp' '023' '0' '' 'x465C' 'x405C' '' '' '' '' 'PtC0' 'PtC0' 0 (10:2000)}; 

%Anestesias mice
%M071 = {'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\071_073_5am_sleep' 'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\071_073_5am_sleep' '071' '' '' 'x465A' 'x405A' '' 'EEGw' 1 'EMG1' '' '' (1:18000) ''};
%M073 = {'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\071_073_5am_sleep' 'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\071_073_5am_sleep' '073' '' '' 'x465C' 'x405C' '' 'EEGw' 2 'EMG2' '' '' (1:18000) ''};

%Klaudias files
M101 = {'J:\CTN\NedergaardLAB\Personal_folders\Klaudia\Celia\For Sofie\Mouse0_1Day1Rec' 'J:\CTN\NedergaardLAB\Personal_folders\Klaudia\Celia\For Sofie\Mouse0_1Day1Rec' '101' '' '' 'x465A' 'x405A' '' 'EEGw' 1 'EMG1' 'Tick' 'Tick' (1:20000) 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\practice data\mouse_117\117_sleep\6h FP and EEG\Score_117.xlsx'};
M102 = {'J:\CTN\NedergaardLAB\Personal_folders\Klaudia\Celia\For Sofie\Mouse0_1Day1Rec' 'J:\CTN\NedergaardLAB\Personal_folders\Klaudia\Celia\For Sofie\Mouse0_1Day1Rec' '102' '' '' 'x465C' 'x405C' '' 'EEGw' 2 'EMG2' 'Tick' 'Tick' (1:20000) 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\practice data\mouse_117\117_sleep\6h FP and EEG\Score_117.xlsx'};
M103 = {'J:\CTN\NedergaardLAB\Personal_folders\Klaudia\Celia\For Sofie\Mouse0_1Day2Rec' 'J:\CTN\NedergaardLAB\Personal_folders\Klaudia\Celia\For Sofie\Mouse0_1Day2Rec' '103' '' '' 'x465A' 'x405A' '' 'EEGw' 1 'EMG1' 'Tick' 'Tick' (1:20000) 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\practice data\mouse_117\117_sleep\6h FP and EEG\Score_117.xlsx'};
M104 = {'J:\CTN\NedergaardLAB\Personal_folders\Klaudia\Celia\For Sofie\Mouse0_1Day2Rec' 'J:\CTN\NedergaardLAB\Personal_folders\Klaudia\Celia\For Sofie\Mouse0_1Day2Rec' '104' '' '' 'x465C' 'x405C' '' 'EEGw' 2 'EMG2' 'Tick' 'Tick' (1:20000) 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\practice data\mouse_117\117_sleep\6h FP and EEG\Score_117.xlsx'};


M117 = {'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\practice data\mouse_117' 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\practice data\mouse_117' '117' '' '' 'x465C' 'x405C' '' 'EEGw' 1 'EMG1' 'PtC0' 'PtC0' (1:20000) 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\practice data\mouse_117\117_sleep\6h FP and EEG\Score_117.xlsx'};
M124 = {'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\practice data\mouse_124' 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\practice data\mouse_117' '124' '' '' 'Dv4C' 'Dv5C' 'red' 'EEGw' 2 'EMG2' 'PtC0' 'PtC0' (1:20000) 'C:\Users\trb938\OneDrive - University of Copenhagen\MATLAB\practice data\mouse_124\124_sleep\6h FP and EEG\Score_124.xlsx'};
%M168 = {'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\mouse_168' 'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\mouse_168' '168' '' '' 'x465A' 'x405A' 'red' 'EEGw' 1 'EMG1' '' '' (1:18000) 'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\mouse_168\168_sleep_data.xlsx'};
%M147 = {'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\147_149_5_51_am_sleep_rec\mouse_147' 'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\147_149_5_51_am_sleep_rec\mouse_147' '147' '' '' 'x465A' 'x405A' 'red' 'EEGw' 1 'EMG1' '' '' (1:18000) 'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\147_149_5_51_am_sleep_rec\mouse_147\147_sleep_data.xlsx'};
%M149 = {'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\147_149_5_51_am_sleep_rec\mouse_149' 'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\147_149_5_51_am_sleep_rec\mouse_149' '149' '' '' 'x465C' 'x405C' 'red' 'EEGw' 2 'EMG2' '' '' (1:18000) 'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\147_149_5_51_am_sleep_rec\mouse_149\149_sleep_data.xlsx'};
M100 = {'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\EEGnofilt_Sara' 'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\EEGnofilt_Sara' '100' '' '' 'x465A' 'x405A' 'red' 'EEGw' 1 'EMG1' 'PtC0' 'PtC0' (1:18000) 'J:\CTN\NedergaardLAB\KjaerbyLab\Sofie\EEGnofilt_Sara\M100_sleep_new.xlsx'};

%mice_saline = {M015, M084, M569, M578, M580, M588, M592, M600, M602};
mice = {M168, M147, M149, M117, M124, M387, M392, M403, M412, M414, M416, M418, M468, M420, M477, M484,M015, M084, M569, M578, M580, M588, M592, M600, M602};
mice_without_TTL = {M168, M147, M149, M071, M073, M100};
mice_TTL = {M124, M117, M101, M102, M103, M104};
viewpoint_mice = {'M017', 'M026', 'M003', 'M005', 'M019', 'M021', 'M023', 'M025', 'M387', 'M399', 'M392', 'M403', 'M412', 'M414', 'M416', 'M418', 'M468', 'M420', 'M477','M484', 'M015', 'M084', 'M569', 'M578', 'M580', 'M588', 'M592', 'M600', 'M602'};
synapse_mice = {M168, M147, M149, M117, M124, M071, M073};
mice_without_TTL = {};
%RR_mice_sal_yfp = {M420, M580, M588};
%mice_without_TTL = {};

viewpoint_mice = {'M026', 'M015', 'M025','M420', 'M580', 'M588'};

o = {M025, M026, M420, M580, M588};
o = {M420, M588, M117, M124};
o = {M124};
% Create a matrix of mice pairs where the first column is the mouse without EEG data
% and the second column is the mouse with EEG data

mice_pairs = {'M124', 'M117', 'M149', 'M147', 'M073', 'M071', 'M102', 'M101', 'M104', 'M103'}; % Example given with M124 and M117 - col 2 has the data

% Reshape mice_pairs into a two-column format
num_pairs = numel(mice_pairs) / 2;
mice_pairs = reshape(mice_pairs, 2, num_pairs).';

mice_without_TTL_IDs = {};

%Extract names of the mice withoutTTL for later use
for idx = 1:length(mice_without_TTL)
    m = mice_without_TTL{idx}; % Assuming mouse is a cell array with relevant data
    ID = sprintf('M%s', m{3}); % Extract the ID as intended
    mice_without_TTL_IDs{end+1} = ID; % Correctly append ID to the cell array
end

mice_with_TTL_IDs = {};

%Extract names of the mice withoutTTL for later use
for idx = 1:length(mice_TTL)
    t = mice_TTL{idx}; % Assuming mouse is a cell array with relevant data
    ID = sprintf('M%s', t{3}); % Extract the ID as intended
    mice_with_TTL_IDs{end+1} = ID; % Correctly append ID to the cell array
end

%% Load FP and EEG data for all mice

for idx = 1:length(o)
    mouse = o{idx};
    % Since mouse{3} contains the ID for all mice, directly use it to create the mouseID
    mouseID = sprintf('M%s', mouse{3}); % mouse{3} is directly used, making mouseID a char array
    
    % Debugging print to verify mouseID
    disp(mouseID);
    
    % Define the FP and EEG variable names based on the mouse ID
    data_FPrig_varName = sprintf('data_FPrig_%s', mouse{3});
    
    % Load FP rig data for all mice
    eval([data_FPrig_varName, ' = TDTbin2mat(mouse{1});']);

    % Skip loading EEG data for viewpoint mice by comparing the string directly
    if ~ismember(mouseID, viewpoint_mice) && ~ismember(mouseID, mice_pairs(:, 1))
        % Note: Since mouseID is a char, we use it directly without braces
        data_EEGrig_varName = sprintf('data_EEGrig_%s', mouse{3});
        eval([data_EEGrig_varName, ' = TDTbin2mat(mouse{2});']); % Load EEG rig data if conditions are met
    end
    % Viewpoint EEG is handled in a separate function later
end
%% Preprocess FP, EEG and EMG
%For each mouse, check if they are part of the group with out a TTL pulse
%Either way, check if they have a partner ID with the EEG data, if yes: use
%the EEG rig from that animal and extract channel 2. If not, use it's own
%ID for the EEG rig.

for idx = 1:length(o)
    mouse = o{idx};
    mouseID = sprintf('M%s', mouse{3}); % Extract the ID
    disp(mouseID)

    data_FPrig_input = eval(sprintf('data_FPrig_%s', mouse{3}));
        % Check if the current mouse identifier is in the mice_without_TTL list
    if ismember(mouseID, mice_without_TTL_IDs)
                % Determine if this mouse needs to pull EEG/EMG data from a partner
        partnerIdx = find(strcmp(mice_pairs(:,1), mouseID));
        disp(partnerIdx)
        if isempty(partnerIdx)
            % This mouse has its own EEG data
            partnerData = eval(sprintf('data_EEGrig_%s', mouse{3}));
        else
            % This mouse needs to use its partner's EEG data
            partnerID = mice_pairs{partnerIdx, 2};
            % Remove any letters from partnerID, keeping only digits
            partnerID_numeric = regexprep(partnerID, '\D', '');
            disp(partnerID_numeric)
            % Now use the modified partnerID_numeric in eval
            partnerData = eval(sprintf('data_EEGrig_%s', partnerID_numeric));
        end
        % Call processSignals_without_TTL function for mice without TTL
        [delta465_filt_2, sec_signal_2, signal_fs, EEG, EMG, sec_signal_EEG, EEG_fs] = processSignals_without_TTL(mouse, data_FPrig_input, partnerData);

    elseif ismember(mouseID, viewpoint_mice)
        %Process viewpoint data with TTL in it's own way
        [delta465_filt_2, sec_signal_2, signal_fs, EEG, EMG, sec_signal_EEG, EEG_fs, onset_FP_EEG, EEG_rig] = processSignals_Viewpoint_with_TTL(mouse, data_FPrig_input);
        eval(sprintf('data_EEGrig_%s = EEG_rig;', mouse{3}));
        eval(sprintf('onset_FP_EEG_%s = onset_FP_EEG;', mouse{3}));
        disp('is a viewpoint mouse')
    else
        % Determine if this mouse needs to pull EEG/EMG data from a partner
        partnerIdx = find(strcmp(mice_pairs(:,1), mouseID));
        if isempty(partnerIdx)
            % This mouse has its own EEG data
            partnerData = eval(sprintf('data_EEGrig_%s', mouse{3}));
        else
            % This mouse needs to use its partner's EEG data
            partnerID = mice_pairs{partnerIdx, 2};
            % Remove any letters from partnerID, keeping only digits
            partnerID_numeric = regexprep(partnerID, '\D', '');
            disp(partnerID_numeric)
            % Now use the modified partnerID_numeric in eval
            partnerData = eval(sprintf('data_EEGrig_%s', partnerID_numeric));
        end
    
        % Now call processSignals with partnerData
        [delta465_filt_2, sec_signal_2, signal_fs, EEG, EMG, sec_signal_EEG, EEG_fs, onset_FP_EEG] = processSignals(mouse, data_FPrig_input, partnerData);
        eval(sprintf('onset_FP_EEG_%s = onset_FP_EEG;', mouse{3}));
    end
        % Dynamically save the output variables with mouse-specific names
    eval(sprintf('delta465_filt_2_%s = delta465_filt_2;', mouse{3}));
    eval(sprintf('sec_signal_2_%s = sec_signal_2;', mouse{3}));
    eval(sprintf('signal_fs_%s = signal_fs;', mouse{3}));
    eval(sprintf('EEG_%s = EEG;', mouse{3}));
    eval(sprintf('EMG_%s = EMG;', mouse{3}));
    eval(sprintf('sec_signal_EEG_%s = sec_signal_EEG;', mouse{3}));
    eval(sprintf('EEG_fs_%s = EEG_fs;', mouse{3}));
end
%% cut start of signal
for idx = 1:length(o)
    mouse = o{idx};
    uniqueId = mouse{3}; % Extract unique identifier

    delta465_var_name = sprintf('delta465_filt_2_%s', uniqueId);
    sec_signal_2_var_name = sprintf('sec_signal_2_%s', uniqueId);
    delta465_filt_2 = eval(delta465_var_name);
    EEG_var_name = sprintf('EEG_%s', uniqueId);
    sec_signal_EEG_var_name = sprintf('sec_signal_EEG_%s', uniqueId);
    EEG = eval(EEG_var_name);
    signal_fs_var_name = sprintf('signal_fs_%s', uniqueId);
    EEG_fs_var_name = sprintf('EEG_fs_%s', uniqueId);
    EEG_fs = eval(EEG_fs_var_name);
    signal_fs = eval(signal_fs_var_name);

    samplesToRemove_EEG_EMG = EEG_fs; % Number of samples in 1 second for EEG and EMG
    samplesToRemove_FP = signal_fs; % Number of samples in 1 second for photometry signals

    % Directly trim the first second from EEG and EMG
    EEG = EEG(samplesToRemove_EEG_EMG:end);
    EMG = EMG(samplesToRemove_EEG_EMG:end);
    sec_signal_EEG = (1:length(EEG))/EEG_fs;
    eval(sprintf('EEG_%s = EEG;', mouse{3}));
    eval(sprintf('EMG_%s = EMG;', mouse{3}));
    eval(sprintf('sec_signal_EEG_%s = sec_signal_EEG;', mouse{3}));

    % Directly trim the first second from signal_405_2 and signal_465_2
    delta465_filt_2 = delta465_filt_2(samplesToRemove_FP:end);
    sec_signal_2 = (1:length(delta465_filt_2))/signal_fs;
    eval(sprintf('sec_signal_2_%s = sec_signal_2;', mouse{3}));
    eval(sprintf('delta465_filt_2_%s = delta465_filt_2;', mouse{3}));

end
%% QC - Check all traces are there

for idx = 1:length(o)
    mouse = o{idx};
    uniqueId = mouse{3}; % Extract unique identifier
    
    % Creating one figure per mouse
    figure;
    sgtitle(sprintf('Mouse %s', uniqueId)); % Set the figure title with the mouse ID
    
    % Delta465 Filt 2 Signal Plot
    subplot(3,1,1); % Adjust the number of rows as necessary if adding more plots
    delta465_var_name = sprintf('delta465_filt_2_%s', uniqueId);
    sec_signal_2_var_name = sprintf('sec_signal_2_%s', uniqueId);
    delta465_filt_2 = eval(delta465_var_name);
    sec_signal_2 = eval(sec_signal_2_var_name);
    plot(sec_signal_2, delta465_filt_2);
    title('Delta465 Filt 2');
    xlabel('Time (s)');
    ylabel('Delta F/F (%)');
    
    % EEG Signal Plot
    subplot(3,1,2); % Adjust for EEG plot
    EEG_var_name = sprintf('EEG_%s', uniqueId);
    sec_signal_EEG_var_name = sprintf('sec_signal_EEG_%s', uniqueId);
    EEG = eval(EEG_var_name);
    sec_signal_EEG = eval(sec_signal_EEG_var_name);
    plot(sec_signal_EEG, EEG);
    title('EEG');
    xlabel('Time (s)');
    ylabel('EEG Signal');
    
    % EMG Signal Plot (assuming you have EMG variables named similarly)
    subplot(3,1,3); % Adjust for EMG plot
    EMG_var_name = sprintf('EMG_%s', uniqueId);
    EMG = eval(EMG_var_name);
    EEG_fs_var_name = sprintf('EEG_fs_%s', uniqueId); % Adjust variable naming as necessary
    EEG_fs = eval(EEG_fs_var_name);
    sec_signal_EMG = (1:length(EMG))/EEG_fs;
    plot(sec_signal_EMG, EMG);
    title('EMG');
    xlabel('Time (s)');
    ylabel('EMG Signal');
end


%% Downsample FP and filter EEG
    % Normalize fluorescence traces
MeanFilterOrder = 1000; % Order for smoothing
MeanFilter = ones(MeanFilterOrder, 1) / MeanFilterOrder; % Define the mean filter
ds_factor_FP = 100; % Downsample factor

% Loop through each mouse entry in the 'mice' cell array
for idx = 1:length(o)
    mouse = o{idx}; % Current mouse
    uniqueId = mouse{3}; % Extract unique identifier from the third index

    % Generate variable names based on uniqueId
    delta465_var_name = sprintf('delta465_filt_2_%s', uniqueId);
    sec_signal_var_name = sprintf('sec_signal_2_%s', uniqueId);
    
    % Assuming delta465_filt_2 and sec_signal_2 data are loaded in the workspace
    delta465_filt_2 = eval(delta465_var_name);
    sec_signal_2 = eval(sec_signal_var_name);

    % Smooth the delta465_filt_2 signal
    smooth_var_name = sprintf('delta465_filt_2_%s_smooth', uniqueId);
    norm_var_name = sprintf('delta465_filt_2_%s', uniqueId);

    eval([smooth_var_name ' = filtfilt(MeanFilter, 1, delta465_filt_2);']);

    % Downsample the smoothed signal and the corresponding secondary signal
    ds_delta465_var_name_smooth = sprintf('ds_%s', smooth_var_name);
    ds_delta465_var_name = sprintf('ds_%s', norm_var_name);
    ds_sec_signal_var_name = sprintf('ds_%s', sec_signal_var_name);

    eval([ds_delta465_var_name_smooth ' = downsample(' smooth_var_name ', ds_factor_FP);']);
    eval([ds_delta465_var_name ' = downsample(' norm_var_name ', ds_factor_FP);']);
    eval([ds_sec_signal_var_name ' = downsample(' sec_signal_var_name ', ds_factor_FP);']);
end

% Design a bandpass filter
% bpFilt = designfilt('bandpassfir', 'FilterOrder', 100, ...
%     'CutoffFrequency1', 20, 'CutoffFrequency2', 300, ...
%     'SampleRate', EEG_fs_117);
% 
% % Apply the bandpass filter to your EMG data
% filtered_EMG_117 = filtfilt(bpFilt, EMG_117);
% filtered_EMG_124 = filtfilt(bpFilt, EMG_124);
% filtered_EMG_168 = filtfilt(bpFilt, EMG_168);
% filtered_EMG_147 = filtfilt(bpFilt, EMG_147);
% filtered_EMG_149 = filtfilt(bpFilt, EMG_149);


%% Run sleep analysis
%function will give you the variables needed for plotting, further sleep
%periods, NREM without MA and 

% Assuming mice is the master list of all mice
for idx = 1:length(o)
    mouse = o{idx}; % mouse is the current mouse cell array
    mouseID = mouse{3}; % Extract the unique ID from the third index
    disp(['Processing mouse ID: ', mouseID]);
    ID = sprintf('M%s', mouseID);

    % Format the variable names for EEG and other signals
    sec_signal_EEG_var_name = sprintf('sec_signal_EEG_%s', mouseID);
    EEG_fs_var_name = sprintf('EEG_fs_%s', mouseID);
    onset_FP_EEG_var_name = sprintf('onset_FP_EEG_%s', mouseID);

    % Call the appropriate processing function based on group membership
    if ismember(ID, mice_without_TTL_IDs)
        % Call the SleepProcess_without_TTL function
        [wake_woMA_binary_vector, sws_binary_vector, REM_binary_vector, MA_binary_vector, ...
         NREMinclMA_periods, NREMexclMA_periods, wake_periods, REM_periods, MA_periods, ...
         SWS_before_MA_filtered, SWS_before_wake_filtered, SWS_before_REM_filtered, ...
         REM_before_MA_filtered, REM_before_wake_filtered] = SleepProcess_without_TTL(mouse, eval(sec_signal_EEG_var_name), 30, 30, 40);
    elseif ismember(ID, mice_with_TTL_IDs)
        % Call the SleepProcess_TTL function
        [wake_woMA_binary_vector, sws_binary_vector, REM_binary_vector, MA_binary_vector, ...
         NREMinclMA_periods, NREMexclMA_periods, wake_periods, REM_periods, MA_periods, ...
         SWS_before_MA_filtered, SWS_before_wake_filtered, SWS_before_REM_filtered, ...
         REM_before_MA_filtered, REM_before_wake_filtered] = SleepProcess_TTL(mouse, eval(sec_signal_EEG_var_name), eval(EEG_fs_var_name), eval(onset_FP_EEG_var_name), 30, 30, 40);
    elseif ismember(ID, viewpoint_mice)
        % Call the SleepProcess_viewpoint function
        [wake_woMA_binary_vector, sws_binary_vector, REM_binary_vector, MA_binary_vector, ...
         NREMinclMA_periods, NREMexclMA_periods, wake_periods, REM_periods, MA_periods, ...
         SWS_before_MA_filtered, SWS_before_wake_filtered, SWS_before_REM_filtered, ...
         REM_before_MA_filtered, REM_before_wake_filtered] = SleepProcess_viewpoint(mouse, eval(sec_signal_EEG_var_name), eval(onset_FP_EEG_var_name), eval(EEG_fs_var_name), 30, 30, 40);
    else
        disp(['Mouse ID ' mouseID ' does not belong to any known group']);
    end

    % Store the results in dynamically named variables
    vars_to_save = {'wake_woMA_binary_vector', 'sws_binary_vector', 'REM_binary_vector', 'MA_binary_vector', ...
                    'NREMinclMA_periods', 'NREMexclMA_periods', 'wake_periods', 'REM_periods', 'MA_periods', ...
                    'SWS_before_MA_filtered', 'SWS_before_wake_filtered', 'SWS_before_REM_filtered', ...
                    'REM_before_MA_filtered', 'REM_before_wake_filtered'};
    for v = vars_to_save
        eval(sprintf('%s_%s = %s;', v{1}, mouseID, v{1}));
    end
end

% [wake_woMA_binary_vector_117, sws_binary_vector_117, REM_binary_vector_117, MA_binary_vector_117, NREMinclMA_periods_117, NREMexclMA_periods_117, wake_periods_117, REM_periods_117, MA_periods_117, SWS_before_MA_filtered_117, SWS_before_wake_filtered_117, SWS_before_REM_filtered_117, REM_before_MA_filtered_117, REM_before_wake_filtered_117] = SleepProcess_TTL(M117, sec_signal_EEG_117, EEG_fs_117, onset_FP_EEG_117, 20, 20, 15);
% [wake_woMA_binary_vector_124, sws_binary_vector_124, REM_binary_vector_124, MA_binary_vector_124, NREMinclMA_periods_124, NREMexclMA_periods_124, wake_periods_124, REM_periods_124, MA_periods_124, SWS_before_MA_filtered_124, SWS_before_wake_filtered_124, SWS_before_REM_filtered_124, REM_before_MA_filtered_124, REM_before_wake_filtered_124] = SleepProcess_TTL(M124, sec_signal_EEG_124, EEG_fs_124, onset_FP_EEG_124, 20, 20, 15);
% [wake_woMA_binary_vector_168, sws_binary_vector_168, REM_binary_vector_168, MA_binary_vector_168, NREMinclMA_periods_168, NREMexclMA_periods_168, wake_periods_168, REM_periods_168, MA_periods_168, SWS_before_MA_filtered_168, SWS_before_wake_filtered_168, SWS_before_REM_filtered_168, REM_before_MA_filtered_168, REM_before_wake_filtered_168] = SleepProcess_without_TTL(M168, sec_signal_EEG_168, 20, 20, 15);
% [wake_woMA_binary_vector_147, sws_binary_vector_147, REM_binary_vector_147, MA_binary_vector_147, NREMinclMA_periods_147, NREMexclMA_periods_147, wake_periods_147, REM_periods_147, MA_periods_147, SWS_before_MA_filtered_147, SWS_before_wake_filtered_147, SWS_before_REM_filtered_147, REM_before_MA_filtered_147, REM_before_wake_filtered_147] = SleepProcess_without_TTL(M147, sec_signal_EEG_147, 20, 20, 15);
% [wake_woMA_binary_vector_149, sws_binary_vector_149, REM_binary_vector_149, MA_binary_vector_149, NREMinclMA_periods_149, NREMexclMA_periods_149, wake_periods_149, REM_periods_149, MA_periods_149, SWS_before_MA_filtered_149, SWS_before_wake_filtered_149, SWS_before_REM_filtered_149, REM_before_MA_filtered_149, REM_before_wake_filtered_149] = SleepProcess_without_TTL(M149, sec_signal_EEG_149, 20, 20, 15);
% [wake_woMA_binary_vector_073, sws_binary_vector_073, REM_binary_vector_073, MA_binary_vector_073, NREMinclMA_periods_073, NREMexclMA_periods_073, wake_periods_073, REM_periods_073, MA_periods_073, SWS_before_MA_filtered_073, SWS_before_wake_filtered_073, SWS_before_REM_filtered_073, REM_before_MA_filtered_073, REM_before_wake_filtered_073] = SleepProcess_without_TTL(M073, sec_signal_EEG_073, 20, 20, 15);
% 
% [wake_woMA_binary_vector_387, sws_binary_vector_387, REM_binary_vector_387, MA_binary_vector_387, NREMinclMA_periods_387, NREMexclMA_periods_387, wake_periods_387, REM_periods_387, MA_periods_387, SWS_before_MA_filtered_387, SWS_before_wake_filtered_387, SWS_before_REM_filtered_387, REM_before_MA_filtered_387, REM_before_wake_filtered_387] = SleepProcess_viewpoint(M387, sec_signal_EEG_387, onset_FP_EEG_387, EEG_fs_387, 20, 20, 15);
% [wake_woMA_binary_vector_392, sws_binary_vector_392, REM_binary_vector_392, MA_binary_vector_392, NREMinclMA_periods_392, NREMexclMA_periods_392, wake_periods_392, REM_periods_392, MA_periods_392, SWS_before_MA_filtered_392, SWS_before_wake_filtered_392, SWS_before_REM_filtered_392, REM_before_MA_filtered_392, REM_before_wake_filtered_392] = SleepProcess_viewpoint(M392, sec_signal_EEG_392, onset_FP_EEG_392, EEG_fs_392, 20, 20, 15);
% 
% 
% [wake_woMA_binary_vector_403, sws_binary_vector_403, REM_binary_vector_403, MA_binary_vector_403, NREMinclMA_periods_403, NREMexclMA_periods_403, wake_periods_403, REM_periods_403, MA_periods_403, SWS_before_MA_filtered_403, SWS_before_wake_filtered_403, SWS_before_REM_filtered_403, REM_before_MA_filtered_403, REM_before_wake_filtered_403] = SleepProcess_viewpoint(M403, sec_signal_EEG_403, onset_FP_EEG_403, EEG_fs_403, 20, 20, 15);
% [wake_woMA_binary_vector_412, sws_binary_vector_412, REM_binary_vector_412, MA_binary_vector_412, NREMinclMA_periods_412, NREMexclMA_periods_412, wake_periods_412, REM_periods_412, MA_periods_412, SWS_before_MA_filtered_412, SWS_before_wake_filtered_412, SWS_before_REM_filtered_412, REM_before_MA_filtered_412, REM_before_wake_filtered_412] = SleepProcess_viewpoint(M412, sec_signal_EEG_412, onset_FP_EEG_412, EEG_fs_412, 20, 20, 15);
% [wake_woMA_binary_vector_414, sws_binary_vector_414, REM_binary_vector_414, MA_binary_vector_414, NREMinclMA_periods_414, NREMexclMA_periods_414, wake_periods_414, REM_periods_414, MA_periods_414, SWS_before_MA_filtered_414, SWS_before_wake_filtered_414, SWS_before_REM_filtered_414, REM_before_MA_filtered_414, REM_before_wake_filtered_414] = SleepProcess_viewpoint(M414, sec_signal_EEG_414, onset_FP_EEG_414, EEG_fs_414, 20, 20, 15);
% [wake_woMA_binary_vector_416, sws_binary_vector_416, REM_binary_vector_416, MA_binary_vector_416, NREMinclMA_periods_416, NREMexclMA_periods_416, wake_periods_416, REM_periods_416, MA_periods_416, SWS_before_MA_filtered_416, SWS_before_wake_filtered_416, SWS_before_REM_filtered_416, REM_before_MA_filtered_416, REM_before_wake_filtered_416] = SleepProcess_viewpoint(M416, sec_signal_EEG_416, onset_FP_EEG_416, EEG_fs_416, 20, 20, 15);
% [wake_woMA_binary_vector_418, sws_binary_vector_418, REM_binary_vector_418, MA_binary_vector_418, NREMinclMA_periods_418, NREMexclMA_periods_418, wake_periods_418, REM_periods_418, MA_periods_418, SWS_before_MA_filtered_418, SWS_before_wake_filtered_418, SWS_before_REM_filtered_418, REM_before_MA_filtered_418, REM_before_wake_filtered_418] = SleepProcess_viewpoint(M418, sec_signal_EEG_418, onset_FP_EEG_418, EEG_fs_418, 20, 20, 15);
% [wake_woMA_binary_vector_420, sws_binary_vector_420, REM_binary_vector_420, MA_binary_vector_420, NREMinclMA_periods_420, NREMexclMA_periods_420, wake_periods_420, REM_periods_420, MA_periods_420, SWS_before_MA_filtered_420, SWS_before_wake_filtered_420, SWS_before_REM_filtered_420, REM_before_MA_filtered_420, REM_before_wake_filtered_420] = SleepProcess_viewpoint(M420, sec_signal_EEG_420, onset_FP_EEG_420, EEG_fs_420, 20, 20, 15);
% [wake_woMA_binary_vector_468, sws_binary_vector_468, REM_binary_vector_468, MA_binary_vector_468, NREMinclMA_periods_468, NREMexclMA_periods_468, wake_periods_468, REM_periods_468, MA_periods_468, SWS_before_MA_filtered_468, SWS_before_wake_filtered_468, SWS_before_REM_filtered_468, REM_before_MA_filtered_468, REM_before_wake_filtered_468] = SleepProcess_viewpoint(M468, sec_signal_EEG_468, onset_FP_EEG_468, EEG_fs_468, 20, 20, 15);
% 
% [wake_woMA_binary_vector_580, sws_binary_vector_580, REM_binary_vector_580, MA_binary_vector_580, NREMinclMA_periods_580, NREMexclMA_periods_580, wake_periods_580, REM_periods_580, MA_periods_580, SWS_before_MA_filtered_580, SWS_before_wake_filtered_580, SWS_before_REM_filtered_580, REM_before_MA_filtered_580, REM_before_wake_filtered_580] = SleepProcess_viewpoint(M580, sec_signal_EEG_580, onset_FP_EEG_580, EEG_fs_580, 20, 20, 15);
% [wake_woMA_binary_vector_588, sws_binary_vector_588, REM_binary_vector_588, MA_binary_vector_588, NREMinclMA_periods_588, NREMexclMA_periods_588, wake_periods_588, REM_periods_588, MA_periods_588, SWS_before_MA_filtered_588, SWS_before_wake_filtered_588, SWS_before_REM_filtered_588, REM_before_MA_filtered_588, REM_before_wake_filtered_588] = SleepProcess_viewpoint(M588, sec_signal_EEG_588, onset_FP_EEG_588, EEG_fs_588, 20, 20, 15);
% [wake_woMA_binary_vector_025, sws_binary_vector_025, REM_binary_vector_025, MA_binary_vector_025, NREMinclMA_periods_025, NREMexclMA_periods_025, wake_periods_025, REM_periods_025, MA_periods_025, SWS_before_MA_filtered_025, SWS_before_wake_filtered_025, SWS_before_REM_filtered_025, REM_before_MA_filtered_025, REM_before_wake_filtered_025] = SleepProcess_viewpoint(M025, sec_signal_EEG_025, onset_FP_EEG_025, EEG_fs_025, 20, 20, 15);
%% 

delta465_filt_2_100 = delta465_filt_2_100(signal_fs_100*3:end);
EEG_100 = EEG_100(EEG_fs*3:end);
EMG_100 = EMG_100(EEG_fs*3:end);

sec_signal_2_100 = (1:length(delta465_filt_2_100))/signal_fs_100; % time vector for fiber photometry signal
sec_signal_EEG_100 = (1:length(EEG_100))/EEG_fs_100; % time vector for fiber photometry signal

%% QC - plot sleep
% Assuming 'mice' is a list of mouse identifiers like {'168', '149', ...}
for idx = 1:length(o)
    mouse = o{idx};
    disp(mouse{3})
    uniqueId = mouse{3}; % Extract mouse ID as a string

    % Dynamically generate variable names based on the mouse ID
    wake_woMA_varName = sprintf('wake_woMA_binary_vector_%s', uniqueId);
    sws_varName = sprintf('sws_binary_vector_%s', uniqueId);
    REM_varName = sprintf('REM_binary_vector_%s', uniqueId);
    MA_varName = sprintf('MA_binary_vector_%s', uniqueId);
    ds_sec_signal_2_varName = sprintf('ds_sec_signal_2_%s', uniqueId);
    ds_delta465_filt_2_varName = sprintf('ds_delta465_filt_2_%s', uniqueId);
    sec_signal_EEG_varName = sprintf('sec_signal_EEG_%s', uniqueId);
    EEG_varName = sprintf('EEG_%s', uniqueId);
    EMG_varName = sprintf('EMG_%s', uniqueId);

    % Access the variables dynamically
    wake_woMA_binary_vector = eval(wake_woMA_varName);
    sws_binary_vector = eval(sws_varName);
    REM_binary_vector = eval(REM_varName);
    MA_binary_vector = eval(MA_varName);
    ds_sec_signal_2 = eval(ds_sec_signal_2_varName);
    ds_delta465_filt_2 = eval(ds_delta465_filt_2_varName);
    sec_signal_EEG = eval(sec_signal_EEG_varName);
    EEG = eval(EEG_varName);
    EMG = eval(EMG_varName);
    
    sleepscore_time = 0:length(wake_woMA_binary_vector)-1; % Assuming all vectors are the same length
    uniqueIdStr = string(uniqueId);

        % Append zeros if the mouse ID is '015'
    % Append zeros if the mouse ID is '015'
    if strcmp(uniqueId, '015')  % Correct comparison for strings
        sws_binary_vector = [sws_binary_vector, zeros(1, 3)];  % Append zeros horizontally
        REM_binary_vector = [REM_binary_vector, zeros(1, 3)];  % Append zeros horizontally
    end

    % Plot for the current mouse
    figure;
    sgtitle(sprintf('Mouse %s', uniqueId)); % Set the figure title with the mouse ID

    a = subplot(3, 1, 1);
        plot_sleep(ds_sec_signal_2, ds_delta465_filt_2, sleepscore_time, wake_woMA_binary_vector, sws_binary_vector, REM_binary_vector, MA_binary_vector);
        title(['Norepinephrine']);
        xlabel('time (s)');
        ylabel('NE (df/f)');
        grid on;

    b = subplot(3, 1, 2);
        plot_sleep(sec_signal_EEG, EMG, sleepscore_time, wake_woMA_binary_vector, sws_binary_vector, REM_binary_vector, MA_binary_vector);
        xlabel('time (s)');
        ylabel('EMG (V)');
        title(['EMG']);
        grid on;

    c = subplot(3, 1, 3);
        plot_sleep(sec_signal_EEG, EEG, sleepscore_time, wake_woMA_binary_vector, sws_binary_vector, REM_binary_vector, MA_binary_vector);
        xlabel('time (s)');
        ylabel('EEG (V)');
        title(['EEG']);
        grid on;

    % Linking axes for synchronized zooming
    linkaxes([a, b, c], 'x');
end
%% Get RR intervals
% [RR_387, RR_time_387, RR_fs_387] = GetRRIntervals(M387, -EMG_387, sec_signal_EEG_387, EEG_fs_387);
[RR_124, RR_time_124, RR_fs_124, Rpeaks_124, Rpeaks_time_124] = GetRRIntervals(M124, EMG_124, sec_signal_EEG_124, EEG_fs_124, 3.5, 2.5);
%[RR_392, RR_time_392, RR_fs_392] = GetRRIntervals(M392, EMG_392, sec_signal_EEG_392, EEG_fs_392);
[RR_403, RR_time_403, RR_fs_403] = GetRRIntervals(M403, EMG_403, sec_signal_EEG_403, EEG_fs_403, 2.5, 2.5); % could be used before 2730, but needs cutting prior to that
%[RR_412, RR_time_412, RR_fs_412] = GetRRIntervals(M412, EMG_412, sec_signal_EEG_412, EEG_fs_412);
%[RR_414, RR_time_414, RR_fs_414] = GetRRIntervals(M414, EMG_414, sec_signal_EEG_414, EEG_fs_414);
[RR_416, RR_time_416, RR_fs_416] = GetRRIntervals(M416, -EMG_416, sec_signal_EEG_416, EEG_fs_416, 1, 2.5);
%[RR_418, RR_time_418, RR_fs_418] = GetRRIntervals(M418, EMG_418, sec_signal_EEG_418, EEG_fs_418, 2.5);
[RR_420, RR_time_420, RR_fs_420, Rpeaks_420, Rpeaks_time_420] = GetRRIntervals(M420, -EMG_420, sec_signal_EEG_420, EEG_fs_420, 6.3, 2.5);
[RR_468, RR_time_468, RR_fs_468] = GetRRIntervals(M468, -EMG_468, sec_signal_EEG_468, EEG_fs_468, 2.5, 2.3); %Parts are good, others are messy
%[RR_484, RR_time_484, RR_fs_484] = GetRRIntervals(M484, EMG_484, sec_signal_EEG_484, EEG_fs_484, 2.5);
%[RR_477, RR_time_477, RR_fs_477] = GetRRIntervals(M477, -EMG_477, sec_signal_EEG_477, EEG_fs_477, 3.5);
%[RR_015, RR_time_015, RR_fs_015] = GetRRIntervals(M015, -EMG_015, sec_signal_EEG_015, EEG_fs_015, 1); 
[RR_084, RR_time_084, RR_fs_084] = GetRRIntervals(M084, -EMG_084, sec_signal_EEG_084, EEG_fs_084, 2.5, 2.5); %Acceptable but not great
%[RR_569, RR_time_569, RR_fs_569] = GetRRIntervals(M569, EMG_569, sec_signal_EEG_569, EEG_fs_569, 2.5); 
%[RR_578, RR_time_578, RR_fs_578] = GetRRIntervals(M578, -EMG_578, sec_signal_EEG_578, EEG_fs_578, 2.5);
[RR_580, RR_time_580, RR_fs_580, Rpeaks_580, Rpeaks_time_580] = GetRRIntervals(M580, -EMG_580, sec_signal_EEG_580, EEG_fs_580, 2.3, 2.3); 
[RR_588, RR_time_588, RR_fs_588, Rpeaks_588, Rpeaks_time_588] = GetRRIntervals(M588, -EMG_588, sec_signal_EEG_588, EEG_fs_588, 2.5, 2.5); %Best one!!!
%[RR_592, RR_time_592, RR_fs_592] = GetRRIntervals(M592, -EMG_592, sec_signal_EEG_592, EEG_fs_592, 2.5, 2.5); 
%[RR_600, RR_time_600, RR_fs_600] = GetRRIntervals(M600, -EMG_600, sec_signal_EEG_600, EEG_fs_600, 2.5, 2.5); 
%[RR_602, RR_time_602, RR_fs_602] = GetRRIntervals(M602, -EMG_602, sec_signal_EEG_602, EEG_fs_602, 2.5, 2.5); 
%[RR_073, RR_time_073, RR_fs_073] = GetRRIntervals(M073, EMG_073, sec_signal_EEG_073, EEG_fs_073, 2.5, 2.5); 

%[RR_017, RR_time_017, RR_fs_017] = GetRRIntervals(M017, EMG_017, sec_signal_EEG_017, EEG_fs_017, 2.5, 2.5); 
%[RR_019, RR_time_019, RR_fs_019] = GetRRIntervals(M019, EMG_019, sec_signal_EEG_019, EEG_fs_019, 2.5, 2.5); 
%[RR_021, RR_time_021, RR_fs_021] = GetRRIntervals(M021, EMG_021, sec_signal_EEG_021, EEG_fs_021, 2.5, 2.5); 
[RR_023, RR_time_023, RR_fs_023] = GetRRIntervals(M023, -EMG_023, sec_signal_EEG_023, EEG_fs_023, 3.5, 2.2); %Could be used but not great 
[RR_025, RR_time_025, RR_fs_025, Rpeaks_025, Rpeaks_time_025] = GetRRIntervals(M025, EMG_025, sec_signal_EEG_025, EEG_fs_025, 2.3, 2.0); 
[RR_026, RR_time_026, RR_fs_026, Rpeaks_026, Rpeaks_time_026] = GetRRIntervals(M026, EMG_026, sec_signal_EEG_026, EEG_fs_026, 3, 2); 
%[RR_015, RR_time_015, RR_fs_015] = GetRRIntervals(M015, -EMG_015, sec_signal_EEG_015, EEG_fs_015, 1.1, 2.3); %This is Tessa's hist files

figure;
    a = subplot(2, 1, 1);
    plot(sec_signal_EEG_588, -EMG_588,  Rpeaks_time_588, Rpeaks_588, 'o', 'color', [0.5 0.5 0.5], 'MarkerEdgeColor', 'k');
    b = subplot(2, 1, 2);
    plot(RR_time_588, RR_588,  Rpeaks_time_588, Rpeaks_588, 'color', 'k');
    linkaxes([a, b], 'x');

%% Get HRB
[HRB_124, HRB_time_124] = findHRB(RR_time_124, RR_124);
[HRB_403, HRB_time_403] = findHRB(RR_time_403, RR_403);
[HRB_416, HRB_time_416] = findHRB(RR_time_416, RR_416);
[HRB_420, HRB_time_420] = findHRB(RR_time_420, RR_420);
[HRB_580, HRB_time_580] = findHRB(RR_time_580, RR_580);
[HRB_588, HRB_time_588] = findHRB(RR_time_588, RR_588);
[HRB_026, HRB_time_026] = findHRB(RR_time_026, RR_026);
%[HRB_015, HRB_time_015] = findHRB(RR_time_015, RR_015);
[HRB_025, HRB_time_025] = findHRB(RR_time_025, RR_025);

% sleepscore_time = 0:length(wake_woMA_binary_vector_420)-1; % Assuming all vectors are the same length
% 
% figure;
% plot_sleep(RR_time_420, RR_420, sleepscore_time, wake_woMA_binary_vector_420, sws_binary_vector_420, REM_binary_vector_420, MA_binary_vector_420);
% hold on;
% scatter(HRB_time_420, HRB_420, 'b', 'filled'); % Plotting HRB
% hold off;
% xlabel('Time (s)');
% ylabel('RR intervals');
% title('HRV p-chip (M403)');
% grid on;

    sleepscore_time_420 = 0:length(wake_woMA_binary_vector_420)-1; % Assuming all vectors are the same length
    sleepscore_time_580 = 0:length(wake_woMA_binary_vector_580)-1; % Assuming all vectors are the same length
    sleepscore_time_588 = 0:length(wake_woMA_binary_vector_588)-1; % Assuming all vectors are the same length
    sleepscore_time_026 = 0:length(wake_woMA_binary_vector_026)-1; % Assuming all vectors are the same length
    sleepscore_time_015 = 0:length(wake_woMA_binary_vector_015)-1; % Assuming all vectors are the same length
    sleepscore_time_025 = 0:length(wake_woMA_binary_vector_025)-1; % Assuming all vectors are the same length

    figure;
    a = subplot(3, 1, 1);
        plot_sleep(RR_time_420, RR_420, sleepscore_time_420, wake_woMA_binary_vector_420, sws_binary_vector_420, REM_binary_vector_420, MA_binary_vector_420);
        hold on;
        scatter(HRB_time_420, HRB_420, 'b', 'filled'); % Plotting HRB
        hold off;
        xlabel('Time (s)');
        ylabel('RR intervals');
        title('HRV p-chip (M420)');
        grid on;

    b = subplot(3, 1, 2);
        plot_sleep(RR_time_580, RR_580, sleepscore_time_580, wake_woMA_binary_vector_580, sws_binary_vector_580, REM_binary_vector_580, MA_binary_vector_580);
        hold on;
        scatter(HRB_time_580, HRB_580, 'b', 'filled'); % Plotting HRB
        hold off;
        xlabel('Time (s)');
        ylabel('RR intervals');
        title('HRV p-chip (M580)');
        grid on;


    c = subplot(3, 1, 3);
        plot_sleep(RR_time_588, RR_588, sleepscore_time_588, wake_woMA_binary_vector_588, sws_binary_vector_588, REM_binary_vector_588, MA_binary_vector_588);
        hold on;
        scatter(HRB_time_588, HRB_588, 'b', 'filled'); % Plotting HRB
        hold off;
        xlabel('Time (s)');
        ylabel('RR intervals');
        title('HRV p-chip (M588)');
        grid on;

    % Linking axes for synchronized zooming
    linkaxes([a, b, c], 'x');

% % Determine if sws_binary_vector_015 is a row or column vector and append zeros accordingly
% if isrow(sws_binary_vector_015)
%     sws_binary_vector_015 = [sws_binary_vector_015, zeros(1, 3)]; % Append zeros horizontally
% else
%     sws_binary_vector_015 = [sws_binary_vector_015; zeros(3, 1)]; % Append zeros vertically
% end
% 
% % Determine if REM_binary_vector_015 is a row or column vector and append zeros accordingly
% if isrow(REM_binary_vector_015)
%     REM_binary_vector_015 = [REM_binary_vector_015, zeros(1, 3)]; % Append zeros horizontally
% else
%     REM_binary_vector_015 = [REM_binary_vector_015; zeros(3, 1)]; % Append zeros vertically
% end
%% QC - plot sleep w. NE, HR peak and HRB
% Assuming 'mice' is a list of mouse identifiers like {'168', '149', ...}
for idx = 1:length(o)
    mouse = o{idx};
    disp(mouse{3})
    uniqueId = mouse{3}; % Extract mouse ID as a string

    % Dynamically generate variable names based on the mouse ID
    wake_woMA_varName = sprintf('wake_woMA_binary_vector_%s', uniqueId);
    sws_varName = sprintf('sws_binary_vector_%s', uniqueId);
    REM_varName = sprintf('REM_binary_vector_%s', uniqueId);
    MA_varName = sprintf('MA_binary_vector_%s', uniqueId);
    ds_sec_signal_2_varName = sprintf('ds_sec_signal_2_%s', uniqueId);
    ds_delta465_filt_2_varName = sprintf('ds_delta465_filt_2_%s_smooth', uniqueId);
    sec_signal_EEG_varName = sprintf('sec_signal_EEG_%s', uniqueId);
    EEG_varName = sprintf('EEG_%s', uniqueId);
    EMG_varName = sprintf('EMG_%s', uniqueId);
    RR_varName = sprintf('RR_%s', uniqueId);
    RR_time_varName = sprintf('RR_time_%s', uniqueId);
    Rpeaks_varName = sprintf('Rpeaks_%s', uniqueId);
    Rpeaks_time_varName = sprintf('Rpeaks_time_%s', uniqueId);    
    HRB_varName = sprintf('HRB_%s', uniqueId);
    HRB_time_varName = sprintf('HRB_time_%s', uniqueId);
    NREMexclMA_periods_pklocs_varName = sprintf('NREMexclMA_periods_pklocs_%s', uniqueId);
    SWS_before_MA_pklocs_varName = sprintf('SWS_before_MA_pklocs_%s', uniqueId);
    SWS_before_wake_pklocs_varName = sprintf('SWS_before_wake_pklocs_%s', uniqueId);
    REM_before_MA_pklocs_varName = sprintf('REM_before_MA_pklocs_%s', uniqueId);
    REM_before_wake_pklocs_varName = sprintf('REM_before_wake_pklocs_%s', uniqueId);
    signal_fs_varName = sprintf('signal_fs_%s', uniqueId);

    % Access the variables dynamically
    wake_woMA_binary_vector = eval(wake_woMA_varName);
    sws_binary_vector = eval(sws_varName);
    REM_binary_vector = eval(REM_varName);
    MA_binary_vector = eval(MA_varName);
    ds_sec_signal_2 = eval(ds_sec_signal_2_varName);
    ds_delta465_filt_2_smooth = eval(ds_delta465_filt_2_varName);
    sec_signal_EEG = eval(sec_signal_EEG_varName);
    EEG = eval(EEG_varName);
    EMG = eval(EMG_varName);
    RR = eval(RR_varName);
    RR_time = eval(RR_time_varName);
    Rpeaks = eval(Rpeaks_varName);
    Rpeaks_time = eval(Rpeaks_time_varName);
    HRB = eval(HRB_varName);
    HRB_time = eval(HRB_time_varName);
    NREMexclMA_periods_pklocs = eval(NREMexclMA_periods_pklocs_varName);
    SWS_before_MA_pklocs = eval(SWS_before_MA_pklocs_varName);
    SWS_before_wake_pklocs = eval(SWS_before_wake_pklocs_varName);
    REM_before_MA_pklocs = eval(REM_before_MA_pklocs_varName);
    REM_before_wake_pklocs = eval(REM_before_wake_pklocs_varName);
    signal_fs = eval(signal_fs_varName);


    sleepscore_time = 0:length(wake_woMA_binary_vector)-1; % Assuming all vectors are the same length
    uniqueIdStr = string(uniqueId);

    % Plot for the current mouse
    figure;
    sgtitle(sprintf('Mouse %s', uniqueId)); % Set the figure title with the mouse ID

    a = subplot(3, 1, 1);
        plot_sleep(ds_sec_signal_2, ds_delta465_filt_2_smooth, sleepscore_time, wake_woMA_binary_vector, sws_binary_vector, REM_binary_vector, MA_binary_vector);
        hold on
        plot(NREMexclMA_periods_pklocs, ds_delta465_filt_2_smooth(round(NREMexclMA_periods_pklocs*signal_fs)), 'r*')
        plot(SWS_before_MA_pklocs, ds_delta465_filt_2_smooth(round(SWS_before_MA_pklocs*signal_fs)), 'b*')
        plot(SWS_before_wake_pklocs, ds_delta465_filt_2_smooth(round(SWS_before_wake_pklocs*signal_fs)), 'g*')
        plot(REM_before_MA_pklocs, ds_delta465_filt_2_smooth(round(REM_before_MA_pklocs*signal_fs)), 'y*')
        plot(REM_before_wake_pklocs, ds_delta465_filt_2_smooth(round(REM_before_wake_pklocs*signal_fs)), 'r*')
        hold off
        title('Norepinephrine');
        xlabel('Time (s)');
        ylabel('NE (df/f)');
        grid on;

    b = subplot(3, 1, 2);
        plot(sec_signal_EMG, EMG, 'b-', quality_selected_peak_times, quality_selected_peaks, 'ro');    
        xlabel('Time (s)');
        ylabel('EMG (V)');
        title('Original EMG Data w. peaks');
        grid on;

    c = subplot(3, 1, 3);
        plot_sleep(RR_time, RR, sleepscore_time, wake_woMA_binary_vector, sws_binary_vector, REM_binary_vector, MA_binary_vector);
        hold on;
        scatter(HRB_time, HRB, 'bo'); % Plotting HRB
        hold off;
        xlabel('Time (s)');
        ylabel('RR intervals');
        title('HRV p-chip');
        grid on;

    % Linking axes for synchronized zooming
    linkaxes([a, b, c], 'x');
end

%% Power analysis on EEG
power_bands = {[0.5, 1], [1, 4], [4, 8], [8, 15], [15, 30]}; % define SO, delta, theta, sigma, and beta, respectively
frw = 0:0.2:30;
window_in_sec = 1; % sec. 1 for 30 sec

%[mean_spectrogram_117, time_spectrogram_zero_117, F_117, band_powers_117, EEG_bands_fs_117] = PowerAnalysisEEG(EEG_117, EEG_fs_117, frw, window_in_sec, power_bands);
[mean_spectrogram_124, time_spectrogram_zero_124, F_124, band_powers_124, EEG_bands_fs_124] = PowerAnalysisEEG(EEG_124, EEG_fs_124, frw, window_in_sec, power_bands);
[mean_spectrogram_420, time_spectrogram_zero_420, F_420, band_powers_420, EEG_bands_fs_420] = PowerAnalysisEEG(EEG_420, EEG_fs_420, frw, window_in_sec, power_bands);
[mean_spectrogram_580, time_spectrogram_zero_580, F_580, band_powers_580, EEG_bands_fs_580] = PowerAnalysisEEG(EEG_580, EEG_fs_580, frw, window_in_sec, power_bands);
[mean_spectrogram_588, time_spectrogram_zero_588, F_588, band_powers_588, EEG_bands_fs_588] = PowerAnalysisEEG(EEG_588, EEG_fs_588, frw, window_in_sec, power_bands);
[mean_spectrogram_025, time_spectrogram_zero_025, F_025, band_powers_025, EEG_bands_fs_025] = PowerAnalysisEEG(EEG_025, EEG_fs_025, frw, window_in_sec, power_bands);
[mean_spectrogram_026, time_spectrogram_zero_026, F_026, band_powers_026, EEG_bands_fs_026] = PowerAnalysisEEG(EEG_026, EEG_fs_026, frw, window_in_sec, power_bands);
%% Plot smoothed NE
for idx = 1:length(o)
    mouse = o{idx};
    disp(mouse{3})
    uniqueId = mouse{3}; % Extract mouse ID as a string

    % Dynamically generate variable names based on the mouse ID
    wake_woMA_varName = sprintf('wake_woMA_binary_vector_%s', uniqueId);
    sws_varName = sprintf('sws_binary_vector_%s', uniqueId);
    REM_varName = sprintf('REM_binary_vector_%s', uniqueId);
    MA_varName = sprintf('MA_binary_vector_%s', uniqueId);
    ds_sec_signal_2_varName = sprintf('ds_sec_signal_2_%s', uniqueId);
    ds_delta465_filt_2_smooth_varName = sprintf('ds_delta465_filt_2_%s_smooth', uniqueId);
    ds_delta465_filt_2_varName = sprintf('ds_delta465_filt_2_%s', uniqueId);
    sec_signal_EEG_varName = sprintf('sec_signal_EEG_%s', uniqueId);

    % Access the variables dynamically
    wake_woMA_binary_vector = eval(wake_woMA_varName);
    sws_binary_vector = eval(sws_varName);
    REM_binary_vector = eval(REM_varName);
    MA_binary_vector = eval(MA_varName);
    ds_sec_signal_2 = eval(ds_sec_signal_2_varName);
    ds_delta465_filt_2_smooth = eval(ds_delta465_filt_2_smooth_varName);
    ds_delta465_filt_2 = eval(ds_delta465_filt_2_varName);
    sec_signal_EEG = eval(sec_signal_EEG_varName);

    sleepscore_time = 0:length(wake_woMA_binary_vector)-1; % Assuming all vectors are the same length
    uniqueIdStr = string(uniqueId);

    % Plot for the current mouse
    figure;
    sgtitle(sprintf('Unsmooth vs. smooth NE for Mouse %s', uniqueId)); % Set the figure title with the mouse ID

    a = subplot(2, 1, 1);
        plot_sleep(ds_sec_signal_2, ds_delta465_filt_2, sleepscore_time, wake_woMA_binary_vector, sws_binary_vector, REM_binary_vector, MA_binary_vector);
        hold on
        hold off
        title('Norepinephrine');
        xlabel('Time (s)');
        ylabel('NE (df/f)');
        grid on;

    b = subplot(2, 1, 2);
        plot_sleep(ds_sec_signal_2, ds_delta465_filt_2_smooth, sleepscore_time, wake_woMA_binary_vector, sws_binary_vector, REM_binary_vector, MA_binary_vector);
        hold on
        hold off
        title('Norepinephrine Smooth (30K)');
        xlabel('Time (s)');
        ylabel('NE (df/f)');
        grid on;

    % Linking axes for synchronized zooming
    linkaxes([a, b], 'x');
end

%% Find NE troughs in sleep transitions and NREM
SWS_before_MA_pklocs_117 = findPeriodsBeforeTransitionMA(SWS_before_MA_filtered_117, signal_fs_117, delta465_filt_2_117_smooth, sec_signal_2_117, MA_periods_117, 15, 15, 1.2);
NREMexclMA_periods_pklocs_117 = find_NE_troughs(NREMexclMA_periods_117, signal_fs_117, delta465_filt_2_117_smooth, sec_signal_2_117, 3); % Change SD multiplyer to 1 for more selective troughs
SWS_before_wake_pklocs_117 = findPeaksBeforeTransition(SWS_before_wake_filtered_117, signal_fs_117, delta465_filt_2_117_smooth, sec_signal_2_117, 0.1, mean(delta465_filt_2_117)-5, 15, 15);
REM_before_MA_pklocs_117 = findPeaksBeforeTransition(REM_before_MA_filtered_117, signal_fs_117, delta465_filt_2_117_smooth, sec_signal_2_117, 0, 0, 0, 15);
REM_before_wake_pklocs_117 = findPeaksBeforeTransition(REM_before_wake_filtered_117, signal_fs_117, delta465_filt_2_117_smooth, sec_signal_2_117, 0, 0, 0, 15);

NREMexclMA_periods_pklocs_124 = find_NE_troughs(NREMexclMA_periods_124, signal_fs_124, delta465_filt_2_124_smooth, sec_signal_2_124, 3); % Change SD multiplyer to 1 for more selective troughs
SWS_before_MA_pklocs_124 = findPeriodsBeforeTransitionMA(SWS_before_MA_filtered_124, signal_fs_124, delta465_filt_2_124_smooth, sec_signal_2_124, MA_periods_124, 15, 15, 1.2);
SWS_before_wake_pklocs_124 = findPeaksBeforeTransition(SWS_before_wake_filtered_124, signal_fs_124, delta465_filt_2_124_smooth, sec_signal_2_124, 0.1, mean(delta465_filt_2_124)-5, 15, 15);
REM_before_MA_pklocs_124 = findPeaksBeforeTransition(REM_before_MA_filtered_124, signal_fs_124, delta465_filt_2_124_smooth, sec_signal_2_124, 0, 0, 0, 0);
REM_before_wake_pklocs_124 = findPeaksBeforeTransition(REM_before_wake_filtered_124, signal_fs_124, delta465_filt_2_124_smooth, sec_signal_2_124, 0, 0, 0, 0);

NREMexclMA_periods_pklocs_420 = find_NE_troughs(NREMexclMA_periods_420, signal_fs_420, delta465_filt_2_420_smooth, sec_signal_2_420, 0.3); % Lower value = more peaks
SWS_before_MA_pklocs_420 = findPeriodsBeforeTransitionMA(SWS_before_MA_filtered_420, signal_fs_420, delta465_filt_2_420_smooth, sec_signal_2_420, MA_periods_420, 15, 15, 0.2);
SWS_before_wake_pklocs_420 = findPeaksBeforeTransition(SWS_before_wake_filtered_420, signal_fs_420, delta465_filt_2_420_smooth, sec_signal_2_420, 0.1, mean(delta465_filt_2_420)-5, 15, 15);
REM_before_MA_pklocs_420 = findPeaksBeforeTransition(REM_before_MA_filtered_420, signal_fs_420, delta465_filt_2_420_smooth, sec_signal_2_420, 0, 0, 0, 0);
REM_before_wake_pklocs_420 = findPeaksBeforeTransition(REM_before_wake_filtered_420, signal_fs_420, delta465_filt_2_420_smooth, sec_signal_2_420, 0, 0, 0, 0);

NREMexclMA_periods_pklocs_580 = find_NE_troughs(NREMexclMA_periods_580, signal_fs_580, delta465_filt_2_580_smooth, sec_signal_2_580, 0.7); % Lower value = more peaks
SWS_before_MA_pklocs_580 = findPeriodsBeforeTransitionMA(SWS_before_MA_filtered_580, signal_fs_580, delta465_filt_2_580_smooth, sec_signal_2_580, MA_periods_580, 15, 15, 0.3);
SWS_before_wake_pklocs_580 = findPeaksBeforeTransition(SWS_before_wake_filtered_580, signal_fs_580, delta465_filt_2_580_smooth, sec_signal_2_580, 0.1, mean(delta465_filt_2_580)-5, 15, 15);
REM_before_MA_pklocs_580 = findPeaksBeforeTransition(REM_before_MA_filtered_580, signal_fs_580, delta465_filt_2_580_smooth, sec_signal_2_580, 0, 0, 0, 0);
REM_before_wake_pklocs_580 = findPeaksBeforeTransition(REM_before_wake_filtered_580, signal_fs_580, delta465_filt_2_580_smooth, sec_signal_2_580, 0, 0, 0, 0);

NREMexclMA_periods_pklocs_588 = find_NE_troughs(NREMexclMA_periods_588, signal_fs_588, delta465_filt_2_588_smooth, sec_signal_2_588, 0.7); % Lower value = more peaks
SWS_before_MA_pklocs_588 = findPeriodsBeforeTransitionMA(SWS_before_MA_filtered_588, signal_fs_588, delta465_filt_2_588_smooth, sec_signal_2_588, MA_periods_588, 15, 15, 0.3);
SWS_before_wake_pklocs_588 = findPeaksBeforeTransition(SWS_before_wake_filtered_588, signal_fs_588, delta465_filt_2_588_smooth, sec_signal_2_588, 0.1, mean(delta465_filt_2_588)-5, 15, 15);
REM_before_MA_pklocs_588 = findPeaksBeforeTransition(REM_before_MA_filtered_588, signal_fs_588, delta465_filt_2_588_smooth, sec_signal_2_588, 0, 0, 0, 0);
REM_before_wake_pklocs_588 = findPeaksBeforeTransition(REM_before_wake_filtered_588, signal_fs_588, delta465_filt_2_588_smooth, sec_signal_2_588, 0, 0, 0, 0);

NREMexclMA_periods_pklocs_025 = find_NE_troughs(NREMexclMA_periods_025, signal_fs_025, delta465_filt_2_025_smooth, sec_signal_2_025, 1.2); % Lower value = more peaks
SWS_before_MA_pklocs_025 = findPeriodsBeforeTransitionMA(SWS_before_MA_filtered_025, signal_fs_025, delta465_filt_2_025_smooth, sec_signal_2_025, MA_periods_025, 15, 15, 0.3);
SWS_before_wake_pklocs_025 = findPeaksBeforeTransition(SWS_before_wake_filtered_025, signal_fs_025, delta465_filt_2_025_smooth, sec_signal_2_025, 0.1, mean(delta465_filt_2_025)-5, 15, 15);
REM_before_MA_pklocs_025 = findPeaksBeforeTransition(REM_before_MA_filtered_025, signal_fs_025, delta465_filt_2_025_smooth, sec_signal_2_025, 0, 0, 0, 0);
REM_before_wake_pklocs_025 = findPeaksBeforeTransition(REM_before_wake_filtered_025, signal_fs_025, delta465_filt_2_025_smooth, sec_signal_2_025, 0, 0, 0, 0);

NREMexclMA_periods_pklocs_026 = find_NE_troughs(NREMexclMA_periods_026, signal_fs_026, delta465_filt_2_026_smooth, sec_signal_2_026, 0.7); % Lower value = more peaks
SWS_before_MA_pklocs_026 = findPeriodsBeforeTransitionMA(SWS_before_MA_filtered_026, signal_fs_026, delta465_filt_2_026_smooth, sec_signal_2_026, MA_periods_026, 15, 15, 0.3);
SWS_before_wake_pklocs_026 = findPeaksBeforeTransition(SWS_before_wake_filtered_026, signal_fs_026, delta465_filt_2_026_smooth, sec_signal_2_026, 0.1, mean(delta465_filt_2_026)-5, 15, 15);
REM_before_MA_pklocs_026 = findPeaksBeforeTransition(REM_before_MA_filtered_026, signal_fs_026, delta465_filt_2_026_smooth, sec_signal_2_026, 0, 0, 0, 0);
REM_before_wake_pklocs_026 = findPeaksBeforeTransition(REM_before_wake_filtered_026, signal_fs_026, delta465_filt_2_026_smooth, sec_signal_2_026, 0, 0, 0, 0);

% Logical condition for values not in the ranges 18950 to 19000 and 5400 to 5450
not_in_range_124 = ~(REM_before_wake_pklocs_124 > 18950 & REM_before_wake_pklocs_124 < 19000) & ~(REM_before_wake_pklocs_124 > 5400 & REM_before_wake_pklocs_124 < 5450);
REM_before_wake_pklocs_124 = REM_before_wake_pklocs_124(not_in_range_124);

not_in_range_588_NREMexclMA = ~(NREMexclMA_periods_pklocs_588 > 4400 & NREMexclMA_periods_pklocs_588 < 4450) & ~(NREMexclMA_periods_pklocs_588 > 7325 & NREMexclMA_periods_pklocs_588 < 7350)& ~(NREMexclMA_periods_pklocs_588 > 9705 & NREMexclMA_periods_pklocs_588 < 9710) & ~(NREMexclMA_periods_pklocs_588 > 10060 & NREMexclMA_periods_pklocs_588 < 10065) & ~(NREMexclMA_periods_pklocs_588 > 12035 & NREMexclMA_periods_pklocs_588 < 12045);
NREMexclMA_periods_pklocs_588 = NREMexclMA_periods_pklocs_588(not_in_range_588_NREMexclMA);

not_in_range_420_sws_to_MA =~(SWS_before_MA_pklocs_420 > 5780 & SWS_before_MA_pklocs_420 < 5790) &  ~(SWS_before_MA_pklocs_420 > 4980 & SWS_before_MA_pklocs_420 < 5100) &  ~(SWS_before_MA_pklocs_420 > 7090 & SWS_before_MA_pklocs_420 < 7100)&  ~(SWS_before_MA_pklocs_420 > 3590 & SWS_before_MA_pklocs_420 < 3600);
SWS_before_MA_pklocs_420 = SWS_before_MA_pklocs_420(not_in_range_420_sws_to_MA);

not_in_range_588_sws_to_MA =~(SWS_before_MA_pklocs_588 > 4750 & SWS_before_MA_pklocs_588 < 4800) &  ~(SWS_before_MA_pklocs_588 > 9000 & SWS_before_MA_pklocs_588 < 9050);
SWS_before_MA_pklocs_588 = SWS_before_MA_pklocs_588(not_in_range_588_sws_to_MA);

not_in_range_588_REM_to_MA =~(REM_before_MA_pklocs_588 > 9300 & REM_before_MA_pklocs_588 < 9350);
REM_before_MA_pklocs_588 = REM_before_MA_pklocs_588(not_in_range_588_REM_to_MA);

not_in_range_580_sws_to_MA =~(SWS_before_MA_pklocs_580 > 8210 & SWS_before_MA_pklocs_580 < 8220);
SWS_before_MA_pklocs_580 = SWS_before_MA_pklocs_580(not_in_range_580_sws_to_MA);

not_in_range_025_NREMexclMA = ~(NREMexclMA_periods_pklocs_025 > 4615 & NREMexclMA_periods_pklocs_025 < 4620) & ~(NREMexclMA_periods_pklocs_025 > 5960 & NREMexclMA_periods_pklocs_025 < 5965)& ~(NREMexclMA_periods_pklocs_025 > 10900 & NREMexclMA_periods_pklocs_025 < 10905);
NREMexclMA_periods_pklocs_025 = NREMexclMA_periods_pklocs_025(not_in_range_025_NREMexclMA);

not_in_range_025_sws_to_MA =~(SWS_before_MA_pklocs_025 > 1000 & SWS_before_MA_pklocs_025 < 1600) &  ~(SWS_before_MA_pklocs_025 > 2210 & SWS_before_MA_pklocs_025 < 2220)&  ~(SWS_before_MA_pklocs_025 > 7200 & SWS_before_MA_pklocs_025 < 7310)&  ~(SWS_before_MA_pklocs_025 > 8100 & SWS_before_MA_pklocs_025 < 8200)&  ~(SWS_before_MA_pklocs_025 > 8900 & SWS_before_MA_pklocs_025 < 10000)&  ~(SWS_before_MA_pklocs_025 > 10350 & SWS_before_MA_pklocs_025 < 10400)&  ~(SWS_before_MA_pklocs_025 > 11975 & SWS_before_MA_pklocs_025 < 11985)&  ~(SWS_before_MA_pklocs_025 > 15540 & SWS_before_MA_pklocs_025 < 15550)&  ~(SWS_before_MA_pklocs_025 > 16381 & SWS_before_MA_pklocs_025 < 16386)&  ~(SWS_before_MA_pklocs_025 > 17540 & SWS_before_MA_pklocs_025 < 17860);
SWS_before_MA_pklocs_025 = SWS_before_MA_pklocs_025(not_in_range_025_sws_to_MA);

not_in_range_025_sws_to_wake = ~(SWS_before_wake_pklocs_025 > 900 & SWS_before_wake_pklocs_025 < 1400) & ~(SWS_before_wake_pklocs_025 > 14800 & SWS_before_wake_pklocs_025 < 14850);
SWS_before_wake_pklocs_025 = SWS_before_wake_pklocs_025(not_in_range_025_sws_to_wake);

not_in_range_025_REM_to_MA = ~(REM_before_MA_pklocs_025 > 9700 & REM_before_MA_pklocs_025 < 9750);
REM_before_MA_pklocs_025 = REM_before_MA_pklocs_025(not_in_range_025_REM_to_MA);

not_in_range_025 = ~(REM_before_wake_pklocs_025 > 2000 & REM_before_wake_pklocs_025 < 2100);
REM_before_wake_pklocs_025 = REM_before_wake_pklocs_025(not_in_range_025);

not_in_range_026_NREMexclMA = ~(NREMexclMA_periods_pklocs_026 > 7180 & NREMexclMA_periods_pklocs_026 < 7200) & ~(NREMexclMA_periods_pklocs_026 > 7815 & NREMexclMA_periods_pklocs_026 < 7825)& ~(NREMexclMA_periods_pklocs_026 > 9215 & NREMexclMA_periods_pklocs_026 < 9225) & ~(NREMexclMA_periods_pklocs_026 > 10954 & NREMexclMA_periods_pklocs_026 < 10960) & ~(NREMexclMA_periods_pklocs_026 > 10954 & NREMexclMA_periods_pklocs_026 < 10960) & ~(NREMexclMA_periods_pklocs_026 > 11605 & NREMexclMA_periods_pklocs_026 < 11615) & ~(NREMexclMA_periods_pklocs_026 > 12040 & NREMexclMA_periods_pklocs_026 < 12046)  & ~(NREMexclMA_periods_pklocs_026 > 13120 & NREMexclMA_periods_pklocs_026 < 13320);
NREMexclMA_periods_pklocs_026 = NREMexclMA_periods_pklocs_026(not_in_range_026_NREMexclMA);

not_in_range_026_sws_to_MA =~(SWS_before_MA_pklocs_026 > 1000 & SWS_before_MA_pklocs_026 < 1750) &  ~(SWS_before_MA_pklocs_026 > 1800 & SWS_before_MA_pklocs_026 < 2950)&  ~(SWS_before_MA_pklocs_026 > 3050 & SWS_before_MA_pklocs_026 < 3300)&  ~(SWS_before_MA_pklocs_026 > 3800 & SWS_before_MA_pklocs_026 < 3900)&  ~(SWS_before_MA_pklocs_026 > 4500 & SWS_before_MA_pklocs_026 < 4700)&  ~(SWS_before_MA_pklocs_026 > 5300 & SWS_before_MA_pklocs_026 < 5700)&  ~(SWS_before_MA_pklocs_026 > 6100 & SWS_before_MA_pklocs_026 < 6200)&  ~(SWS_before_MA_pklocs_026 > 6500 & SWS_before_MA_pklocs_026 < 6900)&  ~(SWS_before_MA_pklocs_026 > 7200 & SWS_before_MA_pklocs_026 < 7900)&  ~(SWS_before_MA_pklocs_026 > 7950 & SWS_before_MA_pklocs_026 < 8050)&  ~(SWS_before_MA_pklocs_026 > 8300 & SWS_before_MA_pklocs_026 < 8400)&  ~(SWS_before_MA_pklocs_026 > 9300 & SWS_before_MA_pklocs_026 < 9350)&  ~(SWS_before_MA_pklocs_026 > 9650 & SWS_before_MA_pklocs_026 < 9700)&  ~(SWS_before_MA_pklocs_026 > 9900 & SWS_before_MA_pklocs_026 < 9950)&  ~(SWS_before_MA_pklocs_026 > 10250 & SWS_before_MA_pklocs_026 < 10300)&  ~(SWS_before_MA_pklocs_026 > 10500 & SWS_before_MA_pklocs_026 < 10600)&  ~(SWS_before_MA_pklocs_026 > 11550 & SWS_before_MA_pklocs_026 < 12450)&  ~(SWS_before_MA_pklocs_026 > 13050 & SWS_before_MA_pklocs_026 < 13250)&  ~(SWS_before_MA_pklocs_026 > 13500 & SWS_before_MA_pklocs_026 < 13600);
SWS_before_MA_pklocs_026 = SWS_before_MA_pklocs_026(not_in_range_026_sws_to_MA);

not_in_range_026_sws_to_wake = ~(SWS_before_wake_pklocs_026 > 1300 & SWS_before_wake_pklocs_026 < 2600) & ~(SWS_before_wake_pklocs_026 > 3600 & SWS_before_wake_pklocs_026 < 7000) & ~(SWS_before_wake_pklocs_026 > 8200 & SWS_before_wake_pklocs_026 < 12600);
SWS_before_wake_pklocs_026 = SWS_before_wake_pklocs_026(not_in_range_026_sws_to_wake);

not_in_range_026_REM_to_MA = ~(REM_before_MA_pklocs_026 > 9700 & REM_before_MA_pklocs_026 < 10000);
REM_before_MA_pklocs_026 = REM_before_MA_pklocs_026(not_in_range_026_REM_to_MA);

not_in_range_026 = ~(REM_before_wake_pklocs_026 > 4000 & REM_before_wake_pklocs_026 < 5200) & ~(REM_before_wake_pklocs_026 > 7600 & REM_before_wake_pklocs_026 < 7700);
REM_before_wake_pklocs_026 = REM_before_wake_pklocs_026(not_in_range_026);

% Apply logical indexing to keep only values not in the specified ranges
SWS_before_MA_pklocs_124 = SWS_before_MA_pklocs_124';
NREMexclMA_periods_pklocs_124 = NREMexclMA_periods_pklocs_124';

%% visualize calculated troughs
    sleepscore_time = 0:length(wake_woMA_binary_vector_025)-1; % Assuming all vectors are the same length

figure
plot_sleep(ds_sec_signal_2_025, ds_delta465_filt_2_025_smooth, sleepscore_time, wake_woMA_binary_vector_025, sws_binary_vector_025, REM_binary_vector_025, MA_binary_vector_025);
hold on
plot(NREMexclMA_periods_pklocs_025, delta465_filt_2_025_smooth(round(NREMexclMA_periods_pklocs_025*signal_fs)), 'r*')
title('NE with selected peaks');

    sleepscore_time = 0:length(wake_woMA_binary_vector_026)-1; % Assuming all vectors are the same length

figure
plot_sleep(ds_sec_signal_2_026, ds_delta465_filt_2_026_smooth, sleepscore_time, wake_woMA_binary_vector_026, sws_binary_vector_026, REM_binary_vector_026, MA_binary_vector_026);
hold on
plot(REM_before_wake_pklocs_026, delta465_filt_2_026_smooth(round(REM_before_wake_pklocs_026*signal_fs)), 'r*')
title('NE with selected peaks');

    sleepscore_time = 0:length(wake_woMA_binary_vector_420)-1; % Assuming all vectors are the same length

figure
plot_sleep(ds_sec_signal_2_420, ds_delta465_filt_2_420_smooth, sleepscore_time, wake_woMA_binary_vector_420, sws_binary_vector_420, REM_binary_vector_420, MA_binary_vector_420);
hold on
plot(SWS_before_MA_pklocs_420, delta465_filt_2_420_smooth(round(SWS_before_MA_pklocs_420*signal_fs)), 'r*')
title('NE with selected peaks');

    sleepscore_time = 0:length(wake_woMA_binary_vector_580)-1; % Assuming all vectors are the same length

figure
plot_sleep(ds_sec_signal_2_580, ds_delta465_filt_2_580_smooth, sleepscore_time, wake_woMA_binary_vector_580, sws_binary_vector_580, REM_binary_vector_580, MA_binary_vector_580);
hold on
plot(REM_before_wake_pklocs_580, delta465_filt_2_580_smooth(round(REM_before_wake_pklocs_580*signal_fs)), 'r*')
title('NE with selected peaks');

    sleepscore_time = 0:length(wake_woMA_binary_vector_588)-1; % Assuming all vectors are the same length

figure
plot_sleep(ds_sec_signal_2_588, ds_delta465_filt_2_588_smooth, sleepscore_time, wake_woMA_binary_vector_588, sws_binary_vector_588, REM_binary_vector_588, MA_binary_vector_588);
hold on
plot(REM_before_MA_pklocs_588, delta465_filt_2_588_smooth(round(REM_before_MA_pklocs_588*signal_fs)), 'r*')
title('NE with selected peaks');

%%% for next animal
    sleepscore_time = 0:length(wake_woMA_binary_vector_124)-1; % Assuming all vectors are the same length

figure
plot_sleep(ds_sec_signal_2_124, ds_delta465_filt_2_124_smooth, sleepscore_time, wake_woMA_binary_vector_124, sws_binary_vector_124, REM_binary_vector_124, MA_binary_vector_124);
hold on
plot(NREMexclMA_periods_pklocs_124, delta465_filt_2_124_smooth(round(NREMexclMA_periods_pklocs_124*signal_fs)), 'r*')
title('NE with selected peaks');

%% 
% Find the maximum length among the variables
maxLen = max([length(SWS_before_MA_pklocs_124), length(NREMexclMA_periods_pklocs_124), ...
              length(SWS_before_wake_pklocs_124), length(REM_before_wake_pklocs_124)]);

% Preallocate arrays of NaNs to the maximum length
SWS_before_MA_124_padded = NaN(maxLen, 1);
NREMexclMA_periods_124_padded = NaN(maxLen, 1);
SWS_before_wake_124_padded = NaN(maxLen, 1);
REM_before_wake_124_padded = NaN(maxLen, 1);

% Fill the preallocated arrays with actual data
SWS_before_MA_124_padded(1:length(SWS_before_MA_pklocs_124)) = SWS_before_MA_pklocs_124;
NREMexclMA_periods_124_padded(1:length(NREMexclMA_periods_pklocs_124)) = NREMexclMA_periods_pklocs_124;
SWS_before_wake_124_padded(1:length(SWS_before_wake_pklocs_124)) = SWS_before_wake_pklocs_124;
REM_before_wake_124_padded(1:length(REM_before_wake_pklocs_124)) = REM_before_wake_pklocs_124;

% Calculate the differences between consecutive observations
Diff_SWS_before_MA_124 = [NaN; diff(SWS_before_MA_124_padded)];
Diff_NREMexclMA_periods_124 = [NaN; diff(NREMexclMA_periods_124_padded)];
Diff_SWS_before_wake_124 = [NaN; diff(SWS_before_wake_124_padded)];
Diff_REM_before_wake_124 = [NaN; diff(REM_before_wake_124_padded)];

% Compile into a structure for easy access
NE_trough_locs = struct('SWS_before_MA_pklocs_124', round(SWS_before_MA_124_padded), ...
                   'Diff_SWS_before_MA_124', round(Diff_SWS_before_MA_124), ...
                   'NREMexclMA_periods_pklocs_124', round(NREMexclMA_periods_124_padded), ...
                   'Diff_NREMexclMA_periods_124', round(Diff_NREMexclMA_periods_124), ...
                   'SWS_before_wake_pklocs_124', round(SWS_before_wake_124_padded), ...
                   'Diff_SWS_before_wake_124', round(Diff_SWS_before_wake_124), ...
                   'REM_before_wake_pklocs_124', round(REM_before_wake_124_padded), ...
                   'Diff_REM_before_wake_124', round(Diff_REM_before_wake_124));

% Accessing data example:
% dataFrame.SWS_before_MA_pklocs_124


%% 
% Initialize an array to hold the furthest peak time and its distance from offset for each bout
peak_info = []; % Each row: [peak time, distance to offset]

% Iterate through each bout
for i = 1:size(REM_before_arousal_filtered_124, 1)
    bout_onset = REM_before_arousal_filtered_124(i, 1);
    bout_offset = REM_before_arousal_filtered_124(i, 2);
    
    % Find peaks that fall within this bout
    peaks_in_bout = REM_before_wake_pklocs_124(REM_before_wake_pklocs_124 >= bout_onset & REM_before_wake_pklocs_124 <= bout_offset);
    
    % Calculate distances of these peaks from the bout's offset
    distances = bout_offset - peaks_in_bout;
    
    % Find the peak furthest from the offset
    if ~isempty(distances)
        [max_distance, idx] = max(distances);
        furthest_peak = peaks_in_bout(idx);
        peak_info = [peak_info; furthest_peak, max_distance];
    end
end

% Sort the peak_info array by distance to offset, descending
[~, sortIdx] = sort(peak_info(:, 2), 'descend');
sorted_peak_info = peak_info(sortIdx, :);

% Display the top 3 peaks furthest from their bout's offset
num_peaks_to_display = min(3, size(sorted_peak_info, 1)); % Ensure we don't exceed the number of found peaks
for i = 1:num_peaks_to_display
    fprintf('Peak time: %f, Distance to offset: %f\n', sorted_peak_info(i, 1), sorted_peak_info(i, 2));
end

%% visualize calculated troughs
    sleepscore_time = 0:length(wake_woMA_binary_vector_117)-1; % Assuming all vectors are the same length

figure
plot_sleep(ds_sec_signal_2_117, ds_delta465_filt_2_117, sleepscore_time, wake_woMA_binary_vector_117, sws_binary_vector_117, REM_binary_vector_117, MA_binary_vector_117);
hold on
plot(REM_before_wake_pklocs_117, delta465_filt_2_117(round(REM_before_wake_pklocs_117*signal_fs)), 'r*')
title('NE with selected peaks');

%%% for next animal
    sleepscore_time = 0:length(wake_woMA_binary_vector_124)-1; % Assuming all vectors are the same length

figure
plot_sleep(ds_sec_signal_2_124, ds_delta465_filt_2_124_smooth, sleepscore_time, wake_woMA_binary_vector_124, sws_binary_vector_124, REM_binary_vector_124, MA_binary_vector_124);
hold on
plot(SWS_before_wake_pklocs_124, delta465_filt_2_124_smooth(round(SWS_before_wake_pklocs_124*signal_fs)), 'r*')
title('NE with selected peaks');

%% Percent HRB assocaitated troughs

% Assuming HRB_time and the trough variables are defined
trough_variables = {
    'NREM (M124)', NREMexclMA_periods_pklocs_124;
    'NREM to MA transition (M124)', SWS_before_MA_pklocs_124;
    'NREM to wake transition (M124)', SWS_before_wake_pklocs_124;
    'REM to MA/wake transition (M124)', REM_before_wake_pklocs_124
};

% Combine all trough times for checking consecutive troughs
all_trough_times = sort([NREMexclMA_periods_pklocs_124; SWS_before_MA_pklocs_124; SWS_before_wake_pklocs_124; REM_before_wake_pklocs_124]);

resultsTable = NETroughToHRBAssociation(trough_variables, all_trough_times, HRB_time);

%% Plot NE trough to HRB association

[NE_associated_HRB_time, HRB_times_no_troughs] = separateHRBAssociatedTroughs(trough_variables, all_trough_times, HRB_time);

% Assuming 'NE_associated_HRB_time' and 'HRB_times_no_troughs' are available
% and contain the HRB times that are associated and not associated with NE troughs, respectively.
% And assuming HRB_time and HRB variables contain all HRB events and their times.

    sleepscore_time = 0:length(wake_woMA_binary_vector_124)-1; % Assuming all vectors are the same length

% Corrected color specifications using RGB triplets
figure;
plot_sleep(new_time_vector, resampled_RR_pchip, sleepscore_time, wake_woMA_binary_vector_124, sws_binary_vector_124, REM_binary_vector_124, MA_binary_vector_124);
hold on;

% Scatter plot for HRBs that are associated with NE troughs in green
scatter(NE_associated_HRB_time, HRB(ismember(HRB_time, NE_associated_HRB_time)), 'g', 'filled');

% Scatter plot for HRBs that aren't associated with NE troughs in red
scatter(HRB_times_no_troughs, HRB(ismember(HRB_time, HRB_times_no_troughs)), 'r', 'filled');

xlabel('Time (s)');
ylabel('RR intervals');
title('HRV p-chip (M124)');
grid on;

% NREM_M124__HRB in black
for i = 1:length(NREM_M124__HRB)
    xline(NREM_M124__HRB(i), '--', 'Color', 'k');
end

% NREM_M124__no_HRB in gray
for i = 1:length(NREM_M124__no_HRB)
    xline(NREM_M124__no_HRB(i), '--', 'Color', [0.5 0.5 0.5]);
end

% NREMToMATransition_M124__HRB in orange
for i = 1:length(NREMToMATransition_M124__HRB)
    xline(NREMToMATransition_M124__HRB(i), '--', 'Color', 'yellow');
end

% NREMToMATransition_M124__no_HRB in yellow
for i = 1:length(NREMToMATransition_M124__no_HRB)
    xline(NREMToMATransition_M124__no_HRB(i), '--', 'Color', 'white');
end

% NREMToWakeTransition_M124__HRB in dark green
for i = 1:length(NREMToWakeTransition_M124__HRB)
    xline(NREMToWakeTransition_M124__HRB(i), '--', 'Color', [0, 0.5, 0]);
end

% NREMToWakeTransition_M124__no_HRB in light green
for i = 1:length(NREMToWakeTransition_M124__no_HRB)
    xline(NREMToWakeTransition_M124__no_HRB(i), '--', 'Color', [0.5647, 0.9333, 0.5647]);
end

% REMToMA_wakeTransition_M124__HRB in dark blue
for i = 1:length(REMToMA_wakeTransition_M124__HRB)
    xline(REMToMA_wakeTransition_M124__HRB(i), '--', 'Color', [0.6784, 0.8471, 0.9020]);
end

% REMToMA_wakeTransition_M124__no_HRB in light blue
for i = 1:length(REMToMA_wakeTransition_M124__no_HRB)
    xline(REMToMA_wakeTransition_M124__no_HRB(i), '--', 'Color', [0, 0, 0.6]);
end

hold off; % Release the plot for further commands

%% Split HRB no through by sleep stage

[NREMinclMA_HRB_124, NREMexclMA_HRB_124, wake_HRB_124, REM_HRB_124] = categorizeHRBBySleepStage(HRB_times_no_troughs, NREMinclMA_periods_124, NREMexclMA_periods_124, wake_periods_124, REM_periods_124);

figure;
plot_sleep(new_time_vector, resampled_RR_pchip, sleepscore_time, wake_woMA_binary_vector_124, sws_binary_vector_124, REM_binary_vector_124, MA_binary_vector_124);
hold on;

% Assuming 'HRB' is an array with HRB markers, and 'HRB_time' is the corresponding time array
% Note: You may need to adjust the 'HRB' array access to match the specific values you wish to plot for each category.

% Scatter plot for NREMinclMA_HRB_124 in yellow
scatter(NREMinclMA_HRB_124, HRB(ismember(HRB_time, NREMinclMA_HRB_124)), 'y', 'filled');

% Scatter plot for NREMexclMA_HRB_124 in red
scatter(NREMexclMA_HRB_124, HRB(ismember(HRB_time, NREMexclMA_HRB_124)), 'r', 'filled');

% Scatter plot for REM_HRB_124 in green
scatter(REM_HRB_124, HRB(ismember(HRB_time, REM_HRB_124)), 'g', 'filled');

% Scatter plot for wake_HRB_124 in blue
scatter(wake_HRB_124, HRB(ismember(HRB_time, wake_HRB_124)), 'b', 'filled');

xlabel('Time (s)');
ylabel('RR intervals');
title('HRV p-chip (M124)');
grid on;
hold off;

%% Generate the main plot

event_var = {NREMexclMA_periods_pklocs_124, SWS_before_MA_pklocs_124, SWS_before_wake_pklocs_124, REM_before_wake_pklocs_124};
titles = {'NREM', 'NREM to MA Transition', 'NREM to Wake Transition', 'REM to Wake/MA Transition'};
main_title = 'Averaged Activity During NE Trough (M124)';

MainPlot(event_var, 30, 60, titles, main_title, delta465_filt_2_124_smooth, sec_signal_2_124, signal_fs_124, RR_124, RR_124, RR_fs_124,  mean_spectrogram_124, F_124, EEG_bands_fs_124)

%% Generate the main plot for HRB associated NE vs HRB not associated NE vs HRB not associated with NE

event_var = {NREM_M124__HRB, NREMToMATransition_M124__HRB, NREMToWakeTransition_M124__HRB, REMToMA_wakeTransition_M124__HRB};
titles = {'NREM', 'NREM to MA Transition', 'NREM to Wake Transition', 'REM to Wake/MA Transition'};
main_title = 'Averaged Activity During NE Troughs That Are HRB Related (M124)';
MainPlot(event_var, 30, 60, titles, main_title, delta465_filt_2_124_smooth, sec_signal_2_124, signal_fs_124, resampled_RR_pchip_124, new_time_vector_124, new_fs_RR_124,  mean_spectrogram_124, F_124, EEG_bands_fs_124)

event_var = {NREM_M124__no_HRB, NREMToMATransition_M124__no_HRB, NREMToWakeTransition_M124__no_HRB, REMToMA_wakeTransition_M124__no_HRB};
titles = {'NREM', 'NREM to MA Transition', 'NREM to Wake Transition', 'REM to Wake/MA Transition'};
main_title = 'Averaged Activity During NE Troughs That Are Not HRB Related (M124)';
MainPlot(event_var, 30, 60, titles, main_title, delta465_filt_2_124_smooth, sec_signal_2_124, signal_fs_124, resampled_RR_pchip_124, new_time_vector_124, new_fs_RR_124,  mean_spectrogram_124, F_124, EEG_bands_fs_124)

event_var = {NREMexclMA_HRB_124, NREMinclMA_HRB_124, wake_HRB_124, REM_HRB_124};
filteredEventVars = FilterHRBperSleepStageForPlottings(event_var, 30, 60, sec_signal_2_124);
titles = {'NREM excl. MA', 'NREM incl. MA', 'Wake', 'REM'};
main_title = 'Averaged Activity During HRBs Which Are Not NE Trough Related (M124)';
MainPlot(filteredEventVars, 30, 60, titles, main_title, delta465_filt_2_124_smooth, sec_signal_2_124, signal_fs_124, resampled_RR_pchip_124, new_time_vector_124, new_fs_RR_124,  mean_spectrogram_124, F_124, EEG_bands_fs_124)

%% QC plot for NE troughs
pklocs_variables_117 = {NREMexclMA_periods_pklocs_117, SWS_before_MA_pklocs_117, SWS_before_wake_pklocs_117, REM_before_wake_pklocs_117};
titles_117 = {'NREM - M117', 'NREM to MA Transition - M117', 'NREM to Wake Transition - M117', 'REM to Wake Transition - M117'};
QC_plot_all_NE_troughs(pklocs_variables_117, titles_117, ds_delta465_filt_2_117, ds_sec_signal_2_117, signal_fs_117)


pklocs_variables_124 = {NREMexclMA_periods_pklocs_124, SWS_before_MA_pklocs_124, SWS_before_wake_pklocs_124, REM_before_wake_pklocs_124};
titles_124 = {'NREM - M124', 'NREM to MA Transition - M124', 'NREM to Wake Transition - M124', 'REM to Wake/MA Transition - M124'};
maintitle = 'RR Activity Around Troughs';
ylab = 'RR Intervals';
QC_plot_all_NE_troughs(pklocs_variables_124, titles_124, maintitle, ylab, resampled_RR_pchip_124, new_time_vector_124, new_fs_RR_124)

% Assume REM_before_wake_pklocs_124, ds_delta465_filt_2, and ds_sec_signal_2 are defined
pklocs = REM_before_wake_pklocs_124; % Trough times
event_count = length(pklocs); % Number of troughs

for i = 1:event_count
    pkloc_time = pklocs(i);
    % Find the index of pkloc_time in ds_sec_signal_2
    [~, closest_index] = min(abs(ds_sec_signal_2_124 - pkloc_time));
    start_index = max(1, closest_index - round(30 * signal_fs_124));
    end_index = min(length(ds_delta465_filt_2_124_smooth), closest_index + round(60 * signal_fs_124));
    
    % Create a new figure for each trough
    figure; % Create a new figure window for each plot to make it one by one
    hold on;
    
    % Plot the NE trace for this event, ensuring the time axis is centered at the trough
    plot_time = ds_sec_signal_2_124(start_index:end_index) - ds_sec_signal_2_124(closest_index);
    plot(plot_time, ds_delta465_filt_2_124_smooth(start_index:end_index));
    
    % Formatting the plot
    title(['Trough ' num2str(i) ' NE Activity']);
    xlabel('Time (s) relative to trough');
    ylabel('NE Activity');
    xlim([-30, 60]); % 30 seconds before to 60 seconds after the trough
    grid on;
    hold off;
    
    % Pause and wait for the user to close the figure or press a key to continue to the next plot
    waitforbuttonpress; % Wait for a button press to continue
    % Alternatively, use pause; and manually close the figure to move to the next one
end

%% QC plot for HRB events - not run yet!
sleep_stage_periods_117 = {NREMexclMA_periods_117, NREMinclMA_periods_117, wake_periods_117, REM_periods_117};
sleep_stages_117 = {'NREM excl MA - M117', 'NREM incl MA - M117', 'Wake - M117', 'REM - M117'};
QC_plot_all_HRB(sleep_stage_periods_117, sleep_stages_117, HRB_117, HRB_time_117)

sleep_stage_periods_124 = {NREMexclMA_periods_124, NREMinclMA_periods_124, wake_periods_124, REM_periods_124};
sleep_stages_124 = {'NREM excl MA - M124', 'NREM incl MA - M124', 'Wake - M124', 'REM - M124'};
QC_plot_all_HRB(sleep_stage_periods_124, sleep_stages_124, HRB_124, HRB_time_124)

%% Split NE into hours for each mouse and store the information

mice_data_hours = []; % To store mouse numbers and their corresponding data hours

for idx = 1:length(synapse_mice)
    mouse = synapse_mice{idx};
    mouseNumber = mouse{3}; % Extract unique mouse identifier
    
    % Assuming data_FPrig contains the start and end time information for each mouse
    data_FPrig_varName = sprintf('data_FPrig_%s', mouseNumber);
    data_FPrig = eval(data_FPrig_varName); % Dynamically access the data_FPrig variable for the current mouse
    
        % Extract start and end times from data_FPrig
    startTimeStr = data_FPrig.info.utcStartTime;
    endTimeStr = data_FPrig.info.utcStopTime;

    % Convert to datetime in UTC timezone
    startTime = datetime(startTimeStr, 'InputFormat', 'HH:mm:ss', 'TimeZone', 'UTC');
    endTime = datetime(endTimeStr, 'InputFormat', 'HH:mm:ss', 'TimeZone', 'UTC');
    
    % Adjust startTime and endTime by adding one hour for local time zone
    startTime = startTime + hours(1);
    endTime = endTime + hours(1);

    % Now adjust to full hours for segmentation, using the local time
    startTimeNextHour = dateshift(startTime, 'start', 'hour', 'next');
    endTimePreviousHour = dateshift(endTime, 'end', 'hour', 'previous');
    
    % Calculate total full hours and segment data
    totalFullHours = hours(endTimePreviousHour - startTimeNextHour);
    currentSegmentStart = startTimeNextHour;

    signal_fs_varName = sprintf('signal_fs_%s', mouseNumber);
    signal_fs = eval(signal_fs_varName); % Access signal frequency for the current mouse
    
    delta465_filt_2_varName = sprintf('delta465_filt_2_%s', mouseNumber);
    sec_signal_2_varName = sprintf('sec_signal_2_%s', mouseNumber);
    delta465_filt_2 = eval(delta465_filt_2_varName); % Access the FP data for the current mouse
    
    for i = 1:totalFullHours
        % Segment naming incorporating mouse number and hour
        hourSegment = hour(currentSegmentStart);
        
        segmentStartSec = seconds(currentSegmentStart - startTime);
        segmentEndSec = segmentStartSec + 3600; % +1 hour in seconds
        
        % Indices for the segment
        segmentStartIndex = round(segmentStartSec * signal_fs) + 1;
        segmentEndIndex = min(round(segmentEndSec * signal_fs), length(delta465_filt_2)); % Ensure it does not exceed the signal length
        
        % Extract the segments
        segmentDelta = delta465_filt_2(segmentStartIndex:segmentEndIndex);
        segmentTime = ((segmentStartIndex:segmentEndIndex) - segmentStartIndex + 1) / signal_fs;
        
        % Naming and saving segments dynamically
        eval(sprintf('delta465_filt_2_%s_%d = segmentDelta;', mouseNumber, hourSegment));
        eval(sprintf('sec_signal_2_%s_%d = segmentTime + segmentStartSec;', mouseNumber, hourSegment));
        
        % Store mouse number and hour of data segment
        mice_data_hours = [mice_data_hours; str2double(mouseNumber), hourSegment];
        
        % Move to the next hour segment
        currentSegmentStart = currentSegmentStart + hours(1);
    end
end

% At this point, 'mice_data_hours' will have 2 columns: mouse number and hour segments

%% Devide hourly NE data into sleep phases if sleep phase is long enough
min_sleep_period_duration = 90;

sleepStages = {'NREMinclMA_periods', 'NREMexclMA_periods', 'wake_periods', 'REM_periods'};
updated_mice_data_hours = []; % To store the expanded mice_data_hours data

for i = 1:size(mice_data_hours, 1)
    mouseNumber = mice_data_hours(i, 1);
    hourSegment = mice_data_hours(i, 2);

    % Dynamic variable names for sec_signal_2 and delta465_filt_2 data
    sec_signal_2_varName = sprintf('sec_signal_2_%d_%d', mouseNumber, hourSegment);
    delta465_filt_2_varName = sprintf('delta465_filt_2_%d_%d', mouseNumber, hourSegment);
    
    sec_signal_2_hourly = eval(sec_signal_2_varName);
    delta465_filt_2_hourly = eval(delta465_filt_2_varName);

    for stage = sleepStages
        sleepVarName = sprintf('%s_%d', stage{1}, mouseNumber);
        sleepPeriods = eval(sleepVarName); % Load sleep periods data

        allIndices = []; % Initialize empty array to collect all relevant indices

        % Collect indices for all periods within this sleep stage
        for periodIndex = 1:size(sleepPeriods, 1)
            onset = sleepPeriods(periodIndex, 1);
            offset = sleepPeriods(periodIndex, 2);
            
            % Check if the sleep period is longer than 120 seconds
            if (offset - onset) > min_sleep_period_duration
                % Indices where sec_signal_2_hourly is within the onset and offset
                indices = find(sec_signal_2_hourly >= onset & sec_signal_2_hourly <= offset);
                

                % Use allIndices to extract the relevant segments
                if ~isempty(indices)
                    filtered_sec_signal_2 = sec_signal_2_hourly(indices);
                    filtered_delta465_filt_2 = delta465_filt_2_hourly(indices);
        
                    % Save filtered data with new variable names
                    newSecSignalName = sprintf('sec_signal_2_%d_%d_%s', mouseNumber, hourSegment, stage{1}(1:end-8)); % Simplify stage name
                    newDeltaName = sprintf('delta465_filt_2_%d_%d_%s', mouseNumber, hourSegment, stage{1}(1:end-8));
        
                    eval([newSecSignalName ' = filtered_sec_signal_2;']);
                    eval([newDeltaName ' = filtered_delta465_filt_2;']);
        
                    % Update new mice_data_hours array
                    updated_mice_data_hours = [updated_mice_data_hours; [mouseNumber, hourSegment, {stage{1}(1:end-8)}, {newSecSignalName}, {eval(newSecSignalName)}, {newDeltaName}, {eval(newDeltaName)}]];
                end
            end
        end
    end
end

%Information on updated_mice_data_hours: first collumn is the mouse number,
%2nd collumn is the start of the hour
%3rd collumn is the sleep variable
%4th and 5th holds the name of FP time variable and the actual timestamps
%in seconds
%6th and 7th holds the name of FP data variable and the actual FP data
%% Get PSD for each sleep stage
% Initialization
max_freq = 0.1; % Maximum frequency for PSD analysis
sample_pr_sec = 0.002; % Frequency resolution for PSD

% Initialize the PSD_NE_table_new with headers
PSD_NE_table_new = [{'MouseNumber', 'Hour', 'SleepStage', 'PeakPower', 'PeakPowerFreq', 'Freq25Quartile', 'MedianFrequency', 'Freq75Quartile', 'Freq95Quartile', 'AUC', 'TotalPower'}];
PSD_data = [];
uniqueMouseNumbers = unique(cell2mat(updated_mice_data_hours(:, 1)));
uniqueHours = unique(cell2mat(updated_mice_data_hours(:, 2)));

% Loop through each hour
for uHour = uniqueHours'
    
    % Find all entries for this hour
    hourEntries = updated_mice_data_hours([updated_mice_data_hours{:, 2}] == uHour, :);

    % Loop through each mouse for the current hour
    for uMouseNumber = uniqueMouseNumbers'
        
        % Extract fs for the current mouse using its identifier
        fs_varName = sprintf('signal_fs_%d', uMouseNumber);
        fs = eval(fs_varName); % Assuming fs is defined in the workspace
        
        combinedPSDData = struct(); % Structure to hold combined PSD data for each sleep stage

        % Loop through each sleep stage for the current mouse and hour
        for uSleepStage = sleepStages
            sleepStage = uSleepStage{1}(1:end-8); % Removing '_periods'
            stageEntries = hourEntries(strcmp(hourEntries(:,3), sleepStage), :);

            weightedPSD = [];
            freqs = [];
            totalDataPoints = 0;

            % Process each sleep bout within the stage
            for entry = stageEntries'
                secSignalData = entry{5};
                deltaSignalData = entry{7};

                % Process each signal segment to calculate PSD
                [detrendedSignal, segmentPSD, freqs, segmentDataPoints] = processSignalSegment(secSignalData, deltaSignalData, fs, max_freq, sample_pr_sec);

                % figure
                % set(gcf, 'Position',  [100, 300, 1500, 250])
                % titleStr = sprintf('Sleep Stage: %s, Mouse: %d', sleepStage, uMouseNumber);
                % sgtitle(titleStr); 
                % a = subplot(1,2,1);
                %     %a.Position = [0.1300 0.1100 0.6200 0.8150];
                %     plot(secSignalData,deltaSignalData);
                %     hold on
                %     plot(secSignalData,detrendedSignal);
                %     legend({'raw','fitted'})
                %     hold off
                % b = subplot(1,2,2);
                %     %b.Position = [0.8140 0.1100 0.1533 0.8150];
                %     plot(freqs,segmentPSD);

                if isempty(weightedPSD)
                    weightedPSD = segmentPSD * segmentDataPoints;
                else
                    weightedPSD = weightedPSD + segmentPSD * segmentDataPoints;
                end
                totalDataPoints = totalDataPoints + segmentDataPoints;
            end

            if totalDataPoints > 0
                % Calculate average PSD for this stage
                avgPSD = weightedPSD / totalDataPoints;
                PSD_data = [PSD_data; [uMouseNumber, uHour, sleepStage, {freqs}, {avgPSD}, totalDataPoints]];

                % Calculate additional metrics from avgPSD and freqs
                [metrics] = calculatePSDMetrics(avgPSD, freqs);

                % Append the calculated metrics for this mouse, hour, and sleep stage to PSD_NE_table_new
                PSD_NE_table_new = [PSD_NE_table_new; {uMouseNumber, uHour, sleepStage, metrics.peakPower, metrics.peakPowerFreq, metrics.Freq25Quartile, metrics.MedianFrequency, metrics.Freq75Quartile, metrics.Freq95Quartile, metrics.AUC, metrics.totalPower}];
            end
        end
    end
end
%% Get PSD per hour/stage cross animal

% Initialize a table for averaged PSD data across mice for each sleep stage and hour
avgPSD_data = [];

% Unique hours and sleep stages for grouping
uniqueHours = unique([PSD_data{:, 2}]);
uniqueSleepStages = unique(PSD_data(:, 3));

% Loop through each unique hour and sleep stage to average PSDs
for hourIdx = 1:length(uniqueHours)
    uHour = uniqueHours(hourIdx);

    % Assuming uniqueHours was obtained from a numeric array
    % Find all entries for this hour
    hourEntriesIdx = find(cell2mat(PSD_data(:, 2)) == uHour);

    for stageIdx = 1:length(uniqueSleepStages)
        uSleepStage = uniqueSleepStages{stageIdx};

        % Since uniqueSleepStages comes from a cell array of strings,
        % use cellfun combined with strcmp to compare each element
        stageMatches = cellfun(@(x) strcmp(x, uSleepStage), PSD_data(:, 3));
        
        % Now find the indices where both the hour and the sleep stage match
        % This requires combining the logical arrays for hour and stage
        matchingEntriesIdx = hourEntriesIdx(stageMatches(hourEntriesIdx));
        
        if isempty(matchingEntriesIdx)
            continue; % Skip if no matching entries
        end
        
        % Initialize accumulator for PSD sums and list to store mouse numbers
        PSD_sum = zeros(size(PSD_data{matchingEntriesIdx(1), 5})); % Initialize based on the first entry's PSD size
        numEntries = 0; % Count of matching entries
        mouseNumbersList = []; % To store mouse numbers contributing to the average
        
        % Loop through matching entries to accumulate PSD sums and collect mouse numbers
        for idx = matchingEntriesIdx'
            currentAvgPSD = PSD_data{idx, 5};
            PSD_sum = PSD_sum + currentAvgPSD; % Sum up the PSD values
            numEntries = numEntries + 1; % Increment count
            mouseNumbersList = [mouseNumbersList, PSD_data{idx, 1}]; % Append mouse number
        end
        
        % Calculate the simple average PSD for the current hour and sleep stage
        if numEntries > 0
            avgPSD = PSD_sum / numEntries; % Calculate the simple average
            currentFreqs = PSD_data{matchingEntriesIdx(1), 4}; % Frequencies assumed to be consistent
            % Add the averaged PSD data and the list of mouse numbers to avgPSD_data
            avgPSD_data = [avgPSD_data; {uHour, uSleepStage, currentFreqs, avgPSD, mouseNumbersList}];
        end
    end
end
%% Plot PSD for NREMinclMA per hour
plotPSDBySleepStage(avgPSD_data, 'NREMinclMA')

%% plot PSD per hour per sleepsatge
% Assuming avgPSD_data is not empty and frequencies are consistent across all entries
if isempty(avgPSD_data)
    disp('avgPSD_data is empty. No plots can be generated.');
    return; % Exit if avgPSD_data is empty
end

% Extract frequencies from the first row of avgPSD_data for plotting
universalFreqs = avgPSD_data{1, 3}; % Use the frequencies from the first row for all plots

colors = {'blue', 'red', 'green', 'black'}; % Color for each sleep phase
sleepStages = {'NREMinclMA', 'NREMexclMA', 'REM', 'wake'};
colorMap = containers.Map(sleepStages, colors);

uniqueHours = unique([avgPSD_data{:, 1}]);
uniqueSleepStages = unique(avgPSD_data(:, 2));

% Loop through each unique hour
for hourIdx = 1:length(uniqueHours)
    uHour = uniqueHours(hourIdx);

    figure; % Create a new figure for each unique hour
    hold on; % Hold on to plot multiple lines

    % Initialize a container to collect mouse numbers for the current hour
    mouseNumbersForHour = [];

    % Loop through each unique sleep stage
    for stageIdx = 1:length(uniqueSleepStages)
        uSleepStage = uniqueSleepStages{stageIdx};

        % Manual approach to find the matching entry
        matchingEntryFound = false;
        for i = 1:size(avgPSD_data, 1)
            if avgPSD_data{i, 1} == uHour && strcmp(avgPSD_data{i, 2}, uSleepStage)
                matchingEntryFound = true;
                matchingEntryIdx = i;
                disp(['Match found - Hour: ', num2str(uHour), ', Sleep Stage: ', uSleepStage, ', Row Index: ', num2str(matchingEntryIdx)]);
                break; % Stop looking once a match is found
            end
        end

        % Proceed if a matching entry is found
        if matchingEntryFound
            avgPSD = avgPSD_data{matchingEntryIdx, 4}; % Access nested PSD
            mouseNumbersList = avgPSD_data{matchingEntryIdx, 5}; % Access mouse numbers
            mouseNumbersForHour = union(mouseNumbersForHour, mouseNumbersList); % Accumulate mouse numbers

            plotColor = colorMap(uSleepStage); % Determine the color for the plot
            plot(universalFreqs, avgPSD, 'DisplayName', uSleepStage, 'Color', plotColor);
        end
    end

    % Construct the title string with mouse numbers
    mouseNumbersStr = strjoin(arrayfun(@(x) num2str(x), mouseNumbersForHour, 'UniformOutput', false), ', ');
    titleStr = sprintf('Power Spectral Density from Hour %d - %d. Averaged across Mice %s', uHour, uHour+1, mouseNumbersStr);

    title(titleStr);
    xlabel('Frequency (Hz)');
    ylabel('Weighted Power');
    legend('show');
    grid on;
    hold off;
    set(gcf, 'color', 'white');
end

%% Preprocess %NREM per hour plot

sleepStages = {'NREMinclMA_periods'}; % Only interested in 'NREMinclMA_periods' for the final output
NREM_mice_data_hours = []; % To store the expanded mice_data_hours data

for i = 1:size(mice_data_hours, 1)
    mouseNumber = mice_data_hours(i, 1);
    hourSegment = mice_data_hours(i, 2);

    % Dynamic variable names for sec_signal_2 and delta465_filt_2 data
    sec_signal_2_varName = sprintf('sec_signal_2_%d_%d', mouseNumber, hourSegment);
    delta465_filt_2_varName = sprintf('delta465_filt_2_%d_%d', mouseNumber, hourSegment);
    
    sec_signal_2_hourly = eval(sec_signal_2_varName);
    delta465_filt_2_hourly = eval(delta465_filt_2_varName);

    for stage = sleepStages
        sleepVarName = sprintf('%s_%d', stage{1}, mouseNumber);
        sleepPeriods = eval(sleepVarName); % Load sleep periods data

        allIndices = []; % Initialize empty array to collect all relevant indices

        % Collect indices for all periods within this sleep stage
        for periodIndex = 1:size(sleepPeriods, 1)
            onset = sleepPeriods(periodIndex, 1);
            offset = sleepPeriods(periodIndex, 2);
            
            % No longer checking if the sleep period is longer than a specific duration.
            % This includes all sleep periods, regardless of their duration.
            indices = find(sec_signal_2_hourly >= onset & sec_signal_2_hourly <= offset);

            if ~isempty(indices)
                filtered_sec_signal_2 = sec_signal_2_hourly(indices);
                filtered_delta465_filt_2 = delta465_filt_2_hourly(indices);
    
                % Save filtered data with new variable names
                newSecSignalName = sprintf('sec_signal_2_%d_%d_%s', mouseNumber, hourSegment, stage{1}(1:end-8)); % Simplify stage name
                newDeltaName = sprintf('delta465_filt_2_%d_%d_%s', mouseNumber, hourSegment, stage{1}(1:end-8));

                eval([newSecSignalName ' = filtered_sec_signal_2;']);
                eval([newDeltaName ' = filtered_delta465_filt_2;']);

                % Update new mice_data_hours array
                NREM_mice_data_hours = [NREM_mice_data_hours; [mouseNumber, hourSegment, {stage{1}(1:end-8)}, {newSecSignalName}, {eval(newSecSignalName)}, {newDeltaName}, {eval(newDeltaName)}]];
            end
        end
    end
end


% Assuming NREM_mice_data_hours is your input matrix or table
% with columns: Mouse ID, Hour, Sleep Stage, Variable Name, sec_signal_2 Data, Variable Name 2, delta465_filt_2 Data


% Convert hours from cells to a numeric array and subtract 6.5 to get Zeitgeber Time
% Assuming NREM_mice_data_hours(:, 2) contains the 'hours' data

if iscell(NREM_mice_data_hours(:, 2))
    % Extract numeric values from cells
    hoursNumeric = cell2mat(NREM_mice_data_hours(:, 2));
else
    % If 'hours' is already a numeric array, we don't need to convert it
    hoursNumeric = NREM_mice_data_hours(:, 2);
end

% Subtract 6.5 to get the Zeitgeber Time
zeitgeberTimes = hoursNumeric - 6.5;

% Verify if zeitgeberTimes contains NaN values
if any(isnan(zeitgeberTimes))
    warning('NaN values found after subtraction in "zeitgeberTimes"');
end

% Convert the first two columns to strings if they are not already
mouseIDs = string(NREM_mice_data_hours(:, 1));

% Create a unique key for each combination of Mouse ID and Hour by concatenating
uniqueKeys = mouseIDs + "_" + hoursNumeric;

% Find unique combinations and their indices
[uniqueCombinations, ~, groupIndices] = unique(uniqueKeys);

% Initialize the output
percent_NREM = [];

for i = 1:length(uniqueCombinations)
    % Find rows belonging to the current combination
    rows = find(groupIndices == i);
    
    % Initialize variables
    totalSeconds = 0;
    durations = []; % To store the durations of NREM bouts for calculating the mean

    for j = rows'
        % Access the sec_signal_2 data
        secSignalData = NREM_mice_data_hours{j, 5};
        
        % Calculate the duration if secSignalData is not empty
        if ~isempty(secSignalData)
            duration = max(secSignalData) - min(secSignalData);
            totalSeconds = totalSeconds + duration;
            durations = [durations; duration]; % Store the duration for later calculation
        end
    end
    
    % Calculate the percentage of an hour and the mean duration
    percentOfHour = (totalSeconds / 3600) * 100;
    meanDuration = mean(durations); % Mean duration of NREM bouts

    % Split the unique combinations to get mouse ID and hour
    mouseHourSplit = split(uniqueCombinations(i), '_');
    mouseID = str2double(mouseHourSplit(1));
    mouseID = int64(mouseID);
    
    % Use the pre-calculated Zeitgeber Time for the current rows
    % Adjust the index to match the rows from unique combinations
    hourIndex = find(mouseIDs == mouseHourSplit(1) & hoursNumeric == str2double(mouseHourSplit(2)));
    hour = zeitgeberTimes(hourIndex(1));

    % Append to the output array
    % Including the count of NREM bouts (length of rows for this combination) and mean duration
    percent_NREM = [percent_NREM; {mouseID, hour, percentOfHour, length(rows), meanDuration}];
end

% Convert to table with additional columns for NREM bout count and mean duration
percent_NREM = cell2table(percent_NREM, 'VariableNames', {'MouseID', 'Zeitgeber Time', 'PercentNREMinclMA', 'NREM_bout_n', 'NREM_bout_duration'});

%% Plot %NREM, NREM bout n, and NREM bout duration

plotNREMDataWithShading(percent_NREM, 'Percent NREM per Hour', 'PercentNREMinclMA', '% NREM', true, true);
plotNREMDataWithShading(percent_NREM, 'Mean NREM Bout Count per Hour', 'NREM_bout_n', 'Mean Bout Count', false, true);
plotNREMDataWithShading(percent_NREM, 'Mean NREM Bout Duration per Hour', 'NREM_bout_duration', 'Mean Bout Duration (sec)', false, true);

plotIndividualAnimalData(percent_NREM, 'Percent NREM per Hour', 'PercentNREMinclMA', '% NREM', true, true);
plotIndividualAnimalData(percent_NREM, 'NREM Bout Count per Hour', 'NREM_bout_n', 'Bout Count', false, true);
plotIndividualAnimalData(percent_NREM, 'NREM Bout Duration per Hour', 'NREM_bout_duration', 'Mean Bout Duration (sec)', false, true);
%% Cut NE data into 30 min
mice_data_half_hours = []; % Initialize for storing mouse numbers and their corresponding data hours in 30-min segments

for idx = 1:length(synapse_mice)
    mouse = synapse_mice{idx};
    mouseNumber = mouse{3}; % Extract unique mouse identifier

    % Dynamically access the data_FPrig variable for the current mouse
    data_FPrig_varName = sprintf('data_FPrig_%s', mouseNumber);
    data_FPrig = eval(data_FPrig_varName);

    % Extract start and end times from data_FPrig
    startTimeStr = data_FPrig.info.utcStartTime;
    endTimeStr = data_FPrig.info.utcStopTime;

    % Convert to datetime in UTC timezone and adjust for local time zone
    startTime = datetime(startTimeStr, 'InputFormat', 'HH:mm:ss', 'TimeZone', 'UTC') + hours(1);
    endTime = datetime(endTimeStr, 'InputFormat', 'HH:mm:ss', 'TimeZone', 'UTC') + hours(1);

    % Adjust startTime to the nearest half-hour forward or on the hour if it's exactly on the half-hour
    minutePart = minute(startTime);
    if minutePart < 30
        startTime.Minute = 30;
    elseif minutePart > 30
        startTime = dateshift(startTime + hours(1), 'start', 'hour');
    end

    % Adjust endTime to the nearest half-hour back
    minutePart = minute(endTime);
    if minutePart > 30
        endTime.Minute = 30;
    elseif minutePart < 30 && minutePart > 0
        endTime = dateshift(endTime, 'start', 'hour');
    end

    % Access signal frequency for the current mouse
    signal_fs_varName = sprintf('signal_fs_%s', mouseNumber);
    signal_fs = eval(signal_fs_varName);

    % Access the FP data for the current mouse
    delta465_filt_2_varName = sprintf('delta465_filt_2_%s', mouseNumber);
    delta465_filt_2 = eval(delta465_filt_2_varName);

    % Determine number of 30-minute intervals between startTime and endTime
    totalFullHalfHours = hours(endTime - startTime) * 2;
    currentSegmentStart = startTime;

    for i = 1:totalFullHalfHours
        % Use datevec to get the numeric components of the datetime
        [year, month, day, hourSegment, min_segment, sec] = datevec(currentSegmentStart);
        disp(hourSegment)
    
        segmentStartSec = seconds(currentSegmentStart - startTime);
        segmentEndSec = segmentStartSec + 1800; % +30 minutes in seconds
    
        % Calculate indices for the segment
        segmentStartIndex = round(segmentStartSec * signal_fs) + 1;
        segmentEndIndex = min(round(segmentEndSec * signal_fs), length(delta465_filt_2));
    
        % Extract segments
        segmentDelta = delta465_filt_2(segmentStartIndex:segmentEndIndex);
        segmentTime = ((segmentStartIndex:segmentEndIndex) - segmentStartIndex + 1) / signal_fs;
    
        % Naming and saving segments dynamically with 30min suffix
        eval(sprintf('delta465_filt_2_%s_%d_%d = segmentDelta;', mouseNumber, hourSegment, min_segment));
        eval(sprintf('sec_signal_2_%s_%d_%d = segmentTime + segmentStartSec;', mouseNumber, hourSegment, min_segment));
    
        % Store mouse number and half-hour of data segment, formatted as 'HH:MM'
        mice_data_half_hours = [mice_data_half_hours; {mouseNumber, sprintf('%02d:%02d', hourSegment, min_segment), '30min'}];
    
        % Advance to the next half-hour segment
        currentSegmentStart = currentSegmentStart + minutes(30);
    end
end

% Convert to table with additional columns for 30-min segments
mice_data_half_hours_table = cell2table(mice_data_half_hours, 'VariableNames', {'MouseNumber', 'TimeSegment', 'Duration'});

%% Add on the sleep phases for the 30 min data
min_sleep_period_duration = 90;

sleepStages = {'NREMinclMA_periods', 'NREMexclMA_periods', 'wake_periods', 'REM_periods'};
updated_mice_data_half_hours = []; % To store the expanded data for 30-min segments

for i = 1:size(mice_data_half_hours_table, 1)
    mouseNumber = mice_data_half_hours_table.MouseNumber{i};
    timeSegment = mice_data_half_hours_table.TimeSegment{i}; % This will be something like '14:30'
    % Parse the timeSegment to extract the hour and minutes for variable naming
    timeParts = split(timeSegment, ':');
    hourSegment = str2double(timeParts{1});
    minSegment = str2double(timeParts{2});

    % Dynamic variable names for sec_signal_2 and delta465_filt_2 data
    sec_signal_2_varName = sprintf('sec_signal_2_%s_%d_%d', mouseNumber, hourSegment, minSegment);
    delta465_filt_2_varName = sprintf('delta465_filt_2_%s_%d_%d', mouseNumber, hourSegment, minSegment);
    
    % Check if the variables exist to handle cases where they might not due to filtering or other reasons
    if exist(sec_signal_2_varName, 'var') && exist(delta465_filt_2_varName, 'var')
        sec_signal_2_halfhourly = eval(sec_signal_2_varName);
        delta465_filt_2_halfhourly = eval(delta465_filt_2_varName);

        for stage = sleepStages
            sleepVarName = sprintf('%s_%s', stage{1}, mouseNumber);
            if exist(sleepVarName, 'var')
                sleepPeriods = eval(sleepVarName); % Load sleep periods data

                allIndices = []; % Initialize empty array to collect all relevant indices

                % Collect indices for all periods within this sleep stage
                for periodIndex = 1:size(sleepPeriods, 1)
                    onset = sleepPeriods(periodIndex, 1);
                    offset = sleepPeriods(periodIndex, 2);
                    
                    % Check if the sleep period is longer than 90 seconds
                    if (offset - onset) > min_sleep_period_duration
                        indices = find(sec_signal_2_halfhourly >= onset & sec_signal_2_halfhourly <= offset);

                        if ~isempty(indices)
                            filtered_sec_signal_2 = sec_signal_2_halfhourly(indices);
                            filtered_delta465_filt_2 = delta465_filt_2_halfhourly(indices);
            
                            % Save filtered data with new variable names
                            newSecSignalName = sprintf('sec_signal_2_%s_%d_%d_%s_30min', mouseNumber, hourSegment, minSegment, stage{1}(1:end-8)); % Simplify stage name
                            newDeltaName = sprintf('delta465_filt_2_%s_%d_%d_%s_30min', mouseNumber, hourSegment, minSegment, stage{1}(1:end-8));
            
                            eval([newSecSignalName ' = filtered_sec_signal_2;']);
                            eval([newDeltaName ' = filtered_delta465_filt_2;']);
            
                            % Update new mice_data_half_hours array
                            updated_mice_data_half_hours = [updated_mice_data_half_hours; {mouseNumber, timeSegment, stage{1}(1:end-8), newSecSignalName, filtered_sec_signal_2, newDeltaName, filtered_delta465_filt_2}];
                        end
                    end
                end
            end
        end
    end
end

%% Get PSD for 30 min data


% Initialization
max_freq = 0.1; % Maximum frequency for PSD analysis
sample_pr_sec = 0.002; % Frequency resolution for PSD


% Loop through each entry in the updated_mice_data_half_hours
% Initialization and function definitions are assumed to be as you provided.

% Revised main loop structure:
uniqueSleepStages = unique(updated_mice_data_half_hours(:, 3));
uniqueTimeSegments = unique(updated_mice_data_half_hours(:, 2));

% Create a unique identifier for each combination of MouseNumber, TimeSegment, and SleepStage
combinationIDs = strcat(updated_mice_data_half_hours(:,1), '_', updated_mice_data_half_hours(:,2), '_', updated_mice_data_half_hours(:,3));

% Find unique combinations
[uniqueCombinationIDs, idx] = unique(combinationIDs);

% Initialize your PSD table
PSD_NE_table_new_30min = [{'MouseNumber', 'Hour', 'SleepStage', 'PeakPower', 'PeakPowerFreq', 'Freq25Quartile', 'MedianFrequency', 'Freq75Quartile', 'Freq95Quartile', 'AUC', 'TotalPower', 'avgPSD', 'Freqs'}];

% Loop over unique combinations
for i = 1:length(uniqueCombinationIDs)
    % Extract the index of the current unique combination from the original data
    currentIdx = idx(i);
    mouseNumber = updated_mice_data_half_hours{currentIdx, 1};
    timeSegment = updated_mice_data_half_hours{currentIdx, 2};
    sleepStage = updated_mice_data_half_hours{currentIdx, 3};
    
    % Filter entries for the current combination
    entries = updated_mice_data_half_hours(strcmp(combinationIDs, uniqueCombinationIDs{i}), :);
    
    % Initialize variables for combining PSD data
    weightedPSD = [];
    freqs = [];
    totalDataPoints = 0;
    
    % Process each entry for the current combination
    for j = 1:size(entries, 1)
        secSignalData = entries{j, 5};
        deltaSignalData = entries{j, 7};
        
        % Assume fs is defined for each mouse and doesn't change
        fs_varName = sprintf('signal_fs_%s', mouseNumber);
        fs = eval(fs_varName);

        [detrendedSignal, segmentPSD, freqs, segmentDataPoints] = processSignalSegment(secSignalData, deltaSignalData, fs, max_freq, sample_pr_sec);
        
        if isempty(weightedPSD)
            weightedPSD = segmentPSD * segmentDataPoints;
        else
            weightedPSD = weightedPSD + segmentPSD * segmentDataPoints; % Accumulate weighted PSD
        end
        
        totalDataPoints = totalDataPoints + segmentDataPoints; % Accumulate total data points
    end

    % After processing all entries for the current combination, calculate and store metrics
    if totalDataPoints > 0
        avgPSD = weightedPSD / totalDataPoints;
        
        [metrics] = calculatePSDMetrics(avgPSD, freqs);
        
        % Extract hour and minute from timeSegment and format it
        formattedHour = formatHour(timeSegment);

        PSD_NE_table_new_30min = [PSD_NE_table_new_30min; {mouseNumber, formattedHour, sleepStage, metrics.peakPower, metrics.peakPowerFreq, metrics.Freq25Quartile, metrics.MedianFrequency, metrics.Freq75Quartile, metrics.Freq95Quartile, metrics.AUC, metrics.totalPower, avgPSD, freqs}];
    end
end

%% mean PSD per hour/sleep stage for 30 min data

% Initialize the new dataframe with headers
mean_PSD_by_hour_and_stage = {'Hour', 'SleepStage', 'MeanPSD', 'Freqs'};

uniqueHours = unique(PSD_NE_table_new_30min(2:end, 2)); % Excluding header row
uniqueSleepStages = unique(PSD_NE_table_new_30min(2:end, 3));

for i = 1:length(uniqueHours)
    for j = 1:length(uniqueSleepStages)
        currentHour = uniqueHours{i};
        currentSleepStage = uniqueSleepStages{j};

        % Initialize sumPSD and count for each combination of hour and sleep stage
        sumPSD = [];
        count = 0;
        freqs = [];

        % Iterate through the PSD_NE_table_new_30min to find matching entries
        for k = 2:size(PSD_NE_table_new_30min, 1) % Skip header row
            hour = PSD_NE_table_new_30min{k, 2};
            sleepStage = PSD_NE_table_new_30min{k, 3};
            if strcmp(hour, currentHour) && strcmp(sleepStage, currentSleepStage)
                avgPSD = PSD_NE_table_new_30min{k, 12};
                if isempty(sumPSD)
                    sumPSD = avgPSD;
                    freqs = PSD_NE_table_new_30min{k, 13};
                else
                    % Element-wise addition of the avgPSD to the sumPSD
                    sumPSD = sumPSD + avgPSD; % Assumes avgPSD and sumPSD have the same size
                end
                count = count + 1;
            end
        end

        if count > 0
            % Calculate the mean PSD
            meanPSD = sumPSD / count;
            % Append the results to the new dataframe
            mean_PSD_by_hour_and_stage = [mean_PSD_by_hour_and_stage; {currentHour, currentSleepStage, meanPSD, freqs}];
        end
    end
end

if isempty(mean_PSD_by_hour_and_stage)
    disp('mean_PSD_by_hour_and_stage is empty. No plots can be generated.');
    return; % Exit if mean_PSD_by_hour_and_stage is empty
end

% Define colors and sleep stages for plotting
colors = {'blue', 'red', 'green', 'black'}; % Color for each sleep phase
sleepStages = {'NREMinclMA', 'NREMexclMA', 'REM', 'wake'};
colorMap = containers.Map(sleepStages, colors);

% Extract unique time segments for plotting
uniqueTimeSegments = unique(mean_PSD_by_hour_and_stage(2:end, 1)); % Skipping header row

% Loop through each unique time segment
for i = 1:length(uniqueTimeSegments)
    uTimeSegment = uniqueTimeSegments{i};
    figure; % Create a new figure for each time segment
    hold on; % Hold on to plot multiple lines

    % Extract frequencies from the first row for plotting (assuming consistency across rows)
    universalFreqs = mean_PSD_by_hour_and_stage{2, 4}; % Directly access the frequencies array

    % Loop through each sleep stage for plotting
    for j = 1:length(sleepStages)
        uSleepStage = sleepStages{j};
        color = colorMap(uSleepStage);

        % Initialize a flag to check if the stage is found for plotting
        stageFound = false;

        % Find matching rows for current time segment and sleep stage
        for k = 2:size(mean_PSD_by_hour_and_stage, 1) % Skip header row
            if strcmp(mean_PSD_by_hour_and_stage{k, 1}, uTimeSegment) && strcmp(mean_PSD_by_hour_and_stage{k, 2}, uSleepStage)
                avgPSD = mean_PSD_by_hour_and_stage{k, 3}; % Directly access avgPSD
                plot(universalFreqs, avgPSD, 'DisplayName', uSleepStage, 'Color', color);
                stageFound = true;
                break; % Break after finding the first match, assuming one row per sleep stage per time segment
            end
        end

        % Check if the stage was not found for the current segment
        if ~stageFound
            disp(['No data found for ', uTimeSegment, ' - ', uSleepStage]);
        end
    end

    titleStr = formatTitle(uTimeSegment);
    title(titleStr);
    xlabel('Frequency (Hz)');
    ylabel('Power Spectral Density');
    legend('show');
    grid on;
    hold off;
    set(gcf, 'color', 'white');
end
%% Preprocess NREM plots
% Initialize for storing processed data including actual data arrays
sleepStages = {'NREMinclMA_periods'}; % Only interested in 'NREMinclMA_periods' for the final output
NREM_mice_data_half_hours = [];

for i = 1:size(mice_data_half_hours_table, 1)
    mouseNumber = mice_data_half_hours_table.MouseNumber{i};
    timeSegment = mice_data_half_hours_table.TimeSegment{i}; % 'HH:MM' format
    
    % Split the timeSegment into hours and minutes
    [hoursPart, minutesPart] = strtok(timeSegment, ':');
    minutesPart = strrep(minutesPart, ':', ''); % Remove colon
    
    % Remove leading zeros from the hour part
    hoursPart = num2str(str2double(hoursPart));
    
    % Adjust minutes formatting
    if strcmp(minutesPart, '00')
        minutesFormatted = '0'; % For "00" minutes, format as "_0"
    elseif strcmp(minutesPart, '30')
        minutesFormatted = '30'; % Keep "30" minutes as "_30"
    else
        minutesFormatted = ['0', minutesPart]; % For non-standard cases, assuming correction
    end
    
    % Combine the adjusted hour and minute parts
    timeSegmentFormatted = [hoursPart, '_', minutesFormatted];
        
    % Dynamic variable names for sec_signal_2 and delta465_filt_2 data
    sec_signal_2_varName = sprintf('sec_signal_2_%s_%s', mouseNumber, timeSegmentFormatted);
    delta465_filt_2_varName = sprintf('delta465_filt_2_%s_%s', mouseNumber, timeSegmentFormatted);

    
    % Check if variables exist using the who function to avoid eval's overhead
    if ismember(sec_signal_2_varName, who()) && ismember(delta465_filt_2_varName, who())
        sec_signal_2_data = eval(sec_signal_2_varName);
        delta465_filt_2_data = eval(delta465_filt_2_varName);

        % Process sleep stages
        for stage = sleepStages
            sleepVarName = sprintf('%s_%s', stage{1}, mouseNumber);
            if ismember(sleepVarName, who())
                sleepPeriods = eval(sleepVarName); % Fetch sleep periods data
                
                for periodIndex = 1:size(sleepPeriods, 1)
                    onset = sleepPeriods(periodIndex, 1);
                    offset = sleepPeriods(periodIndex, 2);

                    indices = find(sec_signal_2_data >= onset & sec_signal_2_data <= offset);

                    if ~isempty(indices)
                        filtered_sec_signal_2 = sec_signal_2_data(indices);
                        filtered_delta465_filt_2 = delta465_filt_2_data(indices);
                        
                        % Store actual filtered data arrays directly
                        NREM_mice_data_half_hours = [NREM_mice_data_half_hours; ...
                                                     {mouseNumber, timeSegment, stage{1}(1:end-8), filtered_sec_signal_2, filtered_delta465_filt_2}];
                    end
                end
            end
        end
    end
end

% Convert to table format, with variable names indicating the data they contain
NREM_mice_data_half_hours_table = cell2table(NREM_mice_data_half_hours, ...
                                             'VariableNames', {'MouseNumber', 'TimeSegment', 'SleepStage', 'FilteredSecSignal2Data', 'FilteredDelta465Filt2Data'});

% Adjust 'HH:MM' to decimal hours correctly for Zeitgeber Time
zeitgeberTimes = cellfun(@(x) str2double(x(1:2)) + (str2double(x(4:5)) == 30)*0.5, NREM_mice_data_half_hours_table.TimeSegment) - 6.75;

% Ensure MouseNumber is a string for concatenation
mouseIDs = string(NREM_mice_data_half_hours_table.MouseNumber);

% Create unique keys for combinations of MouseID and Zeitgeber Time
uniqueKeys = mouseIDs + "_" + string(zeitgeberTimes);

% Find unique combinations and their indices
[uniqueCombinations, ~, groupIndices] = unique(uniqueKeys);

% Initialize the output array
percent_NREM = [];

for i = 1:length(uniqueCombinations)
    % Find rows belonging to the current combination
    rows = find(groupIndices == i);

    totalSeconds = 0;
    durations = []; % To store durations of NREM bouts for calculating the mean

    for j = rows'
        % Access the sec_signal_2 data directly
        secSignalData = NREM_mice_data_half_hours_table.FilteredSecSignal2Data{j};
        
        % Check for non-empty and numeric type directly
        if ~isempty(secSignalData) && isnumeric(secSignalData)
            duration = max(secSignalData) - min(secSignalData);
            totalSeconds = totalSeconds + duration;
            durations = [durations; duration]; % Store the duration
        end
    end
    
    percentOfHour = (totalSeconds / (3600/2)) * 100;
    meanDuration = mean(durations);

    % Extract MouseID and Zeitgeber Time from the combination
    comboParts = split(uniqueCombinations(i), '_');
    mouseID = str2double(comboParts{1});
    zeitgeberTime = str2double(comboParts{2}); % Extract numeric part directly

    % Append to the output array
    percent_NREM = [percent_NREM; {mouseID, zeitgeberTime, percentOfHour, numel(rows), meanDuration}];
end

% Convert to table with appropriate column names
percent_NREM_30min = cell2table(percent_NREM, 'VariableNames', {'MouseID', 'Zeitgeber Time', 'PercentNREMinclMA', 'NREM_bout_n', 'NREM_bout_duration'});

%% Plot 30 min of %NREM, NREM bout n, and NREM bout duration

plotNREMDataWithShading(percent_NREM_30min, 'Percent NREM per Hour', 'PercentNREMinclMA', '% NREM', true, false);
plotNREMDataWithShading_30min(percent_NREM_30min, 'Mean NREM Bout Count per Hour', 'NREM_bout_n', 'Mean Bout Count', false, false);
plotNREMDataWithShading_30min(percent_NREM_30min, 'Mean NREM Bout Duration per Hour', 'NREM_bout_duration', 'Mean Bout Duration (sec)', false, false);

plotIndividualAnimalData(percent_NREM_30min, 'Percent NREM per Hour', 'PercentNREMinclMA', '% NREM', true, false);
plotIndividualAnimalData(percent_NREM_30min, 'NREM Bout Count per Hour', 'NREM_bout_n', 'Bout Count', false, false);
plotIndividualAnimalData(percent_NREM_30min, 'NREM Bout Duration per Hour', 'NREM_bout_duration', 'Mean Bout Duration (sec)', false, false);
%% New Main Plot with all data


event_var_blank = {'NREMexclMA_periods_pklocs', 'SWS_before_MA_pklocs', 'SWS_before_wake_pklocs', 'REM_before_MA_pklocs', 'REM_before_wake_pklocs'};
var_lenght = length(event_var_blank)*length(o);

epoc_start = 30;
epoc_end = 60;

iteration_counter = 0;

% Initialize collector arrays
NE_peak_all = cell(var_lenght, 2);
RR_all = cell(var_lenght, 2);
SO_all = cell(var_lenght, 2);
Delta_all = cell(var_lenght, 2);
Theta_all = cell(var_lenght, 2);
Sigma_all = cell(var_lenght, 2);
Beta_all = cell(var_lenght, 2);

% Initialize mean collector arrays
NE_peak_mean_all = cell(var_lenght, 2);
RR_mean_all = cell(var_lenght, 2);
SO_mean_all = cell(var_lenght, 2);
Delta_mean_all = cell(var_lenght, 2);
Theta_mean_all = cell(var_lenght, 2);
Sigma_mean_all = cell(var_lenght, 2);
Beta_mean_all = cell(var_lenght, 2);

for idx = 1:length(o)
    mouse = o{idx};
    % Since mouse{3} contains the ID for all mice, directly use it to create the mouseID
    mouseID = mouse{3}; % Extract the unique ID from the third index
    disp(['Processing mouse ID: ', mouseID]);
    ID = sprintf('M%s', mouseID);

        % Create a new cell array for storing the renamed variables
    event_var = cell(size(event_var_blank));
    for i = 1:length(event_var_blank)
        event_var{i} = sprintf('%s_%s', event_var_blank{i}, mouseID);
    end

    % Format the variable names for EEG and other signals
    sec_signal_2 = sprintf('sec_signal_2_%s', mouseID);
    NE_fs = sprintf('signal_fs_%s', mouseID);
    delta465_filt_2 = sprintf('delta465_filt_2_%s', mouseID);
    RR = sprintf('RR_%s', mouseID);
    RR_time = sprintf('RR_time_%s', mouseID);
    RR_fs = sprintf('RR_fs_%s', mouseID);
    mean_spectrogram = sprintf('mean_spectrogram_%s', mouseID);
    F = sprintf('F_%s', mouseID);
    EEG_bands_fs = sprintf('EEG_bands_fs_%s', mouseID);

        % Access the variables dynamically
    sec_signal_2 = eval(sec_signal_2);
    NE_fs = eval(NE_fs);
    delta465_filt_2 = eval(delta465_filt_2);
    RR = eval(RR);
    RR_time = eval(RR_time);
    RR_fs = eval(RR_fs);
    mean_spectrogram = eval(mean_spectrogram);
    F = eval(F);
    EEG_bands_fs = eval(EEG_bands_fs);
  
   % mid_point = ceil(epoc_start * RR_fs);  % This should be the index of the event time
    %max_epoch_length = ceil((epoc_start + epoc_end) * RR_fs);
    %total_epoch_length = ceil((epoc_start + epoc_end) * RR_fs);
    power_bands = {[0.5, 1], [1, 4], [4, 8], [8, 15], [15, 30]}; % define SO, delta, theta, sigma, and beta, respectively
    
    %Add in the time variable for plotting
   % epoc_FPtime_NE = linspace(-epoc_start, epoc_end, ceil((epoc_start + epoc_end) * NE_fs));
   % epoc_FPtime_EEG_bands = linspace(-epoc_start, epoc_end, ceil((epoc_start + epoc_end) * EEG_bands_fs));
   % epoc_FPtime_RR = linspace(-epoc_start, epoc_end, max_epoch_length);
    
        % Initialize variables to store maximum and minimum values for each type of subplot

    % Iterate over each sleep stage and its NE trough variables
    for stage_idx = 1:length(event_var)
        event_type = event_var{stage_idx}; % Select the current event type
        num_events = length(event_type); % Number of events for the current sleep stage
        iteration_counter = iteration_counter + 1;  % Increment the counter each time the loop runs


        % Resetting collectors for each sleep stage
        NE_peak_epoc_collector = [];
        RR_collector = [];
        SO_collector = [];
        Delta_collector = [];
        Theta_collector = [];
        Sigma_collector = [];
        Beta_collector = [];

            % Extract power for specified bands
        band_powers = cell(1, length(power_bands));
        for b = 1:length(power_bands)
            freq_range = power_bands{b};
            band_powers{b} = mean(mean_spectrogram(F >= freq_range(1) & F <= freq_range(2), :), 1);
        end

        % Extract NE and EEG band epochs for the current sleep stage
        for i = 1:length(event_type)
            NEpk_i = event_type(i);
            if NEpk_i > sec_signal_2(end) - epoc_end % Skip if event is too close to end of recording
                continue;
            end

            % Extract NE epochs
            NEpk_epoc_i = delta465_filt_2((NEpk_i - epoc_start) * NE_fs : (NEpk_i + epoc_end) * NE_fs);
            NE_peak_epoc_collector = [NE_peak_epoc_collector; NEpk_epoc_i];

            HRB_i = event_type(i);
            if HRB_i < RR_time(1) + epoc_start || HRB_i > RR_time(end) - epoc_end
                disp(['Event ', num2str(i), ' skipped due to proximity to start/end of recording']);
                continue;  % Skip this event
            end

            [~, event_idx] = min(abs(RR_time - HRB_i));  % Find the event index in filtered_RR_time

            epoch_start_idx = max(event_idx - mid_point + 1, 1);
            epoch_end_idx = min(event_idx + (total_epoch_length - mid_point), length(RR));

            if epoch_end_idx - epoch_start_idx + 1 <= total_epoch_length
                RR_collector(1:(epoch_end_idx - epoch_start_idx + 1), i) = RR(epoch_start_idx:epoch_end_idx);
            end


            % Extract epochs for EEG bands
            for b = 1:length(band_powers)
                EEG_band_epoc_i = band_powers{b}(:, (NEpk_i - epoc_start)*EEG_bands_fs:(NEpk_i + epoc_end)*EEG_bands_fs);
            switch b
                case 1
                    SO_collector = [SO_collector; EEG_band_epoc_i];
                case 2
                    Delta_collector = [Delta_collector; EEG_band_epoc_i];
                case 3
                    Theta_collector = [Theta_collector; EEG_band_epoc_i];
                case 4
                    Sigma_collector = [Sigma_collector; EEG_band_epoc_i];
                case 5
                    Beta_collector = [Beta_collector; EEG_band_epoc_i];
                end
            end
        end      
        % Append the collected data to the corresponding all array
        NE_peak_all{iteration_counter, 1} = event_var{stage_idx};
        NE_peak_all{iteration_counter, 2} = NE_peak_epoc_collector;
        RR_all{iteration_counter, 1} = event_var{stage_idx};
        RR_all{iteration_counter, 2} = RR_collector';
        SO_all{iteration_counter, 1} = event_var{stage_idx};
        SO_all{iteration_counter, 2} = SO_collector;
        Delta_all{iteration_counter, 1} = event_var{stage_idx};
        Delta_all{iteration_counter, 2} = Delta_collector;
        Theta_all{iteration_counter, 1} = event_var{stage_idx};
        Theta_all{iteration_counter, 2} = Theta_collector;
        Sigma_all{iteration_counter, 1} = event_var{stage_idx};
        Sigma_all{iteration_counter, 2} = Sigma_collector;
        Beta_all{iteration_counter, 1} = event_var{stage_idx};
        Beta_all{iteration_counter, 2} = Beta_collector;

                
        % Calculate means and append
        NE_peak_mean_all{iteration_counter, 1} = event_var{stage_idx};
        NE_peak_mean_all{iteration_counter, 2} = [nanmean(NE_peak_epoc_collector, 1)];
        RR_mean_all{iteration_counter, 1} = event_var{stage_idx};
        RR_mean_all{iteration_counter, 2} = [nanmean(RR_collector, 2)];
        SO_mean_all{iteration_counter, 1} = event_var{stage_idx};
        SO_mean_all{iteration_counter, 2} = [nanmean(SO_collector, 1)];
        Delta_mean_all{iteration_counter, 1} = event_var{stage_idx};
        Delta_mean_all{iteration_counter, 2} = [nanmean(Delta_collector, 1)];
        Theta_mean_all{iteration_counter, 1} = event_var{stage_idx};
        Theta_mean_all{iteration_counter, 2} = [nanmean(Theta_collector, 1)];
        Sigma_mean_all{iteration_counter, 1} = event_var{stage_idx};
        Sigma_mean_all{iteration_counter, 2} = [nanmean(Sigma_collector, 1)];
        Beta_mean_all{iteration_counter, 1} = event_var{stage_idx};
        Beta_mean_all{iteration_counter, 2} = [nanmean(Beta_collector, 1)];
    end
end
%% 
warning('off','all')
warning
% Define the list of all event types for ease of access
event_types = {'NE_peak', 'RR', 'SO', 'Delta', 'Theta', 'Sigma', 'Beta'};

summary_stats = struct();

% Process each event type
for k = 1:length(event_types)
    event_key = event_types{k};
    mean_all = eval([event_key '_mean_all']);  % dynamically access the mean_all arrays

    % Step 1: Modify the first column to remove the last four characters
    for i = 1:size(mean_all, 1)
        if length(mean_all{i, 1}) > 4
            mean_all{i, 1} = mean_all{i, 1}(1:end-4);
        end
    end

    % Step 2: Aggregate data by the modified first column entries
    unique_events = unique(mean_all(:, 1));  % find unique event types

    % Calculate mean and SE for each unique event
    for j = 1:length(unique_events)
        event_name = unique_events{j};
        idx = strcmp(mean_all(:, 1), event_name);  % find all rows with this event
        data_list = mean_all(idx, 2);  % fetch the data for these indices

        % Special handling for 'RR' data if it's transposed
        if strcmp(event_key, 'RR')
            for row = 1:length(data_list)
                data_list{row, 1} = data_list{row, 1}';
            end
        end
        data_matrix = vertcat(data_list{:});  % concatenate all data arrays vertically
        

        % Check for consistent lengths
        row_lengths = cellfun(@(x) length(x), data_list);
        if ~all(row_lengths == row_lengths(1))
            error('Mismatch in data dimensions, expected all rows to be the same length for event %s', event_name);
        end

        % Calculate the mean and SE across each time point (column-wise)
        mean_values = nanmean(data_matrix, 1);  % Row vector of means at each time point
        se_values = nanstd(data_matrix, 0, 1) / sqrt(size(data_matrix, 1));  % SE at each time point

        % Store in a structured way
        summary_stats.(event_name).(event_key).mean = mean_values;
        summary_stats.(event_name).(event_key).SE = se_values;
    end
end

% Now, summary_stats contains the mean and SE for each event type for each data category
% Each .mean and .SE fields will contain an array corresponding to each time point of the respective event length
%% 
% Event groups and custom legends
first_group = {'NREMexclMA_periods_pklocs', 'SWS_before_MA_pklocs', 'SWS_before_wake_pklocs'};
first_group_legends = {'NREM', 'NREM to MA', 'NREM to Wake'};
second_group = {'REM_before_MA_pklocs', 'REM_before_wake_pklocs'};
second_group_legends = {'REM to MA', 'REM to Wake'};

% Custom colors for each group
first_group_colors = [0.3010 0.7450 0.9330; 0 0.4470 0.7410; 0 0 0.5]; % Light blue, blue, dark blue
second_group_colors = [0.4660 0.6740 0.1880; 0 0.5 0]; % Light green, green

% Preparing the time axes based on sampling frequency
time_axes = struct();
time_axes.NE_peak = linspace(-30, 60, 91553); % Length for NE_peak
time_axes.RR = linspace(-30, 60, 5760);       % Length for RR
time_axes.SO = linspace(-30, 60, 180);        % Length for SO and Delta

% Define subplots based on data types and their frequencies
data_types = {'NE_peak', 'RR', 'SO', 'Delta'};

for i = 1:2  % There are two rows
    for j = 1:3  % There are three columns
        index = (i - 1) * 3 + j;  % Calculate the subplot index
        subplot(2, 3, index);
        hold on;

        % Determine the correct event group based on row index
        if i == 1
            group = first_group;
            legends = first_group_legends;
            group_colors = first_group_colors;
        else
            group = second_group;
            legends = second_group_legends;
            group_colors = second_group_colors;
        end

        % Determine the data type based on column index
        data_type = data_types{j};

        % Fetch the correct time axis
        time_points = time_axes.(data_type);

        % Plot data for each event type within the group
        for k = 1:length(group)
            event_stats = summary_stats.(group{k}).(data_type);
            lineProps = {'Color', group_colors(k,:), 'LineWidth', 2};
            shadedErrorBar(time_points, event_stats.mean, event_stats.SE, lineProps, 1);
        end

        % Correctly assigning title based on group using MATLAB's if-else structure
        if i == 1
            group_title = 'NREM';
        else
            group_title = 'REM';
        end

        % Formatting the plot
        if strcmp(data_type, 'NE_peak')
            title(['NE - ' group_title]);  % Simplified title for 'NE_peak'
            ylabel('df/f');
                    % Formatting the plot
        elseif strcmp(data_type, 'RR')
            title(['RR - ' group_title]);  % Simplified title for 'NE_peak'
            ylabel('RR Interval (s)');
        elseif strcmp(data_type, 'SO')
            title(['Slow Oscillations - ' group_title]);  % Simplified title for 'NE_peak'
            ylabel('mV');
        elseif strcmp(data_type, 'Delta')
            title(['Delta Oscillations - ' group_title]);  % Simplified title for 'NE_peak'
            ylabel('mV');
        else
        title([data_type ' - ' group_title]);
        ylabel([data_type ' Measurements']);
        end
        xlabel('Time (s)');
        legend(legends, 'Location', 'NorthEast');  % Adjusted legend position to 'NorthEast'
        grid on;
    end
end

% Enhance figure appearance
set(gcf, 'Color', 'w'); % Set figure background to white
sgtitle('Event Type Analysis Across Stages'); % Super title for the figure


%% 
% Event groups and custom legends
first_group = {'NREMexclMA_periods_pklocs', 'SWS_before_MA_pklocs', 'SWS_before_wake_pklocs'};
first_group_legends = {'NREM', 'NREM to MA', 'NREM to Wake'};
second_group = {'REM_before_MA_pklocs', 'REM_before_wake_pklocs'};
second_group_legends = {'REM to MA', 'REM to Wake'};

% Custom colors for each group
first_group_colors = [0.3010 0.7450 0.9330; 0 0.4470 0.7410; 0 0 0.5]; % Light blue, blue, dark blue
second_group_colors = [0.4660 0.6740 0.1880; 0 0.5 0]; % Light green, green

% Preparing the time axes based on sampling frequency
time_axes = struct();
time_axes.NE_peak = linspace(-30, 60, 91553); % Length for NE_peak
time_axes.RR = linspace(-30, 60, 5760);       % Length for RR
time_axes.SO = linspace(-30, 60, 180);        % Length for SO and Delta

% Define subplots based on data types and their frequencies
data_types = {'NE_peak', 'RR', 'SO', 'Delta'};
for i = 1:2  % There are two rows
    for j = 1:3  % There are three columns
        subplot(2, 3, (i - 1) * 3 + j);
        hold on;

        % Determine the correct event group based on row index using MATLAB if-else
        if i == 1
            group = first_group;
            group_colors = first_group_colors;
            legends = first_group_legends;
        else
            group = second_group;
            group_colors = second_group_colors;
            legends = second_group_legends;
        end

        % Determine the data type based on column index
        data_type = data_types{j};

        % Fetch the correct time axis
        time_points = time_axes.(data_type);

        % Plot data for each event type within the group
        handles = [];  % Initialize handles array for legend entries
        for k = 1:length(group)
            event_stats = summary_stats.(group{k}).(data_type);
            lineProps = {'Color', group_colors(k,:), 'LineWidth', 2};
            H = shadedErrorBar(time_points, event_stats.mean, event_stats.SE, lineProps, 1);
            handles(k) = H.mainLine;  % Store the main line handle for the legend
        end

        % Formatting the plot
        if strcmp(data_type, 'NE_peak')
            title(['NE - ' group_title]);  % Simplified title for 'NE_peak'
            ylabel('df/f');
                    % Formatting the plot
        elseif strcmp(data_type, 'RR')
            title(['RR - ' group_title]);  % Simplified title for 'NE_peak'
            ylabel('RR Interval (s)');
        elseif strcmp(data_type, 'SO')
            title(['Slow Oscillations - ' group_title]);  % Simplified title for 'NE_peak'
            ylabel('mV');
        elseif strcmp(data_type, 'Delta')
            title(['Delta Oscillations - ' group_title]);  % Simplified title for 'NE_peak'
            ylabel('mV');
        else
        title([data_type ' - ' group_title]);
        ylabel([data_type ' Measurements']);
        end
        xlabel('Time (s)');
        legend(legends, 'Location', 'NorthEast');  % Adjusted legend position to 'NorthEast'
        grid on;
    end
end

% Enhance figure appearance
set(gcf, 'Color', 'w'); % Set figure background to white
sgtitle('Event Type Analysis Across Stages'); % Super title for the figure



%% 

% Define the figure
figure;

% Event groups and custom legends
first_group = {'NREMexclMA_periods_pklocs', 'SWS_before_MA_pklocs', 'SWS_before_wake_pklocs'};
first_group_legends = {'NREM', 'NREM to MA', 'NREM to Wake'};
second_group = {'REM_before_MA_pklocs', 'REM_before_wake_pklocs'};
second_group_legends = {'REM to MA', 'REM to Wake'};

% Custom colors for each group
first_group_colors = [0.3010 0.7450 0.9330; 0 0.4470 0.7410; 0 0 0.5]; % Light blue, blue, dark blue
second_group_colors = [0.4660 0.6740 0.1880; 0 0.5 0]; % Light green, green

% Preparing the time axes based on sampling frequency
time_axes = struct();
time_axes.NE_peak = linspace(-30, 60, 91553); % Length for NE_peak
time_axes.RR = linspace(-30, 60, 5760);       % Length for RR
time_axes.SO = linspace(-30, 60, 180);        % Length for SO and Delta

% Define subplots based on data types and their frequencies
data_types = {'NE_peak', 'RR', 'SO', 'Delta', 'CrossCorrelation'};

for i = 1:2  % There are two rows
    for j = 1:4  % Updated to four columns
        index = (i - 1) * 4 + j;  % Calculate the subplot index
        subplot(2, 4, index);
        hold on;

        % Determine the correct event group based on row index
        if i == 1
            group = first_group;
            legends = first_group_legends;
            group_colors = first_group_colors;
        else
            group = second_group;
            legends = second_group_legends;
            group_colors = second_group_colors;
        end

        if j < 4  % Original data plotting for NE_peak, RR, and SO
            data_type = data_types{j};
            time_points = time_axes.(data_type);

            % Plot data for each event type within the group
            for k = 1:length(group)
                event_stats = summary_stats.(group{k}).(data_type);
                lineProps = {'Color', group_colors(k,:), 'LineWidth', 2};
                shadedErrorBar(time_points, event_stats.mean, event_stats.SE, lineProps, 1);
            end

        else  % Fourth column for cross-correlation
            % Here you would compute and plot cross-correlation
            % Placeholder for cross-correlation plot
            plot(rand(10, 1), rand(10, 1), 'o-'); % Example placeholder plot
            title('Cross-Correlation R-values');
            ylabel('R-value');
        end

    %     % Formatting the plot
    %     if strcmp(data_type, 'NE_peak')
    %         title(['NE - ' ((i == 1) ? 'NREM' : 'REM')]);  % Simplified title for 'NE_peak'
    %         ylabel('df/f');
    %     elseif strcmp(data_type, 'RR')
    %         title(['RR - ' ((i == 1) ? 'NREM' : 'REM')]);  % Simplified title for 'RR'
    %         ylabel('RR Interval (s)');
    %     elseif strcmp(data_type, 'SO')
    %         title(['Slow Oscillations - ' ((i == 1) ? 'NREM' : 'REM')]);  % Title for 'SO'
    %         ylabel('mV');
    %     elseif strcmp(data_type, 'Delta')
    %         title(['Delta Oscillations - ' ((i == 1) ? 'NREM' : 'REM')]);  % Title for 'Delta'
    %         ylabel('mV');
    %     end
    %     xlabel('Time (s)');
    %     legend(legends, 'Location', 'NorthEast');  // Adjusted legend position to 'NorthEast'
    %     grid on;
    end
end

% Enhance figure appearance
set(gcf, 'Color', 'w'); % Set figure background to white
sgtitle('Event Type Analysis Across Stages'); % Super title for the figure
%% resample NE
% Original signal
fs_original = signal_fs_124;  % original sampling frequency
fs_new = 64;                           % new sampling frequency

% Load or define your original signal here, e.g.,
% delta465_filt_2_124 = load('your_data_file.mat').your_signal_variable;

% Calculate the greatest common divisor to find the optimal downsample factor
gcd_fs = gcd(round(fs_original), fs_new);

% Compute downsample and upsample factors
P = fs_new / gcd_fs;
Q = round(fs_original) / gcd_fs;

% Resample the signal
delta465_cross_124 = resample(delta465_filt_2_124, P, Q);
sec_signal_cross_124 = (1:length(delta465_cross_124))/fs_new;

% You can now use delta465_resampled for further processing, such as cross-correlation with the RR signal
% Example, assuming RR is already at 64 Hz and properly aligned in time:
% [C, lags] = xcorr(delta465_resampled, RR, 'coeff');
% plot(lags / fs_new, C);  % This plots the cross-correlation coefficient as a function of time lags in seconds
%% Collect data for cross correlation
event_var_blank = {'NREMexclMA_periods_pklocs', 'SWS_before_MA_pklocs', 'SWS_before_wake_pklocs', 'REM_before_wake_pklocs'};
var_lenght = length(event_var_blank)*length(o);

epoc_start = 30;
epoc_end = 60;

iteration_counter = 0;

% Initialize collector arrays
NE_cross = cell(var_lenght, 2);
RR_cross = cell(var_lenght, 2);

for idx = 1:length(o)
    mouse = o{idx};
    % Since mouse{3} contains the ID for all mice, directly use it to create the mouseID
    mouseID = mouse{3}; % Extract the unique ID from the third index
    disp(['Processing mouse ID: ', mouseID]);
    ID = sprintf('M%s', mouseID);

        % Create a new cell array for storing the renamed variables
    event_var = cell(size(event_var_blank));
    for i = 1:length(event_var_blank)
        event_var{i} = sprintf('%s_%s', event_var_blank{i}, mouseID);
    end

    % Format the variable names for EEG and other signals
    sec_signal_2 = sprintf('sec_signal_cross_%s', mouseID);
    NE_fs = sprintf('RR_fs_%s', mouseID);
    delta465_filt_2 = sprintf('delta465_cross_%s', mouseID);
    RR = sprintf('RR_%s', mouseID);
    RR_time = sprintf('RR_time_%s', mouseID);
    RR_fs = sprintf('RR_fs_%s', mouseID);


        % Access the variables dynamically
    sec_signal_2 = eval(sec_signal_2);
    NE_fs = eval(NE_fs);
    delta465_filt_2 = eval(delta465_filt_2);
    RR = eval(RR);
    RR_time = eval(RR_time);
    RR_fs = eval(RR_fs);

    % Iterate over each sleep stage and its NE trough variables
    for stage_idx = 1:length(event_var)
        event_type_name = event_var{stage_idx}; % Select the current event type
        event_type = eval(event_type_name); %Extract the actual data
        num_events = length(event_type); % Number of events for the current sleep stage
        iteration_counter = iteration_counter + 1;  % Increment the counter each time the loop runs


        % Resetting collectors for each sleep stage
        NE_peak_epoc_collector = [];
        RR_collector = [];

        mid_point = ceil(epoc_start * RR_fs);  % This should be the index of the event time
        total_epoch_length = ceil((epoc_start + epoc_end) * RR_fs);


        % Extract NE and EEG band epochs for the current sleep stage
        for i = 1:length(event_type)
            NEpk_i = event_type(i);
            if NEpk_i > sec_signal_2(end) - epoc_end % Skip if event is too close to end of recording
                disp(['Event ', num2str(i), ' skipped due to proximity to start/end of recording']);
                continue;
            end

            % Extract NE epochs
            NEpk_epoc_i = delta465_filt_2((NEpk_i - epoc_start) * NE_fs : (NEpk_i + epoc_end) * NE_fs);
            NE_peak_epoc_collector = [NE_peak_epoc_collector; NEpk_epoc_i];

            HRB_i = event_type(i);
            if HRB_i < RR_time(1) + epoc_start || HRB_i > RR_time(end) - epoc_end
                disp(['Event ', num2str(i), ' skipped due to proximity to start/end of recording']);
                continue;  % Skip this event
            end

            [~, event_idx] = min(abs(RR_time - HRB_i));  % Find the event index in filtered_RR_time

            epoch_start_idx = max(event_idx - mid_point + 1, 1);
            epoch_end_idx = min(event_idx + (total_epoch_length - mid_point), length(RR));

            if epoch_end_idx - epoch_start_idx + 1 <= total_epoch_length
                RR_collector(1:(epoch_end_idx - epoch_start_idx + 1), i) = RR(epoch_start_idx:epoch_end_idx);
            end
        end      
        % Append the collected data to the corresponding all array
        NE_cross{iteration_counter, 1} = event_var{stage_idx};
        NE_cross{iteration_counter, 2} = NE_peak_epoc_collector;
        RR_cross{iteration_counter, 1} = event_var{stage_idx};
        RR_cross{iteration_counter, 2} = RR_collector';

        NE_length = size(NE_cross{stage_idx, 2}, 2); % number of columns in NE data
        RR_length = size(RR_cross{stage_idx, 2}, 2); % number of columns in RR data
    
        if NE_length ~= RR_length
            % Calculate the difference and determine which one is longer
            diff = abs(NE_length - RR_length);
            if NE_length > RR_length
                % NE is longer, trim it
                NE_cross{stage_idx, 2} = NE_cross{stage_idx, 2}(:, 1:end-diff);
                warning_msg = sprintf('Warning: NE and RR not the same length. Cutting %d datapoints from NE %s.', diff, NE_cross{stage_idx, 1});
            else
                % RR is longer, trim it
                RR_cross{stage_idx, 2} = RR_cross{stage_idx, 2}(:, 1:end-diff);
                warning_msg = sprintf('Warning: NE and RR not the same length. Cutting %d datapoints from RR %s.', diff, RR_cross{stage_idx, 1});
            end
            % Display the warning message
            disp(warning_msg);
        end
    end
end

%% Calculate crosscorelation
SamplingRate = RR_fs_124; % Hz (assuming that it is the same as before)
event_n = length(RR_cross);

cross_corr = cell(event_n, 4); % Fixed name here from cross_cor to cross_corr to match further usage

for stage = 1:event_n
    % period_name = summary_index(stage); % Make sure 'summary_index' is defined and has the same length as 'event_n'
    NE = NE_cross{stage, 2};
    RR = RR_cross{stage, 2};

    correlation_collector = [];

    % Ensure NE and RR have the same number of epochs recorded to prevent indexing errors
    min_epochs = min(size(NE, 1), size(RR, 1));
    for i = 1:min_epochs
        NE_period = NE(i, :);
        RR_period = RR(i, :);

        [cc1, lags] = xcorr(NE_period, RR_period, 'coeff'); % 'coeff' normalizes the correlation
        correlation_collector = [correlation_collector, cc1'];
    end

    % Calculate the mean of all correlations in the correlation collector if non-empty
    if ~isempty(correlation_collector)
        mean_correlations = mean(correlation_collector, 2);
        % Calculate standard error of the mean (SEM)
        N = size(correlation_collector, 2); % Number of observations is the number of columns
        std_dev = std(correlation_collector, 0, 2); % Standard deviation across columns
        SEM = std_dev / sqrt(N); % Standard error of the mean
    else
        mean_correlations = [];
        SEM = [];
    end

    cross_corr{stage, 1} = RR_cross{stage, 1}; %Get the event title
    cross_corr{stage, 2} = mean_correlations;
    cross_corr{stage, 3} = SEM; % Store the standard error in the 3rd column
    cross_corr{stage, 4} = lags; 
end


%% Cross correlation plot
% Define the titles for each subplot
subplot_titles = {'NREM', 'NREM to MA', 'NREM to Wake', 'REM to Wake'};

% Define the overall title and figure setup
figure;
sgtitle('Cross Correlation Between NE and RR'); % Super title for the whole figure
set(gcf,'color','white')

% Initialize variables to store global min and max
% global_min = Inf;
% global_max = -Inf;
% 
% % First pass: Determine the global min and max across all subplots
% for i = 1:4
%     mean_correlations = cross_corr{i, 2};
%     SEM = cross_corr{i, 4};
%     temp_min = min(mean_correlations - SEM);
%     temp_max = max(mean_correlations + SEM);
% 
%     if temp_min < global_min
%         global_min = temp_min;
%     end
%     if temp_max > global_max
%         global_max = temp_max;
%     end
% end

% Loop through each row in cross_corr to create subplots
for i = 1:4
    % Access the data for the current subplot
    mean_correlations = cross_corr{i, 2};
    SEM = cross_corr{i, 3};
    event_name = subplot_titles{i}; % Current event name for titles
    disp(mean(mean_correlations));

    % Create the time vector for the plot, assuming the lags are centered at 0 and evenly spaced
    time_vector = linspace(-30, 60, length(mean_correlations)); % Time vector from -30 to 60 seconds

    % Create subplot
    subplot(2, 2, i);
    hold on;

    % Plot mean with a blue line
    plot(time_vector, -mean_correlations, 'b', 'LineWidth', 1.5);

    % Add shaded error bar (SE)
    shadedErrorBar(time_vector, -mean_correlations, -SEM);

    % Add vertical dashed line at x=0
    %y_limits = ylim([global_min global_max]);  % This should correctly set the y-limits before plotting the line
   % plot([0 0], y_limits, '--', 'Color', [0.8 0.8 0.8]);
    plot([0 0], '--', 'Color', [0.8 0.8 0.8]);

    % Formatting the subplot
    xlabel('Time (s)');
    ylabel('R');
    title(event_name);
    grid on;
    hold off;

    % Set the y-axis limits to the global min and max after all plot commands
   % ylim('limits', [global_min global_max]);

end
%% Main plot w. cross correlation
event_var = {NREMexclMA_periods_pklocs_124, SWS_before_MA_pklocs_124, SWS_before_wake_pklocs_124, REM_before_wake_pklocs_124};
titles = {'NREM', 'NREM to MA Transition', 'NREM to Wake Transition', 'REM to Wake Transition', 'REM to MA Transition'};
main_title = 'Averaged Activity During NE Trough (M124)';
epoc_start = 30;
epoc_end = 60;
delta465_filt_2 = delta465_filt_2_124;
sec_signal_2 = sec_signal_2_124;
NE_fs = signal_fs_124;
RR = RR_124;
RR_time = RR_time_124;
RR_fs = RR_fs_124; 
EEG_bands_fs = EEG_bands_fs_124;
mean_spectrogram = mean_spectrogram_124;
F = F_124;
cross_corr = cross_corr;

    mid_point = ceil(epoc_start * RR_fs);  % This should be the index of the event time
    max_epoch_length = ceil((epoc_start + epoc_end) * RR_fs);
    total_epoch_length = ceil((epoc_start + epoc_end) * RR_fs);
    power_bands = {[0.5, 1], [1, 4], [4, 8], [8, 15], [15, 30]}; % define SO, delta, theta, sigma, and beta, respectively
    
    %Add in the time variable for plotting
    epoc_FPtime_NE = linspace(-epoc_start, epoc_end, ceil((epoc_start + epoc_end) * NE_fs));
    epoc_FPtime_EEG_bands = linspace(-epoc_start, epoc_end, ceil((epoc_start + epoc_end) * EEG_bands_fs));
    epoc_FPtime_RR = linspace(-epoc_start, epoc_end, max_epoch_length);
    
    global_max_RR = -inf;
    global_min_RR = inf;
    global_max_delta_465_2 = -inf;
    global_min_delta_465_2 = inf;
    global_max_EEG_bands = -inf;
    global_min_EEG_bands = inf;
    global_max_corr = -inf;
    golbal_min_corr = inf;

        % Initialize variables to store maximum and minimum values for each type of subplot

    % First pass: Loop to find global min/max
    for stage_idx = 1:length(event_var)
        event_type = event_var{stage_idx}; % Select the current event type
        event_name = titles{stage_idx}; % Current event name for titles
        num_events = length(event_type); % Number of events for the current sleep stage
        
        % Resetting collectors for each sleep stage
        NE_peak_epoc_collector = [];
        RR_collector = [];
        SO_collector = [];
        Delta_collector = [];
        Theta_collector = [];
        Sigma_collector = [];
        Beta_collector = [];

        mean_correlations = cross_corr{stage_idx, 2};
        SEM = cross_corr{stage_idx, 3};
        temp_min = min(min(mean_correlations - SEM));
        temp_max = max(max(mean_correlations + SEM));
    
        if temp_min < golbal_min_corr
            golbal_min_corr = temp_min;
        end
        if temp_max > global_max_corr
            global_max_corr = temp_max;
        end
    
            % Extract power for specified bands
        band_powers = cell(1, length(power_bands));
        for b = 1:length(power_bands)
            freq_range = power_bands{b};
            band_powers{b} = mean(mean_spectrogram(F >= freq_range(1) & F <= freq_range(2), :), 1);
        end
    
        % Extract NE and EEG band epochs for the current sleep stage
        for i = 1:length(event_type)
            NEpk_i = event_type(i);
            % Skip events too close to the start of the recording
            if NEpk_i < epoc_start
                disp(['Event ', num2str(i), ' skipped due to being too close to the start of the recording']);
                continue;  % Skip to the next iteration of the loop
            end
            if NEpk_i > sec_signal_2(end) - epoc_end % Skip if event is too close to end of recording
                continue;
            end
            
            % Extract NE epochs
            NEpk_epoc_i = delta465_filt_2((NEpk_i - epoc_start) * NE_fs : (NEpk_i + epoc_end) * NE_fs);
            NE_peak_epoc_collector = [NE_peak_epoc_collector; NEpk_epoc_i];
    
            HRB_i = event_type(i);
            if HRB_i < RR_time(1) + epoc_start || HRB_i > RR_time(end) - epoc_end
                disp(['Event ', num2str(i), ' skipped due to proximity to start/end of recording']);
                continue;  % Skip this event
            end
    
            [~, event_idx] = min(abs(RR_time - HRB_i));  % Find the event index in filtered_RR_time
    
            epoch_start_idx = max(event_idx - mid_point + 1, 1);
            epoch_end_idx = min(event_idx + (total_epoch_length - mid_point), length(RR));
    
            if epoch_end_idx - epoch_start_idx + 1 <= total_epoch_length
                RR_collector(1:(epoch_end_idx - epoch_start_idx + 1), i) = RR(epoch_start_idx:epoch_end_idx);
            end
    
            
            % Extract epochs for EEG bands
            for b = 1:length(band_powers)
                EEG_band_epoc_i = band_powers{b}(:, (NEpk_i - epoc_start)*EEG_bands_fs:(NEpk_i + epoc_end)*EEG_bands_fs);
            switch b
                case 1
                    SO_collector = [SO_collector; EEG_band_epoc_i];
                case 2
                    Delta_collector = [Delta_collector; EEG_band_epoc_i];
                case 3
                    Theta_collector = [Theta_collector; EEG_band_epoc_i];
                case 4
                    Sigma_collector = [Sigma_collector; EEG_band_epoc_i];
                case 5
                    Beta_collector = [Beta_collector; EEG_band_epoc_i];
                end
            end
        end
        
    
        % Calculate mean of epochs for NE and EEG bands
        mean_NEpk_epocs = nanmean(NE_peak_epoc_collector, 1);
        mean_filtered_RR_epocs = nanmean(RR_collector, 2);
        mean_SO_pk_epocs = nanmean(SO_collector, 1);
        mean_Delta_pk_epocs = nanmean(Delta_collector, 1);
        mean_Theta_pk_epocs = nanmean(Theta_collector, 1);
        mean_Sigma_pk_epocs = nanmean(Sigma_collector, 1);
        mean_Beta_pk_epocs = nanmean(Beta_collector, 1);

        global_max_RR = max(global_max_RR, max(mean_filtered_RR_epocs));
        global_min_RR = min(global_min_RR, min(mean_filtered_RR_epocs));

        global_max_delta_465_2 = max(global_max_delta_465_2, max(mean_NEpk_epocs));
        global_min_delta_465_2 = min(global_min_delta_465_2, min(mean_NEpk_epocs));

        global_max_EEG_bands = max(global_max_EEG_bands, max([mean_SO_pk_epocs, mean_Delta_pk_epocs, mean_Theta_pk_epocs, mean_Sigma_pk_epocs, mean_Beta_pk_epocs]));
        global_min_EEG_bands = min(global_min_EEG_bands, min([mean_SO_pk_epocs, mean_Delta_pk_epocs, mean_Theta_pk_epocs, mean_Sigma_pk_epocs, mean_Beta_pk_epocs]));
    end
        global_max_corr = global_max_corr + 0.05; %add a little bit here to have some air in the plot

    % Initialize the figure
    figure;
    
    % Iterate over each sleep stage and its NE trough variables
    for stage_idx = 1:length(event_var)
        event_type = event_var{stage_idx}; % Select the current event type
        event_name = titles{stage_idx}; % Current event name for titles
        num_events = length(event_type); % Number of events for the current sleep stage
        
        % Resetting collectors for each sleep stage
        NE_peak_epoc_collector = [];
        RR_collector = [];
        SO_collector = [];
        Delta_collector = [];
        Theta_collector = [];
        Sigma_collector = [];
        Beta_collector = [];
    
            % Extract power for specified bands
        band_powers = cell(1, length(power_bands));
        for b = 1:length(power_bands)
            freq_range = power_bands{b};
            band_powers{b} = mean(mean_spectrogram(F >= freq_range(1) & F <= freq_range(2), :), 1);
        end
    
        % Extract NE and EEG band epochs for the current sleep stage
        for i = 1:length(event_type)
            NEpk_i = event_type(i);
            if NEpk_i > sec_signal_2(end) - epoc_end % Skip if event is too close to end of recording
                continue;
            end
            
            % Extract NE epochs
            NEpk_epoc_i = delta465_filt_2((NEpk_i - epoc_start) * NE_fs : (NEpk_i + epoc_end) * NE_fs);
            NE_peak_epoc_collector = [NE_peak_epoc_collector; NEpk_epoc_i];
    
            HRB_i = event_type(i);
            if HRB_i < RR_time(1) + epoc_start || HRB_i > RR_time(end) - epoc_end
                disp(['Event ', num2str(i), ' skipped due to proximity to start/end of recording']);
                continue;  % Skip this event
            end
    
            [~, event_idx] = min(abs(RR_time - HRB_i));  % Find the event index in filtered_RR_time
    
            epoch_start_idx = max(event_idx - mid_point + 1, 1);
            epoch_end_idx = min(event_idx + (total_epoch_length - mid_point), length(RR));
    
            if epoch_end_idx - epoch_start_idx + 1 <= total_epoch_length
                RR_collector(1:(epoch_end_idx - epoch_start_idx + 1), i) = RR(epoch_start_idx:epoch_end_idx);
            end
    
            
            % Extract epochs for EEG bands
            for b = 1:length(band_powers)
                EEG_band_epoc_i = band_powers{b}(:, (NEpk_i - epoc_start)*EEG_bands_fs:(NEpk_i + epoc_end)*EEG_bands_fs);
            switch b
                case 1
                    SO_collector = [SO_collector; EEG_band_epoc_i];
                case 2
                    Delta_collector = [Delta_collector; EEG_band_epoc_i];
                case 3
                    Theta_collector = [Theta_collector; EEG_band_epoc_i];
                case 4
                    Sigma_collector = [Sigma_collector; EEG_band_epoc_i];
                case 5
                    Beta_collector = [Beta_collector; EEG_band_epoc_i];
                end
            end
        end
       
    
        % Calculate mean of epochs for NE and EEG bands
        mean_NEpk_epocs = nanmean(NE_peak_epoc_collector, 1);
        mean_filtered_RR_epocs = nanmean(RR_collector, 2);
        mean_SO_pk_epocs = nanmean(SO_collector, 1);
        mean_Delta_pk_epocs = nanmean(Delta_collector, 1);
        mean_Theta_pk_epocs = nanmean(Theta_collector, 1);
        mean_Sigma_pk_epocs = nanmean(Sigma_collector, 1);
        mean_Beta_pk_epocs = nanmean(Beta_collector, 1);

        % After calculating max and min for each type, set consistent y-axis limits and y-ticks
        y_tick_interval_RR = (global_max_RR - global_min_RR) / 5; % Example for dividing into 5 parts
        ytick_values_RR = global_min_RR:y_tick_interval_RR:global_max_RR;
        
        y_tick_interval_delta_465_2 = (global_max_delta_465_2 - global_min_delta_465_2) / 5;
        ytick_values_delta_465_2 = global_min_delta_465_2:y_tick_interval_delta_465_2:global_max_delta_465_2;
        
        y_tick_interval_EEG_bands = (global_max_EEG_bands - global_min_EEG_bands) / 5;
        ytick_values_EEG_bands = global_min_EEG_bands:y_tick_interval_EEG_bands:global_max_EEG_bands;

        % Plotting NE data
        subplot_position_ne = (stage_idx-1)*4 + 1;
        subplot(4, 4, subplot_position_ne);
        
        % Plot the red line first to ensure it appears behind the data
        hold on;  % Keeps the plot active for subsequent data plotting
        plot([0 0], [global_min_delta_465_2, global_max_delta_465_2], 'Color', [0.5 0.5 0.5], 'LineWidth', 1, 'LineStyle', '--', 'HandleVisibility', 'off'); % Dashed maroon line behind
        
        % Plot the NE data with a specific color (e.g., light blue)
        plot(epoc_FPtime_NE, mean_NEpk_epocs, 'Color', [0 0.4470 0.7410]);  % Light blue
        hold off;  % No more plots will be added
        
        title([event_name ' NE (' num2str(num_events) ' Events)']); % Including number of events in the title
        ylabel('NE Activity');
        xlim([-30, 60]);
        ylim([global_min_delta_465_2, global_max_delta_465_2]);
        yticks(ytick_values_delta_465_2);
        grid on




        subplot_idx_RR = subplot_position_ne + 1;  % Position for RR subplot
        subplot(4, 4, subplot_idx_RR);
        
        % Plot the red line first to ensure it appears behind the data
        hold on;  % Keeps the plot active for subsequent data plotting
        plot([0 0], [global_min_RR, global_max_RR], 'Color', [0.5 0.5 0.5], 'LineWidth', 1, 'LineStyle', '--');  % Dashed maroon line
        
        % Now plot the RR interval data, ensuring it's on top of the red line
        plot(epoc_FPtime_RR, mean_filtered_RR_epocs, 'Color', [0.8500 0.3250 0.0980]);
        hold off;  % No more plots will be added
        
        title([event_name ' RR interval (' num2str(length(event_type)) ' Events)']);  % Correcting the number of events
        ylabel('RR interval');
        xlim([-30, 60]);
        ylim([global_min_RR, global_max_RR]);
        yticks(ytick_values_RR);  % Apply custom y-tick values based on the global min/max for RR intervals
        grid on

            % Access the data for the current subplot
    mean_correlations = cross_corr{stage_idx, 2};
    SEM = cross_corr{stage_idx, 3};
    % Create the time vector for the plot, assuming the lags are centered at 0 and evenly spaced
    time_vector = linspace(-30, 60, length(mean_correlations)); % Time vector from -30 to 60 seconds

    subplot_idx_xcorr = subplot_position_ne + 2;  % Position for RR subplot

    % Create subplot
    subplot(4, 4, subplot_idx_xcorr);
    hold on;
    plot([0 0], [golbal_min_corr, global_max_corr], 'Color', [0.5 0.5 0.5], 'LineWidth', 1, 'LineStyle', '--', 'HandleVisibility', 'off'); % Dashed gray line behind

    % Plot mean with a blue line
    plot(time_vector, -mean_correlations, 'b', 'LineWidth', 1.5);

    % Add shaded error bar (SE)
    shadedErrorBar(time_vector, -mean_correlations, -SEM);

    % Formatting the subplot
    ylabel('Correlation strenght (R)');
    xlim([-30, 60]);
    ylim([golbal_min_corr, global_max_corr]);
    title([event_name ' NE-RR Cross Correlation (' num2str(length(event_type)) ' Events)']);
    grid on;
    hold off;

        % Plotting EEG bands data
        subplot_position_eeg = subplot_position_ne + 3;
        subplot(4, 4, subplot_position_eeg);
        
        % Plot the red line first to ensure it appears behind the data
        hold on;  % Keeps the plot active for subsequent data plotting
        plot([0 0], [global_min_EEG_bands, global_max_EEG_bands], 'Color', [0.5 0.5 0.5], 'LineWidth', 1, 'LineStyle', '--', 'HandleVisibility', 'off'); % Dashed maroon line
        
        % Now plot the EEG band data with handles for the legend
        hSO = plot(epoc_FPtime_EEG_bands, mean_SO_pk_epocs, 'DisplayName', 'SO');
        hDelta = plot(epoc_FPtime_EEG_bands, mean_Delta_pk_epocs, 'DisplayName', 'Delta');
        hTheta = plot(epoc_FPtime_EEG_bands, mean_Theta_pk_epocs, 'DisplayName', 'Theta');
        hSigma = plot(epoc_FPtime_EEG_bands, mean_Sigma_pk_epocs, 'DisplayName', 'Sigma');
        hBeta = plot(epoc_FPtime_EEG_bands, mean_Beta_pk_epocs, 'DisplayName', 'Beta');
        hold off;  % No more plots will be added
        
        % Use the handles to specify which plots to include in the legend
        legend([hSO, hDelta, hTheta, hSigma, hBeta], {'SO', 'Delta', 'Theta', 'Sigma', 'Beta'}, 'Location', 'southeast');
        
        title([event_name ' EEG Bands (' num2str(length(event_type)) ' Events)']);
        ylabel('Power');
        xlim([-30, 60]);
        ylim([global_min_EEG_bands, global_max_EEG_bands]);
        yticks(ytick_values_EEG_bands);
        grid on




        set(gcf,'color','white')
        
        % % Adjusting the subplot index for column placement
        % if stage_idx == 2 % After plotting the second sleep stage, switch to second column
        %     subplot_base = 4; % Adjusting base for second column
        % else
        %     subplot_base = 0; % Keep base at 0 for first column
        % end
    end
    
    % Adjust overall plot settings
    sgtitle(main_title);
