% CHRONOS_3AS : 
% 1. TimeInSync, TimeToSync ...

clear all, close all

% 1. Create Learn Scenario
SCENARIO.NAME = 'VISU_HAND_TSERIES';

% Load Scenario
% SCENARIO.NAME = 'EMOT_SINGLE_GROUP';
nameS = [SCENARIO.NAME,'.mat'];
D = load(nameS); %,'SCENARIO')
SCENARIO = D.SCENARIO
% NORMVELOC = D.NORMVELOC;
% NORMACCEL = D.NORMACCEL;
% %              NAME: 'VISU_HAND_TSERIES'
% %                 Q: 'Visualize_Hand_Velocity_timeseries'
% %              xpdf: [1×77 double] span: [2×1 double]
% %                 X: [819×77 double]
% %          features: {'NormVelocity_Hand_X'  'NormVelocity_Hand_Y'  'NormVelocity_Hand_Z'}
% %     namesfeatures: {1×77 cell}
% %                 y: [819×1 double] namey: 'Emotion'
% %                 Y: [819×7 double] YHeader: {1×7 cell}
% % SCENARIO.YHeader
% %     {'Triad'}    {'Order'}    {'NoGroupTrial'}    {'NoIndividualTrial'}    {'RELindex'}
% %     {'Person'}    {'Emotion'}
% 
% TRIAD = SCENARIO.Y(:,1); GROUPTRIAL = SCENARIO.Y(:,3);
% UT = (1:3000)' / ViconFrequency; % CHRONOS_1 
% SCENARIO.UNIQUETIMEINTERVAL = UT; % CHRONOS_1 
% 
% % % CHRONOS_2
% [VF,VPHASES] = f_CHRONOS_2(NORMVELOC',UT); % Warning Column of velocities
% % VF - velocity brought arround 0
% % VPHASES - phases of VF 
% [AF,APHASES] = f_CHRONOS_2(NORMACCEL',UT); % Warning Column of accelerations
% % AF - Accelerations brought arround 0
% % APHASES - phases of AF Warning
% SCENARIO.VF = VF;
% SCENARIO.VPHASES = VPHASES;
% SCENARIO.AF = AF;
% SCENARIO.APHASES = APHASES;
% 
% save(nameS,'SCENARIO')
% 
% 
% Parameters.Visu = true;
% Parameters.nofig = 0;
% Parameters.TypicalCycleDuration = 1.5; % seconds
% Parameters.NumbCyclesinSync = 3; % significant nb. of cycles group is able to keep in sync
% 
% ORDERPARAMTIME = cell(NGROUPS,NTRIALS);
% TYPICALCYCLEDURATION = zeros(NGROUPS,NTRIALS);
% 
% for group = 1 : NGROUPS
%     for trial = 1 : NTRIALS
%         
%         Igt = and(Y(:,YCOLS.group) == group, Y(:,YCOLS.trial) == trial);
%         
%         % 0. Calculate the number of cycles for this (group, trial)
%         Xgt = XF(:,Igt); [tgt,cgt] = size(Xgt); 
%        
%         NbCycles = zeros(1,cgt);
%         for k = 1 : cgt
%             minh = mean(abs(Xgt(:,k)));
%             [pk, lk] = findpeaks(Xgt(:,k),UT, 'MinPeakHeight', 0.1, 'MinPeakDistance', 0.6);
%             figure(1),plot(UT,Xgt(:,k),':k',lk,pk,'or')
%             'wait'
%             NbCycles(k) = length(lk);
%         end
%         NbGCycles = round(mean(NbCycles));
%         TYPICALCYCLEDURATION(group,trial) = TRIALDURATION / NbGCycles;
%         Parameters.TypicalCycleDuration = TRIALDURATION / NbGCycles;
%         
%         % 1. Extract the phase matrix of GROUPSIZE players in group for trial
%         
%         Pgt = XPHASES(:,Igt)';
%         
%         % 2. OrderParamTime = degree of phase synchronization in time
%         [opmt, orderParam, timephase] = orderParameter(Pgt);
%         
%         ORDERPARAMTIME{group,trial} = opmt;
%         
%         [level,thrlevel] = f_LevelR(opmt);
%         TTS = f_TimeToSync(opmt, thrlevel, UT);
%         DT = UT(2) - UT(1);
%         TIS = f_TimeInSync(opmt,DT);
%         
%         if Parameters.Visu
%             thr1 = thrlevel + zeros(1,length(opmt));
%             thr0 = min(getfield(SYNCTHRESHOLD,'weaksync')) + zeros(1,length(opmt));
%             figure(3), clf
%             plot(UT,opmt,'-k',UT,thr1,'-r',UT,thr0,'-b')
%             ylabel('Order Parameter and Threshold'), xlabel('Time [s]'), 
%             legend('Order Parameter','Sync Level','Weak Sync Level')
%             title(['Group / Trial: ', num2str([group,trial]),', T2S / TIS: ', num2str([TTS,TIS])])
%             grid on
%         end
%         'wait'
%     end
% end
% 
% OPMT = cell2mat(ORDERPARAMTIME);
% OPMT = OPMT(:);
% hist(OPMT,101)
