% EMOSync_1 : Load and configures All data from EMOSync experiment

clear all, close all
GLOBAL_;

% Phase 0 : Load Data
pathD = '\\159.31.103.1\janaqi\Documents\artikuj\_These_AS\Data\EMOSync\Vicon\';% 
nmarkers = length(MARKERSNAMES);
ncoords = NCOORD * NMARKERS; 
Parameters.PWD = pwd; Parameters.Separator = ',';
Parameters.P1P2P3 = zeros(GROUPSIZE,ncoords);
for g = 1 : GROUPSIZE
    Parameters.P1P2P3(g,:) = (g-1)*ncoords+1 : g*ncoords;
end
Parameters.WidthMissingValues = 10; % Empirical
tic
[READG,READI,DATA] = f_CSV2MTLB0(pathD,Parameters);
toc
% save('DATA_1.mat','DATA')


% % Phase 1 : Hand Orientations
% DD = load('IndivMirrorTrials.mat');
% INDTRIAL = DD.INDTRIAL; clear DD
% DD = load('GroupMirrorTrials.mat'); %,'GROUPTRIAL')
% GROUPTRIAL = DD.GROUPTRIAL; clear DD
% [YI,YG,IHANDS,GHANDS] = f_HandSynchro(GROUPTRIAL,INDTRIAL);
% save('_HANDSYN.mat','YI','YG','IHANDS','GHANDS');
% Analyze 1D Hand trajectories.
% DD = load('_HANDSYN.mat');
% YI = DD.YI; YG = DD.YG; 
% IHANDS = DD.IHANDS; GHANDS = DD.GHANDS;
% f_CompareHandSynchro(YI,YG,IHANDS,GHANDS);

% % Data to GroupSync
% M = GHANDS{6}; % All positive
% save('Hands_6.csv','M','-ascii','-double')
% use_cl_ph1

% % tic
% % HEADSYNCHRO = f_HeadSynchro(GROUPTRIAL);
% % toc
% % save('_HEADSYNCHRO.mat','HEADSYNCHRO')
% DD = load('_HEADSYNCHRO.mat');
% HEADSYNCHRO = DD.HEADSYNCHRO; clear DD
% nameF = 'FigureFolder';
% F_VisuHeadSynchro(HEADSYNCHRO,nameF)

