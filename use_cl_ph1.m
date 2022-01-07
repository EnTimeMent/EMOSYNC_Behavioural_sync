% USE_CL_Ph

% clear all, close all

TSfilename = 'Hands_6.csv'; %F1_Rich.csv'; %    : data file
TSnumber = 3; %    : number of time series
TSsamplerate = 100; % : sample rate of the time series
TSfsamp = 10; %       : first data point in time series used
TSlsamp = 2990; %6000 ; %    : last data point in time series used
plotflag =1; %     : do plots (0=no, 1=yes)
TITLE = 'Trial 6 : Positive Emotion';
[GRPrhoM INDrhoM INDrpM TSrhoGRP TSrpIND] = ClusterPhase_do(TSfilename, TSnumber, TSfsamp, TSlsamp, TSsamplerate, plotflag,TITLE)

