function [SkyFig, SkyImage] = PolarpassVisualizer(PassData)
%% ==========================================================
% Function : PolarpassVisualizer
%
% Purpose:
% Generates a professional sky plot from imported Gpredict
% pass data and exports the figure as a PNG image.
%
% Input:
%   PassData - Structure returned by ImportPass
%
% Output:
%   SkyFig   - Figure handle
%   SkyImage - Full path to exported PNG image
%
% Author  : Kishore T
% Version : 0.1.0
%% ==========================================================

%% Extract Pass Data

Azimuth = PassData.Azimuth;
Elevation = PassData.Elevation;

%% Convert Coordinates

Theta = deg2rad(Azimuth);
Radius = 90 - Elevation;

%% Create Figure

SkyFig = figure( ...
    'Name', 'Satellite Sky Plot', ...
    'NumberTitle', 'off', ...
    'Color', 'w');

pax = polaraxes(SkyFig);

%% Generate Sky Plot

polarplot(pax, Theta, Radius, '-o', ...
    'LineWidth', 2, ...
    'MarkerSize', 5);

%% Configure Polar Axes

rlim([0 90]);

pax.ThetaZeroLocation = 'top';
pax.ThetaDir = 'clockwise';
pax.RDir = 'reverse';

pax.RTick = [0 30 60 90];
pax.RTickLabel = {'90°', '60°', '30°', '0°'};

pax.FontSize = 12;
pax.FontWeight = 'bold';

title('Satellite Pass Sky Plot');

%% Export Figure

drawnow;

SkyImage = fullfile(tempdir, 'SkyPlot.png');

exportgraphics(SkyFig, SkyImage, ...
    'Resolution', 300);

end