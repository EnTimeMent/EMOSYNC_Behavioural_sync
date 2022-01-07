% t_TRIANGLEBISSECTORS

% Calculate once the bissectors of rigid 
% TRIANGLEVERTICES; see GLOBAL_

GLOBAL_;
T = TRIANGLEVERTICES(:,1:2);
BISSECTRICES = zeros(3,2); 
FlagVisu = true;
[B1,B2,B3] = f_Bissectrices(T(1,:), T(2,:), T(3,:),FlagVisu)
BISSECTRICES = [B1;B2;B3]