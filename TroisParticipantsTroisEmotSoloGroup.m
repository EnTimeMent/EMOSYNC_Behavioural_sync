% TroisParticipantsEmotSoloGroup
close all

IX = cell(3,3,2); % Px3, Ex3, SxG
TX = IX;

for participant = 1 : ngroup
    P = IND == participant; % Participant p
    
    for emotion = EMOTIONS
        
        % 'S' - Solo
        IX{participant,emotion,1} = and(P,and(not(ISG),EMO == emotion));
        nSPE = sum(IX{participant,emotion,1});
        TX{participant,emotion,1} = ['S','P',num2str(participant),'E',num2str(emotion)];
        % 'G' - Group
        IX{participant,emotion,2} = and(P,and(ISG,EMO == emotion));
        nGPE = sum(IX{participant,emotion,2});
        TX{participant,emotion,2} = ['G','P',num2str(participant),'E',num2str(emotion)];
    end
end

% Plot similarity space with ellipses
colors=lines(3500); colors=colors(1:10:end,:);
Parameters.Visu = true; false;
Parameters.Nofig = 0;

k = 0;
for participant = 1 : ngroup
    for emotion = EMOTIONS
        Parameters.Nofig = Parameters.Nofig + 1;
        figure(Parameters.Nofig), clf, hold on
        plot(xx(:,1),xx(:,2),'.g')
        % New plot
        k = k + 1; colk = colors(k,:);
        
        idx = IX{participant,emotion,1};
        sx = TX{participant,emotion,1};
        zx = xx(idx,1:2); mux = mean(zx)'; covx = cov(zx);
        plot(zx(:,1),zx(:,2),'.','MarkerSize',8,'color',colk);
        text(mux(1),mux(2),sx,'FontSize',12,'FontWeight','bold','color',colk)
        plotgauss2d(mux,covx,'conf',0.7,'Color',colk,'LineWidth',1.1);
        
        k = k + 1; colk = colors(k,:);
        idx = IX{participant,emotion,2};
        sx = TX{participant,emotion,2};
        zx = xx(idx,1:2); mux = mean(zx)'; covx = cov(zx);
        plot(zx(:,1),zx(:,2),'.','MarkerSize',8,'color',colk);
        text(mux(1),mux(2),sx,'FontSize',12,'FontWeight','bold','color',colk)
        plotgauss2d(mux,covx,'conf',0.7,'Color',colk,'LineWidth',1.1);
        
        title(['Participant: ',num2str(participant),', Emot: ', num2str(emotion),': Solo & Group'])
        hold off
        'wait'
    end
end