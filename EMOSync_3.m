% EMOSync_3.m : Learning Predicting Sparse Models
% 1. Creates scenario (X, y) - see CreateLearnScenario
% SCENARIO = 
%              NAME: 'EMOT_SINGLE_GROUP'
%                 Q: 'Detect_Emotions_Solo_Group'
%              xpdf: [1×616 double]
%              span: [2×8 double]
%                 X: [819×616 double]
%          features: {1×6 cell}
%     namesfeatures: {1×616 cell}
%                 y: [819×1 double]
%             namey: 'Emotion'
%                 Y: [819×7 double]
%           YHeader: {1×7 cell}
% %! X matrix is organized in blocks of NBINS (global) features
% Example : 616 = NBINS(=77) x 8 blocks of features

clear all, close all
GLOBAL_; % GLOBALS_MV

% 1. Create Learn Scenario
SCENARIO.NAME = 'EMOT_SINGLE_GROUP';
% CreateLearnScenario;

% Load Scenario
% SCENARIO.NAME = 'EMOT_SINGLE_GROUP';
nameS = [SCENARIO.NAME,'.mat'];
D = load(nameS); %,'SCENARIO')
SCENARIO = D.SCENARIO

% 1.1. Cast y to values 1, 2, ...
y = SCENARIO.y' + 1 - min(SCENARIO.y); % zz = unique(y);
X = SCENARIO.X;

% 2. Create Partition of rows in Learn and Test sets
[Model.NOBS,Model.NFEATURES] = size(X);
Model.ABSINDCOL = 1 : Model.NFEATURES;
Model.IT = false(Model.NOBS,1);
Model.IT(4 : 4 : Model.NOBS) = true;
Model.IL = not(Model.IT); nt = sum(Model.IT); nl = sum(Model.IL);
Model.EpsiFilter0 = 1e-4; % Epsi Application
Model.Normalize = false;

% % XP = D.SVMDATA.XP; YP = D.SVMDATA.YP; clear D % gain space
% % % XT = [XT;XP]; YT = [YT, YP];
% m = min(X); M = max(X);
% 
% % % First Filter: Constant Columns
% IND1 = M > m + Parameters.EpsiFilter0;
% NFirst = sum(IND1);
% figure(1),subplot(121), plot(M - m,':k'); %spy([XA;XT])
% subplot(122), hist(M - m,101)
%  
% XL1 = XL(:,IND1); clear XL % gain space
% XT1 = XT(:,IND1); clear XT % gain space

% Learning: Successive decrease of dimension
tic
[ICV,ICOL,X1,SVModel1,COUNT] = f_LearnSPsvm_1(X,y,Model);

% save('SVM1_22_03_2999.mat','SVModel1','ICV','ICOL','COUNT','X1')
% save('SVM1_23_4.mat','SVModel1','ICV','ICOL','COUNT','X1')
toc