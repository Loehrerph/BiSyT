load('..\GCM_calculated');

for subi = 15

% get figure
%--------------------------------------------------------------------------
fig = spm_figure('GetWin','Graphics'); 
colormap(gray)
clf

% trial data
%--------------------------------------------------------------------------
xY  = GCM{subi,1}.xY;                   % data
nt  = length(xY.y);             % Nr trial types
ne  = size(xY.y{1},2);          % Nr electrodes
nb  = size(xY.y{1},1);          % Nr time bins
t   = xY.pst;                   % PST

% post inversion parameters
%--------------------------------------------------------------------------
nu  = length(GCM{subi,1}.B);          % Nr inputs
nc  = size(GCM{subi,1}.H{1},2);       % Nr modes
ns  = size(GCM{subi,1}.A{1},1);       % Nr of sources
np  = size(GCM{subi,1}.K{1},2)/ns;    % Nr of population per source   

% spm_dcm_erp_results(DCM,'ERPs (mode)');
        %------------------------------------------------------------------
        co = {'b', 'r', 'g', 'm', 'y', 'k'};
        lo = {'-', '--'}; A = [0 0];
        
        for i = 1:nc
            subplot(ceil(nc/2),2,i), hold on
            str   = {};
            for j = 1:nt
                plot(t,GCM{subi,1}.H{j}(:,i), lo{1},...
                    'Color', co{j},...
                    'LineWidth',2);
                str{end + 1} = sprintf('trial %i (predicted)',j);
                plot(t,GCM{subi,1}.H{j}(:,i) + GCM{subi,1}.R{j}(:,i), lo{2},...
                    'Color',co{j});
                str{end + 1} = sprintf('trial %i (observed)',j);
                set(gca, 'XLim', [t(1) t(end)]);
                
            end
            hold off
            title(sprintf('mode %i',i))
            grid on
            axis square
            a    = axis;
            A(1) = min(A(1),a(3));
            A(2) = max(A(2),a(4));
        end
        xlabel('time (ms)')
        legend(str)
        
        % set axis
        %------------------------------------------------------------------
        for i = 1:nc
            subplot(ceil(nc/2),2,i)
            set(gca,'YLim',A)
        end
        
   savefig(['Modes_subject_' num2str(subi)]);     
   print(fig, ['Modes_subject_' num2str(subi)], '-dpng')
end 
        