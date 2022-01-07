function K3 = f_TransformSignedAnglesK3(SANGLES)

% SANGLES - Signed Angle between Normals and Bissectors
% ! Be careful with order B, N
% SANGLES(t,p) > 0, N looks at the right of B
% SANGLES(t,p) < 0, N looks at the left  of B
% Transform signed angles into a K3* : V = {1,2,3}
% K3* = [0,L,R; R,0,L; L,R,0]
% DEG-(p) = sum(K3*) indicates the leadership

GLOBAL_;
K3 = zeros(ngroup);
for p = 1 : ngroup
    sap = SANGLES(p);
    sa = min(abs(sap),MaxAlpha);
    taux = sa / MaxAlpha;
    switch p
        case 1
            if sap > 0, cp = 3; else, cp = 2; end
        case 2
            if sap > 0, cp = 1; else, cp = 3; end
        case 3
            if sap > 0, cp = 2; else, cp = 1; end
    end
    K3(p,cp) = taux;
end



