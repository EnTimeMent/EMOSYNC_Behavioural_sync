function Model = f_FirstStats(Model,Parameters)

% Visualisations and Simple statistics
% DATA.    COLUMNLABELS: {1×62 cell}
%               YP: [4879×1 double]
%               YT: [4879×1 double]
%                X: [4879×60 double]
%          NANROWS: [1×4904 logical]

% Global_V; 
GLOBAL_;
X = Model.X; [NOBS, NVAR] = size(X);
% ABSINDCOL = Model.ABSINDCOL;
% ABSNAMEVAR = Model.ABSNAMEVAR;
Y = Model.Y;

% Omit Constant Columns
s = std(X); 
nofig = 0;nofig = nofig + 1; figure(nofig), clf
plot(s), title('Std of variables'), grid on

Model.NOTCONSTCOL = s > FirstColumnFilter; % FirstColumnFilter = 3e-03;
Model.NVAR = sum(Model.NOTCONSTCOL);
X = X(:,Model.NOTCONSTCOL);

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
% Visu = false; %Parameters.Visualize;
if Parameters.Visualize
    
    nofig = nofig + 1; figure(nofig), clf
    plot(Model.Inerties), grid on
    xlabel('nb variables'), ylabel('Explained Variance'), title('PCA')

    % Overall
    nofig = nofig + 1; figure(nofig), clf, hold on
    IC = Y == SESSION.Sain;    % plot(X(IC,:)',':g'),
    plot(mean(X(IC,:)),'-g','LineWidth',1)
    IC = Y == SESSION.Tcsp;     % plot(X(IC,:)',':r'),
    plot(mean(X(IC,:)),'-r','LineWidth',1)
    IC = Y == SESSION.Park;     % plot(X(IC,:)',':k'),
    plot(mean(X(IC,:)),'-k','LineWidth',1)
    hold off, grid on
    title('Means of Rows per Class')    
end