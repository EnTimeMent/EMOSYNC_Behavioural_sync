% SLOW1

clear all; clc; close all;

order = 4; cutOff = 10; SampleFreq = 100;
Wn = (cutOff/(SampleFreq/2));
[param1, param2] = butter(order,Wn);

kk=1; deb=100; fin=2980;

pathD = '\\159.31.103.1\janaqi\Documents\artikuj\_These_AS\Data\SLOW_DATA\MG\D';

no = 1 : 15;
P = [pathD,num2str(1)];

for t = 1 : 54
    F = ['Trial0' num2str(t)];
    PF = fullfile(P,F);
    DA = load(PF);
    X = DA.out_marker; %: [7553×2 double]
    
    x = X(deb:fin,1); ax = 1 : length(x);
    xf = filtfilt( param1, param2, x);
    [ef,ief] = max(abs(x-xf));
    v = fin_diff(xf,1/SampleFreq); %fin-diff est une fonction qui dérive un signal, ici un signal de position
    
    figure(1), clf
    subplot(211),plot(X(deb:fin,:)),legend('1','2'), title(F)
    subplot(212),plot(ax,x,'-k',ax,xf,'-r',ax,v,'-b'),
    legend('x','xf','v')
    title(['x-xf : ',num2str(ef)])%x,xf,v')
%     subplot(313),plot(v), title('2_hist')
    'a'
    
end