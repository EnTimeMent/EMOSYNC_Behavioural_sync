function z = f_PutFX2Boundsy(z)

% Put Values of z to the bounds y

Globals_L;
z(z < MINSTEA) = MINSTEA;
z(z > MAXSTEA) = MAXSTEA;