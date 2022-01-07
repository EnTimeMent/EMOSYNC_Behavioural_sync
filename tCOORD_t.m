% COORD_t

O1 = [2;2]; M = [4;2];
a = M - O1;
j1 = [1;1]; 
O = [0;0]; R = j1;
i1 = ClockWiseNormal(O,j1);

i1 = i1 / norm(i1); j1 = j1 / norm(j1);

M1 = [i1,j1]'*a


