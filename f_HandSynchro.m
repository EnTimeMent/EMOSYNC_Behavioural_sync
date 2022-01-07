function [YI,YG,IHANDS,GHANDS] = f_HandSynchro(GTRIAL,ITRIAL)

GLOBAL_;

% X, Y of R_head and L_head
xyz = [true,true,false];
shoulder = MARKERSCOLINDEX.R_shoulder(xyz);
handi = MARKERSCOLINDEX.Hand(xyz);
lwrist = MARKERSCOLINDEX.L_wrist(xyz);
rwrist = MARKERSCOLINDEX.R_wrist(xyz);

gtrial = length(GTRIAL);
itrial = length(ITRIAL);

GH = cell(ngroup,1); % Hand
GLW = GH; GRW = GH; GS = GH; % Left Wrist; Right Wrist ; Shoulder

YI = zeros(itrial,2); % Y(k,1) = participant; Y(k,2) - emotion
YG = zeros(gtrial,2*ngroup); % Y(k,1:3) - P1, P2, P3; Y(k,4:6)=[E1,E2,E3]

GHANDS = cell(gtrial,1);

for tr = 1 : gtrial    
    trial = GTRIAL{tr};
    % .OriginalFile: 'Trial10_P1Em2_P2em1_P3Em2.csv'
    % .Group: 10, .Emotion: [2 1 2]; .P: {1×3 cell}
    YG(tr,1:3) = 1:3;
    YG(tr,4:6) = trial.Emotion;
    for p = 1 : ngroup
        GS{p} = trial.P{p}(:,shoulder);
        GH{p} = trial.P{p}(:,handi);
        GLW{p} = trial.P{p}(:,lwrist);
        GRW{p} = trial.P{p}(:,rwrist);
    end
    % Calculate Indices for Hand Dynamics
    Gh = f_HandDynamics(GS,GH,GLW,GRW);
    GHANDS{tr} = Gh;
end

for tr = 1 : itrial    
    trial = ITRIAL{tr};
    %     OriginalFile: 'Loop1_P1_Em2.csv'
    %      Participant: 1
    %          Emotion: 2
    %                y: 2
    %           Person: 4
    %                A: [3000×27 double]
    YI(tr,1) = trial.Participant; %: 1
    YI(tr,2) = trial.Emotion; %: 2

    iS = trial.A(:,shoulder);
    disp([GS{YI(tr,1)}(1:10,:),iS(1:10,:)])
    iH = trial.A(:,handi);
    iLW = trial.A(:,lwrist);
    iRW = trial.A(:,rwrist);
    % Inherited from groups
%     for p = 1 : ngroup
%         GS{p} = trial.P{p}(:,shoulder);
%         GH{p} = trial.P{p}(:,handi);
%         GLW{p} = trial.P{p}(:,lwrist);
%         GRW{p} = trial.P{p}(:,rwrist);
%     end
    % Calculate Indices for Hand Dynamics
    noparticipant = YI(tr,1);
    % INdividual Trial is ALLWAYS into POS 1 !!!
    Ih = f_HandDynamicsInd(GS,GH,GLW,GRW,iS,iH,iLW,iRW,noparticipant);
    IHANDS{tr} = Ih;
end
