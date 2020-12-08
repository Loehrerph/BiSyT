%%  extract updated coupling values (connectivity strengths)
%   positive numbers indicate an increased connectivity strength
%   negative numbers incdicate a decreased connectivity strength
%      
%   Forward connections are stored in RCM_A{i,1}.Ep.B.{1,1}, where i indicates the i-ths subject 
%   Backward connections are stored in RCM_A{i,1}.Ep.B.{1,2}
%   Lateral connections are stored in RCM_A{i,1}.Ep.B.{1,3}
%
%   matrix specification: the coupling matrix is arranged in the following order: 
%   left PFC, right PFC, left lPM, right lPM, SMA
% 

close all 
clear all 

load('PEB_B.mat');

for i = 1:39
updated_con_strength(i,1) = RCM_B{i,1}.Ep.B;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Extract updated coupling parameters for connections > .95 posterior probability
%   
%
%   BMS of three Models differing in their hierarchy between lPM and SMA favoured     
%   a model with backward connections from lPM to SMA and forward connections from 
%   SMA to lPM. Therefore this forward connection and stored in A(1,1)
%
%   for the B-matrix, all coupling values are stored in B(1,1), hence no
%   specification as to B(2,1) or B(3,1) (as it is the case with the
%   A-matrix) are needed

for l = 1:39
    
    lPFC_SMA (l,1)= updated_con_strength{l,1}(5,1); %Group
    rlPM_SMA (l,1)= updated_con_strength{l,1}(5,4);
    llPM_lPFC (l,1)= updated_con_strength{l,1}(1,3);
    llPM_llPM (l,1)= updated_con_strength{l,1}(3,3);
    end


excelsheets = [lPFC_SMA, rlPM_SMA, llPM_lPFC, llPM_llPM];    
xlrange1='A2';

excelsheet_names = {'Left PFC to SMA', 'right lPM to SMA', 'left lPM to left PFC', 'left lPM to left lPM'}; 
xlrange2='A1';


for i = 1:size(excelsheets,2)
xlswrite('updated_coupling_parameters', excelsheets(:,i), i, xlrange1); 
xlswrite('updated_coupling_parameters', excelsheet_names(1,i), i, xlrange2); 
end


%% load performance parameters
[performance_parameters, Labels] = xlsread('Design_Matrix.xlsx', 'Mittelwert_B_matrix_TL');

% get values for top and low performer
top_index = performance_parameters(:,3)<0;
top_parameters(:,1) = zeros(10,1);
top_parameters(:,2) = performance_parameters(top_index,4);
top_parameters(:,3) = performance_parameters(top_index,5);

low_index = performance_parameters(:,3)>0;
low_parameters(:,1) = zeros(10,1);
low_parameters(:,2) = performance_parameters(low_index,4);
low_parameters(:,3) = performance_parameters(low_index,5);

young_index = performance_parameters(:,3)==0;
young_parameters(:,1) = zeros(19,1);
young_parameters(:,2) = performance_parameters(young_index,4);
young_parameters(:,3) = performance_parameters(young_index,5);

save('second_level.mat');

%%  calculate correlations for connections involved in Group and Top Low discrimination 
%   and correct the false discovery rate using the Benjamini Hochberg Method

for icor = 1:size(excelsheets,2)
    [RHO_time_sp(icor,1), PVAL_time_sp(icor,1)] = corr(performance_parameters(:,4),excelsheets(1:39,icor),'Type','Spearman');
    [RHO_error_sp(icor,1), PVAL_error_sp(icor,1)] = corr(performance_parameters(:,5),excelsheets(1:39,icor),'Type','Spearman');
    end

PVAL_Total_sp = vertcat(PVAL_time_sp, PVAL_error_sp);
[h_sp, crit_p_sp, adj_ci_cvrg_sp, adj_p_sp]=fdr_bh(PVAL_Total_sp);

RHO_Total_sp = vertcat(RHO_time_sp, RHO_error_sp);
 

xlswrite('pval_rho_time_error_sp_corr_all_subjects_together', adj_p_sp, 1);
xlswrite('pval_rho_time_error_sp_corr_all_subjects_together', RHO_Total_sp, 2);

save ('workspace__sp_corr_all_subjects_together.mat');
