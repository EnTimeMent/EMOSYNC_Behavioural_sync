function VALUES = FEATUREHandOrientation(LOCALVICON)

% For each local vicon file and for each t = 1, ..., T
% calculates the signed angle of the vector (Shoulder --> Hand)
% with the solid bissector (local y axis)
% VALUES{k}(t) = angle > 0, arm tends to the right
% VALUES{k}(t) = angle < 0, arm tends to the left

GLOBAL_;
N = length(LOCALVICON);
VALUES = cell(N,1);

xyz = [true,true,false]; % work on xy plane
shoul = MARKERSCOLINDEX.R_shoulder(xyz);
handi = MARKERSCOLINDEX.Hand(xyz);
b = [0;1]; % y - axis is the local bissector

for v = 1 : N
    
    % This is Position data [x(t),y(t),z(t)], t=1,...,T
    V = LOCALVICON{v}; [T,~] = size(V);
    S = V(:,shoul); H = V(:,handi); Fv = zeros(T,1);    
    for t = 1 : T
        n = f_XYRotate((H(t,:) - S(t,:))',0.5*pi); % lr = ;
        Fv(t) = f_SignedAngle(b,n); %  disp([lr,n]),disp(alpha), % 'wait'
    end
    VALUES{v} = Fv;    % plot(Fv), %'wait'
end