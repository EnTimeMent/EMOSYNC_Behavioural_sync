% Figures of Interest
% 2. Three Emotions of P1 Solo and in Group
% YG
%      1     2     3     2     1     2
%      1     2     3     3     2     1
%      1     2     3     2     3     2
stitle1 = ['Participant: ',num2str(pa),'- Solo - 3 Emotions'];
stitle2 = ['Participant: ',num2str(pa),'- Group - 3 Emotions'];
ftitle2 = ['Participant',num2str(pa),'SolovsGroup','3Emotions'];
sa2 = cell(2,3); F2 = cell(2,3); flevel2 = zeros(2,3); [n,d] = size(S);
CTS2 = cell(2,3);

% pa = 1; % Participant
for sg = 1 : 2 % 1 solo, 2 group
    for em = 1 : 3
        if sg == 1
            rowpe = and(YI(:,1) == pa, YI(:,2) == em);
            zsa = [mean(SpeedI(rowpe,:)); mean(AccelI(rowpe,:))]';
        end
        if sg == 2
            rowpe = YG(:,4) == em;
            zsa = [mean(SpeedG{pa}(rowpe,:)); mean(AccelG{pa}(rowpe,:))]';
        end
        sa2{sg,em} = zsa;
        [fem,~] = mvksdensity(sa2{sg,em},SA,'Bandwidth',bandwSA,'Kernel','normpdf');
        flevel2(sg,em) = norm(max(sa2{sg,em}) - min(sa2{sg,em}));
        F2{sg,em} = reshape(fem,n,d);
    end
    flevel2(sg,:) = flevel2(sg,:) / sum(flevel2(sg,:));
    [flmin,imin] = min(flevel2(sg,:));
    [flmax,imax] = max(flevel2(sg,:));
    flevel2(sg,imin) = flmax; flevel2(sg,imax) = flmin;
end

% Plot
slegend2 = {'Solo Positive','Solo Neutre','Solo Negative';...
            'Group Positive','Group Neutre','Group Negative'};
ecolor2 = {'r','g','k'}; epoint2 = {'.r','.g','.k'};
eline2 = {'-r','-g','-k';
          ':r',':g',':k'};

nofig = 7; figure(nofig),clf
for sg = 1 : 2
    for em = 1 : 3
        fmax = max(max(F2{sg,em}));
        level = flevel2(sg,em) * [fmax,fmax];
        [~,hh]=contour(S,A,F2{sg,em},level,'LineWidth',2,'Color',ecolor{em});%'ShowText','on')
        z = get(hh,'ContourMatrix')';
        CTS2{sg,em} = z(2:end,:);
    end
end
figure(nofig),clf, hold on

for sg = 1 : 2
    subplot(1,2,sg), cla, hold on
    hlegend2 = zeros(3,1);
    for em = 1 : 3
        plot(sa2{sg,em}(:,1),sa2{sg,em}(:,2),epoint2{em})
        hh = plot(CTS2{sg,em}(:,1),CTS2{sg,em}(:,2),eline2{sg,em},'LineWidth',2);
        hlegend2(em) = hh;
    end
    grid on, legend(hlegend2,slegend2(sg,:)), axis([BoundsS,BoundsA])
    xlabel('1D Hand Speed'), ylabel('1D Hand Acceleration')

    if sg == 1, title(stitle1); end
    if sg == 2, title(stitle2); end
end

% Save the figure
saveas(gcf,ftitle2, 'jpg')