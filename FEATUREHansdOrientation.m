function F = FEATUREHeadOrientation(LOCALVICON)


GLOBAL_;
N = length(LOCALVICON);
F = cell(N,1);

xyz = [true,true,false]; % work on xy plane
rhead = MARKERSCOLINDEX.R_head(xyz);
lhead = MARKERSCOLINDEX.L_head(xyz);
b = [0;1]; % y - axis is the local bissector

for v = 1 : N
    
    % This is Position data [x(t),y(t),z(t)], t=1,...,T
    V = LOCALVICON{v}; [T,~] = size(V);
    LH = V(:,lhead); RH = V(:,rhead);
    
    Fv = zeros(T,1);
    
    for t = 1 : T
        lr = (RH(t,:) - LH(t,:))';
        n = f_XYRotate(lr,0.5*pi);
        alpha = f_SignedAngle(b,n);
        Fv(t) = alpha;
        %                 disp([lr,n]),disp(alpha)
        %                 'wait'
    end
    %             plot(Fv),
    %             'wait'
    F{v} = Fv;
end