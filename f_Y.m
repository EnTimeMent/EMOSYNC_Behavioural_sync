function [T,O,G,I,relP,absP,E] = f_Y(fname)

% Extract from fname:
% T, O - T(riad) and O(rder)
% G, I - the numero of group or individual file in triad
% G - 0 if individual or G in (1:15) if group
% I - 0 if group or I in (1:18)
% relP - relative index of persons in the group.if group relP = [1,2,3]
% if individual - relP = mod(I,3);
% absP - absolute index (unique identification) of persons ...
% E - for each individual the emotion ...

GLOBAL_;

% Initialization
G = 0; I = 0; relP = 0; absP = 0; E = -Inf;

r = find(fname == '_');
F1 = fname(1 : r-1);
ltriad = length('Triad');
T = str2double(F1(ltriad + 1 :end));
O = 1;
if mod(T,2) == 0, O = 2; end

F2 = fname(r+1 : end-4);
lgroup = length('Group'); lindiv = length('Individual');

if strcmp(F2(1),'G') % is a group
    
    G = str2double(F2(lgroup + 1 :end));
    relP = 1 : GROUPSIZE;
    absP = ABSINDIVIDUAL(T,:);
    % Find emotion of group
    z = ORDER(O).GROUPPOS == G;
    if any(z), E = repmat(EPOSITIVE,1,GROUPSIZE); end
    z = ORDER(O).GROUPNEU == G;
    if any(z), E = repmat(ENEUTRAL,1,GROUPSIZE); end
    z = ORDER(O).GROUPNEG == G;
    if any(z), E = repmat(ENEGATIVE,1,GROUPSIZE); end
    
else % is individual
    
    I = str2double(F2(lindiv + 1 :end));
    relP = mod(I,GROUPSIZE);
    if relP == 0, relP = 3; end
    absP = ABSINDIVIDUAL(T,relP);
    % Find emotion of individual
    z = ORDER(O).INDIVIDUALPOS == I;
    if any(z), E = EPOSITIVE; end
    z = ORDER(O).INDIVIDUALNEU == I;
    if any(z), E = ENEUTRAL; end
    z = ORDER(O).INDIVIDUALNEG == I;
    if any(z), E = ENEGATIVE; end

end    