% GLOBAL_CHRONOS

global NGROUPS GROUPSIZE NTRIALS;
NGROUPS = 15; GROUPSIZE = 4; NTRIALS = 54;

global TRIALDURATION TRIALFREQUENCY;
TRIALDURATION = 45; % MilliSeconds
TRIALFREQUENCY = 55; % Hertz
global TABLETRIALEMOTDELAY;
global Parameters;
global YCOLS;
YCOLS = struct('person',1,'group',2,'player',3,'trial',4,'emot',5,'delay',6);
global SYNCTHRESHOLD SYNCLEVELS;
SYNCTHRESHOLD = struct('nosync',[0,0.7],'weaksync',[0.7,0.85],...
                'mediumsync',[0.85, 0.95],'highsync',[0.95, 1]);
SYNCLEVELS = fieldnames(SYNCTHRESHOLD);
            