clear all
close all

[data, labels] = xlsread('Mean_Values_Final.xlsx');
labels(:,1) = [];
names = strrep(labels(1,2:end), '_', ' '); %replace underscore by space to avoid subscripts in figures

inp=data(:,2:end);
outp=data(:,1); %response variable 
cfg=[];


for MI_pred=1:size(inp,2)
    temp=MIbin(outp,inp(:,MI_pred),cfg); %MI between each feature and response=relevance 
    rele(MI_pred)=temp.MI; %%relevance
    temp_red=[];
    for MI_feat=1:size(inp,2)
        temp=MIbin(inp(:,MI_feat),inp(:,MI_pred),cfg);
        temp_red(MI_feat)=temp.MI; %redundancy= mean mutual information between feature and all other featurees
    end
    red(MI_pred)=mean(temp_red);
    MIQ(MI_pred)=rele(MI_pred)./red(MI_pred); %Mutual information quotient
end

[value_MIQ,ind_MIQ]=sort(MIQ,'descend');
[value_rele,ind_rele]=sort(rele,'descend');
[value_red,ind_red]=sort(red,'descend');

 names_MIQ=names(ind_MIQ);
 names_rele=names(ind_rele);
 names_red=names(ind_red);
 
%% create figure for MIQ   
figure
sizef = [945 1260]; %1063
res = 600;
%set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
set(gcf, 'Units', 'inches', 'InnerPosition', [0 0 sizef/res]);
bar(value_MIQ, 'BarWidth', 0.5);

title('Mutual Information Quotient','FontWeight', 'normal','FontSize', 6, 'FontName', 'Arial');
axis([0 size(inp,2)+1 0 1.7]);
xticks(1:1:size(inp,2));
yticks(0:0.2:1.6);
set(gca, 'Units', 'normalized', 'FontUnits', 'points',...
    'FontWeight', 'normal', 'FontSize', 6, 'FontName', 'Arial',...
    'XTickLabel', names_MIQ, 'FontName', 'Arial', 'FontSize', 6)
xtickangle(52.3)
ylabel('Arbitrary Units', 'FontSize', 6)
print('MIQ_centimeters_II', '-dtiff', ['-r' num2str(res)]);
saveas(gcf,'MIQ.png');

%% create figure for Relevance
figure
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
bar(value_rele)
xticks(1:1:size(inp,2));
set(gca, 'XTickLabel', names_rele)
xtickangle(90)
ylabel('Rel.')
saveas(gcf,'Relevance.png');

save('workspace_miq.mat');