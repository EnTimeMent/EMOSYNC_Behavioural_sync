function [TRIAL,PAR] = f_CenterRotateLocal(TRIAL,PAR)

% TRIAL{k}.Person: {'P1'  'P2'  'P3'}
% Bring the barycenter of all (x,y,z) points to [0,0,0]
% Rotate all the points s.t. Bissectrices of Shoulder Angles go to Ox
% Zoom all points to a standard Parameters.LengthArm = 720[mm];
% Calculate minxyz = min([S(x,y,z),E(x,y,z),W(x,y,z)])
% Calculate maxxyz = max([S(x,y,z),E(x,y,z),W(x,y,z)])
% Calculate spanxyz = maxxyz - minxyz;
% t =
%          y: 1
%     Person: {'P1'  'P2'  'P3'}
%      Point: {'Shoulder'  'Elbow'  'Wrist'}
%      Coord: {'X'  'Y'  'Z'}
%          P: {[4500×9 double]  [4500×9 double]  [4500×9 double]}

NTRIAL = numel(TRIAL);
NPERSON = numel(TRIAL{1}.Person);
NPOINTS = numel(PAR.Points);
[T,~] = size(TRIAL{1}.P{1}); UNT = ones(T,1);

IShoulder = PAR.SEW(PAR.IS,:); % [X,Y,Z] of shoulder
IElbow = PAR.SEW(PAR.IE,:); % [X,Y,Z] of elbow
IWrist = PAR.SEW(PAR.IW,:); % [X,Y,Z] of wrist

b3 = zeros(NPERSON,3); % Barycenter of Shoulder of each Person{i}
minxyz =  Inf(4,3 * NPOINTS); % min values:positions,speed,acc, jerk
maxxyz = -Inf(4,3 * NPOINTS); % max values:positions,speed,acc, jerk

for trial = 1 : NTRIAL
    
    Pt = TRIAL{trial}.P; % Persons of trial
    
    % 1. Calculate Barycenter of each Shoulder
    bary = b3; 
    for person = 1 : NPERSON
        bary(person,:) = mean(Pt{person}(:,IShoulder));
    end
    
    if PAR.Visualisation
        figure(1);
        plot(bary(1,1),bary(1,2),'*k',bary(2,1),bary(2,2),'*b',bary(3,1),bary(3,2),'*r')
        legend('1','2','3')
    end
    
    % 2. Calculate Bissectrices of each angle in XY - plane
    biss = zeros(NPERSON,2); i0 = false(1,3);
    for person = 1 : NPERSON
        ii = i0; ii(person) = true;
        A = bary(ii,1:2); BC = bary(not(ii),1:2);
        B = BC(1,:); C = BC(2,:);
        biss(person,:)=(B-A)/norm(B-A)+(C-A)/norm(C-A);
    end

    % 3. Shift each Persons s.t. bary(Shoulder)=[0,0,0];
    for person = 1 : NPERSON
        S = Pt{person}(:,IShoulder);
        
        % Shift
        bp = bary(person,:); BP = [bp,bp,bp];
        Pt{person} = Pt{person} - UNT * BP ;
        %
        if PAR.Visualisation
            figure(2), clf
            S1 = Pt{person}(:,IShoulder);
            plot(S(:,1),S(:,2),'.k',S1(:,1),S1(:,2),'.r')
            legend('Avant','Apres'),title(num2str(person))
            hold off
            'wait'
        end
    end

    % 4. Calculate Rot z-angle of Each Bissectrice with Ox
    % Rotate all (x,y,z) points with this matrix
    ixy = [1,2;4,5;7,8];
    for person = 1 : NPERSON % Person
        
        bp = biss(person,:); ad = atand(bp(2)/bp(1));
        if bp(1) < 0, ad = ad - 180; end % quadrant 2 & 3
        R = rotz(-ad);
        
        if PAR.Visualisation
            bp1 = R * [bp,0]';
            figure(3), clf
            plot(bp(1),bp(2),'*k',bp1(1),bp1(2),'*r',0,0,'sk')
            legend('Before','After','center')
            'wait'
        end
        
        S = [Pt{person}(:,ixy(1,:));Pt{person}(:,ixy(2,:));Pt{person}(:,ixy(3,:))];

        for point = 1 : NPOINTS 
            ipoint = PAR.SEW(point,:); % S, E, W
            Pt{person}(:,ipoint) = (R * Pt{person}(:,ipoint)')' ;
        end
        S1 = [Pt{person}(:,ixy(1,:));Pt{person}(:,ixy(2,:));Pt{person}(:,ixy(3,:))];
        
        if PAR.Visualisation
            figure(4), clf
            plot(S(:,1),S(:,2),'.k',S1(:,1),S1(:,2),'.r',0,0,'sk')
            legend('Before','After','center')
            'wait'
        end
    end

    % Normalize ArmLength
    for person = 1 : NPERSON
        
        M = Pt{person}; 
        % Calculate the length of the Arm
        LARM = zeros(T,1);
        
        for t = 1 : T % time
            IShoulder = PAR.SEW(PAR.IS,:);
            IElbow = PAR.SEW(PAR.IE,:);
            IWrist = PAR.SEW(PAR.IW,:);
            S = M(t,IShoulder); E = M(t,IElbow); W = M(t,IWrist);
            LARM(t) = norm(E-S)+norm(W-E);
        end
        
        larm = max(LARM); mul = mean(LARM); slarm = std(LARM);
        M = PAR.LengthArm / mul;
        
        %         PAR.Visualisation = true;
        if PAR.Visualisation
            figure(5), clf, hist(LARM,30)
            'wait'
        end
        %         PAR.Visualisation = false;
                

        % Calculate Span of Positions
        ii = 1; M = Pt{person};
        minxyz(ii,:) = min([minxyz(ii,:); min(M)]);
        maxxyz(ii,:) = max([maxxyz(ii,:); max(M)]);
        
        %  Velocities
        ii = 2; [~,M] = gradient(M);
        minxyz(ii,:) = min([minxyz(ii,:); min(M)]);
        maxxyz(ii,:) = max([maxxyz(ii,:); max(M)]);
        
        % Accelerations
        ii = 3; [~,M] = gradient(M);
        minxyz(ii,:) = min([minxyz(ii,:); min(M)]);
        maxxyz(ii,:) = max([maxxyz(ii,:); max(M)]);
        
        % Jerks
        ii = 4; [~,M] = gradient(M);
        minxyz(ii,:) = min([minxyz(ii,:); min(M)]);
        maxxyz(ii,:) = max([maxxyz(ii,:); max(M)]);

    end
    
    TRIAL{trial}.P = Pt;
    PAR.minXYZ = minxyz;
    PAR.maxXYZ = maxxyz;
    PAR.spanXYZ = maxxyz - minxyz;
end
