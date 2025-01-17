%-----------------------------------------------------------------------
% Job saved on 26-Jun-2020 18:42:54 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7487)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.spm.dcm.estimate.dcms.gcmmat = {'..\Contrast\GCM_DCM_1_LHand.mat'}; %SMA > lPM
matlabbatch{1}.spm.dcm.estimate.output.single.dir = {'..\Contrast'};
matlabbatch{1}.spm.dcm.estimate.output.single.name = 'Calculated';
matlabbatch{1}.spm.dcm.estimate.est_type = 2;
matlabbatch{1}.spm.dcm.estimate.fmri.analysis = 'time';
matlabbatch{2}.spm.dcm.estimate.dcms.gcmmat = {'..\2_LPM_SMA\Contrast\GCM_DCM_1_LHand.mat'}; %SMA < lPM
matlabbatch{2}.spm.dcm.estimate.output.single.dir = {'..\2_LPM_SMA\Contrast'};
matlabbatch{2}.spm.dcm.estimate.output.single.name = 'Calculated';
matlabbatch{2}.spm.dcm.estimate.est_type = 2;
matlabbatch{2}.spm.dcm.estimate.fmri.analysis = 'time';
matlabbatch{3}.spm.dcm.estimate.dcms.gcmmat = {'..\3_SMA_equal_lPM\Contrast\GCM_DCM_1_LHand.mat'}; %SMA = lPM
matlabbatch{3}.spm.dcm.estimate.output.single.dir = {'..\3_SMA_equal_lPM\Contrast'};
matlabbatch{3}.spm.dcm.estimate.output.single.name = 'Calculated';
matlabbatch{3}.spm.dcm.estimate.est_type = 2;
matlabbatch{3}.spm.dcm.estimate.fmri.analysis = 'time';
