function Model = f_ContributionVariables(Model,SCENARIO)

% Model =          Name: 'EMOT_SINGLE'
%                     X: [234×458 double]
%                     Y: [234×1 double]
%                 SortY: [234×1 double]
%                  NOBS: 234
%                 NVAR0: 616
%             ABSINDCOL: [1×186 double]
%            ABSNAMEVAR: {1×186 cell}
%           NOTCONSTCOL: [1×616 logical]
%                  NVAR: 458
%                    MU: [1×458 double]
%                 SIGMA: [1×458 double]
%                 rankX: 233
%             pcaLatent: [233×1 double]
%              Inerties: [233×1 double]
%                    IL: [234×1 logical]
%                    IT: [234×1 logical]
%     FilterCoefficient: 0.0200
%           TargetError: 0.1200
%                Linear: [1×1 struct]
%          LinearFilter: [458×1 logical]
%                   NNZ: 186
%                    b0: -5.1110e-16
%                     b: [186×1 double]
%                    Xf: [234×186 double]
%                    yL: [234×1 double]
%                    yC: [234×1 double]
%                    E0: 0.0641
%                 CLASS: {[3×3 double]  [3×3 double]}

% Model.b0 = LIN.b0;
% Model.b = LIN.b(Model.LinearFilter);
% Model.Xf = X(:,Model.LinearFilter);
% Global_V;

GLOBAL_;

NGVAR = length(Model.ABSINDCOL);
Model.Xfactor = zeros(Model.NOBS,NGVAR);

IC = false(1,NGVAR);

for i = 1 : NGVAR
    b1 = (i-1) * NPDFBINS + 1; b2 = i * NPDFBINS; % NPDFBINS=77 see GLOBAL_
    % find coeffs of b into [b1, b2]
    II = and(Model.ABSINDCOL >= b1, Model.ABSINDCOL <= b2);
    if any(II)
        IC(i) = true;
        Model.Xfactor(:,i) = Model.Xf(:,II) * Model.b(II);
    end
end
Model.InfluentFeatureInd = IC;
Model.InfluentFeature = SCENARIO.features(IC)';

% Original Influent Gait Variables
% Model.FinalGaitVar = Model.VarNames(IC)';
Model.Xfactor = Model.Xfactor(:,IC);

% test
yy = Model.b0 + sum(Model.Xfactor,2);
errr = max(abs(Model.yL - yy));

Model.InfluentFinalVars = corr(Model.yL-Model.b0,Model.Xfactor)';
z = abs(Model.InfluentFinalVars);
Model.PercentInfluence = z/sum(z);

