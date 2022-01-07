function ICOL = f_ReturnColumnInd2(markers)

% Find indices of X, Y, Z columns of a marker into the datafile
% % and put them into the 'good' place of global
% MarkersOrder = {'R_shoulder','R_elbow','R_wrist','L_wrist',...
%                 'Hand','RARM','RUPA','R_head','L_head'};

GLOBAL_;
nm = length(markers); % local from file
ncoord = NCOORD * nm;
ICOL = zeros(1, ncoord);

% Aux
z = 1:ncoord; zz = reshape(z,3,27)';

ik = (1:3)-3;
for g = 1 : GROUPSIZE
    sg = num2str(g);
    for k = 1 : NMARKERS
        Mkg = [MARKERSNAMES{k},sg];                
        ik = ik + 3;
        for p = 1 : nm
            mp = markers{p};
            if strcmp(mp,Mkg)
                ip = zz(p,:); break
            end
        end
%         disp(Mkg),   disp(ip);
        ICOL(ik) = ip;
    end
end
