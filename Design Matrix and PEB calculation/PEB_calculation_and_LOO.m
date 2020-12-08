clear all
close all 

%% calculate PEB Models 

%% 1. change directory to the path containting the respective GCM

cd('..\');

%% 2. Load design matrix and GCM
load('design_matrix_A.mat')

% Load GCM
GCM = load('GCM_Calculated.mat');  %('GCM_DCM_Full_calculated.mat');
GCM=GCM.GCM;

% PEB settings; found in function spm_dcm_peb
M = struct ();
M.Q = 'all';
M.X = design_matrix;
M.Xnames = Labels;
M.maxit = 64; 

%% 3.A PEB model estimation:

[PEB_A, RCM_A] = spm_dcm_peb (GCM, M, {'A'});
save ('PEB_A.mat', 'PEB_A', 'RCM_A');

%% 3.B PEB model estimation: B-Matrix

[PEB_B, RCM_B] = spm_dcm_peb (GCM, M, {'B'});
save ('PEB_B.mat', 'PEB_B', 'RCM_B');

%% 4. Automatic PEB search: 

BMA_automatic = spm_dcm_peb_bmc (PEB_A);
savefig('BMR - all_automatic_A')
savefig('BMC_automatic_A')

spm_dcm_peb_review (BMA_automatic, GCM); %BMA_automatic
savefig('PEB-Review_A_parameters')
save ('BMA_automatic_A_Matrix.mat');
effect_sizes(xPEB)

% 4.1 Automatic PEB search B-Matrix

BMA_automatic = spm_dcm_peb_bmc (PEB_B);
savefig('BMR - all_automatic_B')
savefig('BMC_automatic_B')

spm_dcm_peb_review (BMA_automatic, GCM); %BMA_automatic
savefig('PEB-Review_B_parameters')
save ('BMA_automatic_B_Matrix.mat');
effect_sizes(xPEB)

%%  Leave one out cross validation
%   A{1,2}(4,1) means backward connection (=A(1,2)) from lPFC (1) to rlPM(4)

[qE, qC, Q] = spm_dcm_loo(GCM ,M ,{'A{1,2}(4,1)', 'A{1,2}(3,2)'}); 
save ('LOO_interhemispheric_A_Group.mat', 'qE', 'qC', 'Q', 'design_matrix', 'Labels');
savefig('LOO_interhemispheric_A_Group');
