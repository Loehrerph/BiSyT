%% extract negative free energy (log model evidence)
path (1:3,1)= {zeros};
F (1:39,1:3)= (zeros);

path(1,1) = {'..\Contrast'}; %SMA > lPM
path(2,1) = {'..\2_LPM_SMA\Contrast'}; %SMA < lPM
path(3,1) = {'..\3_SMA_equal_lPM\Contrast'}; %SMA = lPM

for i = 1:length (path)
cd (path{i,1});

GCM = dir('*GCM_calculated*');
load(GCM.name)

for l = 1:39
F(l,i) = GCM{l,1}.F;
end
end

Labels = [{'Contrast_SMA>lPM'}, {'Contrast_SMA<lPM'}, {'Contrast_SMA=lPM'}];

cd('..\Test_BMS_fuer_GCM');
save('F.mat', 'F', 'Labels');