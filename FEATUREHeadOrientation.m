function VALUES = FEATUREHeadOrientation(LOCALVICON)

% For each local vicon file and for each t = 1, ..., T
% calculates the signed angle of normal to LeftHead --> RightHead
% with the solid bissector (local y axis)
% VALUES{k}(t) = angle > 0, head looks to the right
% VALUES{k}(t) = angle < 0, head looks to the left

GLOBAL_;
N = length(LOCALVICON);
VALUES = cell(N,1);

xyz = [true,true,false]; % work on xy plane
rhead = MARKERSCOLINDEX.R_head(xyz);
lhead = MARKERSCOLINDEX.L_head(xyz);
b = [0;1]; % y - axis is the local bissector

for v = 1 : N
    
    % This is Position data [x(t),y(t),z(t)], t=1,...,T
    V = LOCALVICON{v}; [T,~] = size(V);
    LH = V(:,lhead); RH = V(:,rhead); Fv = zeros(T,1);    
    for t = 1 : T
        n = f_XYRotate((RH(t,:) - LH(t,:))',0.5*pi);
        Fv(t) = f_SignedAngle(b,n); %        Fv(t) = alpha; disp([lr,n]),disp(alpha) ,'wait'
    end
    VALUES{v} = Fv;     % plot(Fv), 'wait'
end