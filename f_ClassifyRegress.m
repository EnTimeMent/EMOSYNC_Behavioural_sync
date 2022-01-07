function SVModel = f_ClassifyRegress(XA,YA,XT,YT,Flag)

% Realizes Classfication / Regression for Learning Data (XA,YA)
% and Test Data (XT,YT)
% Init

SVModel.Normalization = cell(1,2);
SVModel.Problem = 'Classification'; % 'Regression'
SVModel.TypeSVM = 'Hinge'; % {'Logit','Hinge'}
SVModel.Lambda = 0;        % Sparsity factor
SVModel.Alpha = [];        % Optimal alpha
SVModel.beta = 0;          % Optimal beta
SVModel.SVFeatures = [];   % The SV Indices of parcimonous columns
SVModel.CLASS = [];        % Confusion Matrices A, T

% Classes : MultiClass
yA = YA; yT = YT; [NOBS,NFEAT] = size(XA);


% Filtering
if Flag.AllData
    
    [Wna,IVCa,fAa,~,CLASSLa,Output] = f_HingeLossQuad(XA,YA,[],[],Flag);
    ERR_a = Output.LearnError; % SP_a = numel(IVCa) / NFEAT;
    
    % Save Results
    SVModel.Alpha = Wna; % Optimal parameters
    SVModel.Lambda = Flag.Lambda;  % Sparsity factor
    SVModel.fA = fAa; % Predicted Classes
    SVModel.FEpsilon = Flag.FEpsi;   % F value Precision
    SVModel.XEpsilon = Flag.XEpsi;   % X value Precision
    SVModel.SVFeatures = IVCa;       % The SV features
    SVModel.CLASS = CLASSLa;         % The confusion matrices
    SVModel.ERRA = sum(SVModel.fA ~= YA) / NOBS;
    SVModel.Output = Output;
        
else % Learning
    
    nA = length(yA); nT = length(yT);
    ERRC = Inf; ERRA = 0; ERRT = 0;
    ILambda = 0; NLambda = length(Flag.Lambda);
    Flag.Fepsi = Flag.FEpsi;
    Flag.Xepsi = Flag.XEpsi;
    
    
    while ERRC >= Flag.ClassifError && ILambda < NLambda
        
        ILambda = ILambda + 1;
        Flag.lambda = Flag.Lambda(ILambda) ;
        
        [xn,IVL,fAL,fTL,CLASSLa] = f_SVM_Logit(XA,yA,XT,yT,Flag);
        
        ERRA = (CLASSLa.A(1,2) + CLASSLa.A(2,1))/nA;
        ERRT = (CLASSLa.T(1,2) + CLASSLa.T(2,1))/nT;
        
        disp([Flag.lambda,ERRA,ERRT,length(IVL)])
        disp([CLASSLa.A,CLASSLa.T])
        ERRC = ERRA + ERRT;
    end
    
    SVModel.Alpha = xn;             % Learned parameters
    SVModel.Lambda = Flag.lambda;  % Sparsity factor
    SVModel.FEpsilon = Flag.Fepsi;   % F value Precision
    SVModel.XEpsilon = Flag.Xepsi;   % X value Precision
    SVModel.SVFeatures = IVL;       % The SV features
    SVModel.CLASS = CLASSLa;
    SVModel.fA = fAL;
    SVModel.fT = fTL;
end
