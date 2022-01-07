function [] = f_VisualizeFeatures(F,Parameters) %(GTRIAL,ITRIAL)

% Visualize and describe Features 
% F.VALUES - will change for each feature
% F.SPAN - the min, max interval of ALL values in F.VALUES
% F.XPDF = linspace(F.SPAN,NPDFBINS) - see GLOBAL_
% F.PDF(k,:) - probability distribution function of F.VALUES{k}
% F.FEATURESNAMES{c} - names of columns of F.PDF

GLOBAL_;

switch Parameters.FeatureName
   
    case 'Hand3TriangleOrientation' % TRIAD Feature
        % F =
        %             TRIAD: [195×1 double]
        %             GROUP: [195×1 double]
        %              EMOT: [195×1 double]
        %            VALUES: {195×1 cell}
        %              SPAN: {[2×3 double]}
        %              XPDF: {[1×231 double]}
        %               PDF: {[195×231 double]}
        %     FEATURESNAMES: {{1×231 cell}}
        % FN = {Parameters.FeatureName}; AN = {'_X','_Y','_Z'};
        nofig = 0;
        
        TRIAD = F.TRIAD; GROUP = F.GROUP; EMOT = F.EMOT;
        VALUES = F.VALUES{1}; PDF = F.PDF{1}; XPDF = F.XPDF{1};
        span = F.SPAN{1};
        i1 =  1 : NPDFBINS; x1 = XPDF(i1);
        i2 = i1 + NPDFBINS; x2 = XPDF(i2);
        i3 = i2 + NPDFBINS; x3 = XPDF(i3);
        
        individual = 7; Vii = F.VALUES{individual}; Pii = PDF(individual,:);        
        tr = [' Triad: ',num2str(TRIAD(individual))];
        gr = [' Group: ',num2str(GROUP(individual))]; 
        em = [' Emotion: ',num2str(EMOT(individual))];
        
        FN = [Parameters.FeatureName,'.']; %        AN = {'_'};
        
        nofig = nofig + 1; figure(nofig), clf        
        subplot(121), cla
        ax = (1 : length(Vii(:,1)))';
        plot(ax,Vii(:,1),'-k',ax,Vii(:,2),'-b',ax,Vii(:,3),'-r')
        legend('Cos Angle X','Cos Angle Y','Cos Angle Z')
        xlabel('Time [ms]'), ylabel('Cosines of Angles')
        title([FN,tr,gr,em]), grid on
        
        subplot(122), cla
        plot(x1,Pii(i1),'-k',x2,Pii(i2),'-b',x3,Pii(i3),'-r')
        xlabel('Cosine of Angles'), ylabel('PDF')
        title([FN,tr,gr,em]), grid on
        
        nofig = nofig + 1; figure(nofig), clf
                
        EP = EMOT == EPOSITIVE;  ET = EMOT == ENEUTRAL; EN = EMOT == ENEGATIVE; 
        
        subplot(131), cla, hold on
        ind = i1; x = x1; sxlabel = 'Cossine X Angles';
        pdfEP = PDF(EP,ind); meanEP = mean(pdfEP);
        pdfET = PDF(ET,ind); meanET = mean(pdfET);
        pdfEN = PDF(EN,ind); meanEN = mean(pdfEN);        
        plot(x,pdfEP',':r',x,pdfET',':b',x,pdfEN',':k')
        h = plot(x,meanEP,'-r',x,meanET,'-b',x,meanEN,'-k','LineWidth',1.5);
        slegend = {'E Positive','E Neutral','E Negative'};
        legend(h,slegend)        
        title('Overall Emotions'), xlabel(sxlabel), ylabel('PDF')
        grid on
        
        subplot(132), cla, hold on
        ind = i2; x = x2; sxlabel = 'Cossine Y Angles';
        pdfEP = PDF(EP,ind); meanEP = mean(pdfEP);
        pdfET = PDF(ET,ind); meanET = mean(pdfET);
        pdfEN = PDF(EN,ind); meanEN = mean(pdfEN);        
        plot(x,pdfEP',':r',x,pdfET',':b',x,pdfEN',':k')
        h = plot(x,meanEP,'-r',x,meanET,'-b',x,meanEN,'-k','LineWidth',1.5);
        slegend = {'E Positive','E Neutral','E Negative'};
        legend(h,slegend)        
        title('Overall Emotions'), xlabel(sxlabel), ylabel('PDF')
        grid on

        subplot(133), cla, hold on
        ind = i3; x = x3; sxlabel = 'Cossine Z Angles';
        pdfEP = PDF(EP,ind); meanEP = mean(pdfEP);
        pdfET = PDF(ET,ind); meanET = mean(pdfET);
        pdfEN = PDF(EN,ind); meanEN = mean(pdfEN);        
        plot(x,pdfEP',':r',x,pdfET',':b',x,pdfEN',':k')
        h = plot(x,meanEP,'-r',x,meanET,'-b',x,meanEN,'-k','LineWidth',1.5);
        slegend = {'E Positive','E Neutral','E Negative'};
        legend(h,slegend)        
        title('Overall Emotions'), xlabel(sxlabel), ylabel('PDF')
        grid on
        
    case 'Hand3TriangleArea' % TRIAD Feature
        
        nofig = 0;        
        % [TRIAD,GROUP,EMOT,VALUES] = FEATUREHand3TriangleArea(DATA);
        % F =         TRIAD: [195×1 double]
        %             GROUP: [195×1 double]
        %              EMOT: [195×1 double]
        %            VALUES: {195×1 cell}
        %              SPAN: {[2×1 double]}
        %              XPDF: {[1×77 double]}
        %               PDF: {[195×77 double]}
        %     FEATURESNAMES: {{1×77 cell}}
        TRIAD = F.TRIAD; GROUP = F.GROUP; EMOT = F.EMOT;
        VALUES = F.VALUES{1}; PDF = F.PDF{1}; XPDF = F.XPDF{1};
        
        individual = 7; 
        tr = [' Triad: ',num2str(TRIAD(individual))];
        gr = [' Group: ',num2str(GROUP(individual))]; 
        em = [' Emotion: ',num2str(EMOT(individual))];
        Vii = F.VALUES{individual};
        Pii = PDF(individual,:);
        
        FN = [Parameters.FeatureName,'.']; %        AN = {'_'};
        
        nofig = nofig + 1; figure(nofig), clf        
        subplot(121), cla
        plot(Vii,'-b'), xlabel('Time [ms]'), ylabel('Area [mm²]')
        title([FN,tr,gr,em]), grid on
        
        subplot(122), grid on
        plot(XPDF,Pii,'-b'), xlabel('Area [mm²]'), ylabel('PDF')
        title([FN,tr,gr,em]), grid on
        
        nofig = nofig + 1; figure(nofig), clf
        hold on
        EP = EMOT == EPOSITIVE; meanEP = mean(PDF(EP,:));
        ET = EMOT == ENEUTRAL; meanET = mean(PDF(ET,:));
        EN = EMOT == ENEGATIVE; meanEN = mean(PDF(EN,:));
        
        plot(XPDF,PDF(EP,:)',':r',XPDF,PDF(ET,:)',':b',XPDF,PDF(EN,:)',':k')
        h = plot(XPDF,meanEP,'-r',XPDF,meanET,'-b',XPDF,meanEN,'-k','LineWidth',1.5);
        slegend = {'E Positive','E Neutral','E Negative'};
        legend(h,slegend)        
        title('Overall Emotions'), xlabel('Area [mm²]'), ylabel('PDF')
        grid on
        
    case 'TriadGaze' % TRIAD Feature
        %         [TRIAD,GROUP,EMOT,VALUES] = FEATURETriadGaze(DATA);
        % F =         TRIAD: [195×1 double]
        %             GROUP: [195×1 double]
        %              EMOT: [195×1 double]
        %            VALUES: {195×1 cell}
        %              SPAN: {[2×6 double]}
        %              XPDF: {[1×462 double]}
        %               PDF: {[195×462 double]}
        %     FEATURESNAMES: {{1×462 cell}}
        % FN = {'GAZE'}; AN = {'12_','13_','21_','23_','31_','32_'};    
        
        nofig = 0;
        TRIAD = F.TRIAD; GROUP = F.GROUP; EMOT = F.EMOT;
        VALUES = F.VALUES{1}; PDF = F.PDF{1}; XPDF = F.XPDF{1};
        span = F.SPAN{1};
        i1 =  1 : NPDFBINS; x1 = XPDF(i1);
        i2 = i1 + NPDFBINS; x2 = XPDF(i2);
        i3 = i2 + NPDFBINS; x3 = XPDF(i3);
        i4 = i3 + NPDFBINS; x4 = XPDF(i1);
        i5 = i4 + NPDFBINS; x5 = XPDF(i2);
        i6 = i5 + NPDFBINS; x6 = XPDF(i3);
        
        individual = 7; Vii = F.VALUES{individual}; Pii = PDF(individual,:);        
        tr = [' Triad: ',num2str(TRIAD(individual))];
        gr = [' Group: ',num2str(GROUP(individual))]; 
        em = [' Emotion: ',num2str(EMOT(individual))];
        
        FN = [Parameters.FeatureName,'.'];
        
        nofig = nofig + 1; figure(nofig), clf        
        subplot(121), cla, hold on
        ax = (1 : length(Vii(:,1)))';
        thres = cos(pi/6) + zeros(size(ax));
        plot(ax,Vii(:,1),'-k',ax,Vii(:,2),':k')
        plot(ax,Vii(:,3),'-b',ax,Vii(:,4),':b')
        plot(ax,Vii(:,5),'-r',ax,Vii(:,6),':r')
        plot(ax,thres,'-g','LineWidth',1.5)
        
        
        legend('Gaze(1,2)','Gaze(1,3)','Gaze(2,1)',...
               'Gaze(2,3)','Gaze(3,1)','Gaze(3,2)','Threshold')
        xlabel('Time [ms]'), ylabel('Cosines of Angles')
        title([FN,tr,gr,em]), grid on
        
        subplot(122), cla, hold on
        plot(x1,Pii(i1),'-k',x2,Pii(i2),':k')
        plot(x3,Pii(i3),'-b',x4,Pii(i4),':b')
        plot(x5,Pii(i5),'-r',x6,Pii(i6),':r')
        xlabel('Cosine of Angles'), ylabel('PDF')
        legend('Gaze(1,2)','Gaze(1,3)','Gaze(2,1)',...
               'Gaze(2,3)','Gaze(3,1)','Gaze(3,2)')
        title([FN,tr,gr,em]), grid on
        
        nofig = nofig + 1; figure(nofig), clf
                
        EP = EMOT == EPOSITIVE;  ET = EMOT == ENEUTRAL; EN = EMOT == ENEGATIVE; 
        
        subplot(131), cla, hold on
        ind = i1; x = x1; sxlabel = 'Cossine X Angles';
        pdfEP = PDF(EP,ind); meanEP = mean(pdfEP);
        pdfET = PDF(ET,ind); meanET = mean(pdfET);
        pdfEN = PDF(EN,ind); meanEN = mean(pdfEN);        
        plot(x,pdfEP',':r',x,pdfET',':b',x,pdfEN',':k')
        h = plot(x,meanEP,'-r',x,meanET,'-b',x,meanEN,'-k','LineWidth',1.5);
        slegend = {'E Positive','E Neutral','E Negative'};
        legend(h,slegend)        
        title('Overall Emotions'), xlabel(sxlabel), ylabel('PDF')
        grid on
        
        subplot(132), cla, hold on
        ind = i2; x = x2; sxlabel = 'Cossine Y Angles';
        pdfEP = PDF(EP,ind); meanEP = mean(pdfEP);
        pdfET = PDF(ET,ind); meanET = mean(pdfET);
        pdfEN = PDF(EN,ind); meanEN = mean(pdfEN);        
        plot(x,pdfEP',':r',x,pdfET',':b',x,pdfEN',':k')
        h = plot(x,meanEP,'-r',x,meanET,'-b',x,meanEN,'-k','LineWidth',1.5);
        slegend = {'E Positive','E Neutral','E Negative'};
        legend(h,slegend)        
        title('Overall Emotions'), xlabel(sxlabel), ylabel('PDF')
        grid on

        subplot(133), cla, hold on
        ind = i3; x = x3; sxlabel = 'Cossine Z Angles';
        pdfEP = PDF(EP,ind); meanEP = mean(pdfEP);
        pdfET = PDF(ET,ind); meanET = mean(pdfET);
        pdfEN = PDF(EN,ind); meanEN = mean(pdfEN);        
        plot(x,pdfEP',':r',x,pdfET',':b',x,pdfEN',':k')
        h = plot(x,meanEP,'-r',x,meanET,'-b',x,meanEN,'-k','LineWidth',1.5);
        slegend = {'E Positive','E Neutral','E Negative'};
        legend(h,slegend)        
        title('Overall Emotions'), xlabel(sxlabel), ylabel('PDF')
        grid on        
        
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
                Vii = DATA.VICON{v};
                VALUES{v,m} = Vii(:,cols);
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
                Vii = DATA.VICON{v};
                VX = Vii(:,cols); [~,dx] = size(VX);
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
                Vii = DATA.VICON{v};
                VX = Vii(:,cols); [~,dx] = size(VX);
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
                Vii = DATA.VICON{v};
                VX = Vii(:,cols); [~,dx] = size(VX);
                for k = 1 : dx
                    VX(:,k) = gradient(VX(:,k));
                    VX(:,k) = gradient(VX(:,k));
                    VX(:,k) = gradient(VX(:,k));
                end
                VALUES{v,m} = VX;
            end
        end
        
    case 'QuantityOfMovement'
        
        % THIS IS Individual feature (see F below)
        %         F.VALUES: {819×9 cell}
        %         F.SPAN: {1×9 cell}
        %         F.XPDF: {1×9 cell}
        %         F.PDF: {1×9 cell}
        %         FEATURESNAMES: {1×9 cell}
        
        % % TRIAD = F.TRIAD; GROUP = F.GROUP;
        
        % Parameters.YHeader = DATA.YHeader;
        % {'Triad'},{'Order'},{'NoGroupTrial'},{'NoIndividualTrial'}
        % {'RELindex'},{'Person'},{'Emotion'}
        
        % select Emotion from Parameters.Y
        TRIAD = Parameters.Y(:,1);
        GROUP = Parameters.Y(:,3); % 0 no-group, >0 number of group
        PERSON = Parameters.Y(:,6);
        EMOT = Parameters.Y(:,7);

        % Choose an Individual
        individual = 7; 
        INDIVSolo = and(PERSON == individual,GROUP == 0); 
        ISoloPos = and(INDIVSolo,EMOT == EPOSITIVE);
        ISoloNet = and(INDIVSolo,EMOT == ENEUTRAL);
        ISoloNeg = and(INDIVSolo,EMOT == ENEGATIVE);
        nsolo = sum(INDIVSolo);
        INDIVGroup = and(PERSON == individual,GROUP > 0);
        IGroupPos = and(INDIVGroup,EMOT == EPOSITIVE);
        IGroupNet = and(INDIVGroup,EMOT == ENEUTRAL);
        IGroupNeg = and(INDIVGroup,EMOT == ENEGATIVE);
        
        notriad = unique(TRIAD(INDIVGroup));
        ngroup = sum(INDIVGroup);

        % Choose a marker - Hand
        imarker = 6; % L_wrist % Hand
        namemarker = MARKERSNAMES{imarker};
               
        %         VALUESGroup = F.VALUES(INDIVGroup,imarker);
        %         PDFGroup = F.PDF{imarker}(INDIVGroup,:);
        XPDF = F.XPDF{imarker}; span = F.SPAN{imarker};
        
        nofig = 0;        
        % Is a Person different when Individual or Group       
        nofig = nofig + 1; figure(nofig), clf
        subplot(211)
        V = F.VALUES(INDIVSolo,imarker);
        n = length(V); T = length(V{1});
        Vsolo = reshape(cell2mat(V),T,n); moyS = mean(Vsolo,2);
        V = F.VALUES(INDIVGroup,imarker);
        n = length(V); T = length(V{1});
        Vgroup = reshape(cell2mat(V),T,n); moyG = mean(Vgroup,2);
        ax = (1 : T)';
        
        plot(ax,Vsolo,':b',ax,Vgroup,':r'), hold on
        h = plot(ax,moyS,'-b',ax,moyG,'-r','LineWidth',1.5);
        legend(h,{'Solo','Group'}), hold off, grid on
        xlabel('Time [ms]'), ylabel('QoM')
        title(['QoM, ',namemarker,', Person: ',num2str(individual)])
        
        subplot(212)
        Vsolo = F.PDF{imarker}(INDIVSolo,:)';
        Vgroup = F.PDF{imarker}(INDIVGroup,:)';
        moyS = mean(Vsolo,2); moyG = mean(Vgroup,2);        
        plot(XPDF,Vsolo,':b',XPDF,Vgroup,':r'), hold on
        h = plot(XPDF,moyS,'-b',XPDF,moyG,'-r','LineWidth',1.5);
        legend(h,{'Solo','Group'}), hold off, grid on
        xlabel('QoM span'), ylabel('pdf')
        title(['PDF of QoM, ',namemarker,', Person: ',num2str(individual)])

        'aa'
        % Are EMOTIONS Solo/Group Differentiables
        nofig = nofig + 1; figure(nofig), clf
        
        IZ = and(GROUP == 0,EMOT == EPOSITIVE);
        ZZ = F.PDF{imarker}(IZ,:); spo = mean(ZZ);
        IZ = and(GROUP == 0,EMOT == ENEUTRAL);
        ZZ = F.PDF{imarker}(IZ,:); snt = mean(ZZ);
        IZ = and(GROUP == 0,EMOT == ENEGATIVE);
        ZZ = F.PDF{imarker}(IZ,:); sne = mean(ZZ);
        IZ = and(GROUP > 0,EMOT == EPOSITIVE);
        ZZ = F.PDF{imarker}(IZ,:); gpo = mean(ZZ);
        IZ = and(GROUP > 0,EMOT == ENEUTRAL);
        ZZ = F.PDF{imarker}(IZ,:); gnt = mean(ZZ);
        IZ = and(GROUP > 0,EMOT == ENEGATIVE);
        ZZ = F.PDF{imarker}(IZ,:); gne = mean(ZZ);

        plot(XPDF,spo,':r',XPDF,gpo,'-r',XPDF,snt,':g',XPDF,gnt,'-g',...
            XPDF,sne,':b',XPDF,gne,'-b','LineWidth',1.5)
        legend('Solo +','Group +','Solo 0','Group 0','Solo -','Group -')
        xlabel('QoM span'), ylabel('mean pdf')
        title(['EMOT in PDF of QoM, ',namemarker])

%         subplot(231), cla, hold on
%         vv = F.VALUES(ISoloPos,imarker);
%         ax = (1 : length(vv{1}))';
%         
%         plot(ax,vv,'-k');
%         ,ax,Vii(:,2),':k')
%         plot(ax,Vii(:,3),'-b',ax,Vii(:,4),':b')
%         plot(ax,Vii(:,5),'-r',ax,Vii(:,6),':r')
%         plot(ax,thres,'-g','LineWidth',1.5)

%         % Vii = F.VALUES{individual,imarker}; % Acceleration XYZ of Hand
%         % Pii = F.PDF{imarker}(individual,:);
%         tr = [' Triad: ',num2str(notriad)];
%         % gr = [' Group: ',num2str(GROUP(individual))]; individual is in 15
%         % groups
%         em = [' Emotion: ',num2str(EMOT(individual))];
%         
%         
%         i1 =  1 : NPDFBINS; x1 = XPDF(i1);
%         i2 = i1 + NPDFBINS; x2 = XPDF(i2);
%         i3 = i2 + NPDFBINS; x3 = XPDF(i3);
%         i4 = i3 + NPDFBINS; x4 = XPDF(i1);
%         i5 = i4 + NPDFBINS; x5 = XPDF(i2);
%         i6 = i5 + NPDFBINS; x6 = XPDF(i3);
%         
%         
%         FN = [Parameters.FeatureName,'.'];
%         
%         nofig = nofig + 1; figure(nofig), clf        
%         subplot(121), cla, hold on
%         ax = (1 : length(Vii(:,1)))';
%         thres = cos(pi/6) + zeros(size(ax));
%         plot(ax,Vii(:,1),'-k',ax,Vii(:,2),':k')
%         plot(ax,Vii(:,3),'-b',ax,Vii(:,4),':b')
%         plot(ax,Vii(:,5),'-r',ax,Vii(:,6),':r')
%         plot(ax,thres,'-g','LineWidth',1.5)
%         
%         
%         legend('Gaze(1,2)','Gaze(1,3)','Gaze(2,1)',...
%                'Gaze(2,3)','Gaze(3,1)','Gaze(3,2)','Threshold')
%         xlabel('Time [ms]'), ylabel('Cosines of Angles')
%         title([FN,tr,gr,em]), grid on
%         
%         subplot(122), cla, hold on
%         plot(x1,Pii(i1),'-k',x2,Pii(i2),':k')
%         plot(x3,Pii(i3),'-b',x4,Pii(i4),':b')
%         plot(x5,Pii(i5),'-r',x6,Pii(i6),':r')
%         xlabel('Cosine of Angles'), ylabel('PDF')
%         legend('Gaze(1,2)','Gaze(1,3)','Gaze(2,1)',...
%                'Gaze(2,3)','Gaze(3,1)','Gaze(3,2)')
%         title([FN,tr,gr,em]), grid on
%         
%         nofig = nofig + 1; figure(nofig), clf
%                 
%         EP = EMOT == EPOSITIVE;  ET = EMOT == ENEUTRAL; EN = EMOT == ENEGATIVE; 
%         
%         subplot(131), cla, hold on
%         ind = i1; x = x1; sxlabel = 'Cossine X Angles';
%         pdfEP = PDF(EP,ind); meanEP = mean(pdfEP);
%         pdfET = PDF(ET,ind); meanET = mean(pdfET);
%         pdfEN = PDF(EN,ind); meanEN = mean(pdfEN);        
%         plot(x,pdfEP',':r',x,pdfET',':b',x,pdfEN',':k')
%         h = plot(x,meanEP,'-r',x,meanET,'-b',x,meanEN,'-k','LineWidth',1.5);
%         slegend = {'E Positive','E Neutral','E Negative'};
%         legend(h,slegend)        
%         title('Overall Emotions'), xlabel(sxlabel), ylabel('PDF')
%         grid on
%         
%         subplot(132), cla, hold on
%         ind = i2; x = x2; sxlabel = 'Cossine Y Angles';
%         pdfEP = PDF(EP,ind); meanEP = mean(pdfEP);
%         pdfET = PDF(ET,ind); meanET = mean(pdfET);
%         pdfEN = PDF(EN,ind); meanEN = mean(pdfEN);        
%         plot(x,pdfEP',':r',x,pdfET',':b',x,pdfEN',':k')
%         h = plot(x,meanEP,'-r',x,meanET,'-b',x,meanEN,'-k','LineWidth',1.5);
%         slegend = {'E Positive','E Neutral','E Negative'};
%         legend(h,slegend)        
%         title('Overall Emotions'), xlabel(sxlabel), ylabel('PDF')
%         grid on
% 
%         subplot(133), cla, hold on
%         ind = i3; x = x3; sxlabel = 'Cossine Z Angles';
%         pdfEP = PDF(EP,ind); meanEP = mean(pdfEP);
%         pdfET = PDF(ET,ind); meanET = mean(pdfET);
%         pdfEN = PDF(EN,ind); meanEN = mean(pdfEN);        
%         plot(x,pdfEP',':r',x,pdfET',':b',x,pdfEN',':k')
%         h = plot(x,meanEP,'-r',x,meanET,'-b',x,meanEN,'-k','LineWidth',1.5);
%         slegend = {'E Positive','E Neutral','E Negative'};
%         legend(h,slegend)        
%         title('Overall Emotions'), xlabel(sxlabel), ylabel('PDF')
%         grid on
%         
%         % QoM of all points
%         N = length(DATA.VICON); VALUES = cell(N,NMARKERS);
%         FN = MARKERSNAMES;
%         for k = 1 : NMARKERS
%             FN{k} = ['QOM_',FN{k}];
%         end
%         AN = {'_'};
%         
%         for m = 1 : NMARKERS
%             mm = MARKERSNAMES{m};
%             cols = getfield(MARKERSCOLINDEX,mm);
%             for v = 1 : N
%                 Vii = DATA.VICON{v}; % Position
%                 VX = Vii(:,cols); [tx,dx] = size(VX);
%                 for k = 1 : dx
%                     VX(:,k) = gradient(VX(:,k)); % Velocity
%                     VX(:,k) = gradient(VX(:,k)); % Acceleration
%                 end
%                 % QoM = norm(Acceleration)
%                 Q = zeros(tx,1);
%                 for k = 1 : tx
%                     Q(k) = norm(VX(k,:));
%                 end
%                 VALUES{v,m} = Q;
%             end
%         end
    % END CASE        
end
% 
% if Parameters.TriadFeature
%     F.TRIAD = TRIAD;
%     F.GROUP = GROUP;
%     F.EMOT = EMOT;
% end
% 
% N = length(VALUES(:,1));
% 
% % Calculate the SPAN of F.VALUES
% F.VALUES = VALUES;
% [NVALUES,DVALUES] = size(VALUES);
% 
% F.SPAN = cell(1,DVALUES);
% F.XPDF = cell(1,DVALUES);
% F.PDF = cell(1,DVALUES);
% F.FEATURESNAMES = cell(1,DVALUES);
% 
% for dvalues = 1 : DVALUES
%     
%     VALUE = VALUES(:,dvalues);
%     
%     [~,d] = size(VALUE{1});
%     SPAN = [Inf(1,d); -Inf(1,d)]; % [min...; max ...]
%     for v = 1 : N
%         m = min(VALUE{v});
%         SPAN(1,:) = min([SPAN(1,:);m]);
%         M = max(VALUE{v});
%         SPAN(2,:) = max([SPAN(2,:);M]);
%     end
%     F.SPAN{dvalues} = SPAN;
%     
%     % Generate XPDF and names
%     % FN = Parameters.FeatureName;
%     % AN = {''}; % nothing to add
%     XPDF = zeros(1,d * NPDFBINS);
%     FEATURESNAMES = cell(1,d * NPDFBINS);
%     for k = 1 : d
%         c1 = (k-1) * NPDFBINS + 1;
%         c2 = k * NPDFBINS;
%         XPDF(:,c1 : c2) = linspace(SPAN(1,k),SPAN(2,k),NPDFBINS);
%         
%         for p = c1 : c2
%             r = [num2str(p+1-c1)];
%             FEATURESNAMES{p} = [FN{dvalues},AN{k},r];
%         end
%     end
%     F.XPDF{dvalues} = XPDF;
%     F.FEATURESNAMES{dvalues} = FEATURESNAMES;
%     
%     % ... and finally calculate the pdfs
%     PDF = zeros(N,d * NPDFBINS);
%     for v = 1 : N
%         Fv = VALUE{v};
%         for k = 1 : d
%             c1 = (k-1) * NPDFBINS + 1;
%             c2 = k * NPDFBINS;
%             xpdf = XPDF(:,c1 : c2);
%             xmin = min(xpdf); xmax = max(xpdf);
%             xv = Fv(:,k);
%             [pdfv,xi] = f_PdfCdf(xv,NPDFBINS,xmin, xmax, 'pdf');
%             
%             PDF(v,c1 : c2) = pdfv;
%         end
%     end
%     F.PDF{dvalues} = PDF;
% end
