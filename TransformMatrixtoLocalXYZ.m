function [T1,T2,T3] = TransformMatrixtoLocalXYZ(Parameters)

% Calculates transform matrices to pass from global (O,I,J,K) coord to 
% local (O1,I1,J1,K1)
% Local Origins O1 are the coordinates of triangle vertices (see GLOBAL_.m)
% z_local_origin = HEIGHT (see GLOBAL_)
% J1 is the bissector of the angle
% I1 is J1 clockwise rotated with pi/2
% K1 = K = [0,0,1]';

GLOBAL_;

K = [0,0,1]';
A1 = TRIANGLEVERTICES(1,1:2)';
A2 = TRIANGLEVERTICES(2,1:2)';
A3 = TRIANGLEVERTICES(3,1:2)';

% Norm 1 bissectors
FlagVisu = Parameters.Visu;
[J1,J2,J3] = f_Bissectrices(A1, A2, A3,FlagVisu);

I1 = ClockWiseNormalVector(J1);
I2 = ClockWiseNormalVector(J2);
I3 = ClockWiseNormalVector(J3);

J = [J1,J2,J3;zeros(1,3)];
I = [I1,I2,I3;zeros(1,3)];
T1 = [I(:,1),J(:,1),K];
T2 = [I(:,2),J(:,2),K];
T3 = [I(:,3),J(:,3),K];
