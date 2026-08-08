function Stats = PassStatistics(PassData)
%% ==========================================================
% Function : PassStatistics
%
% Purpose:
% Computes key statistics for a satellite pass imported from
% a Gpredict pass file.
%
% Input:
%   PassData - Structure returned by ImportPass
%
% Output:
%   Stats - Structure containing pass statistics
%
% Author  : Kishore T
% Version : 0.1.0
%% ==========================================================

%% Extract Pass Data

Time = PassData.Time;
Azimuth = PassData.Azimuth;
Elevation = PassData.Elevation;
Range = PassData.Range;

%% Compute Statistics

[maxElevation, idx] = max(Elevation);

AOS = datetime(Time{1}, 'InputFormat', 'HH:mm:ss');
LOS = datetime(Time{end}, 'InputFormat', 'HH:mm:ss');
PeakTime = datetime(Time{idx}, 'InputFormat', 'HH:mm:ss');

PassDuration = LOS - AOS;

ClosestApproach = min(Range);
FarthestDistance = max(Range);

AzimuthAtAOS = Azimuth(1);
AzimuthAtLOS = Azimuth(end);

%% Display Statistics

fprintf('\n');
fprintf('==========================================\n');
fprintf(' GROUND STATION PASS STATISTICS DASHBOARD\n');
fprintf('==========================================\n');

fprintf('AOS                  : %s\n', datestr(AOS,'hh:MM:SS PM'));
fprintf('LOS                  : %s\n', datestr(LOS,'hh:MM:SS PM'));
fprintf('Pass Duration        : %s\n', char(PassDuration));
fprintf('Maximum Elevation    : %.2f°\n', maxElevation);
fprintf('Time of Max Elev.    : %s\n', datestr(PeakTime,'hh:MM:SS PM'));
fprintf('Closest Approach     : %.2f km\n', ClosestApproach);
fprintf('Farthest Distance    : %.2f km\n', FarthestDistance);
fprintf('Azimuth at AOS       : %.2f°\n', AzimuthAtAOS);
fprintf('Azimuth at LOS       : %.2f°\n', AzimuthAtLOS);

fprintf('==========================================\n');

%% Source File

[~, FileName, Extension] = fileparts(PassData.FileName);

%% Store Results

Stats.AOS = AOS;
Stats.LOS = LOS;
Stats.PassDuration = PassDuration;
Stats.MaxElevation = maxElevation;
Stats.PeakTime = PeakTime;
Stats.ClosestApproach = ClosestApproach;
Stats.FarthestDistance = FarthestDistance;
Stats.AzimuthAtAOS = AzimuthAtAOS;
Stats.AzimuthAtLOS = AzimuthAtLOS;
Stats.SourceFile = [FileName Extension];

end