function [ISG,IND,EMO,X] = f_PutDataInRows(YI,YG,IHANDS,GHANDS)

% For each trajectory k in IHANDS or GHANDS
% ISG(k) - 0 - solo; 1 - group
% IND(k) - individual in traejctory k
% X(k,:) - the trajectory k

% IHANDS =   1×18 cell array     {3000×1 double} 
% GHANDS =  25×1 cell array     {3000×3 double}
% YI =      1     2;      2     3;      3     1
% YG(1,:) =      1     2     3     2     1     2

[s,~] = size(YI); [g,~] = size(YG);
T = numel(IHANDS{1});
N = s + 3*g; 
ISG = false(N,1); IND = zeros(N,1);
EMO = zeros(N,1); X = zeros(N,T);

cpt = 0;
for k = 1 : s
    cpt = cpt+1;
    ISG(cpt) = false;
    IND(cpt) = YI(k,1);
    EMO(cpt) = YI(k,2);
    X(cpt,:) = IHANDS{k}';
end

for k = 1 : g
    x = GHANDS{k}; y = YG(k,4:6);
    for col = 1 : 3
        cpt = cpt+1;
        ISG(cpt) = true; 
        IND(cpt) = col;
        EMO(cpt) = y(col);
        X(cpt,:) = x(:,col)';
    end
end
