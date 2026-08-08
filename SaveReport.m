function SaveReport(Stats, ElevationImage, SkyImage)
% SAVEREPORT Generate a professional PDF report for a satellite pass.
%
%   SaveReport(Stats, ElevationImage, SkyImage) creates a PDF report
%   summarizing the satellite pass statistics, elevation profile, and
%   sky plot, then prompts the user to choose a save location.
%
% ==========================================================
% Ground Station Analysis Toolbox
% Module 5 - Save Report
%
% Purpose:
% Generates a professional PDF report containing:
%   - Report information
%   - Pass statistics
%   - Elevation profile
%   - Satellite sky plot
%
% Inputs:
%   Stats           - Struct containing computed pass statistics
%   ElevationImage  - Path/handle to elevation profile image
%   SkyImage        - Path/handle to sky plot image
%
% Output:
%   Professional PDF Report
% ==========================================================

import mlreportgen.dom.*

%% ==========================================================
% Ask user where to save the report
% ==========================================================

[file, path] = uiputfile( ...
    '*.pdf', ...
    'Save Satellite Pass Report', ...
    'Satellite_Pass_Report.pdf');

if isequal(file, 0)
    return;
end

%% ==========================================================
% Create PDF Document
% ==========================================================

ReportFile = fullfile(path, file);

doc = Document(ReportFile, 'pdf');

Observation = GenerateObservation(Stats);

%% ==========================================================
% Report Header
% ==========================================================

% Main Title
MainTitle = Heading(1, 'GROUND STATION ANALYSIS TOOLBOX');
MainTitle.Bold = true;
MainTitle.HAlign = 'center';
append(doc, MainTitle);

% Institution Name
Institution = Paragraph('Sri Leo Muthu TVET Centre - Space Technology');
Institution.HAlign = 'center';
Institution.Italic = true;
append(doc, Institution);

% Report Title
ReportTitle = Heading(2, 'SATELLITE PASS ANALYSIS REPORT');
ReportTitle.HAlign = 'center';
append(doc, ReportTitle);

% Version
Version = Paragraph('Version 0.1.0');
Version.HAlign = 'center';
append(doc, Version);

append(doc, Paragraph(' '));

%% ==========================================================
% Report Information
% ==========================================================

InfoHeading = Heading(2, 'Report Information');
append(doc, InfoHeading);

% Create Information Table
InfoTable = Table();

InfoTable.Border = 'solid';
InfoTable.ColSep = 'solid';
InfoTable.RowSep = 'solid';
InfoTable.Width = '100%';

% Information Data
InfoData = {
    'Generated On', datestr(now, 'dd-mmm-yyyy HH:MM:SS');
    'Source File', Stats.SourceFile;
    'Version', '0.1.0'
    };

% Populate Table
for i = 1:size(InfoData, 1)

    row = TableRow();

    left = TableEntry();

    leftParagraph = Paragraph(InfoData{i, 1});
    leftParagraph.Bold = true;

    append(left, leftParagraph);

    right = TableEntry();
    append(right, Paragraph(InfoData{i, 2}));

    append(row, left);
    append(row, right);

    append(InfoTable, row);

end

append(doc, InfoTable);

append(doc, Paragraph(' '));

%% ==========================================================
% Pass Statistics
% ==========================================================

StatsHeading = Heading(2, 'Pass Statistics');
append(doc, StatsHeading);

StatsTable = Table();

StatsTable.Width = '100%';
StatsTable.Border = 'solid';
StatsTable.ColSep = 'solid';
StatsTable.RowSep = 'solid';

% Fixed column widths
StatsTable.TableEntriesStyle = {...
    HAlign('left'), ...
    VAlign('middle')};

% Header
Header = TableRow();

Left = TableEntry();
Left.Style = {Bold(true)};
append(Left, Paragraph('Parameter'));

Right = TableEntry();
Right.Style = {Bold(true)};
append(Right, Paragraph('Value'));

append(Header, Left);
append(Header, Right);

append(StatsTable, Header);

% Helper data
Statistics = {
    'Acquisition of Signal (AOS)', Stats.AOS;
    'Loss of Signal (LOS)', Stats.LOS;
    'Pass Duration', Stats.PassDuration;
    'Maximum Elevation', sprintf('%.2f°', Stats.MaxElevation);
    'Peak Elevation Time', Stats.PeakTime;
    'Closest Approach', sprintf('%.2f km', Stats.ClosestApproach);
    'Farthest Distance', sprintf('%.2f km', Stats.FarthestDistance);
    'Azimuth at AOS', sprintf('%.2f°', Stats.AzimuthAtAOS);
    'Azimuth at LOS', sprintf('%.2f°', Stats.AzimuthAtLOS)
    };

% Fill Table
for i = 1:size(Statistics, 1)

    Row = TableRow();

    % Left Column
    Parameter = TableEntry();
    Parameter.Style = {Width('65%')};

    P = Paragraph(Statistics{i, 1});
    P.Bold = true;
    append(Parameter, P);

    % Right Column
    Value = TableEntry();
    Value.Style = {Width('35%')};

    V = Paragraph(string(Statistics{i, 2}));
    append(Value, V);

    append(Row, Parameter);
    append(Row, Value);

    append(StatsTable, Row);

end

append(doc, StatsTable);

append(doc, Paragraph(' '));

%% ==========================================================
% Figure 1 - Elevation Profile
% ==========================================================

ElevationHeading = Heading(2, 'Figure 1. Satellite Elevation Profile');
append(doc, ElevationHeading);

ElevationFigure = Image(ElevationImage);
ElevationFigure.Width = '6.5in';
ElevationFigure.Height = '4.5in';
append(doc, ElevationFigure);

append(doc, Paragraph(' '));

%% Description

ElevationDescriptionHeading = Heading(3, 'Description');
append(doc, ElevationDescriptionHeading);

ElevationDescription = Paragraph(...
    ['The satellite elevation profile illustrates the variation of the ', ...
     'satellite elevation angle above the local horizon throughout the ', ...
     'visible pass. The horizontal axis represents time, while the ', ...
     'vertical axis represents elevation angle in degrees. ', ...
     'Higher elevation angles generally provide better communication ', ...
     'quality and are useful for planning antenna tracking operations.']);

ElevationDescription.HAlign = 'justify';
append(doc, ElevationDescription);

append(doc, Paragraph(' '));

%% Key Observations

ElevationObservationHeading = Heading(3, 'Key Observations');
append(doc, ElevationObservationHeading);

ElevationList = UnorderedList(Observation.Elevation);
append(doc, ElevationList);

append(doc, Paragraph(' '));

%% ==========================================================
% Figure 2 - Satellite Sky Plot
% ==========================================================

SkyHeading = Heading(2, 'Figure 2. Satellite Sky Plot');
append(doc, SkyHeading);

SkyFigure = Image(SkyImage);
SkyFigure.Width = '6.5in';
SkyFigure.Height = '6.5in';
append(doc, SkyFigure);

append(doc, Paragraph(' '));

%% Description

SkyDescriptionHeading = Heading(3, 'Description');
append(doc, SkyDescriptionHeading);

SkyDescription = Paragraph(...
    ['The satellite sky plot illustrates the apparent trajectory of the ', ...
     'satellite across the local sky using azimuth and elevation coordinates. ', ...
     'The outer circle represents the horizon (0° elevation), while the ', ...
     'centre represents the zenith (90° elevation). This visualization ', ...
     'assists operators in understanding the satellite trajectory, ', ...
     'planning antenna pointing, and verifying the tracking path ', ...
     'throughout the communication session.']);

SkyDescription.HAlign = 'justify';
append(doc, SkyDescription);

append(doc, Paragraph(' '));

%% Key Observations

SkyObservationHeading = Heading(3, 'Key Observations');
append(doc, SkyObservationHeading);

SkyList = UnorderedList(Observation.Sky);
append(doc, SkyList);

append(doc, Paragraph(' '));

%% ==========================================================
% Mission Summary
% ==========================================================

SummaryHeading = Heading(1, 'Mission Summary');
SummaryHeading.HAlign = 'center';
append(doc, SummaryHeading);

append(doc, Paragraph(' '));

SummaryDescription = Paragraph(...
    ['The following summary provides an overall engineering assessment ', ...
     'of the observed satellite pass. It combines the computed pass ', ...
     'statistics with automatically generated observations to assist ', ...
     'operators in quickly evaluating the suitability of the pass for ', ...
     'communication, antenna tracking, and educational activities.']);

SummaryDescription.HAlign = 'justify';
append(doc, SummaryDescription);

append(doc, Paragraph(' '));

MissionSummaryList = UnorderedList(Observation.MissionSummary);
append(doc, MissionSummaryList);

append(doc, Paragraph(' '));

%% ==========================================================
% Footer
% ==========================================================

FooterTitle = Paragraph('Ground Station Analysis Toolbox');
FooterTitle.Bold = true;
FooterTitle.HAlign = 'center';
append(doc, FooterTitle);

FooterVersion = Paragraph('Version 0.1.0');
FooterVersion.HAlign = 'center';
append(doc, FooterVersion);

FooterGenerator = Paragraph('Generated using MATLAB Report Generator');
FooterGenerator.HAlign = 'center';
append(doc, FooterGenerator);

FooterCopyright = Paragraph('© 2026 Kishore T');
FooterCopyright.HAlign = 'center';
append(doc, FooterCopyright);

close(doc);

fprintf('\nPDF report created successfully.\n');

end