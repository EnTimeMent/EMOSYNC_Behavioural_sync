function [B1,B2,B3] = f_Bissectrices(A1, A2, A3,FlagVisu)

% Calculate Bissectrices Bi of triangle (A1, A2, A3) at Ai

A = A1; B = A2; C = A3;
B1 = (B - A) / norm(B - A) + (C - A) / norm(C - A);
B1 = B1 / norm(B1);

A = A2; B = A3; C = A1;
B2 = (B - A) / norm(B - A) + (C - A) / norm(C - A);
B2 = B2 / norm(B2);

A = A3; B = A1; C = A2;
B3 = (B - A) / norm(B - A) + (C - A) / norm(C - A);
B3 = B3 / norm(B3);

% Find intersection
% D1(t) = A1 + B1 * t = D2(t) = A2 + B2 * t; 
% (B2-B1)*t = (A1-A2); (B2-B1)'*(B2-B1)*t = (B2-B1)'*(A1-A2); 
% t0 = (B2-B1)'*(A1-A2)/ (B2-B1)'*(B2-B1);
b = (B2-B1); a = (A1-A2);
t0 = (a * b') / (b * b');
CC = A1 + t0 * B1;

if FlagVisu
    figure(5); clf
    hold on
    text(A1(1),A1(2),'\leftarrow P1')
    text(A2(1),A2(2),'\leftarrow P2')
    text(A3(1),A3(2),'\leftarrow P3')
    
    plot(A1(1),A1(2),'or',A2(1),A2(2),'og')
    plot(A3(1),A3(2),'ob',CC(1),CC(2),'.k')
    plot([A1(1),A2(1),A3(1),A1(1)],[A1(2),A2(2),A3(2),A1(2)],':k')
    plot([CC(1),A1(1)],[CC(2),A1(2)],'-r')
    plot([CC(1),A2(1)],[CC(2),A2(2)],'-g')
    plot([CC(1),A3(1)],[CC(2),A3(2)],'-b')
    grid on
    title('Bissector')
end
    
    