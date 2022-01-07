% TroisEmotSoloGroup
close all

IX = cell(3,2); TX = IX; NX = zeros(3,2);

% Y: [819×7 double], YHeader: {1×7 cell}
% YHeader: {'Triad'  'Order'  'NoGroupTrial'  'NoIndividualTrial'  'RELindex'  'Person'  'Emotion'}

ISG = SCENARIO.Y(:,3) > 0; % true for GROUP trial
EMO = SCENARIO.Y(:,7);
TRIAD = SCENARIO.Y(:,1);
% not(ISG) is true for SOLO trial
k = 1; emo  = EPOSITIVE; triad = 2;
IX{k,1} = and(TRIAD == triad,and(not(ISG),EMO == emo)); TX{k,1} = ['S',num2str(emo)];
IX{k,2} = and(TRIAD == triad,and(ISG,EMO == emo)); TX{k,2} = ['G',num2str(emo)];

k = 2; emo  = ENEUTRAL;
IX{k,1} = and(not(ISG),EMO == emo); TX{k,1} = ['S',num2str(emo)];
IX{k,2} = and(ISG,EMO == emo); TX{k,2} = ['G',num2str(emo)];

k = 3; emo  = ENEGATIVE;
IX{k,1} = and(not(ISG),EMO == emo); TX{k,1} = ['S',num2str(emo)];
IX{k,2} = and(ISG,EMO == emo); TX{k,2} = ['G',num2str(emo)];

% Plot similarity space with ellipses
colors=lines(3500); colors=colors(1:10:end,:);
Parameters.Visu = true; false; 
Parameters.Nofig = 0;

k = 0;
for emo = EMOTIONS 
    Parameters.Nofig = Parameters.Nofig + 1;
    figure(Parameters.Nofig), clf, hold on
%     plot(xx(:,1),xx(:,2),'.g')
    % New plot
    k = k + 1; colk = colors(k,:);
    
    idx = IX{emo,1}; sx = TX{emo,1};
    zx = xx(idx,1:2); mux = mean(zx)'; covx = cov(zx);    
    plot(zx(:,1),zx(:,2),'.','MarkerSize',8,'color',colk);
    text(mux(1),mux(2),sx,'FontSize',12,'FontWeight','bold','color',colk)
    plotgauss2d(mux,covx,'conf',0.7,'Color',colk,'LineWidth',1.1);

    k = k + 1; colk = colors(k,:);
    idx = IX{emo,2}; sx = TX{emo,2};
    zx = xx(idx,1:2); mux = mean(zx)'; covx = cov(zx);    
    plot(zx(:,1),zx(:,2),'.','MarkerSize',8,'color',colk);
    text(mux(1),mux(2),sx,'FontSize',12,'FontWeight','bold','color',colk)
    plotgauss2d(mux,covx,'conf',0.7,'Color',colk,'LineWidth',1.1);

    title(['Emot: ', num2str(emo), 'Triad', num2str(triad),': Solo & Group'])
    hold off
    xlabel('cmd 1'), ylabel('cmd 2'),
    'wait'
end 