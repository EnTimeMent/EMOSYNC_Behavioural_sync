function f =  f_HandDynamics(S,H,LW,RW,Parameters)

% N.B. Look for projection of Hand into the Line perpendicular to bissector
% Calculate indices for H(and) dynamics from
% SG - Shoulder P1, P2, P3
% HG - Hand
% LWG - Left Wrist
% RWG - Right Wrist

GLOBAL_;

[T,d] = size(S{1}); UN = ones(T,1);
f = zeros(T,GROUPSIZE);
% 1. Barycenter of S(houlder) in (X, Y)
V = zeros(GROUPSIZE,2);
for p = 1 : GROUPSIZE, V(p,:) = mean(S{p}); end

% Shift data to bring all S{p} tp bary S(p,:)
for p = 1 : GROUPSIZE
    Tp = UN * V(p,:) - S{p};
    S{p} = S{p} + Tp; H{p} = H{p} + Tp;
    LW{p} = LW{p} + Tp; RW{p} = RW{p} + Tp;
end

% Bissector vectors
B = zeros(GROUPSIZE,2); % Bissectors
ip0 = 1 : GROUPSIZE;
K = zeros(GROUPSIZE,2); % K(p,:) is B(p,:) rotated pi/2 clockwise
% s.t. 1D coordinates are > 0 - Right and < 0 - Left

for p = 1 : GROUPSIZE
    a = V(p,:); ip = ip0; ip(p) = [];
    b = V(ip(1),:); c = V(ip(2),:);
    B(p,:) = Bissector(a,b,c);
    K(p,:) = XYRotate(B(p,:),-pi/2);
    K(p,:) = K(p,:)/norm(K(p,:));
end

% Calculate Projection of H{p}-V(p,:) onto K(p,:)
for p = 1 : GROUPSIZE
    f(:,p) = (H{p} - UN * V(p,:)) * K(p,:)';
end

% Calculate intersection of bissectors
% 1. Intersection of bissectors
% D1(z) = V(1,:) + z * B(1,:) = V(2,:) + z * B(2,:);
% V(1,:) - V(2,:) = (B(2,:) - B(1,:)) * z;
b21 = (B(2,:) - B(1,:)); v12 = V(1,:) - V(2,:);
z0 = (v12 * b21') / (b21*b21');
B0 = V(1,:) + z0 * B(1,:); % Intersection point
L0 = 0.5 * norm(B0-V(1,:));

C = {'or','sr','*r';'og','sg','*g';'ob','sb','*b'};
CL = {'-r','-g','-b'};

if Parameters.Visu
    figure(1), clf, hold on
    for p = 1 : GROUPSIZE
        plot(V(p,1),V(p,2),C{p,1})
        plot(H{p}(:,1),H{p}(:,2),C{p,3})
        plot([V(p,1),B0(1)],[V(p,2),B0(2)],CL{p})
    end
    title(Parameters.Title)
    ax = (1:T)';
    figure(2), clf
    plot(ax,f(:,1),CL{1},ax,f(:,2),CL{2},ax,f(:,3),CL{3})
end
% 
% 'aa'