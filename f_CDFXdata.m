function X3 = f_CDFXdata(X)

Globals_L;

[n,d] = size(X); X3 = zeros(n,3);
IC = (1 : NBVALHIST) - NBVALHIST;

for c = 1 : 3
    IC = IC + NBVALHIST;
    XC = X(:,IC);
    for r = 1 : n
        xr = XC(r,:);
        xr = xr / sum(xr); % density
        xr = cumsum(xr); % cdf
        s = sum(xr);
        X3(r,c) = sum(xr);
    end
end