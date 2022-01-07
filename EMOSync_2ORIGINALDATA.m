% EMOSync_2DATA : Calculate sile Features from Vicon NONLOCAL Data

clear all, close all

GLOBAL_;

% Parameters
Parameters.Visu = true; false; 
Parameters.CalculateFeature = true; % false; true; 

% Create FEATURES structure - agile !

% ORIGINAL AXES
Parameters.TriadFeature = true;
Parameters.FeatureName = 'Hand3TriangleOrientation';
% Parameters.FeatureName = 'Hand3TriangleArea';
% Parameters.FeatureName = 'TriadGaze';
% LOCALAXES
% Parameters.TriadFeature = false;
% Parameters.FeatureName = 'HeadOrientation';
% Parameters.FeatureName = 'HandOrientation';
% Parameters.FeatureName = 'D3HandAngles'; % 3D angles of normal to triangle (LW,RW,H) with local axes
% Parameters.FeatureName = 'D3ArmAngles'; % 3D angles of normal to trianble (S,E,H) with local axes
% Parameters.FeatureName = 'AireTriangleSEH'; % aire of triangle shoulder, elbow, mi-wrist
% Parameters.FeatureName = 'DistHeadHand'; % Euclidian distance Head / Hand
% Parameters.FeatureName = 'Position'; % Of all points see global MARKERSNAMES
% Parameters.FeatureName = 'Velocity';
% Parameters.FeatureName = 'Acceleration';
% Parameters.FeatureName = 'Jerk';
% Parameters.FeatureName = 'QuantityOfMovement';

% Load the right data
if Parameters.TriadFeature
    % 0. Load Data
    D = load('DATA_1.mat'); % All data Group and Individual are here
    DATA = D.DATA; clear D
else
    D = load('DATALOCAL.mat'); % All data Group and Individual are here
    DATA = D.DATALOCAL; clear D
end

% Calculate Feature
if Parameters.CalculateFeature
    F = f_Features_1(DATA,Parameters);
    
    % Visualize Feature
    f_VisualizeFeatures(F,Parameters)
    % Save in local directory
    namef = ['F_',Parameters.FeatureName,'.mat'];
    save(namef,'F')
end

% Visualize and Explain each Feature
if Parameters.Visu
    namef = ['F_',Parameters.FeatureName,'.mat'];
    D = load(namef);
    F = D.F; clear D
    f_VisualizeFeatures(F,Parameters)
end

% figure(7),
% V7 = F.VALUES{7};
% [T,d] = size(V7); ax = (1 : T)'; thres = zeros(T,1) + cos(pi/6);
% subplot(311),plot(ax,V7(:,1),'-r',ax,V7(:,2),'-k',ax,thres,':k'), grid on
% subplot(312),plot(ax,V7(:,3),'-r',ax,V7(:,4),'-k',ax,thres,':k'), grid on
% subplot(313),plot(ax,V7(:,5),'-r',ax,V7(:,6),'-k',ax,thres,':k'), grid on
% figure(7),
% subplot(211),plot(F.XPDF{1},F.PDF{1}(7,:))
% subplot(212),plot(F.VALUES{7}/10000)