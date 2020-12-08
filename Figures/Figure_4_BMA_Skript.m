clear all

load ('../BMA_automatic_A_Matrix.mat');

Effect = struct();
Effect.From = {};
Effect.To = {};
Effect.Effect_size = [];
Effect.Probability = [];
Effect.Regressor_Names = {};

np = length(xPEB.PEB.Pnames); % Parameters
ns = length(xPEB.PEB.Snames); % Subjects
nc = size(xPEB.PEB.Ep,2);     % Covariates

region_names = xPEB.region_names;   % region_names - cell array of region names
input_names = xPEB.input_names;     % input_names  - cell array of input (condition) names
regressor_names = xPEB.PEB.Xnames;  % regressor names

probability = xPEB.PEB.Pp;   %probability
effect = full(xPEB.PEB.Ep);  %effect sizes
locations = xPEB.PEB.Pnames; %location names


% find indices for probabilities larger than 85%
indprob = find(probability>0.85);
Effect.Probability = probability(indprob); %return probability values

%% return effect sizes and write name of connection

for i = 1:size(indprob,1)
    
    %get index for rows
    indrow= indprob(i,1)-(floor(indprob(i,1)/np)*np);
    if indrow == 0
        indrow = indrow + np;
    end
    
    %get index for columns
    indcolumn= ceil(indprob(i,1)/np);
   
    % get effect size
   
    Effect.Effect_size(i,1) = effect(indrow,indcolumn);
    Effect.Regressor_Names(i,1) = regressor_names(1,indcolumn);
    
    % generate name
    pname = locations{indrow,1};             % pname        - parameter name string from PEB e.g. A{2}(1,2,3)
    str = ['(?<field>[A-Za-z0-9\{\},]+)\('... % Match field and open bracket
        '(?<row>\d+)(,|\))'...     % Match row and open bracket or comma
        '(?<col>\d+)?(,|\))?'...   % Match column and open bracket or comma
        '(?<input>\d+)?(,|\))?'];  % Match input and open bracket or comma
    
    parts = regexp(pname, str, 'names');
    
    parts.row   = str2double(parts.row);
    parts.col   = str2double(parts.col);
    parts.input = str2double(parts.input);
    
    Effect.From(i,1) = region_names(parts.col);
    Effect.To(i,1) = region_names(parts.row);
    
end
cd ('..\Grafiken\Figure_4\A-Matrix_PEB_Par')
save('workspace_effect_sizes')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%create figure for BMA Parameter Estimates

%Figure 4.A: Group Differences

effect_group = zeros(1,9);
effect_group(1,3) = Effect.Effect_size(5,1);
effect_group(1,5:7) = Effect.Effect_size(6:8,1);
names = {'21', '29', 'Left PFC to right lPM', '31', ...
    'Right PFC to left lPM', 'Right PFC to right lPM', 'Right PFC to SMA', '35', '40'};

%Plot results
figure
sizef = [945 1260]; 
res = 600;
set(gcf, 'Units', 'inches', 'InnerPosition', [0 0 sizef/res]);
bar(effect_group, 'BarWidth', 1);

title('Bayesian Model Average','FontWeight', 'normal','FontSize', 7, 'FontName', 'Arial');
axis([0 size(effect_group,2)+1 0 max(effect_group)+0.1]);
xticks(1:1:size(effect_group,2));
yticks(min(effect_group):0.1:max(effect_group)+0.1);
set(gca, 'Units', 'normalized', 'FontUnits', 'points',...
    'FontWeight', 'normal', 'FontSize', 6, 'FontName', 'Arial',...
    'XTickLabel', names, 'FontName', 'Arial', 'FontSize', 6)
xtickangle(52.3)
ylabel('Estimate', 'FontSize', 6)
print('Group_Differences', '-dtiff', ['-r' num2str(res)]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save('workspace_effect_sizes_diff')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%create figure for BMA Parameter Estimates

%Figure 3.A: Group Commonalities

effect_group = zeros(1,9);
effect_group(1,1) = Effect.Effect_size(1:1);
effect_group(1,4:6) = Effect.Effect_size(2:4,1);
names = {'Left lPM to left PFC', '2', '3', ...
    'Right lPM to right PFC', 'SMA to left PFC', 'SMA to right PFC', '7', '8', '9'};

%Plot results
figure
sizef = [945 1260]; 
res = 600;
set(gcf, 'Units', 'inches', 'InnerPosition', [0 0 sizef/res]);
bar(effect_group, 'BarWidth', 1);

title('Bayesian Model Average','FontWeight', 'normal','FontSize', 7, 'FontName', 'Arial');
axis([0 size(effect_group,2)+1 min(effect_group)-0.1 0]);
xticks(1:1:size(effect_group,2));
yticks(-0.6:0.1:0);
set(gca, 'Units', 'normalized', 'FontUnits', 'points',...
    'FontWeight', 'normal', 'FontSize', 6, 'FontName', 'Arial',...
    'XTickLabel', names, 'FontName', 'Arial', 'FontSize', 6)
xtickangle(52.3)
ylabel('Estimate', 'FontSize', 6)
print('Group_Differences', '-dtiff', ['-r' num2str(res)]);

save('workspace_effect_sizes_comm')
