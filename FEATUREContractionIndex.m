function VALUES = FEATUREContractionIndex(LOCALVICON)

% For each local vicon file and for each t = 1, ..., T
% calculates the rapport of volumes vol(box_min)/vol(box(t))
% box_min - the minimum box of THIS trial
% with box(t) - the box containing all markers at instant t
% VALUES{k}(t) ~ 0, head-arm fully stretched
% VALUES{k}(t) ~ 1, head-arm fully contracted

GLOBAL_;
N = length(LOCALVICON);
VALUES = cell(N,1);

% xyz = [true,true,false]; % work on all points
% rhead = MARKERSCOLINDEX.R_head(xyz);
% lhead = MARKERSCOLINDEX.L_head(xyz);
% b = [0;1]; % y - axis is the local bissector

for v = 1 : N
    
    % This is Position data [x(t),y(t),z(t)], t=1,...,T
    V = LOCALVICON{v}; [T,~] = size(V);
%     P = V(:,lhead); RH = V(:,rhead);
    Fv = zeros(T,1);    
    for t = 1 : T
        vt = V(t,:);
        VT = reshape(vt,3,NMARKERS)';
        minVT = min(VT);
        maxVT = max(VT);
        Fv(t) = prod(maxVT - minVT);
    end
    minF = min(Fv);
    VALUES{v} = minF ./ Fv;     
    plot(VALUES{v})
    'wait'
    
end