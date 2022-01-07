function [] = F_VisuHeadSynchro(HEADSYNCHRO,FigureFolder)

GLOBAL_;
ntrial = length(HEADSYNCHRO);

trial0 = [6,13,23]; 
for tr = 23 : 23 %; % = 1 : 1 % ntrial
%     tr = trial0(k);
    % HEADSYNCHRO{tr} = {P,LH,RH,B,N,K3,S1,S2,S3};
    headsyn = HEADSYNCHRO{tr}; r = 0;
    r = r+1; P = headsyn{r};  % midpoint Left Right participant = 1:3
    r = r+1; L = headsyn{r};  % Left point participant = 1:3
    r = r+1; R = headsyn{r};  % Right point participant = 1:3
    r = r+1; B = headsyn{r};  % Bissector vectors for participant = 1:3
    r = r+1; N = headsyn{r};  % Normal vectors for participant = 1:3
    r = r+1; K3 = headsyn{r}; % K3* for Coupling
    r = r+1; S1= headsyn{r};  % Edge Attraction Unsigned angles proche de pi <-> LOOK
    % <N{1}(t,:),N{2}(t,:)>, <N{1}(t,:),N{3}(t,:)>, <N{2}(t,:),N{3}(t,:)>
    S1 = S1/pi; % normalize 1 is the best    
    r = r+1; S2 = headsyn{r};  % Signed angles
    % S2 - Signed Angle between Normals and Bissectors
    % ! Be careful with order B, N
    % S2(t,p) > 0, N looks at the right of B
    % S2(t,p) < 0, N looks at the left  of B
    r = r+1; S3 = headsyn{r};  % Sum IN degrees into K3* - Leadership
    s3 = sum(S3,2);
    [T,~] = size(S1); % Time index
    for k = 1 : T, S3(k,:) = S3(k,:)/s3(k); end
    
    % Calculate axis min max for triangles 
    z = zeros(3,2); Z = z;
    z(1,:) = min([P{1};P{2};P{3}]); Z(1,:) = max([P{1};P{2};P{3}]);
    z(2,:) = min([L{1};L{2};L{3}]); Z(2,:) = max([L{1};L{2};L{3}]);
    z(3,:) = min([R{1};R{2};R{3}]); Z(3,:) = max([R{1};R{2};R{3}]);
    zz = min(z) - 50; ZZ = max(Z) + 50;
    axtriangle = [zz(1), ZZ(1), zz(2), ZZ(2)];


    ax = (1:T)'; cc = {'-r','-g','-b'}; nofigfile = 0;
    
    for t0 = 1 : 5 : T % 777;
        
        nofig = 0;         
        % Edge Synchronization
        ms1 = min(min(S1)); MS1 = max(max(S1));
        nofig = nofig +1; figure(nofig), clf, hold on
        plot(ax,S1(:,1),cc{1},ax,S1(:,2),cc{2},ax,S1(:,3),cc{3},...
            [t0,t0],[ms1,MS1],':k','LineWidth',2)
        legend('P1 vs. P2', 'P1 vs. P3', 'P2 vs. P3')
        grid on, title('Bi-Connection'), hold off
        
        % Individual orientations
        % S2(t,p) > 0 (<0), N looks right (left) of B
        ms2 = min(S2); MS2 = max(S2);
        Stext = {'P1 looks P3','P1 looks P2';...
                 'P2 looks P1','P2 looks P3'; ...
                 'P3 looks P2','P3 looks P1'};
        nofig = nofig +1; figure(nofig), clf
        for p = 1 : ngroup
            subplot(3,1,p), hold on
            plot(ax,S2(:,p),cc{p},[t0,t0],[MS2(p),ms2(p)],':k','LineWidth',2)
            text([5,5],[MS2(p),ms2(p)],Stext(p,:))
            grid on
            if p == 1, title('Head Orientations'); end
        end
        
        % Leadership
        ms3 = min(min(S3)); MS3 = max(max(S3));
        nofig = nofig +1; figure(nofig), clf, hold on
        plot(ax,S3(:,1),cc{1},ax,S3(:,2),cc{2},ax,S3(:,3),cc{3})
        plot([t0,t0],[MS3,ms3],':k','LineWidth',2)
        legend('Lead P1','Lead P2','Lead P3')
        grid on, title('Information Exhange'), hold off
        
        % TRIANGLE
        Vt = [P{1}(t0,:);P{2}(t0,:);P{3}(t0,:)]; % Vertices of Triangle
        Lt = [L{1}(t0,:);L{2}(t0,:);L{3}(t0,:)]; % Left Head
        Rt = [R{1}(t0,:);R{2}(t0,:);R{3}(t0,:)]; % Right Head
        Bt = [B{1}(t0,:);B{2}(t0,:);B{3}(t0,:)]; % Bissector Vectors
        Nt = [N{1}(t0,:);N{2}(t0,:);N{3}(t0,:)]; % Normal Vectors
        S3t = S3(t0,:);
        htriangle = s_PlotTriangle(Vt,Lt,Rt,Bt,Nt,S3t,nofig,axtriangle);
        
        % Save Figure to *.jpg file
        nofigfile = nofigfile + 1;
        namefile = [FigureFolder,'\T',num2str(nofigfile)];
        saveas(htriangle,namefile, 'jpg')
        'aaa'
    end % for t0
    'AAA'
end

% %%% SUB f
function hfig = s_PlotTriangle(V,L,R,B,N,S3,nofig,axtriangle)

% Plots a triangle and bissectors and normals
GLOBAL_;
% Calculations
% 1. Intersection of bissectors
% D1(z) = V(1,:) + z * B(1,:) = V(2,:) + z * B(2,:);
% V(1,:) - V(2,:) = (B(2,:) - B(1,:)) * z;
b21 = (B(2,:) - B(1,:)); v12 = V(1,:) - V(2,:);
z0 = (v12 * b21') / (b21*b21');
B0 = V(1,:) + z0 * B(1,:); % Intersection point
L0 = 0.5*norm(B0-V(1,:));

% Calculate end points for normals
N0 = zeros(ngroup,2);
for p = 1 : ngroup
    N0(p,:) = V(p,:) + L0 * N(p,:) / norm(N(p,:));
end

C = {'or','sr','*r';'og','sg','*g';'ob','sb','*b'};
CL = {'-r','-g','-b'};

nofig = nofig +1;
hfig = figure(nofig); clf, hold on
hL = zeros(ngroup,1); % legend handles
% Plot triangle
v = [V;V(1,:)]; plot(v(:,1),v(:,2),':k')

% Define leader
[s3,is3] = sort(S3,'descend'); Slead = {'Coupling:';'';'';''};
for p = 1 : ngroup
    Slead{p+1} = ['P',num2str(is3(p)),' : ',num2str(s3(p),2)];
end

for p = 1 : ngroup
    % Vertices of Triangle and Left Right points
    hL(p) = plot(V(p,1),V(p,2),C{p,1});
    plot(L(p,1),L(p,2),C{p,2},R(p,1),R(p,2),C{p,3})
    
    % Plot Bissectors
    x = [V(p,1),B0(1)]; y = [V(p,2),B0(2)];
    plot(x,y,CL{p})
    
    % Plot Normals
    x = [V(p,1),N0(p,1)]; y = [V(p,2),N0(p,2)];
    plot(x,y,CL{p},'LineWidth',2)
end

grid on, axis(axtriangle)
title('Normals and Bissectors')
legend(hL,{'P1','P2','P3'},'Location','bestoutside')

xlim = get(gca,'XLim');%: [-600 800]
lead1 = max(xlim)+10;
lead2 = 0; %max(V(:,2));
text(lead1,lead2,Slead)

