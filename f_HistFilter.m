function x1 = f_HistFilter(x,nbp,p)

% Filter out the values of x s.t. the histogram
% is lower than p% of maximal value

[N,C] = hist(x,nbp);
mN = max(N); s = p * mN;
D = diff(C); d = D(1) / 2;

IX = true(1, length(x)); LN = length(N);
for k = 1 : length(N)
   
    nk = N(k);
    if and(nk <= s,nk > 0)
        % Bin center
        ck = C(k);
        ik = and(x>=ck-d,x < ck+d);
        if k == 1, ik = x < ck; end
        if k == LN, ik = x >= ck; end        
        
        IX(ik) = false;
    end
end
x1 = x(IX);

figure(4),clf
subplot(211), hist(x,C)
subplot(212), hist(x1,C)