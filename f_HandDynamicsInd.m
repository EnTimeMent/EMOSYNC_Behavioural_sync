function h = f_HandDynamicsInd(GS,GH,GLW,GRW,iS,iH,iLW,iRW,Parameters)

% Calculate Projection of Individual Hand into 1D

% Calculate indices for H(and) dynamics

pos = Parameters.PersonPosition;
GLOBAL_;

[T,~] = size(GS{1}); UN = ones(T,1);
h = zeros(T,1); H = zeros(T,GROUPSIZE);

% 1. Barycenter of S(houlder) in (X, Y)
V = zeros(GROUPSIZE,2);
for p = 1 : GROUPSIZE, V(p,:) = mean(GS{p}); end

% Shift data to bring all S{p} tp baryS(p,:)
for p = 1 : GROUPSIZE
    Tp = UN * V(p,:) - GS{p};
    GS{p} = GS{p} + Tp; GH{p} = GH{p} + Tp;
    GLW{p} = GLW{p} + Tp; GRW{p} = GRW{p} + Tp;
end

% Shift Individual Data to Shoulder
v = mean(iS);
tp = UN * v - iS;
s = iS + tp;
v = mean(s);
iH = iH + tp;
lw = iLW + tp; rw = iRW + tp;

% Bissector vectors
B = zeros(GROUPSIZE,2); ip0 = 1 : GROUPSIZE;
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
    H(:,p) = (GH{p} - UN * V(p,:)) * K(p,:)';
end

% Allways Pos 1
h = (iH - UN * v) * K(pos,:)';

% Calculate intersection of bissectors
% 1. Intersection of bissectors
% D1(z) = V(1,:) + z * B(1,:) = V(2,:) + z * B(2,:);
% V(1,:) - V(2,:) = (B(2,:) - B(1,:)) * z;
b21 = (B(2,:) - B(1,:)); v12 = V(1,:) - V(2,:);
z0 = (v12 * b21') / (b21*b21');
B0 = V(1,:) + z0 * B(1,:); % Intersection point
L0 = 0.5*norm(B0-V(1,:));

C = {'or','sr','*r';'og','sg','*g';'ob','sb','*b'};
CL = {'-r','-g','-b'};

if Parameters.Visu
    figure(1), clf, hold on
    for p = 1 : GROUPSIZE
        plot(V(p,1),V(p,2),C{p,1})
        plot(GH{p}(:,1),GH{p}(:,2),C{p,3})
        plot([V(p,1),B0(1)],[V(p,2),B0(2)],CL{p})
        plot(v(1),v(2),'.k')
        plot(iH(:,1),iH(:,2),'.k')
    end
    title(Parameters.Title)
    ax = (1:T)';
    figure(2), clf
    plot(ax,H(:,1),CL{1},ax,H(:,2),CL{2},ax,H(:,3),CL{3},...
        ax,h,'-k')
end

'wait'