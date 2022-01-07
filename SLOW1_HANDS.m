% SLOW1

clear all; clc; close all;

GLOBAL_; % global variables
% Load Data
DD = load('_HANDSYN.mat');
YI = DD.YI; YG = DD.YG; IHANDS = DD.IHANDS; GHANDS = DD.GHANDS;
% Put Data in Rows
[ISG,IND,EMO,X] = f_PutDataInRows(YI,YG,IHANDS,GHANDS);
clear DD YI YG IHANDS GHANDS
% disp([ISG,IND,EMO])

% I. Calculate Velocity profile
[N,T] = size(X); V = zeros(N,T); deb=1; fin=T;
Parameters.Visu = true; true; % true
Parameters.Nofig = 0;

% Filter parameters
order = 4; cutOff = 2; SampleFreq = 100;
[param1, param2] = butter(order,(cutOff/(SampleFreq/2)));

for k = 1 : N    
    xk_filt = filtfilt( param1, param2, X(k,deb:fin));
    ek = max(abs(X(k,deb:fin) - xk_filt));
    V(k,:) = fin_diff(xk_filt,1/SampleFreq); %fin-diff est une fonction qui dérive un signal, ici un signal de position    
end
if Parameters.Visu    
    Parameters.Nofig = Parameters.Nofig + 1;
    figure(Parameters.Nofig), clf, aT = 1 : T;
    plot(aT,X(k,deb:fin),'-k',aT,xk_filt,'-r',aT,V(k,:),'-b')
    'wait'
end

% II. COMPUTE CDF of Velocity Profiles
% Parameters.Visu = true;
vmax = max(V(:)); vmin = min(V(:)); nbpdf = 101;
CDFV = zeros(N,nbpdf);
vv = linspace(vmin,vmax,nbpdf);
for k = 1 : N
    [cdfv,vv] = f_PdfCdf(V(k,:),nbpdf,vmin,vmax,'cdf');
    CDFV(k,:) = cdfv;
end
if Parameters.Visu
    k=1;
    Parameters.Nofig = Parameters.Nofig + 1;
    figure(Parameters.Nofig), clf, plot(vv,CDFV(k,:),'-k')
    'wait'
end

% Compute emds for CDFV
deltav = vv(2) - vv(1);
emds = zeros(N);
for k = 1 : N - 1
    for j = k + 1 : N
        emds(k,j) = sum(abs(CDFV(k,:) - CDFV(j,:))) * deltav;
        emds(j,k) = emds(k,j);
    end
end

[xx,ev] = cmdscale(emds); % Compute the multidimentional scaling of the matrix emds

Parameters.Visu = true; false;
if Parameters.Visu
    Parameters.Nofig = Parameters.Nofig + 1;
    figure(Parameters.Nofig), clf, plot(xx(:,1),xx(:,2),'*g')
end

% III. Conditions and Ellipsoids
% % Trois émotions en Solo ou Groupe
TroisEmotSoloGroup;
TroisParticipantsEmotSoloGroup;


