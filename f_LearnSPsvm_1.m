function [IVC,ICOL,XX,SVM1,COUNT]  = f_LearnSPsvm_1(X,y,Model)

% SVMDATA =
%     XA: [125x120787 double]; YA: [1x125 double]
%     XT: [50x120787 double] ; YT: [1x50 double]
%     XP: [50x120787 double] ; YP: [1x50 double]

% Output
% ICV - last indices of native column variables to retain
% ICOL - cell, telescopic indice's sets filtered by sp learnings
% XX - Last variables matrix
% SVM1{k} = SVModel - contains Learned elements
% COUNT - informations about decreasing the nb of features

% Init
% First Filter: Constant Columns
Model.Normalize = true;
if Model.Normalize
    [X,Model.MU,Model.STD] = zscore(X);
end

% m = min(X); M = max(X);
hist(Model.STD,101)
IND1 = Model.STD > Model.EpsiFilter0; nz = sum(IND1);

% figure(1),subplot(121), plot(M - m,':k'); %spy([XA;XT])
% subplot(122), hist(M - m,101)


XL = X(Model.IL,IND1); YL = y(Model.IL); 
XT = X(Model.IT,IND1); YT = y(Model.IT); 

icol = Model.ABSINDCOL; ICOL = {icol,icol(IND1)}; % NCOL = sum(IND1);
[NOBS, NFEAT] = size(XL); 

% Here XX = [XA(:,IND1); XT(:,IND1)]
XX = [XL; XT]; y = [YL, YT]; NOBS = length(y);

% First filtering - all data.
Flag.Lambda = 1e-08 ; 
Flag.FEpsi = 1.0e-8; % Stop condition
Flag.XEpsi = 1e-05; % Importance of coefficients
% XFactor = [8, 7, 7, 6, 6, 5, 5, 5, 4, 4, 3, 3, 2.5, 3.2, 2.8, 2.8, 2.8];
XFactor = [8, 7, 7, 6, 6, 5, 5, 5, 4, 4, 3, 3, 2.5, 2.8, 2.8, 2.8, 3.2, 3.2];
NIter = length(XFactor);
Flag.AllData = true; %'AllData';
Flag.Visualization = true; %false; %true;
Flag.ClassifError = 5 / 100; % Target Error
Flag.FindEpsilon = false;

IVC = ICOL{2}; SVM1 = cell(1,NIter); COUNT = zeros(NIter,5);

for iter = 1 : NIter
    t0 = clock;
    Flag.XFactor = XFactor(iter);
    Flag.NbMaxIter = 55555; %length(XX(1,:)) / 30;
    
    SVM1i = f_ClassifyRegress(XX,y,[],[],Flag);
    
    % Save Model
    SVM1i.Normalization = Normalization;
    SVM1{iter} = SVM1i; Output = SVM1{iter}.Output
    
    % See IT
    COUNT(iter,1) = XFactor(iter); COUNT(iter,2) = Output.NFeatures;
    COUNT(iter,3) = Output.EPSI; COUNT(iter,4) = Output.Epsi_0;
    COUNT(iter,5) = Output.ERRA; disp(COUNT)
    % Capture the indices of 'good' features
    IV = SVM1{iter}.SVFeatures; % Relative 'good' indices
    XX = XX(:,IV); % Relative good matrix
    IVC = IVC(IV); ICOL = [ICOL,IVC]; % Contains the chain of absolute IND of features
    t1 = etime(clock,t0)
    
    if Flag.Visualization
        Wn = SVM1{iter}.Alpha; fA = SVM1{iter}.fA;
        ERRA = SVM1{iter}.ERRA; NFeat = Output.NFeatures;

        figure(1), clf
        subplot(411);plot(Output.RelErrors(3 : end)); title( 'Relative Errors')
        subplot(412);plot(Wn','.'); title('Sparse Estimate')
        subplot(413); ax = 1 : length(fA);
        plot(ax,fA,'.k', ax,y,'ro');
        title(['Learning Data, Err = ',num2str(ERRA)])
        subplot(414); hist(Wn(:),40); 
        title(['Distribution of W, NFeat = ',num2str(NFeat)])
    end
end