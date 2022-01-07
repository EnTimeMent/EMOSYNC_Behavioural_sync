function VALUES = FEATURED3ArmAngles(LOCALVICON)

% For each local vicon file and for each t = 1, ..., T
% 1. Calculates the normal vector n to triangle
% A(t) = [ShoulderX(t);ShoulderY(t),ShoulderZ(t)]
% B(t) = [ElbowX(t);ElbowY(t),ElbowZ(t)]
% C(t) = [HandX(t);HandY(t),HandZ(t)]

% 2. Calculates the angles of this normal with local axes (i0,j0,k0)
% VALUES{k}(t,:) = [angle(n,i),angle(n,j),angle(n,k)]

GLOBAL_;
N = length(LOCALVICON);
VALUES = cell(N,1);

xyz = [true,true,true]; % work on xyz space
SH = MARKERSCOLINDEX.R_shoulder(xyz);
EL = MARKERSCOLINDEX.R_elbow(xyz);
HA = MARKERSCOLINDEX.Hand(xyz);
IJK = eye(3); % local axes

for v = 1 : N
    
    % This is Position data [x(t),y(t),z(t)], t=1,...,T
    V = LOCALVICON{v}; [T,~] = size(V);
    Fv = zeros(T,3);    
    for t = 1 : T
        A = V(t,EL) - V(t,SH);
        B = V(t,HA) - V(t,SH);        
        n = cross(A,B); % normal vector
        nA = n * A'; nB = n * B';
        n = n/norm(n);
        angle = acos(n * IJK);
        Fv(t,:) = n; %acos(n * IJK);
    end
    VALUES{v} = Fv;     % plot(Fv), 'wait'
end