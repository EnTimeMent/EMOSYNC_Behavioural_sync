% GLOBALS_MV.m : Contains Global Variables for MV_SIGN project

global NBSUBJ;  NBSUBJ = 45;
global NBWEEKS; NBWEEKS = 3;
global NBTRIAL; NBTRIAL = 3;
ix = [1 : 3 : 21]'; 
global IndColsXYZ; IndColsXYZ = [ix, ix + 1, ix + 2];
global HEIGHT; HEIGHT = 1960;
global WIDTH; WIDTH = 490;
global TMAX; TMAX = 2999; % maximal number of samples per trial
global PDFNBPOINTS; PDFNBPOINTS = 100;
global nblocks; nblocks = 6;
global BLOCKS; BLOCKS = zeros(6,2); z = [-99,0];
for k = 1 : nblocks, z = z + PDFNBPOINTS; BLOCKS(k,:) = z; end

global NAMEPOINTS; NAMEPOINTS = {'Head', 'Neck', 'Shoulder', 'Hip', 'Knee', 'Ankle', 'Toe'};
global IND;
IND.Head = [1 : 3];
IND.Neck = IND.Head + 3;
IND.Shoulder = IND.Neck + 3;
IND.Hip = IND.Shoulder + 3;
IND.Knee = IND.Hip + 3;
IND.Ankle = IND.Knee + 3;
IND.Toe = IND.Ankle + 3;

global PARTITION; PARTITION = zeros(NBSUBJ * NBWEEKS * NBTRIAL,1);
% Create Learn, Test and Projection Bases
% For each subject 1 : 25
% Matrices 1, 3, 5, 7, 9 - goto Learn; 2, 6 - goto Test; 4, 8 - goto Proj
part = zeros(9,1); part([2,6]) = 1; part([4,8]) = 2; 
PARTITION = repmat(part,NBSUBJ,1);

global Y; s = zeros(NBWEEKS * NBTRIAL, 1); Y = [];
for k = 1 : NBSUBJ, s = s + 1; Y = [Y; s]; end

global Parameters;
Parameters.VisuSuccPositions = false; %true;
Parameters.EpsiFilter0 = 2e-4; % Epsi Application
Parameters.NbSparseIterations = 4759; % NIter: 4759 ELEV
Parameters.Points = NAMEPOINTS; % {'Head', 'Neck', 'Shoulder', 'Hip', 'Knee', 'Ankle', 'Toe'};
Parameters.BinPoints = [1,1,1,1,1,1,1]; % All Points are used
Parameters.xyz = [true, false, true];
Parameters.IndColsXYZ = IndColsXYZ(:,Parameters.xyz);
Parameters.CoarseTime = 20; % - k x 100[ms] - each k time-rows from SWT matrix
Parameters.Height = HEIGHT; % Normalized Height
Parameters.DeltaHeight = 4; % Position [mm / 6ms]
Parameters.Width0 = WIDTH; % Position [mm / 6ms]
Parameters.DeltaWidth0 = 4; % Position [mm / 6ms]
Parameters.Width1 = 20; Parameters.DeltaWidth1 = 20/20; % Speed [mm/s]
Parameters.Width2 = 2;  Parameters.DeltaWidth2 = 2/20; % Acceleration [mm/s^2]
Parameters.Width3 = 0.2; Parameters.DeltaWidth3 = 0.2/20; % Jerk [mm/s^3]
Parameters.WhatToCalculate = [1,0,0,0;   % Pos, Spe, Acc, Jer
                              1,1,1,1];  % Densities of these