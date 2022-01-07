function VALUES = FEATUREQoMCamurri(LOCALVICON)

% For each local vicon file and for each t = 1, ..., T
% 1. Calculates the distance travelled between 2 successive triangles
% [A,B,C](t) and [A,B,C](t)
% A(t) = [ShoulderX(t);ShoulderY(t),ShoulderZ(t)]
% B(t) = [ElbowX(t);ElbowY(t),ElbowZ(t)]
% C(t) = [HandX(t);HandY(t),HandZ(t)]

% 2. The QoM is the norm of velocity of this travel
% VALUES{k}(t) = norm(velocity); [m/s]

GLOBAL_;
N = length(LOCALVICON);
VALUES = cell(N,1);

xyz = [true,true,true]; % work on xyz space
SH = MARKERSCOLINDEX.R_shoulder(xyz);
EL = MARKERSCOLINDEX.R_elbow(xyz);
HA = MARKERSCOLINDEX.Hand(xyz);

for v = 1 : N
    
    % This is Position data [x(t),y(t),z(t)], t=1,...,T
    V = LOCALVICON{v}; [T,~] = size(V);
    bar_0 = mean([V(1,SH);  V(1,EL) ; V(1,HA)]);
    Fv = zeros(T,1);    
    for t = 2 : T        
        % Barycenter - Triangle t and (t+1)
        bar_1 = mean([V(t,SH);  V(t,EL) ; V(t,HA)]);
        d = norm(bar_1 - bar_0);        
        Fv(t) = norm(bar_1 - bar_0);
        bar_0 = bar_1;
    end
    Fv(1) = Fv(2);
    VALUES{v} = (Fv / 1000) / ViconDeltaT; % meters
    
%     plot(VALUES{v})    
%     'wait'    
end