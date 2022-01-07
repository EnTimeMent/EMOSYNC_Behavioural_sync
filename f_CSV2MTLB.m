function TRIAL = f_CSV2MTLB(pathD,Parameters)

FNS = dir([pathD,'*.csv']);
NTRIALS  = numel(FNS);

TRIAL = cell(NTRIALS,1);

wmv = Parameters.WidthMissingValues;

for tr = 1 : NTRIALS
    fN = FNS(tr).name;
    % 1. Transform data from *.csv to matlab structure
    FILENAME = [pathD,fN];
    trial.OriginalFile = fN;
    trial.y = Y_Import(FILENAME);
    trial.Person = {'P1','P2','P3'};
    trial.Point = {'Shoulder','Elbow','Wrist'};
    trial.Coord = {'X','Y','Z'};
    
    % Trajectories
    PL = PI_Import(FILENAME);
    A = table2array(PL);
    A = A(:,2 : end);
    
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
    trial.P{1} = A(:,Parameters.P1P2P3(1,:));
    trial.P{2} = A(:,Parameters.P1P2P3(2,:));
    trial.P{3} = A(:,Parameters.P1P2P3(3,:));
    
    TRIAL{tr} = trial;
end