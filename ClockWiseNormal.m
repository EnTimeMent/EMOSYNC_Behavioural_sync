function n = ClockWiseNormal(L,R)

% Calculate ClockWiseNormal of vector L,R
a = R-L; %a = [2,1]; 
ai = a(1)+1i*a(2);
z = ai*exp(-1i*0.5*pi);
n = [real(z);imag(z)];

% tst v = a*z';