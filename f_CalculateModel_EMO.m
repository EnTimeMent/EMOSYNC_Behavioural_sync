function Model = f_CalculateModel_EMO(Model)

% ...

% Input
% Model =          Name: 'EMOT_SINGLE'
%                     X: [234×458 double]
%                     Y: [234×1 double]
%                 SortY: [234×1 double]
%                  NOBS: 234
%                 NVAR0: 616
%             ABSINDCOL: [1×458 double]
%            ABSNAMEVAR: {1×458 cell}
%           NOTCONSTCOL: [1×616 logical]
%                  NVAR: 458
%                    MU: [1×458 double]
%                 SIGMA: [1×458 double]
%                 rankX: 233
%             pcaLatent: [233×1 double]
%              Inerties: [233×1 double]
%                    IL: [234×1 logical]
%                    IT: [234×1 logical]
%     FilterCoefficient: 1.0000e-05
    
GLOBAL_;

Y = Model.Y; y = Y; C = unique(Y); NOBS = Model.NOBS;

X = Model.X; [n,m] = size(X);
ICOL = true(1,m);
ABSINDCOL = Model.ABSINDCOL; NV = numel(ABSINDCOL);
ABSNAMEVAR = Model.ABSNAMEVAR;

% No Const Cols here, done in f_FirstStats
% Sparse Linear
IL = Model.IL; NZEffL = sum(IL);
Param.NmaxVariables = n;
Param.NMaxSparseVariables = n; %sum(IL);
Param.PercentWeakCoefficients = 0.1;
Param.TargetClassError = 0.01; Model.TargetError;
Param.Visualization = true;

LIN = f_LinearModelEMO(X,Y,y,Param);
Model.Linear = LIN;

% Linear Filter of columns
nofig = Parameters.nofig;
if Param.Visualization
    nofig = nofig + 1; figure(nofig), clf
    subplot(211), stem(LIN.b)
    xlabel('No Feature'), ylabel('Lasso Coefficients')
    subplot(212), histogram(LIN.b,101)
    xlabel('Lasso Coefficients'), ylabel('pdf')
end

bmax = max(abs(LIN.b)); seuil = Model.FilterCoefficient * bmax;
Model.LinearFilter = abs(LIN.b) > seuil;
Model.NNZ = sum(Model.LinearFilter);
LIN.b(not(Model.LinearFilter)) = 0;

Model.ABSINDCOL  = ABSINDCOL(Model.LinearFilter);
Model.ABSNAMEVAR = ABSNAMEVAR(Model.LinearFilter);
Model.b0 = LIN.b0;
Model.b = LIN.b(Model.LinearFilter);
Model.Xf = X(:,Model.LinearFilter);

% Test
yl = Model.b0 + Model.Xf * Model.b;
cyl = f_CastFX2Class(yl,EMOTHRESHOLDS,C);
Model.yL = yl; Model.yC = cyl;
Model.E0 = mean(Y ~= cyl); % Overall Error

[CA,CIA] = f_ConfusionMatrix(cyl(Model.IL),Y(Model.IL),C);
[CT,CIT] = f_ConfusionMatrix(cyl(Model.IT),Y(Model.IT),C);

% disp([CA,CT,CA+CT]),% ,CP
Model.CLASS = {CA, CT};% CIA,CIT};
