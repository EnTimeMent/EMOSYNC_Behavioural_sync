function [] = f_CompareHandSynchro(YI,YG,IHANDS,GHANDS)

% Visual comparizon of Individual and Group attitudes for
% emotions 1, 2, 3

GLOBAL_;
[nItrial,~] = size(YI); [nGtrial,~] = size(YG);

T = length(IHANDS{1});
SpeedI = zeros(nItrial,T); AccelI = SpeedI; % SpeedI(trI,:) = speeds of P indiv trial trI
SpeedG = cell(1,ngroup); AccelG = SpeedG;
for g = 1 : ngroup
    SpeedG{g} = zeros(nGtrial,T); % SpeedG{g}(trG,:) = speeds of P g in group trial trG
    AccelG{g} = zeros(nGtrial,T);
end

for tr = 1 : nItrial
    h = IHANDS{tr}'; SpeedI(tr,:) = gradient(h);
    AccelI(tr,:) = gradient(SpeedI(tr,:));
end
% GHANDS = 25×1 cell array  {3000×3 double}
for tr = 1 : nGtrial
    for g = 1 : ngroup
        h0 = GHANDS{tr}(:,g)';
        h1 = gradient(h0); h2 = gradient(h1);
        SpeedG{g}(tr,:) = h1; AccelG{g}(tr,:) = h2;
    end
end

% Calculate AbsSpeedMin, AbsSpeedMax, AbsAccelMin, AbsAccelMax
mMS = zeros(4,2); mMA = mMS;
mMS(1,1) = min(min(SpeedI)); mMS(1,2) = max(max(SpeedI));
mMA(1,1) = min(min(AccelI)); mMA(1,2) = max(max(AccelI));
for g = 1 : ngroup
    mMS(g+1,1) = min(min(SpeedG{g})); mMS(g+1,2) = max(max(SpeedG{g}));
    mMA(g+1,1) = min(min(AccelG{g})); mMA(g+1,2) = max(max(AccelG{g}));
end

% Common values for pdf calculations
BoundsS = [floor(min(mMS(:,1))),ceil(max(mMS(:,2)))];
BoundsA = [floor(min(mMA(:,1))),ceil(max(mMA(:,2)))]; %mMS, mMA
SpanSA = [BoundsS(2)-BoundsS(1),(BoundsA(2)-BoundsA(1))];
bandwSA = [SpanSA(1)/15, SpanSA(2)/25];
NPtsPdf = 125; delta = SpanSA/NPtsPdf;
s = BoundsS(1) : delta(1) : BoundsS(2); % speed values
a = BoundsA(1) : delta(2) : BoundsA(2); % acceleration values
[S,A] = ndgrid(s,a); S = S(:,:)'; A = A(:,:)'; SA = [S(:) A(:)];

% Figures of Interest
% 1. Three Emotions of Solo P1
for pa = 1 : ngroup
    PlotP1_3Emotions;
    
 
    % Figures of Interest
    % 2. Three Emotions of P1 Solo and in Group
    PLotP1SoloGroup;
    
    'a'
end










% figure(5), clf
% for em = 1 : 3
%     subplot(1,3,em),surf(S,A,F{em})
%     xlabel('1D Hand Speed'), ylabel('1D Hand Acceleration')
%     title(slegend{em})
% end
