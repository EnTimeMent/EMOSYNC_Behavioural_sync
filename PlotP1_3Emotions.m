% PlotP1_3Emotions

sa1 = cell(1,3); F1 = cell(1,3); [n,d] = size(S);
flevel1 = zeros(1,3);
 
stitle1 = ['Participant: ',num2str(pa),' - 3 Emotions'];
ftitle1 = ['Participant',num2str(pa),'3Emotions'];
for em = 1 : 3
    rowpe = and(YI(:,1) == pa, YI(:,2) == em);
    sa1{em} = [mean(SpeedI(rowpe,:)); mean(AccelI(rowpe,:))]';
    [fem,~] = mvksdensity(sa1{em},SA,'Bandwidth',bandwSA,'Kernel','normpdf');
    flevel1(em) = norm(max(sa1{em}) - min(sa1{em})); 
    F1{em} = reshape(fem,n,d);
end
flevel1 = flevel1 / sum(flevel1);
[flmin,imin] = min(flevel1); [flmax,imax] = max(flevel1);
flevel1(imin) = flmax; flevel1(imax) = flmin;

% Plot
slegend = {'Positive','Neutre','Negative'};
ecolor = {'r','g','k'};
epoint = {'.r','.g','.k'}; eline = {'-r','-g','-k'};

figure(6),clf
for em = 1 : 3
    fmax = max(max(F1{em})); level = flevel1(em) * [fmax,fmax];
    [~,hh]=contour(S,A,F1{em},level,'LineWidth',2,'Color',ecolor{em});%'ShowText','on')
    z = get(hh,'ContourMatrix')';
    CTS{em} = z(2:end,:);
end
figure(6),clf, hold on
for em = 1 : 3
    plot(sa1{em}(:,1),sa1{em}(:,2),epoint{em})
    hh = plot(CTS{em}(:,1),CTS{em}(:,2),eline{em},'LineWidth',2);
    hlegend(em) = hh;
end
grid on, legend(hlegend,slegend), axis([BoundsS,BoundsA])
xlabel('1D Hand Speed'), ylabel('1D Hand Acceleration')
title(stitle1)

% Save the figure
saveas(gcf,ftitle1, 'jpg')
