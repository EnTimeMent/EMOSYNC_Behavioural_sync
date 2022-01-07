% TroisEmotSoloGroup_PerTriad
close all
pathFIGURE = '\\159.31.103.1\janaqi\Documents\artikuj\_These_AS\FigureFolder_23_06\';

IX = cell(3,2); TX = IX; NX = zeros(3,2); PX = IX;

% Y: [819×7 double], YHeader: {1×7 cell}
% YHeader: {'Triad'  'Order'  'NoGroupTrial'  'NoIndividualTrial'  'RELindex'  'Person'  'Emotion'}

TRIAD = SCENARIO.Y(:,1);
PERSON = SCENARIO.Y(:,6);
GROUP = SCENARIO.Y(:,3) > 0; % true for GROUP trial
SOLO = not(GROUP);
EMOT = SCENARIO.Y(:,7);
RELIND = SCENARIO.Y(:,5);
ZEMOT = [EPOSITIVE; ENEUTRAL; ENEGATIVE];
NTRIAD = unique(TRIAD);
% OVERLAP(triad,emot) = overlap ELLIPSES of SOLO and GROUP for (triad,emot)
OVERLAP = zeros(length(NTRIAD),3);

% FOR Plot similarity space with ellipses
colors = lines(3500); colors=colors(1:10:end,:); k = 0;

for tr = 1 : length(NTRIAD)
    
    triad = NTRIAD(tr);
    
    % Init IX, TX
    for emo = 1 : 3 % 3 emotions
        zemo  = ZEMOT(emo); %triad = 2;
        IX{emo,1} = and(TRIAD == triad,and(SOLO,EMOT == zemo));
        PX{emo,1} = RELIND(IX{emo,1}); TX{emo,1} = ['S',num2str(zemo)];
        IX{emo,2} = and(TRIAD == triad,and(GROUP,EMOT == zemo));
        PX{emo,2} = RELIND(IX{emo,2}); TX{emo,2} = ['G',num2str(zemo)];
        
        %         TX, PX        
        % Numerical informations for SOLO and GROUP
        k = k + 1;  colS = colors(k,:);
        idS = IX{emo,1}; sxS = TX{emo,1}; pxS = PX{emo,1};
        zS = xx(idS,1:2); muS = mean(zS)'; covS = cov(zS);
        
        [AS,QS,rS,ES] = f_EllipseCalculus(muS, covS,[], 0.7, 100);
        
        k = k + 1; colG = colors(k,:);
        idG = IX{emo,2}; sxG = TX{emo,2}; pxG = PX{emo,2};
        zG = xx(idG,1:2); muG = mean(zG)'; covG = cov(zG);
        
        [AG,QG,rG,EG] = f_EllipseCalculus( muG, covG,[], 0.7, 100);
        
        A = f_EllipseCalculus2(muS,covS,AS,QS,ES,rS,muG,covG,AG,QG,EG,rG);
        
        OVERLAP(tr,emo) = 2 * A / (AS + AG);
        % New plot        
        figure(emo), clf, hold on                        
        [AS,ES] = s_PlotEllipses(zS, pxS, sxS, muS, covS, colS);
        [AG,EG] = s_PlotEllipses(zG, pxG, sxG, muG, covG, colG);
        stri = num2str(triad);
        semo = num2str(ZEMOT(emo));
        somega = num2str(OVERLAP(tr,emo));
        title(['Solo & Group, Triad:',stri,', Emot: ',semo,', Omega: ',somega])
        hold off, xlabel('cmd 1'), ylabel('cmd 2'),
        
%         % Save figure
%         ff = [pathFIGURE,['EmotSoloGroup','Triad',num2str(triad),'Emot',num2str(emo)]];
%         saveas(gcf,ff,'jpg')
%         'wait'
    end
end

