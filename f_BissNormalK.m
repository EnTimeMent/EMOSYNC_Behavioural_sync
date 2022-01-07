function [B,N,K3,S1,S2,S3] =  f_BissNormalK(P,LH,RH)

% For each t calculate
% The bissector B{p}(t,:) of each angle P{1}(t,:),P{2}(t,:),P{3}(t,:)
% The normal N{p}(t,:) at P{p}(t,:) of vector LH{p}(t,:) --> RH{p}(t,:)
% S1 : The angles - near pi means two persons look each other
% <N{1}(t,:),N{2}(t,:)>, <N{1}(t,:),N{3}(t,:)>, <N{2}(t,:),N{3}(t,:)>
% S2 : The angles - < 0 looks Right; > 0 looks left
% <N{p}(t,:),B{p}(t,:)>, p = 1 : ngroup

GLOBAL_;

% Init
T = length(P{1}(:,1));
B = cell(1,ngroup); N = B; K3 = B; 
for p = 1 : ngroup
    B{p} = zeros(T,2); N{p} = zeros(T,2);
end
S1 = zeros(T,ngroup); S2 = S1; S3 = S1;

FlagVisu = true;

for t = 1 : T
    
    IP = [1,2,3; 2,1,3; 3,1,2];
    for p = 1 : ngroup        
        % Bissectrices
        ip = IP(p,:);
        a = P{ip(1)}(t,:); b = P{ip(2)}(t,:); c = P{ip(3)}(t,:);
        bi = Bissector(a,b,c);
        B{p}(t,:) = bi;
        
        % Normals        
        L = LH{p}(t,:); R = RH{p}(t,:);
        n = ClockWiseNormal(L,R);
        N{p}(t,:) = n;
        
        % S2 - Signed Angle between Normals and Bissectors
        % ! Be careful with order B, N
        % S2(t,p) > 0, N looks at the right of B
        % S2(t,p) < 0, N looks at the left  of B
        angle = SignedAngle(B{p}(t,:),N{p}(t,:));
        S2(t,p) = angle;                
    end
    
    % Transform S2(t,:) into a K3* : V = {1,2,3}
    % K3* = [0,L,R; R,0,L; L,R,0]
    K3t = f_TransformSignedAnglesK3(S2(t,:));
    K3{t} = K3t; 
    s3t = sum(K3t); % Normalized IN-Degrees
    S3(t,:) = s3t;
    
    % S1 - 3 normals available - calculate angles
    % <N{1}(t,:),N{2}(t,:)>, <N{1}(t,:),N{3}(t,:)>, <N{2}(t,:),N{3}(t,:)>
    p = 1; a = N{1}(t,:); b = N{2}(t,:);
    angle = SignedAngle(a,b);
    S1(t,p) = abs(angle);  
    p = 2; a = N{1}(t,:); b = N{3}(t,:);
    angle = SignedAngle(a,b);
    S1(t,p) = abs(angle);
    p = 3; a = N{2}(t,:); b = N{3}(t,:);
    angle = SignedAngle(a,b);
    S1(t,p) = abs(angle); 
end