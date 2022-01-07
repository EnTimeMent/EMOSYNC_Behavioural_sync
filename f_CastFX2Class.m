function c = f_CastFX2Class(f,t,C)

% Put continuous values of f to classes in c
% following thresholds in t and classes in C

GLOBAL_;

n = length(f); c = zeros(n,1);
t = [-Inf; t; Inf];


for k = 1 : length(t) - 1
    c(and(f > t(k),f <= t(k+1))) = C(k);
end

% plot(1 : n,f,'-k',1 : n,c,'-r')
    
    
