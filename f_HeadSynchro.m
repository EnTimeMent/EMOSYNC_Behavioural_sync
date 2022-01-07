function HEADSYNCHRO = f_HeadSynchro(GROUPTRIAL)

GLOBAL_;

ntrial = length(GROUPTRIAL);

% X, Y of R_head and L_head
xyz = [true,true,false];
rhead = MarkerColInd.R_head(xyz);
lhead = MarkerColInd.L_head(xyz);
LH = cell(ngroup,1); RH = LH; P = LH; bP = zeros(3,2);

HEADSYNCHRO = cell(ntrial,1);

for tr = 1 : ntrial
    
    trial = GROUPTRIAL{tr};
    % .OriginalFile: 'Trial10_P1Em2_P2em1_P3Em2.csv'
    % .Group: 10, .Emotion: [2 1 2]; .P: {1×3 cell}
    for p = 1 : ngroup
        LH{p} = trial.P{p}(:,lhead);
        RH{p} = trial.P{p}(:,rhead);
        P{p} = 0.5 * (LH{p}+RH{p});
        bP(p,:) = mean(P{p});
    end
    % Calculate Indices for Head LOOK Synchro
    [B,N,K3,S1,S2,S3] =  f_BissNormalK(P,LH,RH);
    HEADSYNCHRO{tr} = {P,LH,RH,B,N,K3,S1,S2,S3};   
end