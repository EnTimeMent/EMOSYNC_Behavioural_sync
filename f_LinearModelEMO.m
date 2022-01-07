function LIN = f_LinearModelEMO(X,Y,y,Param)

% Approximates Y with b0 + X * b sparse
% Approximate continuous y that is cast to classes Y
% Input
% X, Y, y - Features matrix X, Class Y, continuous y
% Param.NmaxVariables = n; nb of X rows
% Param.NMaxSparseVariables = nb of learn rows
% Param.PercentWeakCoefficients = 0.1; % kill this % of max value
% Param.TargetClassError ; attain this classification error
% Param.Visualization = true;
% Param.nofig = 0;

GLOBAL_;

C = unique(Y); NC = length(C);
[n,d] = size(X); b00 = mean(y);
LIN.b0 = 0; LIN.b = zeros(d,1);
LIN.yL = zeros(n,1); LIN.ERR = 0;
LIN.NNZ = 0;

% DO Sparse Learning
nzmax = Param.NMaxSparseVariables;
[B,S] = lasso(X,y,'DFmax',nzmax); 
B = [S.Intercept;B];

nofig = Parameters.nofig;
if Param.Visualization
    nofig = nofig + 1; figure(nofig), clf
    subplot(311), plot(S.MSE), title('MSE'), grid on    
    subplot(312), plot(S.DF), title('Nb of Features'), grid on
    subplot(313), plot(S.Intercept), title('b0'), grid on
end

trials = length(S.Intercept);
FbL = [ones(n,1), X] * B;
% FbL = f_PutFX2Boundsy(FbL,C(1),C(NC));

ERRL = zeros(1,trials); t = EMOTHRESHOLDS;
for k = 1 : trials
    Fk = f_CastFX2Class(FbL(:,k),EMOTHRESHOLDS,C); 
    ERRL(k) = mean(Fk ~= Y);
end

if Param.Visualization
    nofig = nofig + 1; figure(nofig), clf    
    plot(ERRL), grid on
    title('Classification errors'), xlabel('Lambda indices'), ylabel('Errors')
end

% Calculate the Sparsest Model as function of Param.TargetClassError
ITarget = ERRL <= Param.TargetClassError; IZ = 1 : trials;
if any(ITarget)   
    IZ = IZ(ITarget);
else    
    IZ = IZ(ERRL == min(ERRL));
end
imin = IZ(end);
imin = 1;

% if isempty(imin)
%     IZ = 1 : trials; IZ = IZ(S.DF <= nzeff); imin = IZ(1);
% end
LIN.b0 = B(1,imin); LIN.b = B(2 : d + 1,imin);
LIN.yL = LIN.b0 + X * LIN.b;
% LIN.yL = f_PutFX2Boundsy(LIN.yL,C(1),C(NC));
%
clY = zeros(n,1);
LIN.clY = f_CastFX2Class(LIN.yL,EMOTHRESHOLDS,C);   

if Param.Visualization
    nofig = nofig + 1; figure(nofig), ax = 1 : n;
    subplot(311),plot(ax,LIN.yL,':k',ax,Y,'-r')
    subplot(312),plot(ax,LIN.clY,':k',ax,Y,'-r')
    subplot(313), histogram(LIN.yL,101)
end
Parameters.nofig = nofig;

LIN.ERR =  mean(LIN.clY ~= Y);
LIN.NNZ = S.DF(imin);
LIN.ANALYSE.ERRL = ERRL;
LIN.ANALYSE.NBFEAT = S.DF;
LIN.ANALYSE.STD = sqrt(S.MSE);
