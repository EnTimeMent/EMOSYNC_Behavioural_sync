function N = f_Normals(LR)

% Calculate anticlockwise normal to vector Left --> Right

[nl,nc] = size(LR); N = zeros(nl,2);

for p = 1 : nl
    L = LR(p,1:2); R = LR(p,1:2);
    n = ClockWiseNormal(L,R);
    N(p,:) = n;
end
LR1 = [LH{1}(t,:),RH{1}(t,:)];