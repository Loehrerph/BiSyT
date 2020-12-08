%%  extract updated coupling values (connectivity strengths)
%   positive numbers indicate an increased connectivity strength
%   negative numbers incdicate a decreased connectivity strength
%      
%   Forward connections are stored in RCM_A{i,1}.Ep.A.{1,1}, where i indicates the i-ths subject 
%   Backward connections are stored in RCM_A{i,1}.Ep.A.{1,2}
%   Lateral connections are stored in RCM_A{i,1}.Ep.A.{1,3}
%
%   matrix specification: the coupling matrix is arranged in the following 
%   order: left PFC, right PFC, left lPM, right lPM, SMA
%   

close all 
clear all 

load('PEB_A.mat');

for i = 1:39
updated_con_strength(i,1:3) = RCM_A{i,1}.Ep.A;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Extract updated coupling parameters for connections > .95 posterior probability
%   
%
%   BMS of three Models differing in their hierarchy between lPM and SMA favoured     
%   a model with backward connections from lPM to SMA and forward connections from 
%   SMA to lPM. Therefore this forward connection and stored in A(1,1)

for l = 1:39
    llPM_lPFC (l,1)= updated_con_strength{l,1}(1,3); %Commonalities
    rlPM_rPFC (l,1)= updated_con_strength{l,1}(2,4); 
    
    lPFC_rlPM (l,1)= updated_con_strength{l,2}(4,1); %Group
    rPFC_llPM (l,1)= updated_con_strength{l,2}(3,2);
    rPFC_rlPM (l,1)= updated_con_strength{l,2}(4,2);
    rPFC_SMA (l,1)= updated_con_strength{l,2}(5,2);
        
    llPM_rPFC (l,1)= updated_con_strength{l,1}(2,3); %Top_Low
    SMA_lPFC (l,1)= updated_con_strength{l,1}(1,5);
    SMA_rPFC (l,1)= updated_con_strength{l,1}(2,5);
    SMA_llPM (l,1)= updated_con_strength{l,1}(3,5);
    SMA_rlPM (l,1)= updated_con_strength{l,1}(4,5);
    
    lPFC_llPM (l,1)= updated_con_strength{l,2}(3,1); %Time
    llPM_SMA (l,1)= updated_con_strength{l,2}(5,3);
    
    
    rlPM_SMA (l,1)= updated_con_strength{l,2}(5,4); %Error
    
   end


excelsheets = [llPM_lPFC, rlPM_rPFC, lPFC_rlPM, rPFC_llPM, rPFC_rlPM, rPFC_SMA, llPM_rPFC, ...
   SMA_lPFC, SMA_rPFC, SMA_llPM, SMA_rlPM,  lPFC_llPM, llPM_SMA, rlPM_SMA ]; 

xlrange1='A2';


excelsheet_names = {'Left lPM to left PFC', 'right lPM to right PFC',  'Left PFC to right lPM', 'right PFC to Left lPM', 'right PFC to right lPM', ...
    'right PFC to SMA', 'Left lPM to right PFC', 'SMA to Left PFC', 'SMA to right PFC', ...
    'SMA to Left lPM', 'SMA to right lPM',  'Left PFC to Left lPM', 'Left lPM to SMA', 'right lPM to SMA'};

xlrange2='A1';


for i = 1:size(excelsheets,2)
xlswrite('updated_coupling_parameters_all', excelsheets(:,i), i, xlrange1); 
xlswrite('updated_coupling_parameters_all', excelsheet_names(1,i), i, xlrange2); 
end

%% load performance parameters
[performance_parameters, Labels] = xlsread('Design_Matrix.xlsx', 'Mittelwert_A_Matrix_TL');

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

old_index = performance_parameters(:,2)==1;
old_parameters(:,1) = zeros(20,1);
old_parameters(:,2) = performance_parameters(old_index,4);
old_parameters(:,3) = performance_parameters(old_index,5);

save('second_level.mat');

%%  calculate correlations for connections involved in Group and Top Low discrimination 
%   and correct the false discovery rate using the Benjamini Hochberg Method

correlation_group = [lPFC_rlPM, rPFC_llPM, rPFC_rlPM, rPFC_SMA, llPM_lPFC, rlPM_rPFC, SMA_lPFC, SMA_rPFC];

correlation_TL = [SMA_lPFC, SMA_rPFC, SMA_llPM, SMA_rlPM, llPM_rPFC, rPFC_rlPM];


for icor = 1:size(correlation_group,2)
    [RHO_time_corr_group(icor,1),PVAL_time_corr_group(icor,1)] = corr(young_parameters(:,2),correlation_group(1:19,icor),'Type','Spearman');
    [RHO_time_corr_group(icor+size(correlation_group,2),1),PVAL_time_corr_group(icor+size(correlation_group,2),1)] = corr(old_parameters(1:20,2),correlation_group(old_index,icor),'Type','Spearman');
    
    [RHO_error_corr_group(icor,1),PVAL_error_corr_group(icor,1)] = corr(young_parameters(:,3),correlation_group(1:19,icor),'Type','Spearman');
    [RHO_error_corr_group(icor+size(correlation_group,2),1),PVAL_error_corr_group(icor+size(correlation_group,2),1)] = corr(old_parameters(1:20,3),correlation_group(old_index,icor),'Type','Spearman');
end


for icor = 1:size(correlation_TL,2)
    [RHO_time_corr_TL(icor,1),PVAL_time_corr_TL(icor,1)] = corr(young_parameters(:,2),correlation_TL(1:19,icor),'Type','Spearman');
    [RHO_time_corr_TL(icor+size(correlation_TL,2),1),PVAL_time_corr_TL(icor+size(correlation_TL,2),1)] = corr(top_parameters(1:10,2),correlation_TL(top_index,icor),'Type','Spearman');
    [RHO_time_corr_TL(icor+size(correlation_TL,2)*2,1),PVAL_time_corr_TL(icor+size(correlation_TL,2)*2,1)] = corr(low_parameters(1:10,2),correlation_TL(low_index,icor),'Type','Spearman');
    
    [RHO_error_corr_TL(icor,1),PVAL_error_corr_TL(icor,1)] = corr(young_parameters(:,3),correlation_TL(1:19,icor),'Type','Spearman');
    [RHO_error_corr_TL(icor+size(correlation_TL,2),1),PVAL_error_corr_TL(icor+size(correlation_TL,2),1)] = corr(top_parameters(1:10,3),correlation_TL(top_index,icor),'Type','Spearman');
    [RHO_error_corr_TL(icor+size(correlation_TL,2)*2,1),PVAL_error_corr_TL(icor+size(correlation_TL,2)*2,1)] = corr(low_parameters(1:10,3),correlation_TL(low_index,icor),'Type','Spearman');
end


PVAL_Total_corr_group = vertcat(PVAL_time_corr_group, PVAL_error_corr_group, PVAL_time_corr_TL, PVAL_error_corr_TL);

[h_sp, crit_p_sp, adj_ci_cvrg_sp, adj_p_sp]=fdr_bh(PVAL_Total_corr_group);

xlswrite('pval_rho_time_error_corr_group_final', adj_p_sp, 1);
xlswrite('pval_rho_time_error_corr_group_final', RHO_time_corr_group, 2);
xlswrite('pval_rho_time_error_corr_group_final', RHO_error_corr_group, 3);
xlswrite('pval_rho_time_error_corr_group_final', RHO_time_corr_TL, 4);
xlswrite('pval_rho_time_error_corr_group_final', RHO_error_corr_TL, 5);

save ('workspace_pvals_group.mat');
