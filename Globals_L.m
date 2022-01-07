% Globals_L : GLOBAL Parameters

global epsi; epsi = 1e05 * eps;
global MINSTEA MAXSTEA; MINSTEA = 0; MAXSTEA = 100;
global NbClasses; NbClasses = 3;
global Hist2Zero; Hist2Zero = 1;
global SmoothWidth; SmoothWidth = 5;
global NBVALHIST ; NBVALHIST = 255; 
global ClassThreshold; ClassThreshold = [-eps, 30; 30 50; 50 100];
global TargetError; TargetError = 4/100;
global nm; nm = 155;
global NBROWS; NBROWS = [54, 115, nm];