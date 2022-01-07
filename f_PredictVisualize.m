function [stX,clX,ERRORS,CL] = f_PredictVisualize(X,y,Y,P)

% Predict Steatosis stX of X
% and Steatosis Class clX
% If observed stea y and clas Y are given return regression errors and
% confusion class matrices

stX = []; clX = [];  CL = {}; ERRORS = []; C = P.C;

% Coefficient of actual Learn/Test model
b0 = P.Linear.b0; b = P.Linear.b;
IL = P.IL; IT = P.IT;
XX = X(:,P.ICOL{3});
stX = b0 + XX * b; % predict all
stX = f_PutFX2Boundsy(stX);
clX = f_CastFX2Class(stX);

if ~isempty(Y)
    [CA,CIA,TA] = f_ConfusionMatrix(clX(P.IL),Y(P.IL),C);
    [CT,CIT,TT] = f_ConfusionMatrix(clX(P.IT),Y(P.IT),C);
    [CV,CIV,TV] = f_ConfusionMatrix(clX(P.IV),Y(P.IV),C);
    CL = {TA,TT,TV};
    ERR0 = mean(clX~=Y);
    ERL = mean(clX(P.IL)~=Y(P.IL));
    ERT = mean(clX(P.IT)~=Y(P.IT));
    ERV = mean(clX(P.IV)~=Y(P.IV));
    ERRORS = [ERR0, ERL,ERT,ERV];
    if P.Visu
        figure(5), clf
        subplot(221)
        ax = 1 : length(y);
        plot(ax,y,'.:r',ax,stX,'.:b')
        title('All Observations')
        legend('Observed','Predicted')
        ylabel('Steatosis'), grid on
        subplot(222)
        ax = 1 : sum(P.IL);
        plot(ax,y(P.IL),'.:r',ax,stX(P.IL),'.:b')
        title('Learn Observations')
        legend('Observed','Predicted')
        ylabel('Steatosis'), grid on
        subplot(223)
        ax = 1 : sum(P.IT);
        plot(ax,y(P.IT),'.:r',ax,stX(P.IT),'.:b')
        title('Test Observations')
        legend('Observed','Predicted')
        ylabel('Steatosis'), grid on
        subplot(224)
        ax = 1 : sum(P.IV);
        plot(ax,y(P.IV),'.:r',ax,stX(P.IV),'.:b')
        title('Validation Observations')
        legend('Observed','Predicted')
        ylabel('Steatosis'), grid on

    end
end

