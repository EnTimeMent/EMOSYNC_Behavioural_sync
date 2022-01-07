function [Wn,IVC,fA,fT,CLASS,Output] = f_HingeLossQuad(XA,YA,XT,YT,Flag)

% Code classification Hinge quadratique Blondel et al.
% "Block coordinate descent algorithms for large-
% scale sparse multiclass classification"

% Output
% Wn - The learned parameter
% IVC - indices of retained features
% IVW - indices of W <= XEpsi
% fA, fT - predicted Learn and Test data
% CLASS.A, CLASS.T - confusion matrix for A and T data
% Output - informations about convergence of optimization

[NA,NVAR] = size(XA); C = unique(YA); NCLASS = length(C);

IV = []; % indices of important variables
fA = zeros(1,NA); % prediction of A observations
fT = zeros(length(YT),1); % prediction of T observations
CLASS.A = zeros(length(C)); % confusion matrix A
CLASS.T = []; % confusion matrix T
if ~isempty(YT), CLASS.T = CLASS.A; NT = length(YT); end

% Set a value for the sparsity degree
lambda = Flag.Lambda;

Z1 = YA + (0: NCLASS : (NA - 1) * NCLASS); %[YA',z',Z1']
D = setdiff((1 : NA * NCLASS), Z1)'; % set difference
Z2 = reshape(D, NCLASS-1, NA);

% Forward-Backward algorithm
beta = sum((4 * (NCLASS - 1) / NA * sum(XA .^ 2, 2))); % disp(beta)
gamma = 1.9/(beta); crit = [0, 1]; n = 2;
Wn = zeros(NCLASS,NVAR);  % transpose to article & 0 values ?

EE = abs(crit(n) - crit(n-1))/abs(crit(n));
ERRAn = mean(fA ~= YA);
    
% || ERRAn > Flag.ClassifError
while (EE > Flag.FEpsi ) && (n < Flag.NbMaxIter)
    n = n + 1;
    dect = transform_dir(Wn,Z1,Z2,NCLASS,XA');%dec.T(Wn);
    dectadj = transform_adj(max(0,1 - dect),Z1,Z2,NCLASS,XA'); %dec.Tadj(max(0,1 - dect));
    grad = -2 / NA * dectadj;
    Wn   = Wn - gamma * grad;
    Wn   = prox_L1(Wn, lambda * gamma);
    crit(n) = 1/NA* sum(sum(max(0,1 - dect).^2)) + lambda * sum(abs(Wn(:)));
    EE = abs(crit(n) - crit(n-1))/abs(crit(n));
    [~,fAn] = max(Wn * XA');
    ERRAn = mean(fAn ~= YA);
    disp([n,EE,ERRAn])
end

Output.FEpsi = EE;
Output.NIter = n;
Output.LearnError = ERRAn;
Output.RelErrors = crit;

% Print results
% disp('Nombre features d''interet:');
% disp([num2str(length(find(abs(Wn)> Flag.XEpsi))),'/',int2str(NVAR*NCLASS)]);

EPSI = max(abs(Wn(:))); 
epsi_0 = 0; % EPSI / Flag.XFactor; % disp([epsi_0,Flag.XEpsi])
Output.EPSI = EPSI; Output.Epsi_0 = epsi_0;

IVC = find(max(abs(Wn)) > epsi_0); %disp(length(IVC))
Output.NFeatures = length(IVC);

Wn = Wn(:,IVC); XA = XA(:,IVC);
% Training
[~,fA] = max(Wn * XA'); % Multi Class
ERRA = mean(fA ~= YA);
Output.ERRA = ERRA; %disp(ERRA)
[A,~] = f_ConfusionMatrix(fA,YA,C);
disp(A)
CLASS.A = A;
% Test
if ~isempty(XT)
    [~,fT] = max(Wn(:,IV) * XT(:,IV)');      
    [T,~] = f_ConfusionMatrix(fT,YT,C);
    CLASS.T = T;    
    Output.ERRT = sum(fT ~= YT) / NT;
end
