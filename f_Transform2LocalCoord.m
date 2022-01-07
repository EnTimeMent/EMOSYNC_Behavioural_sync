function VL = f_Transform2LocalCoord(DATA,Parameters)

% Transform each vicon matrix to local coordinates (see GLOBAL_)
% Calculates transform matrices to pass from global (O,I,J,K) coord to 
% local (O1,I1,J1,K1)
% Local Origins O1 are the coordinates of triangle vertices (see GLOBAL_.m)
% z_local_origin = HEIGHT (see GLOBAL_)
% J1 is the bissector of the angle
% I1 is J1 clockwise rotated with pi/2
% K1 = K = [0,0,1]';

GLOBAL_;
HEIGHT = TRIANGLEVERTICES(1,3); % 1980 mm
[T1,T2,T3] = TransformMatrixtoLocalXYZ(Parameters);

% Column of Y containing the person and position = 1, 2, 3
personcol = 0;
for k = 1 : length(DATA.YHeader)
    ck = DATA.YHeader{k};
    if strcmp(ck,'RELindex'), personcol = k; break; end    
end

% col index of markers
ff = fieldnames(MARKERSCOLINDEX); nff = length(ff);

% Z of R_head and L_head
zrhead = MARKERSCOLINDEX.R_head([false,false,true]);
zlhead = MARKERSCOLINDEX.L_head([false,false,true]);

N = length(DATA.FileNames); VL = cell(N,1);

for k = 1 : N
    
    V = DATA.VICON{k}; V1 = V;
    person = DATA.Y(k,personcol);
    fichier = DATA.FileNames{k};
    
    % Find the right Transform Matrix from person
    P = zeros(1,3); P(person) = 1;
    T = P(1)*T1 + P(2)*T2 + P(3)*T3;
    
    % Find the right origin of coordinates
    origin = TRIANGLEVERTICES(person,:);

    [t,~] = size(V); UN = ones(t,1);
    
    % Shift X s.t. z(mean(Head)) = HEIGHT = 1800 
    mul = mean(V(:,zlhead));
    mur = mean(V(:,zrhead));
    mu = 0.5 * (mean(V(:,zlhead)) + mean(V(:,zrhead)));
    SHIFT = [0,0,HEIGHT - mu];
    
    for f = 1 : nff
        cols = getfield(MARKERSCOLINDEX,ff{f});
        
        if strcmp(ff{f},'Hand'), handcols = cols; end
        
        v = V(:,cols);
        
        % Do the shift
        v = v + UN * SHIFT;
        
        % Do the transform of coordinates
        ORIGIN = UN * origin;
        v1 = inv(T) * (v - ORIGIN)';
        
        % Put it into the right place
        V1(:,cols) = v1';
    end    
 
    VL{k} = V1;
    
    if Parameters.Visu
        % Plot Hand in old and new coord
        figure(7)
        handold = V(:,handcols);
        handnew = V1(:,handcols);
        subplot(121), plot(handold(:,1),handold(:,2),'.k')
        title(['Person: ',num2str(person)])
        subplot(122), plot(handnew(:,1),handnew(:,2),'.k')
        title(['Person: ',num2str(person)])        
    end   
end