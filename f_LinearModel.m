function LIN = f_LinearModel(X,Y,y,nzeff,imin,P)

% Approximates y with b0 + b' * x 

Globals_L;

[n,d] = size(X); 
LIN.b0 = 0; LIN.b = zeros(d,1);
LIN.yL = zeros(n,1); LIN.ERR = 0;
LIN.NNZ = 0;

% LASSO learning
W = diag(P.W);
[B,S] = lasso(W * X, W * y);
B = [S.Intercept;B];

trials = length(S.Intercept);
FbL = [ones(n,1), X] * B;
FbL = f_PutFX2Boundsy(FbL);

ERRL = zeros(1,trials);
for k = 1 : trials
    fx = f_CastFX2Class(FbL(:,k));
    ERRL(k) = mean(fx ~= Y);
end

if P.Visu
    figure(1)
    subplot(221),plot(ERRL), title('Best CL error'), grid on
    subplot(222),plot(S.DF), title('Nb. of Features'), grid on
    subplot(223),plot(sqrt(S.MSE)), title('mse'), grid on
    nv = S.DF/ max(S.DF); mse = sqrt(S.MSE) / max(sqrt(S.MSE));
    subplot(224),plot(S.Intercept,':.g')%,zz,mse,':r',zz,z,':k'),
    title('b0'), grid on
end

% Calculate the Sparsest Model as function of TargetError (see Globals_L)
ITarget = ERRL <= TargetError; IZ = 1 : trials;
if any(ITarget)   
    IZ = IZ(ITarget);
else    
    IZ = IZ(ERRL == min(ERRL));
end
imin = IZ(end);

if isempty(imin)
    IZ = 1 : trials; IZ = IZ(S.DF <= nzeff); imin = IZ(1);
end

LIN.b0 = B(1,imin); LIN.b = B(2 : d + 1,imin);
LIN.yL = LIN.b0 + X * LIN.b;
LIN.yL = f_PutFX2Boundsy(LIN.yL);
LIN.clY = f_CastFX2Class(LIN.yL);
LIN.ERR =  mean(LIN.clY ~= Y);
LIN.NNZ = S.DF(imin);
LIN.ANALYSE.ERRL = ERRL;
LIN.ANALYSE.NBFEAT = S.DF;
LIN.ANALYSE.STD = sqrt(S.MSE);