% PRODUCE_REFMODEL_0

clear all, close all
Globals_L;
date = '19_06';
% 1. Load data
DDD = load('Model_REF0.mat');
X = DDD.X; y = DDD.y; Y = f_CastFX2Class(y);
XREFMean = DDD.XMEAN; XREFstd = DDD.XSTD;
XREFvars = DDD.XVARS; bREF0 = DDD.b0; bREF = DDD.b;

% TODO
% 1. Filter the b coefficients
% 2. Validate phase

MM = load(FiM,'PREDICT');
% Smooth x-values
X = f_SmoothX(X);

% Do models with increasing number of observations
NBMODELS = length(NBROWS);
PREDICT = cell(NBMODELS,2); % Col 1 : Raw Data; Col 2: Normalized Data

rng('default')
for nbm = 1 : NBMODELS
    
    inbm = 1 : NBROWS(nbm);
    Predict.X = X(inbm,:);
    Predict.y = y(inbm); Predict.Y = Y(inbm);
    
    for zsc = 1 : 2
                
        % Normalize or not
        Predict.Normalize = false;
        if zsc == 2, Predict.Normalize = true; end
        
        % 4. LEARN NEW MODEL
        Models2Select = cell(nSelectModel,1);
        ELT = zeros(nSelectModel,2); % Errors Learn / Test
        Predict.NOBS = length(Predict.y);
        
        for k = 1 : nSelectModel
            % Partition Learn (75%), Test (25%)
            Predict.IT = false(Predict.NOBS,1);
            r = rand(Predict.NOBS,1);
            Predict.IT(r < 0.25) = true;
            Predict.IL = not(Predict.IT);
            
            % Calculate Model for Given Work Data - TODO xx
            Predict = f_CalculateModel_03xx(Predict);            
            Models2Select{k} = Predict;
            ELT(k,:) = [Predict.ERRL,Predict.ERRT];
        end
        
        % Save in Suite of Models
        [m0,i0] = min(abs(ELT(:,1) - ELT(:,2)));
        Predict0 = Models2Select{i0}
        LearnConfMat = Predict0.CLASS{3,1}
        TestConfMat =  Predict0.CLASS{3,2}

        PREDICT{nbm,zsc} = Predict0;
    end
end
FiM = ['REF_PREDICT_',date,'.mat'];
save(FiM,'PREDICT');
toc


