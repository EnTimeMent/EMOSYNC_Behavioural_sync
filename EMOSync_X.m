% EMOSync_X_0: use Lasso for Emot prediction

clear all, close all

GLOBAL_; 

% 1. Create Learn Scenario
SCENARIO.NAME = 'EMOT_SINGLE_GROUP';
% CreateLearnScenario;
% CreateLearnScenario_22_06;
% Load Scenario
nameS = [SCENARIO.NAME,'.mat'];
% pathLITTLE = '\\159.31.103.1\janaqi\Documents\artikuj\_These_AS\Mtlb\EMOSync\';
% D = load([pathLITTLE,nameS]); %,'SCENARIO')
% pathBIG = 'D:\_These_AS\Mtlb\EMOSync\';
% pathBIG = 'C:\Users\janaqi\OneDrive - IMT MINES ALES\Documents\';
D = load(nameS); %,'SCENARIO')

SCENARIO = D.SCENARIO
% SCENARIO = NAME: 'EMOT_SINGLE_GROUP'
%                 Q: 'Detect_Emotions_Solo_Group'
%              xpdf: [1×539 double]
%              span: [2×7 double]
%                 X: [819×539 double]
%          features: {1×7 cell}
%     namesfeatures: {1×539 cell}
%                 y: [819×1 double]
%             namey: 'Emotion'
%                 Y: [819×7 double]
%           YHeader: {1×7 cell}
% SCENARIO.YHeader = {'Triad','Order','NoGroupTrial','NoIndividualTrial',
%                     'RELindex','Person','Emotion'}
% % 1.1 SINGLE 
% Model.Name = 'EMOT_SINGLE'; % Predict EMOT for individual trials
% IGROUPINDIV = SCENARIO.Y(:,4) > 0;
% Model.FilterCoefficient = 0.02; % % of weak coefficients to put to 0;

% % 1.2 GROUP
Model.Name = 'EMOT_GROUP'; % Predict EMOT for Group trials
IGROUPINDIV = SCENARIO.Y(:,4) == 0;
Model.FilterCoefficient = 0.001; % % of weak coefficients to put to 0;

y = SCENARIO.y(IGROUPINDIV); 
X = SCENARIO.X(IGROUPINDIV,:);
[y,SortY] = sort(y); X = X(SortY,:);

Model.X = X; Model.Y = y; Model.SortY = SortY;
[Model.NOBS,Model.NVAR0] = size(Model.X);
Model.ABSINDCOL = 1 : Model.NVAR0;
Model.ABSNAMEVAR = SCENARIO.namesfeatures;

% First Stats
Parameters.Normalize = true; %false; 
Parameters.Visualize = true; %false; % true
Parameters.nofig = 0;

% Model
Model = f_FirstStatsEMO(Model);

% Learn Model : 3/4 - Learn; 1/4 - Test
Model.IL = true(Model.NOBS,1);
Model.IL(4 : 4 : Model.NOBS) = false; Model.IT = not(Model.IL);
Model.FilterCoefficient = 0.02; % % of weak coefficients to put to 0;
Model.TargetError = 0.12; % 12%
% TODO : Place the index rows in front of absolute names !
Model = f_CalculateModel_EMO(Model)
E0 = Model.E0; L = Model.Linear; %    disp(L.yL)

% Disp Class
[Model.CLASS{1,1},Model.CLASS{1,2},Model.CLASS{1,1}+Model.CLASS{1,2}]
% CA = Model.CLASS{2,1}
% CT = Model.CLASS{2,2}
Model = f_ContributionVariables(Model,SCENARIO);

% f_VisualizeResults(Model)
save([Model.Name,'_23_06.mat'],'Model','SCENARIO')
