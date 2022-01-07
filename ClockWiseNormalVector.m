function n = ClockWiseNormalVector(a)

% Calculate ClockWiseNormal of 2D vector a

ai = a(1)+1i*a(2);
z = ai*exp(-1i*0.5*pi);
n = [real(z);imag(z)];