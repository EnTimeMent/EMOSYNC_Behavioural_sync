function [XF,XPHASES] = f_CHRONOS_2(X,UT)

% CHRONOS_2 : 
% 1. Filters (if needed) with butterwoth
% 2. Calculate instantaneous phases with Hilbert transform
% 3. Put parameters into GLOBAL_CHRONOS

% clear all; clc; close all;

GLOBAL_;
% % Load Local Data
% % DATA Structure
% D = load('FINALDATA.mat'); %,'DATA')
% DATA = D.DATA; clear D
% % DATA = 
% %                    Name: 'Chronos'
% %     TABLETRIALEMOTDELAY: [54×6 table]
% %                 YHeader: {1×6 cell}
% %                       Y: [3240×6 double]
% %         PERCENTMISSVALS: [3240×1 double]
% %         UNIQUETINTERVAL: [2475×1 double]
% %                  FINALX: [2475×3240 double]
% %                  
% % ! Positions are in COLUMNS of FINALX

% UT = DATA.UNIQUETINTERVAL;
% X = DATA.FINALX; DATA = rmfield(DATA,'FINALX'); % gain memory
[T,N] = size(X); 

% see InterpFiltData 
% Filtering_and_Cutting
XF0 = X ;  % filtered data
XF = X;  % filtered data bring arround 0
DT = UT(2) - UT(1); % miliseconds
FREQ = ViconFrequency;
% FREQ = round(1 / DT); %FREQ = 57; 
CUTOFFFREQ = 5; %the maximum frequency of players in group is 6.45 rad/s <-> 1.03Hz
[b,a] = butter(2, 2 * CUTOFFFREQ / FREQ, 'low'); %filter

for n = 1 : N   
    XF0(:,n) = filtfilt(b,a,X(:,n)); %FiltPos = filtfilt(b,a,InterpPos'); 
    
    % Bring XF arround 0
    % Find inflexion points into XF(:,n)
    % Find linear interpolation of this points LIn
    % XF(:,n) = XF(:,n)-LIn
    xx = XF0(:,n);
    xx2 = gradient(gradient(xx));
    mx2 = max(abs(xx2));
    IIL = abs(xx2) < 0.01 * mx2;
    Xl = [xx(1);xx(IIL);xx(end)];
    Tl = [UT(1);UT(IIL);UT(end)];
    % [C,IA,IC] = unique(A) also returns index vectors IA and IC such that
    % C = A(IA) and A = C(IC) (or A(:) = C(IC), if A is a matrix or array).
    [Tl,IATl] = unique(Tl);
    Xl = Xl(IATl);
    XL = interp1(Tl,Xl,UT,'linear');
    z = any(isnan(XL));    
    XX = xx - XL;
    XF(:,n) = XX;
    
    if Parameters.Visu
        Parameters.nofig = 1; %Parameters.nofig + 1;
        figure(Parameters.nofig), clf
        ICOL = 1 : T;
        subplot(211)
        plot(UT(ICOL),xx(ICOL),'-k',Tl,Xl,'or',UT(ICOL),XL(ICOL),'-b')
        legend('xfilt','Inflexions','Interpol')
        title('Bring Signal Arround 0'), grid on
        subplot(212)
        plot(UT(ICOL),XX(ICOL),'-k')
        'wait'
    end
end

% Calculate PHASES
XPHASES = XF; 
for n =  1 : N 
    disp(n)
    protophase = co_hilbproto(XF(:,n));
    [phases,~,~] = co_fbtrT(protophase);  %in [0,2*pi[
    XPHASES(:,n) = phases;
    
    if Parameters.Visu
        Parameters.nofig = 1; %Parameters.nofig + 1;
        figure(Parameters.nofig), clf
        ICOL = 1 : T; 500;
        subplot(211)
        plot(UT(ICOL),X(ICOL,n),'-k',UT(ICOL),XF(ICOL,n),'-r'), legend('x','xfilt0')
        title('Positions'), grid on
        
        subplot(212)
        plot(UT(ICOL),protophase(ICOL),'-k',UT(ICOL),phases(ICOL),'-r'), legend('protoPH','PH')
        title('Phases'), grid on
        'wait'
    end
end

% DATA.XF = XF;
% DATA.PHASES = PHASES;
% DATA
% save('DATAXFILTPHASES.mat','DATA','XF','XPHASES')
