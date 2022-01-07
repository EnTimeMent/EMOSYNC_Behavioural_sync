% tst_gradient

dt = 2*pi / 30;
t = 0 : dt : 5*pi;
y = sin(t);
y2 = gradient(gradient(y));
m2 = max(abs(y2));
IL = abs(y2) < 0.01 * m2;
yl = y(IL); tl = t(IL);
figure(3), clf
plot(t,y,'-k',t,y2,'-r',tl,yl,'or')
grid on