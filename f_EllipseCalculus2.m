function A = f_EllipseCalculus2(m1,S1,A1,Q1,E1,r1,m2,S2,A2,Q2,E2,r2)

% Calculates the OVERLAP between 2 ellipses 
% ELL(m1,S1,rho) = x : (x-m1)inv(S1)(x-m1) <= r1
% ELL(m2,S2,rho) = x : (x-m2)inv(S2)(x-m2) <= r2

% Test distances 

MAH1 = inv(S1); MAH2 = inv(S2);
[~,n1] = size(E1); [~,n2] = size(E2); 

z1 = E1 - m1 * ones(1,n1); % D1 = sqrt(diag(z1' * MAH1 * z1));
z2 = E2 - m2 * ones(1,n2); % D2 = sqrt(diag(z2' * MAH2 * z2));

% Find points of E1 inside ELL2 and points of E2 inside ELL1
z12 = E1 - m2 * ones(1,n1);
D12 = sqrt(diag(z12' * MAH2 * z12));
Z12 = E1(:,D12 <= r2);

z21 = E2 - m1 * ones(1,n2);
D21 = sqrt(diag(z21' * MAH1 * z21));
Z21 = E2(:,D21 <= r1);

% If not empty find ellipse containing these IN points
ZZ = [Z12,Z21];
if ~isempty(ZZ)
    nZZ = length(ZZ(1,:));
    muZZ = mean(ZZ,2); covZZ = cov(ZZ');
    zz = ZZ - muZZ * ones(1,nZZ);
    DZZ = sqrt(diag(zz' * inv(covZZ) * zz));
    prob = 0.7; nbpts = 30; radius = mean(DZZ);
    % Find area of this ellipse
    [A,Q,r,E] = f_EllipseCalculus(muZZ, covZZ,radius, prob, nbpts);
end

figure(7), clf, hold on
plot(E1(1,:),E1(2,:),'-r',E2(1,:),E2(2,:),'-b')
plot(ZZ(1,:),ZZ(2,:),'*k')
plot(E(1,:),E(2,:),'-k')
hold off

% 'aa'
