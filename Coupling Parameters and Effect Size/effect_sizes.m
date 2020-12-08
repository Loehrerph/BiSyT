function effect_sizes(xPEB)
%creates a Excel file containing the Effect Size, Probability, Direction
%and respective Regressor of all connections with Probabilities above .95


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


% find indices for probabilities larger than 95%
indprob = find(probability>0.95);
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

writetable(struct2table(Effect),'Effectsizes.xlsx')

end
