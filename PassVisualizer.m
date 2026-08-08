function [ElevationFig, ElevationImage] = PassVisualizer(PassData)
%% ==========================================================
% Function : PassVisualizer
%
% Purpose:
% Generates the satellite elevation profile from imported
% Gpredict pass data and exports the figure as a PNG image.
%
% Input:
%   PassData - Structure returned by ImportPass
%
% Output:
%   ElevationFig   - Figure handle
%   ElevationImage - Full path to exported PNG image
%
% Author  : Kishore T
% Version : 0.1.0
%% ==========================================================

%% Extract Pass Data

Time = PassData.Time;
Elevation = PassData.Elevation;

%% Convert Time Format

Time = datetime(Time, 'InputFormat', 'HH:mm:ss');
Time.Format = 'HH:mm:ss';

%% Create Figure

ElevationFig = figure( ...
    'Name', 'Satellite Elevation Profile', ...
    'NumberTitle', 'off', ...
    'Color', 'w');

%% Plot Elevation Profile

plot(Time, Elevation, '-o', ...
    'LineWidth', 1.5, ...
    'MarkerSize', 5);

grid on;
box on;

title('Satellite Elevation Profile');
xlabel('Time');
ylabel('Elevation (Degrees)');

%% Export Figure

drawnow;

ElevationImage = fullfile(tempdir, 'ElevationPlot.png');

exportgraphics(ElevationFig, ElevationImage, ...
    'Resolution', 300);

end