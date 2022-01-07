% EMOSync_2 : Calculate Features from Vicon Data
% 1. Data are in local coordinates and normalized HEIGHT = 1800 mm
% 2. Calculate Features (see ListFeatures structure) and their span
% 3. Calculate pdf for each feature
% 4. Put these pdf into a FEATURES matrix ready to learn

clear all, close all

GLOBAL_;

% % 0. Load Data
% D = load('DATA_1.mat'); % All data Group and Individual are here
% DATA = D.DATA; clear D

% Parameters
Parameters.Visu = false; true;
% VL = f_Transform2LocalCoord(DATA, Parameters); % Vicon Local
% DATALOCAL = DATA; DATALOCAL.VICON = VL;
% save('DATALOCAL.mat','DATALOCAL')

D = load('DATALOCAL.mat'); % All data Group and Individual are here
DATALOCAL = D.DATALOCAL; clear D
% DATA = YHeader: {1×7 cell} ; Y: [819×7 double]; FileNames: {819×1 cell}
%         VICON: {819×1 cell}

Parameters.XYZ = [true,true,true]; % Work on XYZ space

% Create FEATURES structure - agile !
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
Parameters.FeatureName = 'QuantityOfMovement';
   
% Calculate Feature
F = f_Features_1(DATALOCAL,Parameters)
% F =            VALUES: {819×1 cell}
%              SPAN: [2×1 double]; XPDF: [1×77 double]
%     FEATURESNAMES: {1×77 cell}; PDF: [819×77 double]

figure(7), plot(F.XPDF{1},F.PDF{1}(7,:))

% Save in local directory
namef = ['F_',Parameters.FeatureName,'.mat'];
save(namef,'F')
