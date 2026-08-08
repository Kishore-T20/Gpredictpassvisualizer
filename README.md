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
