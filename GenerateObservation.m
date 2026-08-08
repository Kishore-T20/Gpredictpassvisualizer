function Observation = GenerateObservation(Stats)
%% ==========================================================
% Function : GenerateObservation
%
% Purpose:
% Generates engineering observations from computed satellite
% pass statistics for inclusion in the PDF report.
%
% Input:
%   Stats - Structure returned by PassStatistics
%
% Output:
%   Observation - Structure containing generated observations
%                 for the elevation profile, sky plot, and
%                 mission summary.
%
% Author  : Kishore T
% Version : 0.1.0
%% ==========================================================

%% ==========================================================
% Pass Quality Assessment
% ==========================================================

if Stats.MaxElevation >= 70
    Observation.PassQuality = "Excellent";
elseif Stats.MaxElevation >= 45
    Observation.PassQuality = "Good";
elseif Stats.MaxElevation >= 20
    Observation.PassQuality = "Moderate";
else
    Observation.PassQuality = "Low";
end

%% ==========================================================
% Communication Assessment
% ==========================================================

if Stats.MaxElevation >= 60
    Observation.Communication = ...
        "Excellent communication quality is expected near the peak elevation.";
elseif Stats.MaxElevation >= 35
    Observation.Communication = ...
        "Good communication quality is expected during most of the pass.";
else
    Observation.Communication = ...
        "Communication quality may be limited because of the low elevation angle.";
end

%% ==========================================================
% Elevation Profile Observations
% ==========================================================

Observation.Elevation = {

sprintf('Satellite acquired at %s (AOS).', Stats.AOS)

sprintf('Maximum elevation reached %.2f°.', Stats.MaxElevation)

sprintf('Peak elevation occurred at %s.', Stats.PeakTime)

sprintf('Visible pass duration: %s.', Stats.PassDuration)

char(Observation.Communication)

sprintf('Overall pass quality: %s.', Observation.PassQuality)

};

%% ==========================================================
% Sky Plot Observations
% ==========================================================

Observation.Sky = {

sprintf('Satellite rises at an azimuth of %.2f°.', Stats.AzimuthAtAOS)

sprintf('Satellite sets at an azimuth of %.2f°.', Stats.AzimuthAtLOS)

'The sky plot illustrates the apparent trajectory across the local sky.'

'Useful for antenna pointing and tracking verification.'

'Supports both manual and automatic antenna tracking.'

};

%% ==========================================================
% Mission Summary
% ==========================================================

Observation.MissionSummary = {

sprintf('Overall Pass Quality: %s', Observation.PassQuality)

sprintf('Maximum Elevation: %.2f°', Stats.MaxElevation)

sprintf('Visible Pass Duration: %s', Stats.PassDuration)

sprintf('Peak Elevation Time: %s', Stats.PeakTime)

'Recommended for telemetry reception.'

'Recommended for antenna tracking demonstrations.'

'Suitable for educational activities.'

};

end