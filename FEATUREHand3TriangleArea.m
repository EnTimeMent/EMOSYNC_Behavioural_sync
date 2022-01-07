function [TRIAD,GROUP,EMOT,VALUES] = FEATUREHand3TriangleArea(DATA)

% For each triad (1:13) x group (1:15) of 3 original vicon file
% and for each t = 1, ..., T
% calculates the area of triangle H1(t,:), H2(t,:), H3(t,:)
% ! Right hand angle for normal (P1,P3) with (P1,P2)
% DATA.YHeader : {'Triad'}, {'Order'}, {'NoGroupTrial'}, {'NoIndividualTrial'}
% {'RELindex'}, {'Person'}, {'Emotion'}
% Output
% TRIAD(k), GROUP(k), EMOT(k) - y-Values of trial
% VALUES{k} - a vector of dim T containning the areas

GLOBAL_;
% N = length(DATA.VICON);
YTRIAD = DATA.Y(:,1);
YGROUP = DATA.Y(:,3);
YREL = DATA.Y(:,5);
YPERS = DATA.Y(:,6);
YEMOT =  DATA.Y(:,7); emot = unique(YEMOT);

NTRIADS = max(unique(YTRIAD));
NGROUPS = max(unique(YGROUP));
N = NTRIADS * NGROUPS;
TRIAD = zeros(N,1); GROUP = zeros(N,1);
EMOT = zeros(N,1); VALUES = cell(N,1);

xyz = [true,true,true]; % work on xyz space
ha = MARKERSCOLINDEX.Hand(xyz); % HAND marker columns
IJK = eye(3);

cpt = 0;
for triad = 1 : NTRIADS
    for group = 1 : NGROUPS
        
        
        IFILTER = and(YTRIAD == triad, YGROUP == group);
        
        V3 = DATA.VICON(IFILTER);
        T3 = YTRIAD(IFILTER); G3 = YGROUP(IFILTER);
        R3 = YREL(IFILTER);   P3 = YPERS(IFILTER);
        E3 = YEMOT(IFILTER);
        
        H1 = V3{1}(:,ha); H2 = V3{2}(:,ha); H3 = V3{3}(:,ha);
        % This is Position data [x(t),y(t),z(t)], t=1,...,T
        [T,~] = size(H1); Fv = zeros(T,1);
        for t = 1 : T
            A = H3(t,:) - H1(t,:);
            B = H2(t,:) - H1(t,:);
            n = cross(A,B); % normal vector
            nA = n * A'; nB = n * B'; % verif
            % n = n/norm(n);
            % angles = acos(n * IJK);            
            Fv(t) = 0.5 * norm(n);
        end

        cpt = cpt + 1;
        TRIAD(cpt) = unique(T3);
        GROUP(cpt) = unique(G3);
        EMOT(cpt) = unique(E3);
        VALUES{cpt} = Fv;
    end
end