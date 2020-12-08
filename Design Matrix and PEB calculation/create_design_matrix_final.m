%% import excel spreadsheet to create design matrix and mean centre it 

%% 1. A-Matrix
%% import excel
[design_matrix, Labels] = xlsread('Design_Matrix.xlsx', 'Mittelwert_A_matrix_TL'); 

%% mean centre design_matrix
design_matrix(:,2:end) = design_matrix(:,2:end) - mean(design_matrix(:,2:end));

%% save as design_matrix

save ('design_matrix_A.mat', 'design_matrix', 'Labels'); 

%% create design_matrix with variables in regressor position (position No. 2) other than 'Group' and save it

for i = 1:3
design_matrix_2 (:,1) = design_matrix (:,1);
design_matrix_2 (:,2:4) = design_matrix (:,3:5);
design_matrix_2 (:,5) = design_matrix (:,2);

design_matrix = design_matrix_2;

Labels_2 (:,1) = Labels (:,1);
Labels_2 (:,2:4) = Labels (:,3:5);
Labels_2 (:,5) = Labels (:,2);

Labels = Labels_2;
name_design_matrix = ['design_matrix_A_' num2str(i) '.mat'];
save (name_design_matrix, 'design_matrix', 'Labels');
end

clear all 

%% 2. B-Matrix
%% import excel
[design_matrix, Labels] = xlsread('Design_Matrix.xlsx', 'Mittelwert_B_matrix_TL'); 

%% mean centre design_matrix
design_matrix(:,2:end) = design_matrix(:,2:end) - mean(design_matrix(:,2:end));

%% save as design_matrix

save ('design_matrix_B.mat', 'design_matrix', 'Labels'); 

%% create design_matrix with variables in regressor position (position No. 2) other than 'Group' and save it

for i = 1:3
design_matrix_2 (:,1) = design_matrix (:,1);
design_matrix_2 (:,2:4) = design_matrix (:,3:5);
design_matrix_2 (:,5) = design_matrix (:,2);

design_matrix = design_matrix_2;

Labels_2 (:,1) = Labels (:,1);
Labels_2 (:,2:4) = Labels (:,3:5);
Labels_2 (:,5) = Labels (:,2);

Labels = Labels_2;
name_design_matrix = ['design_matrix_A_' num2str(i) '.mat'];
save (name_design_matrix, 'design_matrix', 'Labels');
end

clear all  