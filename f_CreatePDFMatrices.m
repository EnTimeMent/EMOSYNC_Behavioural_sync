function [Y,G,PDFS] = f_CreatePDFMatrices(TRIAL,PAR)

% TRIAL{k}.Person: {'P1'  'P2'  'P3'}
% For each (trial,person) Y = (emotion,trial,person)
% for each Person in trial {'P1'  'P2'  'P3'}
%   for each point [S(x,y,z),E(x,y,z),W(x,y,z)]
%       for each coordinate 
% calculate density of positions of the coordinate
% calculate density of speeds of the coordinate
% calculate density of accelerations of the coordinate
% calculate density of jerks of the coordinate
% This will give 4 pdf vectors of 9 x nbpoints 
% pdf vectors of each coordinate will be aligned with min of min
% and max of max of that coordinate
% A LeftRight oriented 3-graph as function of y-pdf of Elbow and/or Wrist
% Vertices 1, 2, 3 of this graph are fixed in anticlockwise
% G = [0, right,left;left,0,right;right,left,0]
% right = y < 0; left : y >=0
% z < 0 down; z >= 0 upp
% xShoulder < 0 backward; % xShoulder >= 0 forward;
% iywrist = 8;
% trial =
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
NBPDF = PAR.NbPdfPoints;
NCOL = 3 * NPOINTS * NBPDF; % 3 = DIM; 9 * 30 = 270
N = NTRIAL * NPERSON;

% Outputs
values = zeros(N,3); % Y(i,:) = [Emotion,Trial,Person]
GLR = cell(NTRIAL,1); % Graph Left-Right NPERSON x NPERSON matrix
PosPDF = zeros(N,NCOL); PosPDFx = zeros(N,NCOL);
PosMin = Inf(1,3 * NPOINTS); PosMax = -PosMin;
SpePDF = zeros(N,NCOL); SpePDFx = zeros(N,NCOL);
SpeMin = Inf(1,3 * NPOINTS); SpeMax = -PosMin;
AccPDF = zeros(N,NCOL); AccPDFx = zeros(N,NCOL);
AccMin = Inf(1,3 * NPOINTS); AccMax = -PosMin;
JerPDF = zeros(N,NCOL); JerPDFx = zeros(N,NCOL);
JerMin = Inf(1,3 * NPOINTS); JerMax = -PosMin;

row = 0; iywrist = 8;
for trial = 1 : NTRIAL
    
    glf = zeros(NPERSON);   
    Pt = TRIAL{trial}.P; % Persons of trial
    
    for person = 1 : NPERSON
        
        row = row + 1;
        
        values(row,:) = [TRIAL{trial}.y,trial,person];
        
        % Get person
        Pp = Pt{person}; [~,n] = size(Pp);
        
        for c = 1 : n
            
            x = Pp(:,c); x = sort(x);
            
            % Filter min and max values
            K = ceil(0.02 * T);
            x = x(K+1 : T - K);
            
            % Filter the OUTLIER values of x            
%             x = f_HistFilter(x,200,0.10);
            
            % Calculate the right place of pdf(x) in PDF matrices            
            C1 = (c-1)*NBPDF + 1; C2 = c * NBPDF;
            IC = C1 : C2;
            
            % POS Calculate the pdf of x
            [f,xi] = f_PdfCdf(x,NBPDF,'pdf');                         
            PosPDF(row,IC) = f; PosPDFx(row,IC) = xi;
            PosMin(c) = min(PosMin(c),min(xi));
            PosMax(c) = max(PosMax(c),max(xi));

            % Update GLF
            % G = [0, right,left;left,0,right;right,left,0]
            % right = y < 0; left : y >=0
            if c == iywrist
                dxi = xi(2) - xi(1);
                v = dxi * sum(f);
                right = dxi * sum(f(xi<0));
                left  = dxi * sum(f(xi>=0));
                if person == 1, glf(person,:) = [0,right,left]; end
                if person == 2, glf(person,:) = [left,0,right]; end
                if person == 3, glf(person,:) = [right,left,0]; end
            end
            % SPEED Calculate the pdf of
            x = gradient(x);
            [f,xi] = f_PdfCdf(x,NBPDF,'pdf');
            SpePDF(row,IC) = f; SpePDFx(row,IC) = xi;
            SpeMin(c) = min(SpeMin(c),min(xi));
            SpeMax(c) = max(SpeMax(c),max(xi));

            % ACCELERATION Calculate the pdf of x
            x = gradient(x);
            [f,xi] = f_PdfCdf(x,NBPDF,'pdf');
            AccPDF(row,IC) = f; AccPDFx(row,IC) = xi;
            AccMin(c) = min(AccMin(c),min(xi));
            AccMax(c) = max(AccMax(c),max(xi));

            % JERK Calculate the pdf of x
            x = gradient(x);
            [f,xi] = f_PdfCdf(x,NBPDF,'pdf');
            JerPDF(row,IC) = f; JerPDFx(row,IC) = xi;
            JerMin(c) = min(JerMin(c),min(xi));
            JerMax(c) = max(JerMax(c),max(xi));            
        end       
    end
    GLR{trial} = glf;
end
% [PosMin;PosMax]
% [SpeMin;SpeMax]
% [AccMin;AccMax]
% [JerMin;JerMax]

% Align densities
PosPDFX = zeros(1,NCOL);
SpePDFX = zeros(1,NCOL);
AccPDFX = zeros(1,NCOL);
JerPDFX = zeros(1,NCOL);

for b = 1 : 3 * NPOINTS
    block = (b-1)*NBPDF+1 : b*NBPDF;
    
    % POS Get the block
    B = PosPDF(:,block); Bx = PosPDFx(:,block);
    xmin = PosMin(b);xmax = PosMax(b);
    xmin1 = min(min(Bx)); xmax1 = max(max(Bx));
    xb = linspace(xmin,xmax,NBPDF);
    B1 = f_AlignPDF(Bx,B,xb);
    EE = max(max(abs(B-B1)));
    
    PosPDFX(block) = xb; PosPDF(:,block) = B1;
    
    % SPEED Get the block
    B = SpePDF(:,block); Bx = SpePDFx(:,block);
    xmin = SpeMin(b);xmax = SpeMax(b);
    xmin1 = min(min(Bx)); xmax1 = max(max(Bx));
    xb = linspace(xmin,xmax,NBPDF);
    B1 = f_AlignPDF(Bx,B,xb);
    EE = max(max(abs(B-B1)));    
    SpePDFX(block) = xb; SpePDF(:,block) = B1;
    
    % Acceleration Get the block
    B = AccPDF(:,block); Bx = AccPDFx(:,block);
    xmin = AccMin(b);xmax = AccMax(b);
    xmin1 = min(min(Bx)); xmax1 = max(max(Bx));
    xb = linspace(xmin,xmax,NBPDF);
    B1 = f_AlignPDF(Bx,B,xb);
    EE = max(max(abs(B-B1)));    
    AccPDFX(block) = xb; AccPDF(:,block) = B1;

    % JERK Get the block
    B = JerPDF(:,block); Bx = JerPDFx(:,block);
    xmin = JerMin(b);xmax = JerMax(b);
    xmin1 = min(min(Bx)); xmax1 = max(max(Bx));
    xb = linspace(xmin,xmax,NBPDF);
    B1 = f_AlignPDF(Bx,B,xb);
    EE = max(max(abs(B-B1)));    
    JerPDFX(block) = xb; JerPDF(:,block) = B1;
end

% Outputs
Y.Columns = {'Emotion','Trial','Person'};
Y.Values = values;
G.Structure = {'0','right','left';'left','0','right';'right','left','0'};
G.GLR = GLR;
PDFS.PosPDFX = PosPDFX; PDFS.PosPDF = PosPDF; 
PDFS.SpePDFX = SpePDFX; PDFS.SpePDF = SpePDF; 
PDFS.AccPDFX = AccPDFX; PDFS.AccPDF = AccPDF; 
PDFS.JerPDFX = JerPDFX; PDFS.JerPDF = JerPDF; 
