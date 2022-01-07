% SLOW1_EMOSync
% Plot Ellipses per Individual/Emotion/Group or Solo

clear all; clc; close all;

GLOBAL_; % global variables

% 1. Create Learn Scenario
SCENARIO.NAME = 'EMOT_GROUP_05_07';
% CreateLearnScenario_SLOW;
% CreateLearnScenario_22_06
% CreateLearnScenario_05_07;
% Load Scenario
nameS = [SCENARIO.NAME,'.mat'];
D = load(nameS); %,'SCENARIO')
SCENARIO = D.SCENARIO
%              NAME: 'ELLIPSE_PEGS'
%                 Q: 'Plot_Ellipses_P_E_G_S'
%              xpdf: [1×308 double]
%              span: [2×4 double]
%                 X: [819×308 double]
%          features: {1×4 cell}
%     namesfeatures: {1×308 cell}
%                 y: [819×1 double], namey: 'Emotion'
%                 Y: [819×7 double], YHeader: {1×7 cell}
%             VALUE: {819×1 cell}
% YHeader: {'Triad'  'Order'  'NoGroupTrial'  'NoIndividualTrial'  'RELindex'  'Person'  'Emotion'}

% %! X matrix is organized in blocks of NBINS (global) features
% Example : 308 = NBINS(=77) x 4 blocks of features

% 0. Calculate Velocity profile
[N,F] = size(SCENARIO.X); CDFF = zeros(N,F); % deb=1; fin=F;
Parameters.Visu = true; false;
Parameters.Nofig = 0;

% I. Calculate RVE - Relative Velocity Error
% Here SCENARIO.VALUE: {819×1 cell} contains the velocities of HAND
% for every Group/Trial/Person
RVE = f_CalculateRVE(SCENARIO.VALUE);

% II. COMPUTE CDF of every BLOCK of features
% Parameters.Visu = false;true;
NBLOCKS = length(SCENARIO.features);
Parameters.Nofig = Parameters.Nofig + 1;
iobs = 333;

for b = 1 : NBLOCKS
    cb1 = (b-1)*NPDFBINS + 1; cb2 = b*NPDFBINS;
    IC = cb1 : cb2;
    xb = SCENARIO.xpdf(IC); delta = xb(2) - xb(1);
    B = SCENARIO.X(:,IC);
    BB = delta * cumsum(B,2);
    z = max(BB,[],2); 
    BB = diag(1./ z) * BB;
    CDFF(:,IC) = BB;
    if Parameters.Visu        
        figure(Parameters.Nofig)        
        subplot(2,2,b)
        plot(xb,B(iobs,:),'-b',xb,BB(iobs,:),'-r')
        title(['Pdf and Cdf:',SCENARIO.features{b}]), grid on       
    end
    'wait'
end
    
% Compute emds for CDFV
emds = zeros(N);
for k = 1 : N - 1
    for j = k + 1 : N
        emds(k,j) = sum(abs(CDFF(k,:) - CDFF(j,:)));
        emds(j,k) = emds(k,j);
    end
end

[xx,ev] = cmdscale(emds); % Compute the multidimentional scaling of the matrix emds

Parameters.Visu = true;
% if Parameters.Visu
%     Parameters.Nofig = Parameters.Nofig + 1;
%     figure(Parameters.Nofig), clf, plot(xx(:,1),xx(:,2),'*g')
%     xlabel('cmd 1'), ylabel('cmd 2')
% end

% III. Conditions and Ellipsoids
% 3 emotions Solo / Group
% TroisEmotSoloGroup_PerTriad;
% TroisEmotSoloGroup;
% TroisParticipantsEmotSoloGroup;

% Update SCENARIO
% SCENARIO.RVE = RVE;
% SCENARIO.OVERLAP = OVERLAP;
SCENARIO.EMD = emds;
save(nameS,'SCENARIO')