function K = f_XYRotate(B,alpha)

% Rotate 2D vector B with angle alpha
% alpha > 0 - anticlockwise
% alpha < 0 - clockwise

b = B(1) + 1i * B(2);
k = b * exp(1i * alpha);
K = [real(k);imag(k)];
% figure(6)
% plot(0,0,'*k',B(1),B(2),'*r',K(1),K(2),'*b')
% 'aa'