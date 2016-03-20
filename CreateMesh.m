%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Creating a .stl 3D surface from a .tif raster                         %%
%% Runa Magnusson for University of Amsterdam GIS-studio, May 2015       %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% read tif file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DEM = imread('dem_austria2.tif');
Y = 1:size(DEM,1);
X = 1:size(DEM,2);

% set nodata to NaN
DEM(find(DEM <= -9999)) = NaN;

% smooth a little bit to avoid too thin elements
h = 1/9*ones(3);
DEM = filter2(h,DEM);
% remove edges that have been smoothed incorrectly due to use of moving
% average, and ensure that there's 0's surrounding the model so that an
% edge is present in the 3D model
DEM(1:2,:) = NaN;
DEM((max(Y)-1):max(Y),:) = NaN;
DEM(:,1:2) = NaN;
DEM(:,(max(X)-1):max(X)) = NaN;

% set a minimum height to avoid thin walls
DEM = DEM + (3-min(DEM(:)));

% set nodata to 0
DEM(find(isnan(DEM))) = 0;

% convert to .stl
stlwrite('C:\Users\Runa\Documents\MountainPrint\Austria_GeoNew.stl',X,Y,DEM,'mode','ascii');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
