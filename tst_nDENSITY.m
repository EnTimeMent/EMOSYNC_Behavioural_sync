% Estimate Multivariate Kernel Density Using Grids

clear all

p = pwd;
% Load the Hald cement data.
pp = '\\159.31.103.1\janaqi\Documents\MATLAB\Examples\stats';%\EstimateTheDensityOfMultivatiateDataExample';
isdir(pp)
cd(pp)
load 'hald'; %h = hald;
%
% The data measures the heat of hardening for 13 different cement
% compositions. The predictor matrix |ingredients| contains the percent
% composition for each of four cement ingredients. The response matrix
% |heat| contains the heat of hardening (in cal/g) after 180 days.

%
% Create a array of points at which to estimate the density. First, define
% the range and spacing for each variable, using a similar number of points
% in each dimension.
gridx1 = 0:2:22;
gridx2 = 20:5:80;
gridx3 = 0:2:24;
gridx4 = 5:5:65;

%
% Next, use |ndgrid| to generate a full grid of points using the defined
% range and spacing. 
% [x1,x2,x3,x4] = ndgrid(gridx1,gridx2,gridx3,gridx4);
[x1,x2] = ndgrid(gridx1,gridx2);
%
% Finally, transform and concatenate to create an array that contains 
% the points at which to estimate the density. This array has one column
% for each variable.
x1 = x1(:,:)';
x2 = x2(:,:)';
% x3 = x3(:,:)';
% x4 = x4(:,:)';
% xi = [x1(:) x2(:) x3(:) x4(:)];
xi = [x1(:) x2(:)];% x3(:) x4(:)];
%
% Estimate the density.
inGG = ingredients(:,1:2)
mi = min(inGG)
Mi = max(inGG)
[f,bw] = mvksdensity(inGG,xi,...
	'Bandwidth',[4.0579 10.7345 ],... % 4.4185 11.5466
	'Kernel','normpdf');

%
% View the size of |xi| and |f| to confirm that |mvksdensity| calculates
% the density at each point in |xi|.
[n,d] = size(x1);
F = reshape(f,n,d);
size_xi = size(xi)
surf(x1,x2,F)
size_f = size(f)
cd(p)