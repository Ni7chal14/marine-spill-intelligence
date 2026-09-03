Module Documentation
Marine Spill Intelligence System
SIH26143 | Space Technology

1. Purpose

This document defines the responsibilities, inputs, processing, outputs, and integration points of each major module in the Marine Spill Intelligence System.

The system is divided into independent modules to ensure:

Clear responsibilities
Parallel development
Easier testing
Easier integration
Better maintainability

2. System Modules Overview
MARINE SPILL INTELLIGENCE SYSTEM
│
├── Frontend Module
├── Backend Module
├── AI Detection Module
├── Drift Analysis Module
├── AIS Vessel Analysis Module
└── Database Module

The overall communication flow is:

Frontend
    ↓
Backend
    ↓
AI / Drift / AIS Modules
    ↓
Database + External Data Sources

3. Frontend Module
Purpose

The frontend provides the user interface and visualizes all analysis results.

Responsibilities
User interaction
File upload
Region selection
Historical event selection
Displaying analysis results
Interactive map visualization
Displaying vessel investigation results
Main Pages
Dashboard

Provides an overview of the system and recent analyses.

Near-Real-Time Monitoring

Allows users to select a region and analyse the latest available satellite observation.

Historical Event Analysis

Allows users to select and analyse preconfigured historical oil spill events.

Upload and Analyze

Allows users to upload supported imagery for analysis.

Input

The frontend receives user actions such as:

Region Selection
Historical Event Selection
Satellite Image Upload
Analysis Request
Output

The frontend displays:

Detection results
Spill boundaries
Spill statistics
Origin zones
Drift trajectories
Vessel positions
Investigation rankings
Communication
Frontend
    ↓ REST API
Backend

The frontend should not directly communicate with:

Database
AI model
Drift engine
AIS processing system

4. Backend Module
Purpose

The backend acts as the central orchestration layer.

Technology
FastAPI
Python
Responsibilities
Receive API requests
Validate inputs
Manage analysis workflows
Call analytical modules
Fetch external data
Store results
Return responses
Main Flow
Frontend Request
       ↓
Input Validation
       ↓
Analysis Service
       ↓
AI / Drift / AIS Modules
       ↓
Database
       ↓
API Response
Input

Examples:

Uploaded files
Region coordinates
Historical event ID
Analysis parameters
Output

Structured API responses containing:

Detection results
Spill data
Drift results
Vessel rankings

5. AI Detection Module
Purpose

The AI module detects and segments potential oil spills from satellite imagery.

Input
Satellite Image
      +
Image Metadata

Examples:

Sentinel-1 SAR imagery
GeoTIFF
Supported uploaded imagery
Processing Pipeline
INPUT IMAGE
     ↓
VALIDATION
     ↓
PREPROCESSING
     ↓
AI DETECTION
     ↓
CLASSIFICATION
     ↓
SEGMENTATION
     ↓
SPILL CHARACTERIZATION
Step 1: Validation

Check:

Supported format
Image integrity
Available metadata
Georeferencing information
Step 2: Preprocessing

Possible operations:

SAR preprocessing
Noise reduction
Normalization
Resizing
Tiling
Step 3: Detection and Classification

The model identifies whether the observation contains:

Oil Spill
Look-Alike
No Significant Spill
Step 4: Segmentation

If an oil spill is detected:

Satellite Image
       ↓
Segmentation Model
       ↓
Binary Spill Mask
       ↓
Spill Boundary
       ↓
Spill Polygon
Output
{
    spill_detected,
    classification,
    confidence,
    spill_mask,
    spill_boundary,
    spill_polygon
}
Integration

The AI module sends processed results to the backend.

Backend
    ↓
AI Module
    ↓
Detection Result
    ↓
Backend

6. Spill Characterization Module

This can initially remain part of the AI/geospatial processing pipeline.

Purpose

Converts the detected spill into meaningful information.

Input
Spill mask
Satellite metadata
Geospatial metadata
Processing

Calculate:

Location
Approximate area
Shape
Orientation
Geographic boundary
Observation time
Output
Spill Object
│
├── Location
├── Polygon
├── Area
├── Shape
├── Orientation
└── Observation Time

7. Drift Analysis Module
Purpose

Analyses the possible past and future movement of the oil spill.

Technologies

Potentially:

Python
OpenDrift
OpenOil
Input
Spill Location
       +
Observation Time
       +
Ocean Current Data
       +
Wind Data

7.1 Hindcasting
Purpose

Estimate where the spill may have originated.

Flow
Current Spill Location
          ↓
Environmental Data
          ↓
Backward Simulation
          ↓
Possible Origin Region
Output
Estimated origin region
Estimated time window
Uncertainty zone
Backward trajectory

7.2 Forecasting
Purpose

Predict possible future movement.

Flow
Current Spill Location
          ↓
Environmental Data
          ↓
Forward Simulation
          ↓
Predicted Movement
Output
Predicted trajectory
Future positions
Potential spread region
Time-based predictions

8. AIS Vessel Analysis Module
Purpose

Analyse vessel activity near the estimated spill origin.

The module helps identify vessels that may require further investigation.

It does not determine guilt or responsibility.

Input
Estimated Origin Region
          +
Estimated Origin Time Window
          +
AIS Vessel Data
Processing Pipeline
AIS DATA
   ↓
DATA CLEANING
   ↓
SPATIAL FILTERING
   ↓
TEMPORAL FILTERING
   ↓
TRAJECTORY ANALYSIS
   ↓
BEHAVIOURAL ANALYSIS
   ↓
PRIORITY SCORING
Spatial Filtering

Find vessels:

Inside the origin region
Near the origin region
Near the spill trajectory
Temporal Filtering

Identify vessels present during the estimated origin time window.

Trajectory Analysis

Analyse:

Vessel routes
Distance from origin
Time spent nearby
Route intersections
Behavioural Analysis

Possible indicators:

AIS transmission gaps
Unusual route deviations
Significant speed changes
Unusual stopping patterns

These are only investigation indicators.

9. Investigation Priority Scoring Module
Purpose

Ranks relevant vessels based on multiple investigation factors.

Input
Spatial Correlation
        +
Temporal Correlation
        +
Trajectory Correlation
        +
Behavioural Indicators
Processing

A weighted scoring system calculates an investigation priority score.

Conceptually:

Priority Score
=
Proximity Score
+
Temporal Score
+
Trajectory Score
+
Behavioural Score

The exact weights should be configurable.

Output
Vessel Investigation Result
│
├── Vessel ID
├── Priority Score
├── Rank
└── Evidence

Example:

Vessel A
Priority Score: 82/100

Evidence:
✓ Present near origin region
✓ Present during relevant time window
✓ Trajectory correlated with region

10. Database Module
Purpose

Provides persistent storage for application and processed geospatial data.

Technology
PostgreSQL
+
PostGIS
Input

The database receives processed data from:

Backend
AI module
Drift module
AIS module
Main Stored Data
Events
Historical Event
├── Event ID
├── Name
├── Date
├── Location
└── Description
Analysis
Analysis
├── Analysis ID
├── Timestamp
├── Source
├── Status
└── Detection Result
Spill Data
Spill
├── Location
├── Polygon
├── Area
└── Observation Time
Drift Data
Drift Result
├── Trajectory
├── Origin Zone
├── Forecast Region
└── Simulation Time
Vessel Data
Vessel Investigation
├── Vessel ID
├── Priority Score
├── Rank
└── Evidence

11. External Data Module

The system depends on external sources for large-scale data.

Satellite Data

Provides:

Sentinel-1 imagery
Historical observations
Latest available observations
Environmental Data

Provides:

Ocean currents
Wind information

Used by the drift module.

AIS Data

Provides:

Vessel positions
Timestamps
Vessel movement
Speed
Course
Vessel metadata

12. Complete Module Integration Flow
                     USER
                       │
                       ▼
                  FRONTEND
                       │
                       ▼
                   BACKEND
                       │
          ┌────────────┼────────────┐
          │            │            │
          ▼            ▼            ▼
       AI MODULE    DRIFT MODULE  DATABASE
          │            │
          │            │
          ▼            ▼
     SPILL DATA   ORIGIN REGION
                       │
                       ▼
                   AIS MODULE
                       │
                       ▼
               PRIORITY SCORING
                       │
                       ▼
                   DATABASE
                       │
                       ▼
                   FRONTEND

13. Standard Module Interface Principle

Every major processing module should follow a clear pattern:

INPUT
  ↓
VALIDATION
  ↓
PROCESSING
  ↓
OUTPUT

Each module should ideally:

Receive structured input
Return structured output
Avoid directly depending on frontend code
Avoid unnecessary knowledge of other modules
Be independently testable

14. Module Dependencies
Frontend
    │
    ▼
Backend
    │
    ├──────────► AI Module
    │
    ├──────────► Drift Module
    │                 │
    │                 ▼
    │            Environmental Data
    │
    ├──────────► AIS Module
    │                 │
    │                 ▼
    │              AIS Data
    │
    └──────────► Database

The backend coordinates communication between modules.

15. Development Responsibility Boundaries

Each module should have a clearly defined responsibility.

Module	Primary Responsibility
Frontend	User interface and visualization
Backend	API and system orchestration
AI	Spill detection and segmentation
Geospatial Processing	Spill characterization
Drift	Hindcasting and forecasting
AIS	Vessel analysis
Scoring	Investigation prioritization
Database	Persistent and spatial storage

16. Integration Priority

The recommended development and integration sequence is:

1. Database Foundation
        ↓
2. Backend Foundation
        ↓
3. AI Detection Prototype
        ↓
4. Frontend Integration
        ↓
5. Historical Event Workflow
        ↓
6. Drift Analysis
        ↓
7. AIS Analysis
        ↓
8. Full System Integration

This order can be adjusted depending on team availability.

17. Module Documentation Summary

The complete system can be understood as:

INPUT DATA
    │
    ▼
AI DETECTION
    │
    ▼
SPILL CHARACTERIZATION
    │
    ├───────────────┐
    ▼               ▼
HINDCASTING     FORECASTING
    │               │
    ▼               ▼
ORIGIN        FUTURE MOVEMENT
    │
    ▼
AIS ANALYSIS
    │
    ▼
PRIORITY SCORING
    │
    ▼
DATABASE
    │
    ▼
FRONTEND VISUALIZATION