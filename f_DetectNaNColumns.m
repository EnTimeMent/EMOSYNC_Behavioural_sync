function  c = f_DetectNaNColumns(A,markers)

% Special function : somme files have entire column of missing markers

GLOBAL_;
NCTRIAD = NMARKERS * NCOORD * GROUPSIZE;
nmarkers = length(markers);

[nA,dA] = size(A);
colcond = false(1,dA);
for k = 1 : dA
    colcond(k) = all(isnan(A(:,k)));
end

[nA,dA] = size(A);
c = any(colcond); %or(any(colcond),nmarkers < NMARKERS * GROUPSIZE)
if c
    disp([triad,fichier])
    disp([num2str(dA),' ',fN,' ',fname])
    disp(markers), pause()
end