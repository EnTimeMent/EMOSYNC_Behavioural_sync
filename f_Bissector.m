function b = f_Bissector(A,B,C)

% Calculate bissector b of angle A of 2D triangle (A,B,C)

b = [NaN,NaN];
ab = B-A; nab = norm(ab);
ac = C-A; nac = norm(ac);

if and(nab > eps, nac > eps)
    b = ab/nab + ac/nac;
end