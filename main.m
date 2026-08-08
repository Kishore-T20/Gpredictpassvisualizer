%% ==========================================================
% GpredictPassToolkit
%
% Main Script
%
% Purpose:
% Import a Gpredict satellite pass file, generate pass
% statistics, visualize the satellite pass, and create
% a professional PDF report.
%
% Author  : Kishore T
% Version : 0.1.0
% ===========================================================

clc;
clear;
close all;

%% Select Gpredict Pass File

[file, path] = uigetfile('*.txt', 'Select a Gpredict Pass File');

if isequal(file, 0)
    disp('Operation cancelled by user.');
    return;
end

filename = fullfile(path, file);

%% Import Pass Data

PassData = ImportPass(filename);

%% Generate Visualizations

[ElevationFig, ElevationImage] = PassVisualizer(PassData);
[SkyFig, SkyImage] = PolarpassVisualizer(PassData);

%% Compute Pass Statistics

Stats = PassStatistics(PassData);

%% Generate PDF Report

SaveReport(Stats, ElevationImage, SkyImage);

disp('Analysis completed successfully.');