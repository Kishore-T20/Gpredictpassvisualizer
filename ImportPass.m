function PassData = ImportPass(filename)
%% ==========================================================
% Function : ImportPass
%
% Purpose:
% Imports a Gpredict satellite pass file and extracts the
% pass information into a structured format.
%
% Input:
%   filename - Full path to the Gpredict pass file
%
% Output:
%   PassData - Structure containing:
%              Time
%              Azimuth
%              Elevation
%              Range
%              Footprint
%              FileName
%
% Author  : Kishore T
% Version : 0.1.0
%% ==========================================================

%% Open File

fileID = fopen(filename, 'r');

if fileID == -1
    error('Cannot open the selected file: %s', filename);
end

%% Read File

FileData = textscan(fileID, '%s', 'Delimiter', '\n');
fclose(fileID);

Lines = FileData{1};

%% Locate Data Header

HeaderLine = 0;

for i = 1:numel(Lines)

    if contains(Lines{i}, 'Time')

        HeaderLine = i;
        break;

    end

end

if HeaderLine == 0
    error('Unable to locate the data header in the selected Gpredict pass file.');
end

%% Extract Pass Data

DataStart = HeaderLine + 2;

Time = {};
Azimuth = [];
Elevation = [];
Range = [];
Footprint = [];

for i = DataStart:numel(Lines)

    % Skip empty lines
    if isempty(strtrim(Lines{i}))
        continue;
    end

    Row = strsplit(strtrim(Lines{i}));

    % Skip incomplete rows
    if numel(Row) < 6
        continue;
    end

    Time{end+1} = Row{2};
    Azimuth(end+1) = str2double(Row{3});
    Elevation(end+1) = str2double(Row{4});
    Range(end+1) = str2double(Row{5});
    Footprint(end+1) = str2double(Row{6});

end

%% Store Results

PassData.Time = Time;
PassData.Azimuth = Azimuth;
PassData.Elevation = Elevation;
PassData.Range = Range;
PassData.Footprint = Footprint;
PassData.FileName = filename;

end

