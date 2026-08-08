# GpredictPassToolkit

A MATLAB-based backend for analyzing satellite pass data exported from Gpredict.

The project imports satellite pass data, calculates key pass statistics, generates visualization plots, produces engineering observations, and creates a PDF analysis report.

## Features

- Import satellite pass data from Gpredict
- Calculate satellite pass statistics
- Generate satellite elevation profiles
- Generate polar sky plots
- Generate automated engineering observations
- Generate PDF satellite pass analysis reports

## Requirements

- MATLAB R2023b or later
- MATLAB Report Generator


## Workflow
Gpredict Pass File
        │
        ▼
   ImportPass
        │
        ▼
   PassData Structure
        │
        ├───────────────┐
        ▼               ▼
 PassStatistics    PassVisualizer
        │               │
        │               ▼
        │        Elevation Profile
        │
        ▼
 PolarpassVisualizer
        │
        ▼
    Sky Plot
        │
        ▼
GenerateObservation
        │
        ▼
   Engineering
   Observations
        │
        ▼
    SaveReport
        │
        ▼
     PDF Report

     Modules
main.m

Main execution script that runs the complete backend workflow.

It allows the user to select a Gpredict pass file and sends the data through the analysis modules.

ImportPass.m

Reads the selected Gpredict pass file and extracts:

Time
Azimuth
Elevation
Range
Footprint

The extracted information is stored in the PassData structure.

PassStatistics.m

Calculates important parameters from the satellite pass, including:

Acquisition of Signal (AOS)
Loss of Signal (LOS)
Pass duration
Maximum elevation
Time of maximum elevation
Closest approach
Farthest distance
Azimuth at AOS
Azimuth at LOS
PassVisualizer.m

Generates the satellite elevation profile showing elevation angle as a function of time.

PolarpassVisualizer.m

Generates a polar sky plot showing the satellite trajectory using azimuth and elevation information.

GenerateObservation.m

Generates engineering observations based on the calculated pass statistics.

The observations include pass quality, communication quality, elevation characteristics, sky trajectory, and mission-related observations.

SaveReport.m

Generates a PDF report containing:

Report information
Pass statistics
Satellite elevation profile
Satellite sky plot
Engineering observations
Mission summary
Input Data

The backend uses satellite pass data exported from Gpredict in text (.txt) format.

A sample pass file is provided in the SampleData directory for testing.

Usage
Open MATLAB.
Set the project folder as the current MATLAB folder.
Run:
main
Select a Gpredict pass file when prompted.
The backend processes the pass data.
The elevation profile and sky plot are generated.
Pass statistics are calculated.
A PDF report is generated.
Output

The backend produces:

Satellite elevation profile
Satellite sky plot
Pass statistics
Automated engineering observations
PDF satellite pass analysis report
Project Status

Backend implementation complete.

The graphical user interface is planned as a future development stage and is not part of the current backend release.



     ## Project Structure

```text
GpredictPassToolkit/
│
├── main.m
│
├── ImportPass.m
├── PassStatistics.m
├── PassVisualizer.m
├── PolarpassVisualizer.m
├── GenerateObservation.m
├── SaveReport.m
│
├── SampleData/
│   └── example_pass.txt
│
├── README.md
├── LICENSE
└── .gitignore
Workflow
