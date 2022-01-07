% CreateLearnScenario
% 0. Given a question Q
% 1. Extract the matrices (X,y) ready to learn for answering Q
% !!! X contains blocks of NBINS (see GLOBAL_) columns
% X is concatenation of PFD matrices
% 2. Extract the x values of pdf
% 3. Extract the span of x values
% 4. Extract the names of Features and name of y

% Init
SCENARIO.Q = 'Detect_Emotions_Solo_Group';
SCENARIO.xpdf = []; SCENARIO.span = []; SCENARIO.X = [];
SCENARIO.features = {};
SCENARIO.namesfeatures = [];
SCENARIO.y = []; SCENARIO.namey = [];
SCENARIO.Y = []; SCENARIO.YHeader = [];

% 0. Load Y Data - in DATA_1 or DATALOCAL
Dx = load('DATALOCAL.mat'); % All data Group and Individual are here
% DATALOCAL.YHeader: {1×7 cell}; .Y: [819×7 double];
% .FileNames: {819×1 cell}; .VICON: {819×1 cell}
% Create y to PREDICT
% YHeader = {'Triad'}, {'Order'},{'NoGroupTrial'},{'NoIndividualTrial'},
% {'RELindex'},{'Person'},{'Emotion'}

SCENARIO.Y = Dx.DATALOCAL.Y; SCENARIO.YHeader = Dx.DATALOCAL.YHeader;
SCENARIO.y = SCENARIO.Y(:,7); SCENARIO.namey = SCENARIO.YHeader{7};

% LIST OF FEATURES
% ORIGINAL AXES - TRIAD FEATURES
% Parameters.TriadFeature = false; true;
% x Parameters.FeatureName = 'Hand3TriangleOrientation';
% x Parameters.FeatureName = 'Hand3TriangleArea';
% x Parameters.FeatureName = 'TriadGaze';
% LOCALAXES
% x Parameters.FeatureName = 'HeadOrientation';
% x Parameters.FeatureName = 'HandOrientation';
% x Parameters.FeatureName = 'D3HandAngles'; % 3D angles of normal to triangle (LW,RW,H) with local axes
% x Parameters.FeatureName = 'D3ArmAngles'; % 3D angles of normal to trianble (S,E,H) with local axes
% x Parameters.FeatureName = 'AireTriangleSEH'; % airemin / aire of triangle shoulder, elbow, mi-wrist
% x Parameters.FeatureName = 'DistHeadHand'; % Euclidian distance Head / Hand
% x Parameters.FeatureName = 'Position'; % Of all points see global MARKERSNAMES
% x Parameters.FeatureName = 'Velocity';
% x Parameters.FeatureName = 'NormVelocity';
% x Parameters.FeatureName = 'Acceleration';
% x Parameters.FeatureName = 'NormAcceleration';
% x Parameters.FeatureName = 'Jerk';
% x Parameters.FeatureName = 'QuantityOfMovement';
% x Parameters.FeatureName = 'QuantityOfMovementCamurri';
% x Parameters.FeatureName = 'ContractionIndexCamurri';

% Create X - predicting features  - agile !

% % 1.
% Parameters.FeatureName = 'HeadOrientation';
% Dx = load(['F_',Parameters.FeatureName,'.mat']); F = Dx.F
% % F =        VALUES: {819×1 cell}
% %              SPAN: {[2×1 double]}
% %              XPDF: {[1×77 double]}
% %               PDF: {[819×77 double]}
% %     FEATURESNAMES: {{1×77 cell}}
% x = F.XPDF{1}; s = F.SPAN{1}; nf = F.FEATURESNAMES{1}; X = F.PDF{1};
% % Update SCENARIO
% SCENARIO.features = [SCENARIO.features,Parameters.FeatureName];
% SCENARIO.xpdf = [SCENARIO.xpdf,x];
% SCENARIO.span = [SCENARIO.span,s];
% SCENARIO.X = [SCENARIO.X,X]; 
% SCENARIO.namesfeatures = [SCENARIO.namesfeatures,nf];

% % 2.
% Parameters.FeatureName = 'HandOrientation';
% Dx = load(['F_',Parameters.FeatureName,'.mat']); F = Dx.F
% % F =        VALUES: {819×1 cell}
% %              SPAN: {[2×1 double]}
% %              XPDF: {[1×77 double]}
% %               PDF: {[819×77 double]}
% %     FEATURESNAMES: {{1×77 cell}}
% x = F.XPDF{1}; s = F.SPAN{1}; nf = F.FEATURESNAMES{1}; X = F.PDF{1};
% % Update SCENARIO
% SCENARIO.features = [SCENARIO.features,Parameters.FeatureName];
% SCENARIO.xpdf = [SCENARIO.xpdf,x];
% SCENARIO.span = [SCENARIO.span,s];
% SCENARIO.X = [SCENARIO.X,X]; 
% SCENARIO.namesfeatures = [SCENARIO.namesfeatures,nf];

% 3. 
% Parameters.FeatureName = 'D3HandAngles'; % cosines of Normal to Hand LW, RW
% Dx = load(['F_',Parameters.FeatureName,'.mat']); F = Dx.F
% x = F.XPDF{1}; s = F.SPAN{1}; nf = F.FEATURESNAMES{1}; X = F.PDF{1};
% % % 3 blocks of 77 columns on X, Y, Z - can choose a block
% % Update SCENARIO
% SCENARIO.features = [SCENARIO.features,Parameters.FeatureName];
% SCENARIO.xpdf = [SCENARIO.xpdf,x];
% SCENARIO.span = [SCENARIO.span,s];
% SCENARIO.X = [SCENARIO.X,X]; 
% SCENARIO.namesfeatures = [SCENARIO.namesfeatures,nf];

% 4.
% Parameters.FeatureName = 'D3ArmAngles'; % cosines of Normal to S E, H
% Dx = load(['F_',Parameters.FeatureName,'.mat']); F = Dx.F
% x = F.XPDF{1}; s = F.SPAN{1}; nf = F.FEATURESNAMES{1}; X = F.PDF{1};
% % % 3 blocks of 77 columns on X, Y, Z - can choose a block
% % Update SCENARIO
% SCENARIO.features = [SCENARIO.features,Parameters.FeatureName];
% SCENARIO.xpdf = [SCENARIO.xpdf,x];
% SCENARIO.span = [SCENARIO.span,s];
% SCENARIO.X = [SCENARIO.X,X]; 
% SCENARIO.namesfeatures = [SCENARIO.namesfeatures,nf];

% % 5.
% Parameters.FeatureName = 'AireTriangleSEH'; % Area of triangle S E H
% Dx = load(['F_',Parameters.FeatureName,'.mat']); F = Dx.F
% x = F.XPDF{1}; s = F.SPAN{1}; nf = F.FEATURESNAMES{1}; X = F.PDF{1};
% % Update SCENARIO
% SCENARIO.features = [SCENARIO.features,Parameters.FeatureName];
% SCENARIO.xpdf = [SCENARIO.xpdf,x];
% SCENARIO.span = [SCENARIO.span,s];
% SCENARIO.X = [SCENARIO.X,X]; 
% SCENARIO.namesfeatures = [SCENARIO.namesfeatures,nf];

% % 6.
% Parameters.FeatureName = 'DistHeadHand'; % Euclidian distance Head / Hand
% Dx = load(['F_',Parameters.FeatureName,'.mat']); F = Dx.F
% x = F.XPDF{1}; s = F.SPAN{1}; nf = F.FEATURESNAMES{1}; X = F.PDF{1};
% % Update SCENARIO
% SCENARIO.features = [SCENARIO.features,Parameters.FeatureName];
% SCENARIO.xpdf = [SCENARIO.xpdf,x];
% SCENARIO.span = [SCENARIO.span,s];
% SCENARIO.X = [SCENARIO.X,X]; 
% SCENARIO.namesfeatures = [SCENARIO.namesfeatures,nf];

% 7.
% Parameters.FeatureName = 'Position'; % Of all points see global MARKERSNAMES
% Dx = load(['F_',Parameters.FeatureName,'.mat']); F = Dx.F
% % 9 cells 1 for each MARKER - can select particular marker
% % For each marker - 3 blocks of 77 values X, Y, Z
% % MARKERSNAMES = {'R_head'; 'L_head'; 'R_shoulder'; ...
% %                 'R_elbow'; 'R_wrist'; 'L_wrist';'Hand';...
% %                 'RUPA'; 'RARM'};
% % F =        VALUES: {819×9 cell}
% %              SPAN: {1×9 cell}
% %              XPDF: {1×9 cell}
% %               PDF: {1×9 cell}
% %     FEATURESNAMES: {1×9 cell}
% imarker = 7; % Hand
% x = F.XPDF{imarker}; s = F.SPAN{imarker};
% nf = F.FEATURESNAMES{imarker}; X = F.PDF{imarker};
% % Update SCENARIO
% SCENARIO.xpdf = [SCENARIO.xpdf,x];
% SCENARIO.span = [SCENARIO.span,s];
% SCENARIO.X = [SCENARIO.X,X]; 
% SCENARIO.namesfeatures = [SCENARIO.namesfeatures,nf];

% % 8.
% Parameters.FeatureName = 'Velocity'; % Of all points see global MARKERSNAMES
% Dx = load(['F_',Parameters.FeatureName,'.mat']); F = Dx.F
% % 9 cells 1 for each MARKER
% % For each marker - 3 blocks of 77 values X, Y, Z
% % !! can select particular marker and particular block X, Y, Z of it
% % MARKERSNAMES = {'R_head'; 'L_head'; 'R_shoulder'; ...
% %                 'R_elbow'; 'R_wrist'; 'L_wrist';'Hand';...
% %                 'RUPA'; 'RARM'};
% % F =        VALUES: {819×9 cell}
% %              SPAN: {1×9 cell}
% %              XPDF: {1×9 cell}
% %               PDF: {1×9 cell}
% %     FEATURESNAMES: {1×9 cell}
% imarker = 7; namemarker = MARKERSNAMES{imarker}; % Hand z = [z,['b'],['c']]
% x = F.XPDF{imarker}; s = F.SPAN{imarker};
% nf = F.FEATURESNAMES{imarker}; X = F.PDF{imarker};
% % Update SCENARIO
% % TODO: Put here namemarker_X, namemarker_Y, namemarker_Z
% SCENARIO.features = [SCENARIO.features,Parameters.FeatureName];
% SCENARIO.xpdf = [SCENARIO.xpdf,x];
% SCENARIO.span = [SCENARIO.span,s];
% SCENARIO.X = [SCENARIO.X,X]; 
% SCENARIO.namesfeatures = [SCENARIO.namesfeatures,nf];

% 8x
Parameters.FeatureName = 'NormVelocity';
Dx = load(['F_',Parameters.FeatureName,'.mat']); F = Dx.F
% 9 cells 1 for each MARKER
% For each marker - 3 blocks of 77 values X, Y, Z
% !! can select particular marker and particular block X, Y, Z of it
% MARKERSNAMES = {'R_head'; 'L_head'; 'R_shoulder'; ...
%                 'R_elbow'; 'R_wrist'; 'L_wrist';'Hand';...
%                 'RUPA'; 'RARM'};
% F =        VALUES: {819×9 cell}
%              SPAN: {1×9 cell}
%              XPDF: {1×9 cell}
%               PDF: {1×9 cell}
%     FEATURESNAMES: {1×9 cell}

imarker = 7; namemarker = MARKERSNAMES{imarker}; % Hand z = [z,['b'],['c']]
x = F.XPDF{imarker}; s = F.SPAN{imarker};
nf = F.FEATURESNAMES{imarker}; X = F.PDF{imarker};

% % [N,~] = size(SCENARIO.Y); [T,~] = size(F.VALUES{1,1});
% % NORMVELOC = zeros(N,T);
% % for n = 1 : N
% %     row = F.VALUES{n,imarker}';     lrow = length(row);
% %     disp([n,size(row)]);   NORMVELOC(n,1:lrow) = row;
% % end

% Update SCENARIO
% TODO: Put here namemarker_X, namemarker_Y, namemarker_Z
SCENARIO.VALUE = F.VALUES(:,imarker);
SCENARIO.features = [SCENARIO.features,[Parameters.FeatureName,'_',namemarker]];
SCENARIO.xpdf = [SCENARIO.xpdf,x];
SCENARIO.span = [SCENARIO.span,s];
SCENARIO.X = [SCENARIO.X,X]; 
SCENARIO.namesfeatures = [SCENARIO.namesfeatures,nf];

% % 9.
% Parameters.FeatureName = 'Acceleration'; % Of all points see global MARKERSNAMES
% Dx = load(['F_',Parameters.FeatureName,'.mat']); F = Dx.F
% % 9 cells 1 for each MARKER - can select particular marker
% % For each marker - 3 blocks of 77 values X, Y, Z
% % MARKERSNAMES = {'R_head'; 'L_head'; 'R_shoulder'; ...
% %                 'R_elbow'; 'R_wrist'; 'L_wrist';'Hand';...
% %                 'RUPA'; 'RARM'};
% % F =        VALUES: {819×9 cell}
% %              SPAN: {1×9 cell}
% %              XPDF: {1×9 cell}
% %               PDF: {1×9 cell}
% %     FEATURESNAMES: {1×9 cell}
% imarker = 7; namemarker = MARKERSNAMES{imarker}; % Hand
% x = F.XPDF{imarker}; s = F.SPAN{imarker};
% nf = F.FEATURESNAMES{imarker}; X = F.PDF{imarker};
% % Update SCENARIO
% SCENARIO.features = [SCENARIO.features,[Parameters.FeatureName,'_',namemarker]];
% SCENARIO.xpdf = [SCENARIO.xpdf,x];
% SCENARIO.span = [SCENARIO.span,s];
% SCENARIO.X = [SCENARIO.X,X]; 
% SCENARIO.namesfeatures = [SCENARIO.namesfeatures,nf];

% % 9x
% Parameters.FeatureName = 'NormAcceleration';
% Dx = load(['F_',Parameters.FeatureName,'.mat']); F = Dx.F
% % 9 cells 1 for each MARKER
% % For each marker - 3 blocks of 77 values X, Y, Z
% % !! can select particular marker and particular block X, Y, Z of it
% % MARKERSNAMES = {'R_head'; 'L_head'; 'R_shoulder'; ...
% %                 'R_elbow'; 'R_wrist'; 'L_wrist';'Hand';...
% %                 'RUPA'; 'RARM'};
% % F =        VALUES: {819×9 cell}
% %              SPAN: {1×9 cell}
% %              XPDF: {1×9 cell}
% %               PDF: {1×9 cell}
% %     FEATURESNAMES: {1×9 cell}
% 
% imarker = 7; namemarker = MARKERSNAMES{imarker}; % Hand z = [z,['b'],['c']]
% x = F.XPDF{imarker}; s = F.SPAN{imarker};
% nf = F.FEATURESNAMES{imarker}; X = F.PDF{imarker};
% % 
% % [N,~] = size(SCENARIO.Y); [T,~] = size(F.VALUES{1,1}); NORMACCEL = zeros(N,T);
% % for n = 1 : N
% %     row = F.VALUES{n,imarker}'; lrow = length(row);
% %     disp([n,size(row)]); NORMACCEL(n,1:lrow) = row;
% % end
% 
% % Update SCENARIO
% % TODO: Put here namemarker_X, namemarker_Y, namemarker_Z
% SCENARIO.features = [SCENARIO.features,[Parameters.FeatureName,'_',namemarker]];
% SCENARIO.xpdf = [SCENARIO.xpdf,x];
% SCENARIO.span = [SCENARIO.span,s];
% SCENARIO.X = [SCENARIO.X,X]; 
% SCENARIO.namesfeatures = [SCENARIO.namesfeatures,nf];

% % 10.
% Parameters.FeatureName = 'Jerk'; % Of all points see global MARKERSNAMES
% Dx = load(['F_',Parameters.FeatureName,'.mat']); F = Dx.F
% % 9 cells 1 for each MARKER - can select particular marker
% % For each marker - 3 blocks of 77 values X, Y, Z
% % MARKERSNAMES = {'R_head'; 'L_head'; 'R_shoulder'; ...
% %                 'R_elbow'; 'R_wrist'; 'L_wrist';'Hand';...
% %                 'RUPA'; 'RARM'};
% % F =        VALUES: {819×9 cell}
% %              SPAN: {1×9 cell}
% %              XPDF: {1×9 cell}
% %               PDF: {1×9 cell}
% %     FEATURESNAMES: {1×9 cell}
% imarker = 7; namemarker = MARKERSNAMES{imarker}; % Hand
% x = F.XPDF{imarker}; s = F.SPAN{imarker};
% nf = F.FEATURESNAMES{imarker}; X = F.PDF{imarker};
% % Update SCENARIO
% SCENARIO.features = [SCENARIO.features,[Parameters.FeatureName,'_',namemarker]];
% SCENARIO.xpdf = [SCENARIO.xpdf,x];
% SCENARIO.span = [SCENARIO.span,s];
% SCENARIO.X = [SCENARIO.X,X]; 
% SCENARIO.namesfeatures = [SCENARIO.namesfeatures,nf];

% % 11.
% Parameters.FeatureName = 'QuantityOfMovement'; % Of all points see global MARKERSNAMES
% Dx = load(['F_',Parameters.FeatureName,'.mat']); F = Dx.F
% % 9 cells 1 for each MARKER - can select particular marker
% % For each marker - 3 blocks of 77 values X, Y, Z
% % MARKERSNAMES = {'R_head'; 'L_head'; 'R_shoulder'; ...
% %                 'R_elbow'; 'R_wrist'; 'L_wrist';'Hand';...
% %                 'RUPA'; 'RARM'};
% % F =        VALUES: {819×9 cell}
% %              SPAN: {1×9 cell}
% %              XPDF: {1×9 cell}
% %               PDF: {1×9 cell}
% %     FEATURESNAMES: {1×9 cell}
% imarker = 7; namemarker = MARKERSNAMES{imarker}; % Hand
% x = F.XPDF{imarker}; s = F.SPAN{imarker};
% nf = F.FEATURESNAMES{imarker}; X = F.PDF{imarker};
% % Update SCENARIO
% SCENARIO.features = [SCENARIO.features,[Parameters.FeatureName,'_',namemarker]];
% SCENARIO.xpdf = [SCENARIO.xpdf,x];
% SCENARIO.span = [SCENARIO.span,s];
% SCENARIO.X = [SCENARIO.X,X]; 
% SCENARIO.namesfeatures = [SCENARIO.namesfeatures,nf];

% % 13. 
% Parameters.FeatureName = 'QuantityOfMovementCamurri';
% Dx = load(['F_',Parameters.FeatureName,'.mat']); F = Dx.F
% x = F.XPDF{1}; s = F.SPAN{1}; nf = F.FEATURESNAMES{1}; X = F.PDF{1};
% % Update SCENARIO
% SCENARIO.features = [SCENARIO.features,Parameters.FeatureName];
% SCENARIO.xpdf = [SCENARIO.xpdf,x];
% SCENARIO.span = [SCENARIO.span,s];
% SCENARIO.X = [SCENARIO.X,X]; 
% SCENARIO.namesfeatures = [SCENARIO.namesfeatures,nf];
% 
% % 14. 
% Parameters.FeatureName = 'ContractionIndexCamurri';
% Dx = load(['F_',Parameters.FeatureName,'.mat']); F = Dx.F
% x = F.XPDF{1}; s = F.SPAN{1}; nf = F.FEATURESNAMES{1}; X = F.PDF{1};
% % Update SCENARIO
% SCENARIO.features = [SCENARIO.features,Parameters.FeatureName];
% SCENARIO.xpdf = [SCENARIO.xpdf,x];
% SCENARIO.span = [SCENARIO.span,s];
% SCENARIO.X = [SCENARIO.X,X]; 
% SCENARIO.namesfeatures = [SCENARIO.namesfeatures,nf];

SCENARIO
% Save SCENARIO in local directory
nameS = [SCENARIO.NAME,'.mat'];
save(nameS,'SCENARIO')
