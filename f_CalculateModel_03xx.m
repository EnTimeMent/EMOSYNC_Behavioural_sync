function P = f_CalculateModel_03xx(P)

% Calculate both Linear and Qudratic Model
% Version _02: All models ask for linear filters but matrices
% X are prepared before

Globals_L;

X = P.X; [n,m] = size(X);
y = P.y;  Y = P.Y;
C = unique(Y); NOBS = P.NOBS;
P.W = ones(NOBS,1); % Possibility to weights of observations

indcol = 1 : m; P.ICOL{1} = indcol;

% First Filter - Omit Constant Columns
NOTCONSTCOL = max(X) > min(X) + eps;
X = X(:,NOTCONSTCOL); % First filter
P.ICOL{2} = P.ICOL{1}(NOTCONSTCOL);
nv = length(P.ICOL{2});

% Sparse Linear
NZEffL = P.rankX; imin = [];
LIN = f_LinearModel(X,Y,y,NZEffL,imin,P);

% Second Filter 
Iepsi = abs(LIN.b) > epsi;
LIN.b = LIN.b(Iepsi); X = X(:,Iepsi); % Second filter
P.ICOL{3} = P.ICOL{2}(Iepsi); % absolute indices
nnv = length(P.ICOL{3});

P.Linear = LIN;

% Test
yl = LIN.b0 + X * LIN.b; yl = f_PutFX2Boundsy(yl);
cyl = f_CastFX2Class(yl);
EL = mean(cyl ~= Y);