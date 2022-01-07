Package EMOSync

This package begins with raw VICON DATA of Emosync experiment

The traitments go through the following scripts

EMOSync_1.m
Read and organize the INDIVIDUAL REKORDS of VICON raw data in a cell 
structure containing N = (NGROUPMEASURE*3+NINDMEASURE)*NTRIADS cells
Fill missing values with the method of moving median with a window width = 10

EMOSync_2.m
Calculates Features from Vicon LOCAL and UNIVERSAL axes
In order to compare (GROUP experiment) the time-series of marker's positions 
a transformation of individual axis is done so as the movements are "parallel"
Then a set of TRIAD and INDIVIDUAL metrics are calculated:

% ORIGINAL AXES - TRIAD FEATURES
Parameters.TriadFeature = false; true;
Parameters.FeatureName = 'Hand3TriangleOrientation';
Parameters.FeatureName = 'Hand3TriangleArea';
Parameters.FeatureName = 'TriadGaze';

% LOCALAXES
Parameters.FeatureName = 'HeadOrientation';
Parameters.FeatureName = 'HandOrientation';
Parameters.FeatureName = 'D3HandAngles'; % 3D angles of normal to triangle (LW,RW,H) with local axes
Parameters.FeatureName = 'D3ArmAngles'; % 3D angles of normal to trianble (S,E,H) with local axes
Parameters.FeatureName = 'AireTriangleSEH'; % aire of triangle shoulder, elbow, mi-wrist
Parameters.FeatureName = 'DistHeadHand'; % Euclidian distance Head / Hand
Parameters.FeatureName = 'Position'; % Of all points see global MARKERSNAMES
Parameters.FeatureName = 'Velocity';
Parameters.FeatureName = 'Acceleration';
Parameters.FeatureName = 'Jerk';
Parameters.FeatureName = 'QuantityOfMovement';

For each marker and each feature name, the probability density of values is calculated 
in order to have a statistical description of that individual rekord

EMOSync_X.m
Connect a set of features with emotion by sparse learning (Lasso method)
Interestengly, a discrimination of emotions can be performed with the preceding features.
Particularly, HandOrientation, AireTriangleSEH, DistHeadHand, Hand NormVelocity, Hand Norm Acceleration,
Hand QuantityofMovement
