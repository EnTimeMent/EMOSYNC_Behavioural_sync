function alpha = f_SignedAngle(b,n)

% Calculates signed angle alpha of 2D vectors b, n
% alpha > 0, b is clockwise rotation of n
% n looks at the right of b
% alpha < 0, b is anticlockwise rotation of n
% n looks at the left of b
% if any b or n is zero, alpha = NaN
% zn * z = zb % rotate n to attain b

% b = [1,0]; n = [0,1];
alpha = NaN;
nb = norm(b); nn = norm(n);
if and(nb > eps, nn > eps)
    b = b/nb; zb = b(1) + 1i * b(2);
    n = n/nn; zn = n(1) + 1i * n(2);    
    z = zb / zn;
    alpha = angle(z);
end