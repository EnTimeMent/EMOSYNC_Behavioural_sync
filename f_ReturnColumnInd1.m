function ICOL = f_ReturnColumnInd1(markers)

% Find indices of X, Y, Z columns of a marker into the datafile 
% % and put them into the 'good' place of global 
% MarkersOrder = {'R_shoulder','R_elbow','R_wrist','L_wrist',... 
%                 'Hand','RARM','RUPA','R_head','L_head'};   

GLOBAL_;

nm = length(markers); % local from file
ncoord = NCOORD * nm;
ICOL = zeros(1, ncoord);
for k = 1 : NMARKERS
    Mk = MARKERSNAMES{k};
    ik = (k-1) * 3 + 1 : 3 * k;
    for p = 1 : nm
        mp = markers{p};
        if contains(mp,Mk)
            ip = (p-1)*3+1 : 3*p;
            break
        end
    end
    ICOL(ik) = ip;
end
    