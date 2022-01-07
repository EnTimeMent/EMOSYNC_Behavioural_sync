% MirrorGame_1

clear all, close all
GLOBAL_;
% Phase 0 : Load Data
% pathD = '\\159.31.103.1\janaqi\Documents\artikuj\_These_AS\Data\MirrorGame\';
% pathD = '\\159.31.103.1\janaqi\Documents\artikuj\_These_AS\Data\Triad4_Individual_Recordings\';
% 
% nmarker = length(MarkersOrder);
% ncoords = 3 * nmarker; 
% Parameters.P1P2P3 = zeros(ngroup,ncoords);
% for g = 1 : ngroup
%     Parameters.P1P2P3(g,:) = (g-1)*ncoords+1 : g*ncoords;
% end
% Parameters.WidthMissingValues = 10; % Empirical
% INDTRIAL = f_CSV2MTLB1(pathD,Parameters);
% save('IndivMirrorTrials.mat','INDTRIAL')
% 
% GROUPTRIAL = f_CSV2MTLB2(pathD,Parameters);
% save('GroupMirrorTrials.mat','GROUPTRIAL')

% % Phase 1 : Hand Orientations
% DD = load('IndivMirrorTrials.mat');
% INDTRIAL = DD.INDTRIAL; clear DD
% DD = load('GroupMirrorTrials.mat'); %,'GROUPTRIAL')
% GROUPTRIAL = DD.GROUPTRIAL; clear DD
% [YI,YG,IHANDS,GHANDS] = f_HandSynchro(GROUPTRIAL,INDTRIAL);
% save('_HANDSYN.mat','YI','YG','IHANDS','GHANDS');
% Analyze 1D Hand trajectories.
DD = load('_HANDSYN.mat');
YI = DD.YI; YG = DD.YG; 
IHANDS = DD.IHANDS; GHANDS = DD.GHANDS;
f_CompareHandSynchro(YI,YG,IHANDS,GHANDS);

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

