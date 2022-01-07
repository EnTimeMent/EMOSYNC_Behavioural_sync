function F = f_Features_1(DATA,Parameters) %(GTRIAL,ITRIAL)

% Calculates for each couple (X,y) --> (F(EATURES), y)
% F.VALUES - will change for each feature
% F.SPAN - the min, max interval of ALL values in F.VALUES
% F.XPDF = linspace(F.SPAN,NPDFBINS) - see GLOBAL_
% F.PDF(k,:) - probability distribution function of F.VALUES{k}
% F.FEATURESNAMES{c} - names of columns of F.PDF

GLOBAL_;
% F.VALUES = cell(N,1);
% F.XPDF = NaN; F.PDF = NaN; F.FEATURESNAMES = NaN;

switch Parameters.FeatureName
    
    case 'Hand3TriangleOrientation' % TRIAD Feature
        [TRIAD,GROUP,EMOT,VALUES] = FEATUREHand3TriangleOrientation(DATA);
        FN = {Parameters.FeatureName};
        AN = {'_X','_Y','_Z'};
        
    case 'Hand3TriangleArea' % TRIAD Feature
        [TRIAD,GROUP,EMOT,VALUES] = FEATUREHand3TriangleArea(DATA);
        FN = {Parameters.FeatureName};
        AN = {'_'};
        
    case 'TriadGaze' % TRIAD Feature
        [TRIAD,GROUP,EMOT,VALUES] = FEATURETriadGaze(DATA);
        FN = {'GAZE'};
        AN = {'12_','13_','21_','23_','31_','32_'};
        
    case 'HeadOrientation'
        % 2D signed angle of Normal to Lhead --> Rhead vector with solid bissector
        % which is locally the y axis
        % angle > 0, person looks right
        % angle < 0, person looks left
        
        VALUES = FEATUREHeadOrientation(DATA.VICON);
        FN = {Parameters.FeatureName};
        AN = {'_'}; % nothing to add                
        
    case 'HandOrientation'
        % 2D angle of Shoulder --> Hand vector with solid bissector
        % which is locally the y axis
        
        VALUES = FEATUREHandOrientation(DATA.VICON);
        FN = {Parameters.FeatureName};
        AN = {'_'}; % nothing to add
        
    case 'D3HandAngles'
        % 3D angles of upper normal to triangle (LW,RW,H) with local axes
        
        VALUES = FEATURED3HandAngles(DATA.VICON);
        FN = {Parameters.FeatureName};
        AN = {'_X','_Y','_Z'};
        
    case 'D3ArmAngles'
        % 3D angles of normal to trianble (S,E,H) with local axes
        
        VALUES = FEATURED3ArmAngles(DATA.VICON);
        FN = {Parameters.FeatureName};
        AN = {'_X','_Y','_Z'};
        
    case 'AireTriangleSEH' % triangle shoulder, elbow, mi-wrist
        % Aire of triangle (S, E, µWrist)
        
        VALUES = FEATUREAireTriangleSEH(DATA.VICON);
        FN = {Parameters.FeatureName};
        AN = {'_'};
        
    case 'DistHeadHand'
        
        % Euclidian distance Head / Hand
        VALUES = FEATUREDDistHeadHand(DATA.VICON);
        FN = {Parameters.FeatureName};
        AN = {'_'};
        
    case 'Position'
        
        % Positions all points
        N = length(DATA.VICON);
        VALUES = cell(N,NMARKERS);
        FN = MARKERSNAMES;
        for k = 1 : NMARKERS
            FN{k} = ['POS_',FN{k}];
        end
        AN = {'_X','_Y','_Z'};
        for m = 1 : NMARKERS
            mm = MARKERSNAMES{m};
            cols = getfield(MARKERSCOLINDEX,mm);
            for v = 1 : N
                V = DATA.VICON{v};
                VALUES{v,m} = V(:,cols);
            end
        end
        
    case 'Velocity'
        
        % Velocity of all points
        N = length(DATA.VICON); VALUES = cell(N,NMARKERS);
        FN = MARKERSNAMES;
        for k = 1 : NMARKERS
            FN{k} = ['VEL_',FN{k}];
        end
        AN = {'_X','_Y','_Z'};
        
        for m = 1 : NMARKERS
            mm = MARKERSNAMES{m};
            cols = getfield(MARKERSCOLINDEX,mm);
            for v = 1 : N
                V = DATA.VICON{v};
                VX = V(:,cols); [~,dx] = size(VX);
                for k = 1 : dx
                    VX(:,k) = gradient(VX(:,k));
                end
                VALUES{v,m} = VX;
            end
        end
        
    case 'Acceleration'
        
        % Acceleration of all points
        N = length(DATA.VICON); VALUES = cell(N,NMARKERS);
        FN = MARKERSNAMES;
        for k = 1 : NMARKERS
            FN{k} = ['ACC_',FN{k}];
        end
        AN = {'_X','_Y','_Z'};
        
        for m = 1 : NMARKERS
            mm = MARKERSNAMES{m};
            cols = getfield(MARKERSCOLINDEX,mm);
            for v = 1 : N
                V = DATA.VICON{v};
                VX = V(:,cols); [~,dx] = size(VX);
                for k = 1 : dx
                    VX(:,k) = gradient(VX(:,k));
                    VX(:,k) = gradient(VX(:,k));
                end
                VALUES{v,m} = VX;
            end
        end
        
    case 'Jerk'
        
        % Jerk of all points
        N = length(DATA.VICON); VALUES = cell(N,NMARKERS);
        FN = MARKERSNAMES;
        for k = 1 : NMARKERS
            FN{k} = ['JER_',FN{k}];
        end
        AN = {'_X','_Y','_Z'};
        
        for m = 1 : NMARKERS
            mm = MARKERSNAMES{m};
            cols = getfield(MARKERSCOLINDEX,mm);
            for v = 1 : N
                V = DATA.VICON{v};
                VX = V(:,cols); [~,dx] = size(VX);
                for k = 1 : dx
                    VX(:,k) = gradient(VX(:,k));
                    VX(:,k) = gradient(VX(:,k));
                    VX(:,k) = gradient(VX(:,k));
                end
                VALUES{v,m} = VX;
            end
        end
        
    case 'QuantityOfMovement'
        
        % QoM of all points
        N = length(DATA.VICON); VALUES = cell(N,NMARKERS);
        FN = MARKERSNAMES;
        for k = 1 : NMARKERS
            FN{k} = ['QOM_',FN{k}];
        end
        AN = {'_'};
        
        for m = 1 : NMARKERS
            mm = MARKERSNAMES{m};
            cols = getfield(MARKERSCOLINDEX,mm);
            for v = 1 : N
                V = DATA.VICON{v}; % Position
                VX = V(:,cols); [tx,dx] = size(VX);
                for k = 1 : dx
                    VX(:,k) = gradient(VX(:,k)); % Velocity
                    VX(:,k) = gradient(VX(:,k)); % Acceleration
                end
                % QoM = norm(Acceleration)
                Q = zeros(tx,1);
                for k = 1 : tx
                    Q(k) = norm(VX(k,:));
                end
                VALUES{v,m} = Q;
            end
        end
        % END CASE
end

if Parameters.TriadFeature
    F.TRIAD = TRIAD;
    F.GROUP = GROUP;
    F.EMOT = EMOT;
end

N = length(VALUES(:,1));

% Calculate the SPAN of F.VALUES
F.VALUES = VALUES;
[NVALUES,DVALUES] = size(VALUES);

F.SPAN = cell(1,DVALUES);
F.XPDF = cell(1,DVALUES);
F.PDF = cell(1,DVALUES);
F.FEATURESNAMES = cell(1,DVALUES);

for dvalues = 1 : DVALUES
    
    VALUE = VALUES(:,dvalues);     
    % TF = isoutlier(A,method) specifies a method for detecting outliers. For example, isoutlier(A,'mean') returns true for all elements more than three standard deviations from the mean.
    % TF = isoutlier(A,'percentiles',threshold) defines outliers as points outside of the percentiles specified in threshold. The threshold argument is a two-element row vector containing the lower and upper percentile thresholds, such as [10 90].
    V1 = cell2mat(VALUE);
    [~,d] = size(V1); SPAN = zeros(2,d);
    TF1 = isoutlier(V1,'percentile',[1 95]); % nTF1 = sum(TF1);
    
    for k = 1 : d
        vk = V1(not(TF1(:,k)),k);
        SPAN(:,k) = [min(vk); max(vk)];
    end
        %1 = [min(V1);max(V1)];
%     figure(7), histogram(V1,101), disp([SPAN,SPAN1])
    F.SPAN{dvalues} = SPAN;

    % Generate XPDF and names
    % FN = Parameters.FeatureName;
    % AN = {''}; % nothing to add
    XPDF = zeros(1,d * NPDFBINS);
    FEATURESNAMES = cell(1,d * NPDFBINS);
    for k = 1 : d
        c1 = (k-1) * NPDFBINS + 1;
        c2 = k * NPDFBINS;
        XPDF(:,c1 : c2) = linspace(SPAN(1,k),SPAN(2,k),NPDFBINS);
        
        for p = c1 : c2
            r = [num2str(p+1-c1)];
            FEATURESNAMES{p} = [FN{dvalues},AN{k},r];
        end
    end
    F.XPDF{dvalues} = XPDF;
    F.FEATURESNAMES{dvalues} = FEATURESNAMES;
    
    % ... and finally calculate the pdfs
    PDF = zeros(N,d * NPDFBINS);
    for v = 1 : N
        Fv = VALUE{v};
        for k = 1 : d
            c1 = (k-1) * NPDFBINS + 1;
            c2 = k * NPDFBINS;
            xpdf = XPDF(:,c1 : c2);
            xmin = min(xpdf); xmax = max(xpdf);
            % Beware of OUTLIERS            
            xv = Fv(:,k);
            ixv = and(xv >= xmin, xv <= xmax);
            xv = xv(ixv);
            [pdfv,xi] = f_PdfCdf(xv,NPDFBINS,xmin, xmax, 'pdf');
            
            PDF(v,c1 : c2) = pdfv;
        end
    end
    F.PDF{dvalues} = PDF;
end
