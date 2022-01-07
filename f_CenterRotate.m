function [TRIAL,PAR] = f_CenterRotate(TRIAL,PAR)

% TRIAL{k}.Person: {'P1'  'P2'  'P3'}
% Fill the NaN values :(
% Bring the barycenter of all (x,y,z) points to [0,0,0]
% Rotate all the points s.t. y(P1) = 0
% Calculate the span(x,y,z)
% t =
%          y: 1
%     Person: {'P1'  'P2'  'P3'}
%      Point: {'Shoulder'  'Elbow'  'Wrist'}
%      Coord: {'X'  'Y'  'Z'}
%          P: {[4500×9 double]  [4500×9 double]  [4500×9 double]}

NTRIAL = numel(TRIAL);
NPERSON = numel(TRIAL{1}.Person);
NPOINTS = numel(PAR.Points);
[T,~] = size(TRIAL{1}.P{1});
UNT = ones(T,1);
IShoulder = PAR.SEW(PAR.IS,:);

b3 = zeros(NPERSON,3);
b0 = zeros(1,3);
B0 = zeros(1,9);
spanmin =  Inf(4,3 * NPOINTS); 
spanmax = -Inf(4,3 * NPOINTS);

for trial = 1 : NTRIAL
    
    Pt = TRIAL{trial}.P; % Persons of trial
    
    % Calculate Barycenter of each Shoulder
    b = b3; 
    for person = 1 : NPERSON, b(person,:) = mean(Pt{person}(:,IShoulder)); end
    
    % Center of Centers of Shoulders
    b0 = mean(b);    
    % Translation of all points b0 --> [0,0,0]
    B0 = [b0,b0,b0];
    for person = 1 : NPERSON, Pt{person} = Pt{person} - UNT * B0 ; end
    
    % Calculate Rot z-angle of Shoulder of P1
    S1 = b(1,:) - b0; ad = atand(S1(1,2) / S1(1,1));
    if S1(1) > 0, ad = ad - 180; end % quadrant 1 & 4
    R = rotz(-ad);
    
    % Rotate all (x,y,z) points with this matrix
    for person = 1 : NPERSON % Person
        for point = 1 : NPOINTS           
            ipoint = PAR.SEW(point,:); % S, E, W
            Pt{person}(:,ipoint) = (R * Pt{person}(:,ipoint)')' ;
        end
        
        % Calculate Span of Positions
        ii = 1; M = Pt{person};
        spanmin(ii,:) = min([spanmin(ii,:); min(M)]);
        spanmax(ii,:) = max([spanmax(ii,:); max(M)]);
        
        %  Velocities
        ii = 2; M = diff(M);
        spanmin(ii,:) = min([spanmin(ii,:); min(M)]);
        spanmax(ii,:) = max([spanmax(ii,:); max(M)]);
        
        % Accelerations
        ii = 3; M = diff(M);
        spanmin(ii,:) = min([spanmin(ii,:); min(M)]);
        spanmax(ii,:) = max([spanmax(ii,:); max(M)]);
        
        % Jerks
        ii = 4; M = diff(M);
        spanmin(ii,:) = min([spanmin(ii,:); min(M)]);
        spanmax(ii,:) = max([spanmax(ii,:); max(M)]);

    end
    
    TRIAL{trial}.P = Pt;
    PAR.SpanXYZ = {spanmin,spanmax};        
end
