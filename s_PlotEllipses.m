%%%% SUB Function
function [A,Q,Exy] = s_PlotEllipses(z, P, S, mu, sigma, col)

plot(z(:,1),z(:,2),'.','MarkerSize',8,'color',col);
for pp = 1 : length(P)
    text(z(pp,1),z(pp,2),[' ',num2str(P(pp))],'FontSize',8,'FontWeight','bold','color',col)
end
text(mu(1),mu(2),S,'FontSize',12,'FontWeight','bold','color',col)
[A,Q,rho,Exy] = f_EllipseCalculus(mu, sigma,[], 0.7, 100);
[A,Q,rho,Exy] = plotgauss2d(mu,sigma,'conf',0.7,'Color',col,'LineWidth',1.1);
'aa'
end