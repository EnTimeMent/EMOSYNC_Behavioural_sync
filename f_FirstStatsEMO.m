function Model = f_FirstStatsEMO(Model,Parameters)

% Visualisations and Simple statistics
% Model =   Name: 'EMOT_SINGLE'
%              X: [234×616 double]
%              Y: [234×1 double]
%          SortY: [234×1 double]
%           NOBS: 234
%          NVAR0: 616
%      ABSINDCOL: [1×616 double]
%     ABSNAMEVAR: {1×616 cell}

GLOBAL_;
X = Model.X; 
[NOBS, NVAR] = size(X);
Y = Model.Y;

% Omit Constant Columns
s = std(X); 
mins = min(s); maxs = max(s);
nofig = Parameters.nofig;
if Parameters.Visualize
    nofig = nofig + 1; figure(nofig), clf
    plot(s), title('Std of variables'), grid on
end
Model.NOTCONSTCOL = s > FirstColumnFilter; % FirstColumnFilter = 3e-03;
Model.NVAR = sum(Model.NOTCONSTCOL);
Model.NameNonConstFeatures = Model.ABSNAMEVAR(Model.NOTCONSTCOL)';
X = X(:,Model.NOTCONSTCOL); % take out non constant columns

% Is there an easy ONE variable discrimination ...
% X333 = X(:,333);
% IC = Y == EPOSITIVE; X3P = X333(IC);
% IC = Y == ENEUTRAL; X3NET = X333(IC);
% IC = Y == ENEGATIVE; X3NEG = X333(IC);
% nofig = nofig + 1; figure(nofig), clf
% hold on
% subplot(131),hist(X3P,33,'g')
% subplot(132),hist(X3NET,33,'b')
% subplot(133),hist(X3NEG,33,'k')
% hold off

% nofig = nofig + 1; figure(nofig), clf
% plot(X'), title('Variables before z-score')

Model.ABSINDCOL = Model.ABSINDCOL(Model.NOTCONSTCOL(1 : NVAR));
Model.ABSNAMEVAR = Model.ABSNAMEVAR(Model.NOTCONSTCOL(1 : NVAR));

% Normalisation Centered Reduced and PCA
if Parameters.Normalize
    [X,MU,SIGMA] = zscore(X);
    Model.MU = MU; Model.SIGMA = SIGMA;
else
    Model.MU = []; Model.SIGMA = [];
end
[~,~,latent,~,Inertie,~] = pca(X);

Model.rankX = rank(X); Model.pcaLatent = latent;
Model.Inerties = cumsum(Inertie);
Model.X = X;
MM = [];
% Visu = false; %Parameters.Visualize;
if Parameters.Visualize
    
    nofig = nofig + 1; figure(nofig), clf
    plot(Model.Inerties), grid on
    xlabel('nb variables'), ylabel('Explained Variance'), title('PCA')
    % Overall
    nofig = nofig + 1; figure(nofig), clf, hold on
    IC = Y == EPOSITIVE;    % plot(X(IC,:)',':g'),
    plot(mean(X(IC,:)),'-g','LineWidth',1)
    MM = [MM,mean(X(IC,:))'];
    IC = Y == ENEUTRAL;     % plot(X(IC,:)',':r'),
    plot(mean(X(IC,:)),'-r','LineWidth',1)
    MM = [MM,mean(X(IC,:))'];

    IC = Y == ENEGATIVE;     % plot(X(IC,:)',':k'),
    plot(mean(X(IC,:)),'-k','LineWidth',1)
    MM = [MM,mean(X(IC,:))'];

    hold off, grid on
    title('Means of Rows per Class')
    legend({'E+','E0','E-'})
end
Parameters.nofig = nofig;
% disp(Model.NameNonConstFeatures)
% disp(MM)