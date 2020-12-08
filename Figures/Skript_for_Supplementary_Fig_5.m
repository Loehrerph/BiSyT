% Skript for supplementary figure 5
% Values for exceedance probabilities were extracted from the following
% file: ..\Vergleich_variational_free_energy_sma_lpm.xlsx


clear all
close all


val = [0.038373, 0.703893, 0.257734];
names_val = {'SMA > lPM', 'lPM > SMA', 'SMA = lPM'};

figure
sizef = [1417 1890];
res = 600;
set(gcf, 'Units', 'inches', 'InnerPosition', [0 0 sizef/res]);
bar(val, 'BarWidth', 0.5);

title('Bayesian Model Selection: RFX','FontWeight', 'normal','FontSize', 10, 'FontName', 'Arial');
axis([0 size(val,2)+1 0 0.8]);
xticks(1:1:size(val,2));
yticks(0:0.1:0.7);
set(gca, 'Units', 'normalized', 'FontUnits', 'points',...
    'FontWeight', 'normal', 'FontSize', 8, 'FontName', 'Arial',...
    'XTickLabel', names_val, 'FontName', 'Arial', 'FontSize', 8)
xtickangle(52.3)
ylabel('Exceedance Probability', 'FontSize', 8)
print('BMS_contrast_large', '-dtiff', ['-r' num2str(res)]);

save('workspace_supp_Fig_1');