function Xs = f_SmoothX(X)

% Smooth values of each row of X

Globals_L; Xs = X ;

% First put to 0 columns 1 : 255 for each R, G, B
I0 = [];
IC = 1 : NBVALHIST;
I0 = [I0, IC(1 : Hist2Zero), IC(end - Hist2Zero + 1 : end)];
IC = IC + NBVALHIST;
I0 = [I0, IC(1 : Hist2Zero), IC(end - Hist2Zero + 1 : end)];
IC = IC + NBVALHIST;
I0 = [I0, IC(1 : Hist2Zero), IC(end - Hist2Zero + 1 : end)];

Xs(:,I0) = 0; [n,~] = size(X); w = SmoothWidth;

for row = 1 : n
    Xs(row,:) = smooth(X(row,:), w, 'moving');
end

% Z = smooth(Y) smooths data Y using a 5-point moving average.
%  
%     Z = smooth(Y,SPAN) smooths data Y using SPAN as the number of points used
%     to compute each element of Z.
%  
%     Z = smooth(Y,SPAN,METHOD) smooths data Y with specified METHOD. The
%     available methods are:
%  
%             'moving'   - Moving average (default)
%             'lowess'   - Lowess (linear fit)
%             'loess'    - Loess (quadratic fit)
%             'sgolay'   - Savitzky-Golay
%             'rlowess'  - Robust Lowess (linear fit)
%             'rloess'   - Robust Loess (quadratic fit)
%  
%     Z = smooth(Y,METHOD) uses the default SPAN 5.
%      Z = smooth(Y) smooths data Y using a 5-point moving average.