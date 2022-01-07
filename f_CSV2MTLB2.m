function GROUPTRIAL = f_CSV2MTLB2(pathD,Parameters)

GLOBAL_;

FNS = dir([pathD,'Trial*.csv']); NTRIALS  = numel(FNS);
GROUPTRIAL = cell(NTRIALS,1);

wmv = Parameters.WidthMissingValues;

for tr = 1 : NTRIALS
    fN = FNS(tr).name;
    % 1. Transform data from *.csv to matlab structure
    FILENAME = [pathD,fN];
    trial.OriginalFile = fN;
%     ip = strfind(fN,'_P');
%     trial.Participant = str2double(fN(ip+2));
%     iem = strfind(fN,'_E');
%     trial.Emotion = str2double(fN(iem+3));     
%     trial.y = trial.Emotion;
    
    % Extract the n° of original individual and 
    % names and order of markers
    [group,emotion,markers] = Y_Import2(FILENAME);
    trial.Group = group;
    trial.Emotion = emotion;    
    % Return indices of columns for each fixes markers's place (GLOBAL_)
    ICOL = f_ReturnColumnInd2(markers);
    
    % Trajectories
    A = importGroupTrial(FILENAME);%, startRow, endRow)
    A = table2array(A);  
    A = A(:,2 : end);  A = A(:,ICOL); % Markers are in fixed order
    
    % Look for NaN Values in A
    if any(any(isnan(A)))
        % Fill missing values
        d = numel(A(1,:));
        for i = 1 : d
            pp = A(:,i); cp = any(isnan(pp));
            while cp
                pp = fillmissing(pp,'movmedian',wmv);
                cp = any(isnan(pp));
            end
            A(:,i) = pp;
        end
    end
%     trial.A = A;
    
    trial.P{1} = A(:,Parameters.P1P2P3(1,:));
    trial.P{2} = A(:,Parameters.P1P2P3(2,:));
    trial.P{3} = A(:,Parameters.P1P2P3(3,:));
    
    GROUPTRIAL{tr} = trial;
end