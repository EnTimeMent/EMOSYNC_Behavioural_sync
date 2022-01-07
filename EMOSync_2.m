% EMOSync_2 : Calculates Features from Vicon LOCAL and UNIVERSAL axes

clear all, close all

GLOBAL_;
% Parameters
Parameters.Visu = false; %true; false;
Parameters.CalculateFeature = true; % false; true; 

% Create FEATURES structure - agile !

% ORIGINAL AXES - TRIAD FEATURES
Parameters.TriadFeature = false; true;
% x Parameters.FeatureName = 'Hand3TriangleOrientation';
% x Parameters.FeatureName = 'Hand3TriangleArea';
% x Parameters.FeatureName = 'TriadGaze';

% LOCALAXES
% x Parameters.FeatureName = 'HeadOrientation';
% x Parameters.FeatureName = 'HandOrientation';
% x Parameters.FeatureName = 'D3HandAngles'; % 3D angles of normal to triangle (LW,RW,H) with local axes
% x Parameters.FeatureName = 'D3ArmAngles'; % 3D angles of normal to trianble (S,E,H) with local axes
% x Parameters.FeatureName = 'AireTriangleSEH'; % aire of triangle shoulder, elbow, mi-wrist
% x Parameters.FeatureName = 'DistHeadHand'; % Euclidian distance Head / Hand
% x Parameters.FeatureName = 'Position'; % Of all points see global MARKERSNAMES
% x Parameters.FeatureName = 'Velocity';
% x Parameters.FeatureName = 'Acceleration';
% x Parameters.FeatureName = 'Jerk';
% x Parameters.FeatureName = 'QuantityOfMovement';

% Load the right data
if Parameters.TriadFeature
    % 0. Load Data
    D = load('DATA_1.mat'); % All data Group and Individual are here
    DATA = D.DATA; clear D
else
    D = load('DATALOCAL.mat'); % All data Group and Individual are here
    DATA = D.DATALOCAL; clear D
end

% Visualization Values
Parameters.YHeader = DATA.YHeader;
Parameters.Y = DATA.Y;
% Calculate Feature
if Parameters.CalculateFeature
    F = f_Features_1(DATA,Parameters);
    
    % Save in local directory
    namef = ['F_',Parameters.FeatureName,'.mat'];
    save(namef,'F')
    
    % Visualize Feature
%     f_VisualizeFeatures(F,Parameters)

end

% % Visualize and Explain each Feature
% if Parameters.Visu
%     namef = ['F_',Parameters.FeatureName,'.mat'];
%     D = load(namef);
%     F = D.F; clear D
%     f_VisualizeFeatures(F,Parameters)
% end