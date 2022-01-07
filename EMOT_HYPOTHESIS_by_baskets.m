% EMOTION HYPOTHESIS
% H1
% H2

clear all; clc; close all;

GLOBAL_; % global variables

% 1. Create Learn Scenario
SCENARIO.NAME = 'EMOT_GROUP_05_07';
% CreateLearnScenario_SLOW;
% CreateLearnScenario_22_06
% CreateLearnScenario_05_07;

% Load Scenario
nameS = [SCENARIO.NAME,'.mat'];
D = load(nameS); %,'SCENARIO')
SCENARIO = D.SCENARIO
%              NAME: 'EMOT_GROUP_05_07'
%                 Q: 'Detect_Emotions_Solo_Group'
%              xpdf: [1×77 double]
%              span: [2×1 double]
%                 X: [819×77 double]
%          features: {'NormVelocity_Hand'}
%     namesfeatures: {1×77 cell}
%                 y: [819×1 double]
%             namey: 'Emotion'
%                 Y: [819×7 double]
%           YHeader: {'Triad'  'Order'  'NoGroupTrial'  'NoIndividualTrial'  'RELindex'  'Person'  'Emotion'}
%             VALUE: {819×1 cell}
%               EMD: [819×819 double]

Y = SCENARIO.Y;
% H1
EMOT = SCENARIO.Y(:,7);
emdz = SCENARIO.EMD; %[emot,iemot] = sort(EMOT); emd = emd(iemot,iemot);
% emdz = triu(emdz,1);

% emot = EMOT == EPOSITIVE; DP = emdz(emot,emot); DP = DP(:);
% emot = EMOT == ENEUTRAL; D0 = emdz(emot,emot);  D0 = D0(:);
% emot = EMOT == ENEGATIVE; DN = emdz(emot,emot); DN = DN(:);
% P = anova1([DN,D0,DP]);



% H2
for condition  = 101:102 % NOT 1 and 2 so not to get mistaken in R when transfer the data to words
    
    if condition == 101 % group
        trial_column = 3;
        % I0 = Y(:,trial_column) > 0;
    elseif condition == 102 % solo
        trial_column = 4;
        % I0 = Y(:,trial_column) > 0;   % logical operator of the needed condition
    end
    
    for triad = 1 : NTRIAD
        
        I0 = Y(:,1) == triad; % logical vector. Identify the needed triad
        % G0 = Y(:,3) > 0; % detect the solo OR group trials
        G0 = Y(:,trial_column) > 0; % detect the solo OR group trials
        ITG0 = and(I0,G0); % logical. Overlay OR "Cross" Triad with Trial
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % EXTRACT and SORT by EMOTION
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        e0 = Y(ITG0,7); % extract the Condition
        Z0 =  emdz(ITG0,ITG0); % extract the needed CONDITION + TRIAD
        [e0,ie0] = sort(e0); % Sort by Emotion
        Z0 = Z0(ie0,ie0); %
        ZZ0 = triu(Z0,1); % take the upper part WITHOUT the diagonal line
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Take the ROW & COL numbers for each EMOTION
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        IrowsNeg = e0 == -1; % logical. Negative emotions
        IrowsNeutr = e0 == 0; % logical. Nuetral state
        IrowsPos = e0 == 1; % logical. Positive emotions
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Create the 6 BASKETS for pairwise comparison
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        MNegNeg = ZZ0(IrowsNeg,IrowsNeg);
        MNegNeutr = ZZ0(IrowsNeg,IrowsNeutr);
        MNegPos = ZZ0(IrowsNeg,IrowsPos);
        MNeutrNeutr = ZZ0(IrowsNeutr,IrowsNeutr);
        MNeutrPos = ZZ0(IrowsNeutr,IrowsPos);
        MPosPos = ZZ0(IrowsPos,IrowsPos);
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Take the values from each BASKET
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        NegNeg = MNegNeg(MNegNeg ~= 0);
        NegNeutr = MNegNeutr(MNegNeutr ~= 0);
        NegPos = MNegPos(MNegPos ~= 0);
        NeutrNeutr = MNeutrNeutr(MNeutrNeutr ~= 0);
        NeutrPos = MNeutrPos(MNeutrPos ~= 0);
        PosPos = MPosPos(MPosPos ~= 0);
        
        vector_for_the_loop = ["NegNeg", "NegNeutr", "NegPos", ...
            "NeutrNeutr", "NeutrPos", "PosPos"];
        
        
        %%%%%%%%%%%%%%%%%%%%
        % FINALIZE on a loop
        %%%%%%%%%%%%%%%%%%%%
        for i = 1 : length(vector_for_the_loop)
            
            %%%%%%%%%%%%%%%%%%%%%%%%%
            % Set the other variables
            %%%%%%%%%%%%%%%%%%%%%%%%%
            emot = vector_for_the_loop{i}; FINAL = eval(emot); %
            nFINAL = length(FINAL); % detect the needed SIZE for adding TRIAD + ORDER + EMOTION
            
            % set the TRIAD number
            notriad = zeros(nFINAL,1) + triad;
            
            % set the ORDER number
            % XX the order number is in 2nd col of Y
            rt = rem(triad,2);
            order_number = 2;
            if rt == 1
                order_number = 1;
            end
%             if triad == 1 || triad == 3 || triad == 5 || triad == 7 || triad == 9 || triad == 11 || triad == 13
%                 order_number = 1;
%             elseif triad == 2 || triad == 4 || triad == 6 || triad == 8 || triad == 10 || triad == 12
%                 order_number = 2;
%             else
%                 disp('No triad number is found')
%             end
            no_order= zeros(nFINAL,1) + order_number;
            
            %set the EMOTION
            emotion = zeros(nFINAL,1) + i; % 1- NegNeg; 2 - NegNEutr; 3 - NegPos; ...

            
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % CONCATENATE ALLTOGETHER
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%
            result = [notriad, no_order, emotion, FINAL];
            
            if condition == 101 && triad == 1 && i == 1
                RESULTS = result;
            else
                RESULTS = [RESULTS; result];
            end 
            
        end 
    end
end

% Write matrix
% save('IMS_GMS_by_basket.csv','RESULTS','-ascii')
writematrix(RESULTS,'IMS_GMS_by_basket.csv') 