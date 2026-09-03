Data Flow
Marine Spill Intelligence System
SIH26143 | Space Technology

1. Purpose

This document defines how data moves through the Marine Spill Intelligence System.

It covers the complete end-to-end workflow for:

Near-real-time monitoring
Historical event analysis
User-uploaded image analysis
Oil spill detection
Spill characterization
Drift analysis
Origin estimation
AIS vessel investigation
Database storage
Frontend visualization

The goal is to ensure that every module has a clear understanding of:

Where data comes from
        ↓
Where it is processed
        ↓
Where results are stored
        ↓
How results reach the user

2. High-Level System Data Flow

The primary data flow of the system is:

                    DATA SOURCE
                         │
                         ▼
                  FRONTEND REQUEST
                         │
                         ▼
                      BACKEND
                         │
                         ▼
                 DATA VALIDATION
                         │
                         ▼
                    AI MODULE
                         │
                         ▼
                 SPILL DETECTED?
                    │       │
                  YES       NO
                    │       │
                    ▼       ▼
           SPILL PROCESSING RETURN RESULT
                    │
                    ▼
              SPILL DATABASE
                    │
          ┌─────────┴─────────┐
          ▼                   ▼
     HINDCASTING          FORECASTING
          │                   │
          ▼                   ▼
     ORIGIN REGION      FUTURE MOVEMENT
          │
          ▼
       AIS ANALYSIS
          │
          ▼
    VESSEL PRIORITIZATION
          │
          ▼
       DATABASE STORAGE
          │
          ▼
    FRONTEND VISUALIZATION

3. Main Input Sources

The system supports three primary analysis workflows.

1. Near-Real-Time Monitoring
2. Historical Event Analysis
3. User Upload Analysis

All three workflows eventually enter the same core analysis pipeline.

DATA INPUT
    ↓
VALIDATION
    ↓
AI DETECTION
    ↓
SPILL CHARACTERIZATION
    ↓
DRIFT ANALYSIS
    ↓
AIS ANALYSIS
    ↓
VISUALIZATION

4. Near-Real-Time Monitoring Flow
Purpose

This workflow allows users to analyse the latest available satellite observation for a selected maritime region.

Important:

"Near-real-time" means the latest available data accessible to the system, not necessarily live satellite imagery.

Complete Flow
USER
 │
 ▼
SELECT MARITIME REGION
 │
 ▼
FRONTEND SENDS REQUEST
 │
 ▼
BACKEND
 │
 ▼
FETCH LATEST AVAILABLE
SATELLITE OBSERVATION
 │
 ▼
VALIDATE DATA
 │
 ▼
PREPROCESS IMAGE
 │
 ▼
AI DETECTION
 │
 ▼
OIL SPILL DETECTED?
 │
 ├─────────────── NO
 │                  │
 ▼                  ▼
YES            RETURN RESULT
 │
 ▼
SEGMENTATION
 │
 ▼
SPILL CHARACTERIZATION
 │
 ▼
STORE ANALYSIS
 │
 ▼
DISPLAY ON MAP

Detailed Steps
Step 1 — Region Selection

The user selects:

Region
Geographic coordinates
Area of interest

Example:

Selected Region
       ↓
Latitude / Longitude
       ↓
Backend Request
Step 2 — Satellite Data Retrieval

The backend requests the latest available satellite observation.

Input:

Region
+
Date Range

Output:

Satellite Image
+
Metadata
Step 3 — AI Analysis

The satellite image enters the AI pipeline.

Satellite Image
      ↓
Preprocessing
      ↓
Detection
      ↓
Classification

Possible results:

Oil Spill
Look-Alike
No Significant Spill
Step 4 — Spill Processing

If an oil spill is detected:

Detection
    ↓
Segmentation
    ↓
Spill Mask
    ↓
Spill Polygon
    ↓
Area Calculation
Step 5 — Store Results

The backend stores:

Analysis metadata
Detection result
Confidence
Spill geometry
Observation timestamp
Step 6 — Visualization

The frontend receives the results.

The map displays:

Spill boundary
Spill centroid
Confidence
Area
Observation time

5. Historical Event Analysis Flow
Purpose

Historical analysis allows the team to demonstrate the complete system using known oil spill events.

This is particularly important for hackathon demonstrations because the system does not depend on a new spill occurring during the presentation.

Complete Flow
USER
 │
 ▼
SELECT HISTORICAL EVENT
 │
 ▼
FRONTEND REQUEST
 │
 ▼
BACKEND
 │
 ▼
LOAD EVENT INFORMATION
 │
 ▼
LOAD SATELLITE DATA
 │
 ▼
AI ANALYSIS
 │
 ▼
SPILL DETECTION
 │
 ▼
SPILL CHARACTERIZATION
 │
 ▼
HINDCASTING
 │
 ▼
ORIGIN ESTIMATION
 │
 ▼
AIS ANALYSIS
 │
 ▼
VESSEL PRIORITIZATION
 │
 ▼
LOAD / STORE RESULTS
 │
 ▼
INTERACTIVE VISUALIZATION
Historical Event Data

The system may store:

Historical Event
      │
      ├── Event Information
      ├── Satellite Data Reference
      ├── Analysis Results
      ├── Spill Geometry
      ├── Drift Results
      └── Vessel Investigation Results
Frontend Visualization

The user should be able to explore:

EVENT TIMELINE
      │
      ▼
SATELLITE OBSERVATION
      │
      ▼
SPILL DETECTION
      │
      ▼
SPILL EVOLUTION
      │
      ▼
ORIGIN ESTIMATION
      │
      ▼
VESSEL ANALYSIS

6. User Upload Analysis Flow
Purpose

Users can upload supported imagery for analysis.

The system must determine what type of processing is possible based on the uploaded file.

Complete Flow
USER
 │
 ▼
UPLOAD FILE
 │
 ▼
FILE VALIDATION
 │
 ├─────────────┐
 ▼             ▼
GEOREFERENCED  NORMAL IMAGE
DATA           (PNG/JPG)
 │             │
 ▼             ▼
FULL           IMAGE-ONLY
GEOSPATIAL     ANALYSIS
ANALYSIS
 │             │
 └──────┬──────┘
        ▼
   AI DETECTION
        │
        ▼
   DETECTION RESULT
        │
        ▼
   AVAILABLE OUTPUTS

7. Georeferenced Upload Flow

Supported examples may include:

GeoTIFF
Satellite Raster Data
Georeferenced Imagery
Processing
UPLOAD
   │
   ▼
FILE INSPECTION
   │
   ▼
EXTRACT METADATA
   │
   ├── CRS
   ├── Coordinates
   ├── Bounds
   └── Observation Metadata
   │
   ▼
AI ANALYSIS
   │
   ▼
SPILL DETECTION
   │
   ▼
SPILL POLYGON
   │
   ▼
FULL GEOSPATIAL ANALYSIS
Available Results

For valid georeferenced data:

Spill location
Spill polygon
Approximate area
Map visualization
Drift analysis
Origin estimation
AIS vessel analysis

8. Normal Image Upload Flow

Supported examples:

PNG
JPG
JPEG

If the image does not contain geographic metadata, the system should not invent a location.

Flow
UPLOAD IMAGE
      │
      ▼
VALIDATE FORMAT
      │
      ▼
AI DETECTION
      │
      ▼
CLASSIFICATION
      │
      ▼
SEGMENTATION
      │
      ▼
VISUAL OUTPUT
Available Results

The system can provide:

Oil spill detection
Classification
Confidence
Spill mask
Image boundary

The system should not automatically provide:

Geographic location
Real-world area
Origin estimation
Drift simulation
AIS analysis

unless location and observation metadata are available.

9. AI Detection Data Flow

The AI pipeline follows:

INPUT IMAGE
     │
     ▼
VALIDATION
     │
     ▼
PREPROCESSING
     │
     ▼
MODEL INFERENCE
     │
     ▼
CLASSIFICATION
     │
     ▼
SPILL DETECTED?
     │
 ┌───┴────┐
 │        │
YES       NO
 │        │
 ▼        ▼
SEGMENT   RETURN
 │
 ▼
SPILL MASK
 │
 ▼
GEOSPATIAL CONVERSION
 │
 ▼
SPILL OBJECT

10. Spill Object Flow

After detection, the system creates a structured spill object.

Conceptually:

SPILL OBJECT
│
├── Spill ID
├── Analysis ID
├── Classification
├── Confidence
├── Observation Time
├── Geometry
├── Centroid
└── Area

This spill object becomes the input for:

Drift Analysis
AIS Investigation
Database Storage
Frontend Visualization

11. Hindcasting Data Flow
Purpose

Estimate where the detected spill may have originated.

Flow
DETECTED SPILL
       │
       ▼
SPILL LOCATION
       +
OBSERVATION TIME
       │
       ▼
FETCH ENVIRONMENTAL DATA
       │
       ├── Ocean Currents
       └── Wind
       │
       ▼
BACKWARD DRIFT SIMULATION
       │
       ▼
MULTIPLE POSSIBLE PATHS
       │
       ▼
ORIGIN UNCERTAINTY REGION
Output
Origin Estimate
│
├── Origin Region
├── Estimated Start Time
├── Estimated End Time
├── Backward Trajectory
└── Uncertainty Information

12. Forecasting Data Flow
Purpose

Predict the possible future movement of the detected spill.

Flow
DETECTED SPILL
       │
       ▼
CURRENT LOCATION
       +
OBSERVATION TIME
       │
       ▼
FETCH ENVIRONMENTAL DATA
       │
       ▼
FORWARD DRIFT SIMULATION
       │
       ▼
PREDICTED TRAJECTORY
       │
       ▼
FUTURE SPREAD REGION
Output

The frontend can visualize:

Predicted path
Time-based movement
Future locations
Possible spread region

13. AIS Investigation Data Flow

The AIS workflow begins after origin estimation.

Complete Flow
ORIGIN ESTIMATE
       │
       ▼
DEFINE SEARCH REGION
       +
TIME WINDOW
       │
       ▼
FETCH AIS DATA
       │
       ▼
CLEAN AIS DATA
       │
       ▼
SPATIAL FILTERING
       │
       ▼
TEMPORAL FILTERING
       │
       ▼
TRAJECTORY ANALYSIS
       │
       ▼
BEHAVIOURAL ANALYSIS
       │
       ▼
PRIORITY SCORING
       │
       ▼
VESSEL INVESTIGATION RESULTS

14. Spatial Filtering Flow

The system identifies vessels based on geographic proximity.

ALL VESSELS
      │
      ▼
SPATIAL QUERY
      │
      ▼
VESSELS NEAR
ORIGIN REGION
      │
      ▼
RELEVANT VESSELS

Example concept:

Origin Region

   ┌───────────────┐
   │               │
   │      ●        │
   │               │
   └───────────────┘

Find vessels within
configured distance.

15. Temporal Filtering Flow

After spatial filtering:

RELEVANT VESSELS
       │
       ▼
FILTER BY TIME WINDOW
       │
       ▼
VESSELS PRESENT DURING
POSSIBLE ORIGIN PERIOD

16. Vessel Priority Scoring Flow

Each vessel is evaluated using investigation indicators.

SPATIAL SCORE
      │
TEMPORAL SCORE
      │
TRAJECTORY SCORE
      │
BEHAVIOURAL SCORE
      │
      ▼
PRIORITY ENGINE
      │
      ▼
FINAL PRIORITY SCORE
      │
      ▼
VESSEL RANKING

17. Database Data Flow

The database stores processed results throughout the analysis.

AI MODULE
    │
    ▼
ANALYSIS + SPILL DATA
    │
    ▼
DATABASE
DRIFT MODULE
    │
    ▼
ORIGIN + TRAJECTORY DATA
    │
    ▼
DATABASE
AIS MODULE
    │
    ▼
VESSEL + INVESTIGATION DATA
    │
    ▼
DATABASE

18. Frontend Data Retrieval Flow

The frontend retrieves processed information through APIs.

DATABASE
    │
    ▼
BACKEND SERVICE
    │
    ▼
API RESPONSE
    │
    ▼
FRONTEND

The frontend then transforms this information into:

Maps
Markers
Polygons
Trajectories
Timelines
Charts
Investigation tables

19. Interactive Map Data Flow

The map is one of the primary visualization components.

DATABASE / API
      │
      ▼
GEOSPATIAL DATA
      │
      ├── Spill Polygon
      ├── Origin Region
      ├── Drift Path
      ├── Vessel Positions
      └── Vessel Trajectories
      │
      ▼
MAP COMPONENT
      │
      ▼
INTERACTIVE VISUALIZATION

20. Complete End-to-End Analysis Flow

The complete intelligence pipeline is:

DATA SOURCE
    │
    ▼
VALIDATION
    │
    ▼
SATELLITE IMAGE
    │
    ▼
AI DETECTION
    │
    ▼
OIL SPILL DETECTED
    │
    ▼
SEGMENTATION
    │
    ▼
SPILL CHARACTERIZATION
    │
    ▼
DATABASE
    │
    ├──────────────────────┐
    ▼                      ▼
HINDCASTING            FORECASTING
    │                      │
    ▼                      ▼
ORIGIN REGION        FUTURE MOVEMENT
    │
    ▼
AIS DATA ANALYSIS
    │
    ▼
VESSEL FILTERING
    │
    ▼
PRIORITY SCORING
    │
    ▼
DATABASE
    │
    ▼
INTERACTIVE MAP
    │
    ▼
USER

21. Error and No-Detection Flow

The system should also handle unsuccessful or negative results clearly.

REQUEST
   │
   ▼
PROCESSING
   │
   ├───────────────┐
   │               │
SUCCESS           FAILURE
   │               │
   ▼               ▼
RESULT         ERROR RESPONSE

For AI analysis:

AI DETECTION
      │
      ▼
NO OIL SPILL
      │
      ▼
STORE RESULT
      │
      ▼
DISPLAY
"NO SIGNIFICANT SPILL DETECTED"

A negative result is still a valid analysis result.

22. Data Flow Principles

The system should follow these principles.

Backend as the Gateway
Frontend
    ↓
Backend
    ↓
Modules / Database

The frontend should not directly access internal modules.

Structured Data Exchange

Modules should exchange structured data.

Example:

Module Input
    ↓
Processing
    ↓
Structured Output

This makes modules easier to replace or improve.

Preserve Metadata

Important metadata should travel with analysis results whenever available.

Examples:

Observation time
Geographic coordinates
CRS
Data source
Analysis ID
Avoid Unnecessary Data Duplication

Store:

Processed results
Important historical data
Relevant AIS information

Avoid unnecessarily duplicating large external datasets.

23. Summary

The Marine Spill Intelligence System follows the data intelligence pipeline:

COLLECT
   ↓
VALIDATE
   ↓
DETECT
   ↓
ANALYSE
   ↓
CHARACTERIZE
   ↓
TRACE
   ↓
INVESTIGATE
   ↓
PREDICT
   ↓
STORE
   ↓
VISUALIZE

The three primary user workflows are:

Near-Real-Time Monitoring
           │
Historical Event Analysis
           │
User Upload Analysis
           │
           ▼
     CORE AI PIPELINE
           │
           ▼
     SPILL INTELLIGENCE
           │
           ▼
     INTERACTIVE MAP