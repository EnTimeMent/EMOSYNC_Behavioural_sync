function [READG,READI,DATA] = f_CSV2MTLB0(pathD,Parameters)

% Create X and Y data from Vicon *.csv files
% To each Vicon file / Person (see GLOBAL_ variables)
% 1. Extract Vicon Matrix with columns put in the order of MARKERSNAMES
% If Group this gives three X matrices
% If Individual this gives one X matrix
% Nb.of X matrices=819=(15*3+18)*13=(NGROUPMEASURE*3+NINDMEASURE)*NTRIADS
% X matrices are treated for missing values/markers
% 2. To each X file is associated a y vector
% y = [triad, order, nogroup, noindividual, relativeindex, absoluteindex, emotion]

% Initialisation
GLOBAL_;
N = (NGROUPMEASURE*3+NINDMEASURE)*NTRIADS;
% global YHeader = {'Triad','Order','NoGroupTrial','NoIndividualTrial',...
%            'RELindex','Person','Emotion'};
DATA.YHeader = YHeader;
LY = length(DATA.YHeader);
DATA.Y = zeros(N,LY);
DATA.FileNames = cell(N,1);
DATA.VICON = cell(N,1);

% Get Triad Folders
folders = dir(pathD); nfold = length(folders);
FOLDERNAMES = cell(nfold,1); f = 0;
for k = 1 : nfold
    nk = folders(k).name;
    if contains(folders(k).name,'Group')
        f = f+1; FOLDERNAMES{f} = nk;
    end
end
FOLDERNAMES = FOLDERNAMES(1 : f); NTRIADS = numel(FOLDERNAMES);

% Read *.csv files in each folder and configure DATA.Y and DATA.VICON
ndata = 0; % it will attain N = 819

READG = 0; READI = 0;

for triad = 1 : NTRIADS
    
    fN = FOLDERNAMES{triad};
    % 0. Go To Folder fN
    folder = fullfile(pathD,fN);
    
    % 1. Get Files
    filesintriad = dir([folder,'\Triad*.csv']);
    nfilesintriad = length(filesintriad);
    
    for fichier = 1 : nfilesintriad
        fname = filesintriad(fichier).name;
        pathfile = fullfile(folder,fname);
        
        if contains(fname,'Group')
            disp([triad,fichier]), disp(fname)

            % Return Y Informations for Individuals of this group
            [trd,ord,G,I,relP,absP,E] = f_Y(fname); % [T,O,G,I,relP,absP,E] = f_Y(fname);
            
            % Get Marker's in data file
            markers = f_GetMarkersInViconFile2(pathfile,Parameters);
            
            % Load vicon data
            A = ImportGroup2Matrix(pathfile); A = A(:,2 : end);
            
            % Detect Entire NaN cols in A
            c = f_DetectNaNColumns(A,markers);
            
            % Fill eventual remaining missing values
            A = f_FillMissingValues(A,Parameters);
            
            % Find the right place of columns
            ICOL = f_ReturnColumnInd2(markers);
            A = A(:,ICOL); % Markers have fixed order (global MARKERSNAMES)
            
            % Put data in DATA
            for k = 1 : GROUPSIZE
                ndata = ndata + 1;
                DATA.FileNames{ndata} = fname;
                DATA.Y(ndata,:) = [trd,ord,G,I,relP(k),absP(k),E(k)];
                DATA.VICON{ndata} = A(:,Parameters.P1P2P3(k,:));
            end
            READG = READG + 1;
        end
        
        % Individual
        if contains(fname,'Individual')
            % Return Y Informations for Individuals of this group
            disp([triad,fichier]), disp(fname)
            [trd,ord,G,I,relP,absP,E] = f_Y(fname); % [T,O,G,I,relP,absP,E] = f_Y(fname);
            
            % Get Marker's in data file
            markers = f_GetMarkersInViconFile2(pathfile,Parameters);
            
            % Load vicon data
            A = ImportIndividual2matrix(pathfile); A = A(:,2 : end);
            
            % Detect Entire NaN cols in A
            c = f_DetectNaNColumns(A,markers);
            
            % Fill eventual remaining missing values
            A = f_FillMissingValues(A,Parameters);
            
            % Find the right place of columns
            ICOL = f_ReturnColumnInd1(markers);
            A = A(:,ICOL); % Markers have fixed order (global MARKERSNAMES)
            
            % Put data in DATA            
            ndata = ndata + 1;
            DATA.FileNames{ndata} = fname;
            DATA.Y(ndata,:) = [trd,ord,G,I,relP,absP,E];
            DATA.VICON{ndata} = A;
            
            READI = READI + 1;
        end
    end    
end

disp([READG, READI])
