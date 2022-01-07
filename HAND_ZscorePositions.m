% HAND_ZscorePositions
% Prepare XYZ Positions of HAND marker for CRQA analysis

clear all; clc; close all;

GLOBAL_; % global variables

% 1. Create Learn Scenario
SCENARIO.NAME = 'HAND_ZSCORE_POSXYZ';
% CreateLearnScenario_HandXYZ_07_07;

% Load Scenario
nameS = [SCENARIO.NAME,'.mat'];
D = load(nameS); %,'SCENARIO')
SCENARIO = D.SCENARIO
%              NAME: 'HAND_ZSCORE_POSXYZ'
%                 Q: 'Prepare_HandPos_to_JRQA'
%              xpdf: [1×231 double], span: [2×3 double]
%                 X: [819×231 double], features: {'Position_Hand'}
%     namesfeatures: {1×231 cell}
%                 y: [819×1 double], namey: 'Emotion', Y: [819×7 double]
%           YHeader: {1×7 cell}, VALUE: {819×1 cell}
% YHeader: {'Triad'  'Order'  'NoGroupTrial'  'NoIndividualTrial'  'RELindex'  'Person'  'Emotion'}

% 0. Calculate Velocity profile
Parameters.Visu = true; false;
Parameters.Nofig = 0;

TRIAD = SCENARIO.Y(:,1);
GROUPTRIAL = SCENARIO.Y(:,3);
PERSON = SCENARIO.Y(:,6);
EMOT = SCENARIO.Y(:,7);
ZEMOT = [EPOSITIVE; ENEUTRAL; ENEGATIVE];

SCENARIO.VALUEZSCORE = SCENARIO.VALUE;
for triad = 1 : NTRIAD
    
    % global NGROUPMEASURE = 15;
    for trial = 1 : NGROUPMEASURE 
        
        IX = and(TRIAD == triad,GROUPTRIAL == trial);
        zemo  = unique(EMOT(IX));
        pers = PERSON(IX);
        
        P = SCENARIO.VALUE(IX); Pz = P;
        for p = 1 : 3, Pz{p} = zscore(P{p}); end
        SCENARIO.VALUEZSCORE(IX) = Pz;
        
        if Parameters.Visu
            nofig = 1;             
            [T,~] = size(P{1}); ax = (1:T)/ViconFrequency;
            
            stt = ['Emot:',num2str(zemo),', Triad:',num2str(triad),', Trial:',num2str(trial)];
            figure(nofig), clf
            for p = 1 : 3
                subplot(2,3,p)                
                plot(ax,P{p}(:,1),'-g',ax,P{p}(:,2),'-b',ax,P{p}(:,3),'-r'), legend('X','Y','Z')
                xlabel('Time [s]'), title([stt,' Original P',num2str(p)])
            end
            for p = 1 : 3
                subplot(2,3,p+3)
                plot(ax,Pz{p}(:,1),'-g',ax,Pz{p}(:,2),'-b',ax,Pz{p}(:,3),'-r'), legend('X','Y','Z')
                xlabel('Time [s]'), title([stt,' Zscore P',num2str(p)])
            end
                        
            %         % Save figure
            %         ff = [pathFIGURE,['EmotSoloGroup','Triad',num2str(triad),'Emot',num2str(emo)]];
            %         saveas(gcf,ff,'jpg')
            'wait'

        end        
    end
end



% Update SCENARIO
save(nameS,'SCENARIO')