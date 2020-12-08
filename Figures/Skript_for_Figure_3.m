%%  extract updated coupling values (connectivity strengths)
%   positive numbers indicate an increased connectivity strength
%   negative numbers incdicate a decreased connectivity strength
%      
%   Forward connections are stored in RCM_A{i,1}.Ep.A.{1,1}, where i indicates the i-ths subject 
%   Backward connections are stored in RCM_A{i,1}.Ep.A.{1,2}
%   Lateral connections are stored in RCM_A{i,1}.Ep.A.{1,3}
%
%   matrix specification: the coupling matrix is arranged in the following order: left PFC, right PFC, left lPM, right lPM, SMA
%   Contrast

close all 
clear all 
load('workspace_pvals.mat')
 
%correct typos in excelsheet
excelsheet_names{1,2} = 'Right lPM to right PFC';  
excelsheet_names{1,8} = 'SMA to left PFC';

% set colour
colour(1,1:3) = [91/255 155/255 213/255];
colour(2,1:3) = [237/255 125/255 49/255];
colour_top(1,1:3) = [91/255 155/255 213/255];
colour_top(2,1:3) = [0/255 176/255 80/255];
colour_top(3,1:3) = [255/255 0/255 0/255];

% cd to Figure Folder Philipps PC
mkdir('Coupling')
cd('Coupling');

%set index
ind = [1, 2, 8, 9];

for i = 1:2 
    figind = ind (1,i);
figure
fig = gcf;
res = 600;
sizef = [945 1063]; 
set(gcf, 'Units', 'inches', 'InnerPosition', [0 0 sizef/res]);

figurename = excelsheet_names{1,figind};

%Boxplot Group
group = {'YA', 'OA'};
box_data(1:19,1) = excelsheets(1:19,figind);
box_data(1:20,2) = excelsheets(20:39,figind);

boxplot(box_data, group, 'Colors', colour);

%Specify axis
title({'A-Matrix Connection:', excelsheet_names{1,figind}},'FontWeight', 'normal','FontSize', 7, 'FontName', 'Arial');
axis([0 size(group,2)+1 -0.6 0.4]); %set y min to -1.4 and max to 0 for SMA coupling otherwise use -0.6 and 0.4
xticks(1:1:size(group,2));
yticks(-0.6:0.2:0.4); %set y min to -1.4 and max to 0 for SMA coupling otherwise use -0.6 and 0.4
set(gca, 'Units', 'normalized', 'FontUnits', 'points',...
    'FontWeight', 'normal', 'FontSize', 6, 'FontName', 'Arial',...
    'XTickLabel', group, 'FontName', 'Arial', 'FontSize', 6)
ylabel('Arbitrary Units', 'FontSize', 6)
print(strcat([excelsheet_names{1,figind}, '_Boxplot']), '-dtiff', ['-r' num2str(res)]);

clear box_data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Scatterplot Group * Time
figure
set(gcf, 'Units', 'inches', 'InnerPosition', [0 0 sizef/res]);
hold on
%Plot
scatter(performance_parameters(1:19,4), excelsheets(1:19,figind), 5, [91/255 155/255 213/255], 'filled')
scatter(performance_parameters(20:39,4), excelsheets(20:39,figind), 5, [237/255 125/255 49/255], 'filled')
yp_young = polyfit(performance_parameters(1:19,4), excelsheets(1:19,figind),1); 
yp_old = polyfit(performance_parameters(20:39,4), excelsheets(20:39,figind),1);
plot(performance_parameters(1:19,4),polyval(yp_young,performance_parameters(1:19,4)), 'Color', [91/255 155/255 213/255]);
plot(performance_parameters(20:39,4),polyval(yp_old,performance_parameters(20:39,4)), 'Color', [237/255 125/255 49/255]);
%Specify axis
axis([0 5 -0.6 0.4]); %set y min to -1.4 and max to 0 for SMA coupling otherwise use -0.6 and 0.4
xticks(1:1:5);
yticks(-0.6:0.2:0.4); %set y min to -1.4 and max to 0 for SMA coupling otherwise use -0.6 and 0.4
set(gca, 'Units', 'normalized', 'FontUnits', 'points',...
    'FontWeight', 'normal', 'FontSize', 6, 'FontName', 'Arial')
ylabel('Arbitrary Units', 'FontSize', 6)
drawaxis(gca, 'x', 0, 'movelabel', 1);
title({excelsheet_names{1,figind}, ' correlation with Time'}, 'FontWeight', 'normal','FontSize', 7, 'FontName', 'Arial');

hold off 
print(strcat([excelsheet_names{1,figind}, '_Scatter_Time']), '-dtiff', ['-r' num2str(res)]);

clear yp_young
clear yp_old
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Scatterplot Group * Error
figure
set(gcf, 'Units', 'inches', 'InnerPosition', [0 0 sizef/res]);
hold on
%Plot
scatter(performance_parameters(1:19,5), excelsheets(1:19,figind), 5, [91/255 155/255 213/255], 'filled')
scatter(performance_parameters(20:39,5), excelsheets(20:39,figind), 5, [237/255 125/255 49/255], 'filled')
yp_young = polyfit(performance_parameters(1:19,5), excelsheets(1:19,figind),1); 
yp_old = polyfit(performance_parameters(20:39,5), excelsheets(20:39,figind),1);
plot(performance_parameters(1:19,5),polyval(yp_young,performance_parameters(1:19,5)), 'Color', [91/255 155/255 213/255]);
plot(performance_parameters(20:39,5),polyval(yp_old,performance_parameters(20:39,5)), 'Color', [237/255 125/255 49/255]);
%Specify axis
axis([0 70 -0.6 0.4]); %set y min to -1.4 and max to 0 for SMA coupling otherwise use -0.6 and 0.4
xticks(10:10:70);
yticks(-0.6:0.2:0.4); %set y min to -1.4 and max to 0 for SMA coupling otherwise use -0.6 and 0.4
set(gca, 'Units', 'normalized', 'FontUnits', 'points',...
    'FontWeight', 'normal', 'FontSize', 6, 'FontName', 'Arial')
ylabel('Arbitrary Units', 'FontSize', 6)
drawaxis(gca, 'x', 0, 'movelabel', 1);
title({excelsheet_names{1,figind}, ' correlation with Error'}, 'FontWeight', 'normal','FontSize', 7, 'FontName', 'Arial');

%Legend (turned off during loop due to overwriting of figure)
% lgd = legend ('YA', 'OA');
% lgd.FontSize = 6; 
% lgd.FontName = 'Arial';

hold off 
print(strcat([excelsheet_names{1,figind}, '_Scatter_Error']), '-dtiff', ['-r' num2str(res)]);

clear yp_young
clear yp_old

end

close all


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%create Plot for Top and Low-Performers 




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





for i = 3:4 
    figind = ind (1,i);
figure
fig = gcf;
res = 600;
sizef = [945 1063]; 
set(gcf, 'Units', 'inches', 'InnerPosition', [0 0 sizef/res]);

figurename = excelsheet_names{1,figind};

%get values for specific top and low value
top_parameters(:,1) = excelsheets(top_index,figind);
low_parameters(:,1) = excelsheets(low_index, figind);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Scatterplot Top_Low * Time
figure
set(gcf, 'Units', 'inches', 'InnerPosition', [0 0 sizef/res]);
hold on
%Plot
scatter(performance_parameters(1:19,4), excelsheets(1:19,figind), 5, [91/255 155/255 213/255], 'filled')
scatter(top_parameters(1:10,2), top_parameters(1:10,1), 5, colour_top(2,1:3), 'filled')
scatter(low_parameters(1:10,2), low_parameters(1:10,1), 5, colour_top(3,1:3), 'filled')
yp_young = polyfit(performance_parameters(1:19,4), excelsheets(1:19,figind),1); 
yp_old = polyfit(top_parameters(1:10,2), top_parameters(1:10,1),1);
yp_old_low = polyfit(low_parameters(1:10,2), low_parameters(1:10,1),1);
plot(performance_parameters(1:19,4),polyval(yp_young,performance_parameters(1:19,4)), 'Color', [91/255 155/255 213/255]);
plot(top_parameters(1:10,2),polyval(yp_old, top_parameters(1:10,2)), 'Color', colour_top(2,1:3));
plot(low_parameters(1:10,2),polyval(yp_old_low, low_parameters(1:10,2)), 'Color', colour_top(3,1:3));
%Specify axis
axis([0 5 -1.4 0.2]); %set y min to -1.4 for SMA coupling otherwise use 0.6
xticks(1:1:5);
yticks(-1.4:0.2:0.2); %set y min to -1.4 for SMA coupling otherwise use 0.6
set(gca, 'Units', 'normalized', 'FontUnits', 'points',...
    'FontWeight', 'normal', 'FontSize', 6, 'FontName', 'Arial')
ylabel('Arbitrary Units', 'FontSize', 6)
drawaxis(gca, 'x', 0, 'movelabel', 1);
title({excelsheet_names{1,figind}, ' correlation with Time'}, 'FontWeight', 'normal','FontSize', 7, 'FontName', 'Arial');

%legend ('young', 'old top', 'old low');
hold off
print(strcat([excelsheet_names{1,figind}, '_Scatter_Time']), '-dtiff', ['-r' num2str(res)]);

clear yp_young
clear yp_old
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Scatterplot Top_Low * Error
figure
set(gcf, 'Units', 'inches', 'InnerPosition', [0 0 sizef/res]);
hold on
scatter(performance_parameters(1:19,5), excelsheets(1:19,figind), 5, [91/255 155/255 213/255], 'filled')
scatter(top_parameters(1:10,3), top_parameters(1:10,1), 5, colour_top(2,1:3), 'filled')
scatter(low_parameters(1:10,3), low_parameters(1:10,1), 5, colour_top(3,1:3), 'filled')
yp_young = polyfit(performance_parameters(1:19,5), excelsheets(1:19,figind),1); 
yp_old = polyfit(top_parameters(1:10,3), top_parameters(1:10,1),1);
yp_old_low = polyfit(low_parameters(1:10,3), low_parameters(1:10,1),1);
plot(performance_parameters(1:19,5),polyval(yp_young,performance_parameters(1:19,5)), 'Color', [91/255 155/255 213/255]);
plot(top_parameters(1:10,3),polyval(yp_old, top_parameters(1:10,3)), 'Color', colour_top(2,1:3));
plot(low_parameters(1:10,3),polyval(yp_old_low, low_parameters(1:10,3)), 'Color', colour_top(3,1:3));
axis([0 70 -1.4 0.2]); %set y min to -1.4 for SMA coupling otherwise use 0.6
xticks(10:10:70);
yticks(-1.4:0.2:0.2); %set y min to -1.4 for SMA coupling otherwise use 0.6
set(gca, 'Units', 'normalized', 'FontUnits', 'points',...
    'FontWeight', 'normal', 'FontSize', 6, 'FontName', 'Arial')
ylabel('Arbitrary Units', 'FontSize', 6)
drawaxis(gca, 'x', 0, 'movelabel', 1);
title({excelsheet_names{1,figind}, ' correlation with Error'}, 'FontWeight', 'normal','FontSize', 7, 'FontName', 'Arial');
legend ('YA', 'OA Top', 'OA Low');

hold off

print(strcat([excelsheet_names{1,figind}, '_Scatter_Error_legend']), '-dtiff', ['-r' num2str(res)]);

clear yp_young
clear yp_old

end
close all

save('workspace_Figure_3_Top_Low');