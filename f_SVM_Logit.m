function [xn,IV,fA,fT,CLASS] = f_SVM_Logit(XA,YA,XT,YT,Param)

% Parcimonious Learning

% Init
[NOBS, NVAR] = size(XA); C = unique(YA);

xn = zeros(1, NVAR); % the svm model
IV = []; % indices of important variables
fA = zeros(NOBS,1); % prediction of A observations
fT = zeros(length(YT),1); % prediction of T observations
CLASS.A = zeros(length(C)); % confusion matrix A
CLASS.IA = cell(2,2); % indices going to each classes
CLASS.T = CLASS.A;  % confusion matrix A
CLASS.IT = cell(2,2); % indices going to each classes
% Set a value for the sparsity degree
lambda = Param.lambda;

% Forward-Backward algorithm
gamma = 1.9 / (norm(XA)^2);
n = 2; crit = [0, 1]; 
EE = abs(crit(n) - crit(n-1))/abs(crit(n)); 

while EE > Param.Fepsi
    n = n + 1;
    EX = exp(-YA .* (XA * xn')');
    G = -YA .* (EX ./ (1 + EX)) * XA;
    xn = xn - gamma * G;
    xn = prox_L1(xn,lambda * gamma);
    crit(n) = sum(log(1 + EX)) + lambda * sum(abs(xn));    
    EE = abs(crit(n) - crit(n-1))/abs(crit(n));
end

% Important variables
ILV = abs(xn) >= Param.Xepsi; IV = find(ILV); 

xnn = zeros(size(xn)); xnn(ILV) = xn(ILV);
fA = XA * xnn'; fAA = sign(fA) ; % sign(XA * xn'); 2-class
[CLASS.A,CLASS.IA] = f_ConfusionMatrix(fAA',YA,C);

if ~isempty(XT)
    fT = XT * xnn'; fTT = sign(fT);
    [CLASS.T,CLASS.IT] = f_ConfusionMatrix(fTT',YT,C);
end