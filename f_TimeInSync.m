function TIS = f_TimeInSync(opmt,DT) % , Period, NumbPer, sampFreq)

% Author: Carmela Calabrese
% Input:
% - orderParamTime: degree of phase synchronization in time after the removal of
%                   the perceptual stimuli (e.g., visual/acoustic coupling)
% USES
% Parameters.TypicalCycleDuration = 1.5; % seconds
% Parameters.NumbCyclesinSync = 3; % significant nb. of cycles group is able to keep in sync
% % - Period = typical period of the oscillation
% % - NumbPer= minimum amount of period required to define synchronization
% % - level= level of synchronization detected with LevelR.m (it does not
% %          apply to trials 'Not in sync')
% % - sampFreq= sampling frequency of the signal;
% 
% Output:
% - TIS: time in synchronization after the removal of the perceptual
%        stimuli. It is the first time instant such that Levelr<Weak if the
%        players stayed in sync (Levelr>Weak) after closing their eyes for at
%        least 3 consecutive period

GLOBAL_CHRONOS;

TIS = 0; % default
NCS = Parameters.NumbCyclesinSync;
TCD = Parameters.TypicalCycleDuration;
% Significant number of samples to be in sync
MinNbofSamplesInSync = round(NCS * TCD * TRIALFREQUENCY);
% PeriodInSamp = round(NumbPer*Period*sampFreq);

z = getfield(SYNCTHRESHOLD,'weaksync');
% Level_r_min = min(z); %0.7;

% temp = length(find(orderParamTime > Level_r_min));
NINS = sum(opmt >= min(z));
if NINS >= MinNbofSamplesInSync
%     TIS = NINS / TRIALFREQUENCY; %sampFreq;
    TIS = NINS * DT;
    TIS = min(TIS,TRIALDURATION);
end