function Y1 = f_AlignPDF(X,Y,x)

% Input
% [X(i,:),Y(i,:)] is a pdf for all rows i
% x - wider x coordinates than all X(i,:)
% Output
% Y(i,:) - pdf in [x,Y(i,:)]

[n,d] = size(Y); lx = length(x);
Y1 = zeros(n,lx);
% figure(4),clf
% subplot(211), hold on
for k = 1 : n
    
%     plot(X(k,:),Y(k,:),':r')
    m = min(X(k,:)); M = max(X(k,:));
    ik = and(x >= m, x <= M);
    Y1(k,ik) = interp1(X(k,:),Y(k,:),x(ik),'nearest');   
end

% subplot(212), plot(x,Y1)