function C = ConcatenateCellsOfCells(CC)

% Creates a 1 level cell C of N elements, N is the total number of cells in 
% the 2 level cells CC

LCC = length(CC);
L = zeros(LCC,1);
for k = 1 : LCC
    L(k) = length(CC{k});
end
N = sum(L);
C = cell(1,N); cpt = 0;

for k = 1 : LCC
    ck = CC{k};
    for p = 1 : L(k)
        cpt = cpt+1; ckp = ck{p}; C{cpt} = ckp;
    end
end
