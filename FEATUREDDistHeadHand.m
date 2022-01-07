function  VALUES = FEATUREDDistHeadHand(LOCALVICON)

% For each local vicon file and for each t = 1, ..., T
% 1. Calculates the Euclidian distance between
% A(t) = [HeadX(t);HeadY(t),HeadZ(t)]
% B(t) = [HandX(t);HandY(t),HandZ(t)]

% 2. Calculates the angles of this normal with local axes (i0,j0,k0)
% VALUES{k}(t) = norm(A(t)-B(t))

GLOBAL_;
N = length(LOCALVICON);
VALUES = cell(N,1);

xyz = [true,true,true]; % work on xyz space
HE = MARKERSCOLINDEX.R_head(xyz);
HA = MARKERSCOLINDEX.Hand(xyz);

for v = 1 : N
    
    % This is Position data [x(t),y(t),z(t)], t=1,...,T
    V = LOCALVICON{v}; [T,~] = size(V);
    Fv = zeros(T,1);    
    for t = 1 : T
        A = V(t,HE); B = V(t,HA);        
        Fv(t) = norm(A - B);
    end
    VALUES{v} = Fv;     % plot(Fv), 'wait'
end