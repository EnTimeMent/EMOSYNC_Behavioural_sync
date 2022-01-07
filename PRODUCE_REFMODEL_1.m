% PRODUCE_REFMODEL_1

clear all, close all
Globals_L; date = '29_06'; tic

% 0. Load data
DDD = load('Model_REF0.mat');
X = DDD.X; y = DDD.y; Y = f_CastFX2Class(y);
XREFMean = DDD.XMEAN; XREFstd = DDD.XSTD;
XREFvars = DDD.XVARS; bREF0 = DDD.b0; bREF = DDD.b;


% 1. First Traitments, Anomalies (identical x and ~= y)
[X,y] = f_FirstStats(X,y);




% 2. Smooth x-values
X = f_SmoothX(X); N = numel(Y); P.C = unique(Y);
rng('default'); % in order to reproduce results
% Normalize or not
P.Normalize = false;

% 3. LEARN NEW MODEL
nSelectModel = 40;
Models2Select = cell(nSelectModel,1);
ELT = zeros(nSelectModel,4); % Errors All / Learn / Test / Valid

for k = 1 : nSelectModel
    
    % Leave-25%-OUT, Learn (50%), Test (25%), Valid (25%)
    r = rand(N,1);
    P.IL = r < 0.5; P.IT = r >= 0.75;
    P.IV = and(r>=0.5, r < 0.75);
    
    % ILT
    ILT = or(P.IL,P.IT);
    P.X = X(ILT,:); P.y = y(ILT); P.Y = Y(ILT);
    P.NOBS = length(P.y);
    
%     % Inertie
%     [~,~,latent,~,Inertie,~] = pca(P.X); % without const cols
%     P.rankX = rank(P.X); P.pcaLatent = latent;
%     P.Inerties = cumsum(Inertie);
    P.rankX = rank(P.X);
    % Calculate Predicting Model for Given Work Data - ILT
    P.Visu = false;
    P = f_CalculateModel_03xx(P);
    
    % Validation phase
    [stX,clX,ERRORS,CL] = f_PredictVisualize(X,y,Y,P);
    ELT(k,:) = ERRORS;
    P.CL = CL;
    Models2Select{k} = P;    
end

% Save in Suite of Models
disp(ELT)
[m0,i0] = min(ELT(:,4)); %min(abs(ELT(:,1) - ELT(:,2)));
PREDICT = Models2Select{i0};
PREDICT.Visu = true;
[stX,clX,ERRORS,CL] = f_PredictVisualize(X,y,Y,PREDICT);

FiM = ['REF_PREDICT_',date,'.mat'];
save(FiM,'PREDICT','Models2Select','ELT');
toc