function VALUES = FEATURED3HandAngles(LOCALVICON)

% For each local vicon file and for each t = 1, ..., T
% 1. Calculates the normal vector n to triangle
% A(t) = [LW_X(t);LW_Y(t),LW_Z(t)]
% B(t) = [RW_X(t);RW_Y(t),RW_Z(t)]
% C(t) = [H_X(t);H_Y(t),H_Z(t)]
% 2. Calculates the cosines of angles of this normal with local axes (i0,j0,k0)
% VALUES{k}(t,:) = cos([angle(n,i),angle(n,j),angle(n,k)])

GLOBAL_;
N = length(LOCALVICON);
VALUES = cell(N,1);

xyz = [true,true,true]; % work on xyz space
LW = MARKERSCOLINDEX.L_wrist(xyz);
RW = MARKERSCOLINDEX.R_wrist(xyz);
HA = MARKERSCOLINDEX.Hand(xyz);
IJK = eye(3);

for v = 1 : N
    
    % This is Position data [x(t),y(t),z(t)], t=1,...,T
    V = LOCALVICON{v}; [T,~] = size(V);
    Fv = zeros(T,3);    
    for t = 1 : T
        A = V(t,LW) - V(t,HA);
        B = V(t,RW) - V(t,HA);
        n = cross(A,B); % normal vector
        nA = n * A'; nB = n * B'; % verif
        n = n/norm(n);
        angles = acos(n * IJK);

        Fv(t,:) = n; %acos(n * IJK);
    end
    VALUES{v} = Fv;     % plot(Fv), 'wait'
end