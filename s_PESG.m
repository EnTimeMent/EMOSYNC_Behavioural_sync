% s_PESG.m

% Display
% 1. Overall Emotion (x3) Solo / Group
% 2. For every person (1 : 39) Emotion (x3) Solo / Group
close all

pathFIGURE = 'F:\_These_AS\Mtlb\EMOSync\FigureFolder\';
% YHeader: {'Triad'  'Order'  'NoGroupTrial'
% 'NoIndividualTrial'  'RELindex'  'Person'  'Emotion'}

EMOT = SCENARIO.Y(:,7);
PERSON = SCENARIO.Y(:,6);
GROUP = SCENARIO.Y(:,3) > 0;
SOLO = not(GROUP);

% 1. Overall Emotion (x3) Solo / Group
NameFigure1 = 'OverallEmotSoloGroup.jpg';
IX = cell(3,2); TX = IX;

% +
IX{1,1} = and(SOLO,EMOT == EPOSITIVE);  TX{1,1} = 'S+';
IX{1,2} = and(GROUP,EMOT == EPOSITIVE); TX{1,2} = 'G+';
% 0
IX{2,1} = and(SOLO,EMOT == ENEUTRAL); TX{2,1} = 'S0';
IX{2,2} = and(GROUP,EMOT == ENEUTRAL); TX{2,2} = 'G0';
% -1
IX{3,1} = and(SOLO,EMOT == ENEGATIVE); TX{3,1} = 'S-';
IX{3,2} = and(GROUP,EMOT == ENEGATIVE); TX{3,2} = 'G-';


% Plot similarity space with ellipses
colors=lines(3500); colors=colors(1:10:end,:);
Parameters.Visu = true; false;
Parameters.Nofig = 0;

Parameters.Nofig = Parameters.Nofig + 1;
figure(Parameters.Nofig), clf

k = 0; emot = {'+','0','-'};
for emotion = EMOTIONS
    
    subplot(3,1,emotion), cla, hold on
    
    plot(xx(:,1),xx(:,2),'.g')
    % New plot
    k = k + 1; colk = colors(k,:);
    
    idx = IX{emotion,1}; sx = TX{emotion,1};
    zx = xx(idx,1:2); mux = mean(zx)'; covx = cov(zx);
    plot(zx(:,1),zx(:,2),'.','MarkerSize',8,'color',colk);
    text(mux(1),mux(2),sx,'FontSize',12,'FontWeight','bold','color',colk)
    plotgauss2d(mux,covx,'conf',0.7,'Color',colk,'LineWidth',1.1);
    
    k = k + 1; colk = colors(k,:);
    idx = IX{emotion,2}; sx = TX{emotion,2};
    zx = xx(idx,1:2); mux = mean(zx)'; covx = cov(zx);
    plot(zx(:,1),zx(:,2),'.','MarkerSize',8,'color',colk);
    text(mux(1),mux(2),sx,'FontSize',12,'FontWeight','bold','color',colk)
    plotgauss2d(mux,covx,'conf',0.7,'Color',colk,'LineWidth',1.1);
    
    xlabel('cmd 1'), ylabel('cmd 2')
    title(['Emot: ', emot{emotion},' : Solo & Group'])
    hold off
    'wait'
end
ff = [pathFIGURE,'OverallEmotSoloGroup'];
saveas(gcf,ff,'jpg')

% 2. For every person (1 : 39) Emotion (x3) Solo / Group
P = unique(PERSON);
for triad = 1 : NTRIADS
    
    Parameters.Nofig = Parameters.Nofig + 1;
    figure(Parameters.Nofig), clf
      
    for p = 1 : GROUPSIZE
        
        if p == 1, isub = 1 : 3; end
        if p == 2, isub = 4 : 6; end
        if p == 3, isub = 7 : 9; end
        
        absperson = (triad-1)*GROUPSIZE + p;
        stitle = ['P:',num2str(absperson),', E:'];
        
        person = P(p); IX = cell(3,2); TX = IX;
        IPS = and(PERSON == absperson,SOLO); n1 = sum(IPS);
        IPG = and(PERSON == absperson,GROUP); n2 = sum(IPG);      
        % Three emotions        
        % +
        IX{1,1} = and(IPS,EMOT == EPOSITIVE); TX{1,1} = 'S+';
        IX{1,2} = and(IPG,EMOT == EPOSITIVE); TX{1,2} = 'G+';
        % 0
        IX{2,1} = and(IPS,EMOT == ENEUTRAL); TX{2,1} = 'S0';
        IX{2,2} = and(IPG,EMOT == ENEUTRAL); TX{2,2} = 'G0';
        % -1
        IX{3,1} = and(IPS,EMOT == ENEGATIVE); TX{3,1} = 'S-';
        IX{3,2} = and(IPG,EMOT == ENEGATIVE); TX{3,2} = 'G-';
        
        for emotion = EMOTIONS
            
            isubplot = isub(emotion); k = 0;            
            subplot(3,3,isubplot), cla, hold on            
            plot(xx(:,1),xx(:,2),'.g')
            % New plot
            k = k + 1; colk = colors(k,:);
                       
            idx = IX{emotion,1}; sx = TX{emotion,1};
            zx = xx(idx,1:2); mux = mean(zx)'; covx = cov(zx);
            plot(zx(:,1),zx(:,2),'.','MarkerSize',8,'color',colk);
            text(mux(1),mux(2),sx,'FontSize',12,'FontWeight','bold','color',colk)
            plotgauss2d(mux,covx,'conf',0.7,'Color',colk,'LineWidth',1.1);
            
            k = k + 1; colk = colors(k,:);
            idx = IX{emotion,2}; sx = TX{emotion,2};
            zx = xx(idx,1:2); mux = mean(zx)'; covx = cov(zx);
            plot(zx(:,1),zx(:,2),'.','MarkerSize',8,'color',colk);
            text(mux(1),mux(2),sx,'FontSize',12,'FontWeight','bold','color',colk)
            plotgauss2d(mux,covx,'conf',0.7,'Color',colk,'LineWidth',1.1);
            
            xlabel('cmd 1'), ylabel('cmd 2')
            
            title([stitle,emot{emotion},' : Solo & Group']);
            hold off
            
        end
    end
    ff = [pathFIGURE,'IndividualEmotSoloGroup','Triad',num2str(triad)];
    saveas(gcf,ff,'jpg')
    'aa'
end
