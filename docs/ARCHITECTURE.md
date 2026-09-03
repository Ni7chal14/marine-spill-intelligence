System Architecture
Marine Spill Intelligence System
SIH26143 | Space Technology

1. Purpose

This document defines the complete technical architecture of the Marine Spill Intelligence System.

It explains:

How the frontend communicates with the backend
How satellite data enters the system
How oil spill detection works
How drift modelling is performed
How AIS vessel investigation works
How data is stored
How all modules connect together

This document acts as the master technical blueprint of the project.

2. System Overview

The system is designed as a modular intelligence platform for detecting and analysing marine oil spills.

The complete system can be represented as:

                        USER
                          │
                          ▼
                   FRONTEND APPLICATION
                          │
                          │ REST API
                          ▼
                    BACKEND (FASTAPI)
                          │
          ┌───────────────┼────────────────┐
          │               │                │
          ▼               ▼                ▼
       DATABASE       PROCESSING       EXTERNAL DATA
                       MODULES
                           │
              ┌────────────┼────────────┐
              │            │            │
              ▼            ▼            ▼
             ML          DRIFT          AIS
              │            │            │
              └────────────┼────────────┘
                           │
                           ▼
                    ANALYSIS RESULTS
                           │
                           ▼
                     VISUALIZATION

3. Architectural Style

The system follows a modular service-oriented architecture.

The main layers are:

PRESENTATION LAYER
        ↓
APPLICATION LAYER
        ↓
PROCESSING LAYER
        ↓
DATA LAYER
        ↓
EXTERNAL DATA SOURCES

4. Architecture Layers
Layer 1 — Presentation Layer

The presentation layer is the frontend.

Responsibilities:

Display the user interface
Display maps
Accept user input
Upload files
Show analysis results
Visualize spill movement
Visualize vessel trajectories

Technology:

React
TypeScript

The frontend should not directly communicate with external satellite or AIS services.

All communication should go through the backend.

Layer 2 — Application Layer

The application layer is the backend.

Responsibilities:

Receive frontend requests
Validate input
Manage workflows
Trigger processing modules
Store results
Return API responses

Technology:

FastAPI
Python
Layer 3 — Processing Layer

This layer contains the intelligence modules.

Main modules:

SATELLITE MODULE
       ↓
ML DETECTION MODULE
       ↓
SPILL ANALYSIS
       ↓
DRIFT MODULE
       ↓
AIS INVESTIGATION

Each module should have a specific responsibility.

Layer 4 — Data Layer

The data layer manages persistent project information.

It stores:

Analysis records
Historical events
Spill results
Geospatial information
Simulation results
Vessel investigation results

Recommended database:

PostgreSQL
+
PostGIS

PostGIS is useful because the project handles:

Coordinates
Polygons
Spatial filtering
Geographic regions
Vessel trajectories

Layer 5 — External Data Layer

The system may use external sources for:

SATELLITE DATA

AIS DATA

ENVIRONMENTAL DATA

Examples:

Satellite Data
→ Sentinel imagery

Environmental Data
→ Wind and ocean current data

AIS Data
→ Vessel movement information

The exact data providers can be finalized during implementation.

5. Main User Workflows

The system supports three primary workflows.

1. Near-Real-Time Monitoring

2. Historical Event Analysis

3. User Upload Analysis

All three workflows eventually use the same core processing pipeline where possible.

6. Workflow 1 — Near-Real-Time Monitoring

The user selects a maritime region.

USER
  │
  ▼
SELECT REGION
  │
  ▼
FRONTEND
  │
  ▼
BACKEND API
  │
  ▼
SATELLITE DATA MODULE
  │
  ▼
LATEST AVAILABLE OBSERVATION
  │
  ▼
VALIDATION
  │
  ▼
ML DETECTION
  │
  ▼
SPILL ANALYSIS
  │
  ▼
DRIFT ANALYSIS
  │
  ▼
AIS INVESTIGATION
  │
  ▼
DATABASE
  │
  ▼
RESULT DISPLAY

Important:

Near-real-time means analysing the latest available observation, not necessarily a live continuous satellite video feed.

7. Workflow 2 — Historical Event Analysis

This workflow is extremely useful for the SIH demonstration.

USER
  │
  ▼
SELECT HISTORICAL EVENT
  │
  ▼
FRONTEND
  │
  ▼
BACKEND
  │
  ▼
LOAD EVENT DATA
  │
  ▼
LOAD ASSOCIATED SATELLITE DATA
  │
  ▼
ML DETECTION
  │
  ▼
SPILL ANALYSIS
  │
  ▼
DRIFT MODELLING
  │
  ▼
AIS INVESTIGATION
  │
  ▼
LOAD / STORE RESULTS
  │
  ▼
INTERACTIVE VISUALIZATION

This workflow ensures that the prototype can always demonstrate the system using known historical events.

8. Workflow 3 — User Upload Analysis

Users can upload supported satellite imagery or general images.

USER
  │
  ▼
UPLOAD FILE
  │
  ▼
FILE VALIDATION
  │
  ▼
METADATA EXTRACTION
  │
  ├───────────────┐
  │               │
  ▼               ▼
GEOREFERENCED    NORMAL IMAGE
DATA             │
  │               │
  ▼               ▼
FULL ANALYSIS    IMAGE ANALYSIS
Georeferenced Data

If geographic metadata is available:

IMAGE
+
LOCATION
+
COORDINATES

The system can perform:

✓ Spill detection

✓ Geographic visualization

✓ Area estimation

✓ Drift modelling

✓ AIS investigation
Normal Image

If no geographic information exists:

IMAGE ONLY

The system can perform:

✓ Spill detection

✓ Classification

✓ Segmentation

But it should not pretend to know:

✗ Exact location

✗ Drift path

✗ Vessel involvement

9. Core Processing Pipeline

The core intelligence pipeline is:

INPUT DATA
    │
    ▼
VALIDATION
    │
    ▼
PREPROCESSING
    │
    ▼
OIL SPILL DETECTION
    │
    ▼
SPILL CHARACTERIZATION
    │
    ▼
GEOSPATIAL ANALYSIS
    │
    ▼
DRIFT MODELLING
    │
    ▼
AIS INVESTIGATION
    │
    ▼
RESULT STORAGE
    │
    ▼
VISUALIZATION

10. Satellite Data Module

The satellite module is responsible for obtaining and preparing satellite data.

Architecture:

SATELLITE SOURCE
       │
       ▼
DATA FETCHER
       │
       ▼
METADATA EXTRACTION
       │
       ▼
VALIDATION
       │
       ▼
PREPROCESSING
       │
       ▼
ML MODULE
Responsibilities
Data Fetcher

Responsible for:

Requesting satellite observations
Downloading data
Managing observation information
Metadata Module

Extracts:

Observation time

Satellite source

Coordinates

Projection

Resolution

Image dimensions
Validation Module

Checks:

Is the data valid?

Is the format supported?

Is geographic metadata available?

Is the image suitable for analysis?

11. ML Detection Architecture

The ML module is responsible for identifying possible oil spills.

SATELLITE IMAGE
       │
       ▼
PREPROCESSING
       │
       ▼
ML MODEL
       │
       ▼
PREDICTION
       │
       ▼
POSTPROCESSING
       │
       ▼
SPILL RESULT
ML Output

The system may return:

SPILL DETECTED
+
CONFIDENCE SCORE
+
SEGMENTATION MASK
+
SPILL GEOMETRY

Example:

Oil Spill Detected

Confidence:
91%

Estimated Area:
12.4 km²

12. Spill Characterization

After detection, the system processes the spill.

SEGMENTATION MASK
        │
        ▼
BOUNDARY EXTRACTION
        │
        ▼
POLYGON GENERATION
        │
        ▼
AREA CALCULATION
        │
        ▼
CENTROID CALCULATION

The output may include:

Spill ID

Spill Geometry

Area

Centroid

Confidence

Observation Time

13. Geospatial Processing

Geospatial processing connects the AI output with real-world coordinates.

PIXEL SPACE
     │
     ▼
IMAGE METADATA
     │
     ▼
GEOGRAPHIC COORDINATES
     │
     ▼
MAP VISUALIZATION

This is only possible when appropriate geographic metadata exists.

14. Drift Module Architecture

The drift module estimates movement of the detected spill.

It contains two major operations:

HINDCAST
+
FORECAST
Hindcast

Question:

Where might the spill have originated?

Architecture:

CURRENT SPILL LOCATION
        │
        ▼
ENVIRONMENTAL DATA
        │
        ▼
REVERSE SIMULATION
        │
        ▼
POSSIBLE ORIGIN REGION

The output should be considered an:

Estimated origin region

not an exact guaranteed source point.

Forecast

Question:

Where might the spill move next?

Architecture:

CURRENT SPILL LOCATION
        │
        ▼
WIND DATA
+
OCEAN CURRENT DATA
        │
        ▼
FORWARD SIMULATION
        │
        ▼
PREDICTED TRAJECTORY

15. Environmental Data Module

The drift module depends on environmental information.

Possible data:

Wind

Ocean currents

Time

Location

Architecture:

SIMULATION REQUEST
       │
       ▼
ENVIRONMENTAL DATA FETCHER
       │
       ▼
DATA NORMALIZATION
       │
       ▼
DRIFT SIMULATION

16. AIS Investigation Architecture

AIS analysis helps identify vessels relevant to the investigation.

Architecture:

SPILL
 │
 ▼
ORIGIN ESTIMATE
 │
 ▼
DEFINE REGION
+
TIME WINDOW
 │
 ▼
FETCH AIS DATA
 │
 ▼
FILTER VESSELS
 │
 ▼
TRAJECTORY ANALYSIS
 │
 ▼
PRIORITY SCORING
 │
 ▼
RANKED VESSELS

17. Vessel Filtering

The system should avoid analysing every vessel.

Instead:

ALL AVAILABLE VESSELS
        │
        ▼
SPATIAL FILTER
        │
        ▼
TEMPORAL FILTER
        │
        ▼
RELEVANT VESSELS
Spatial Filtering

Question:

Was the vessel near the estimated origin region?

Temporal Filtering

Question:

Was the vessel present during the estimated time window?

18. Vessel Priority Scoring

The system ranks vessels based on investigation relevance.

Example conceptual factors:

PROXIMITY
+
TIME RELEVANCE
+
TRAJECTORY RELEVANCE
+
VESSEL INFORMATION

Example:

Vessel Alpha

Priority Score:
92 / 100

The score should always be accompanied by evidence.

19. Explainability Architecture

The system should not behave like a black box.

Instead of only returning:

Priority Score: 92

The backend should return:

Priority Score: 92

Evidence:

✓ Near estimated origin region

✓ Present during estimated time window

✓ Trajectory intersects investigation area

20. Database Architecture

The database acts as the system memory.

FRONTEND
    │
    ▼
BACKEND
    │
    ▼
DATABASE

The database stores:

Users (optional)

Historical Events

Satellite Observations

Analyses

Spills

Drift Simulations

Vessel Investigations

21. Core Entity Relationships

Conceptually:

HISTORICAL EVENT
        │
        ▼
SATELLITE OBSERVATION
        │
        ▼
ANALYSIS
        │
        ▼
SPILL
        │
 ┌──────┼──────┐
 ▼      ▼      ▼
DRIFT  AIS   RESULTS

22. Analysis Lifecycle

Each analysis should have a lifecycle.

CREATED
   │
   ▼
VALIDATING
   │
   ▼
PROCESSING
   │
   ├─────────────┐
   ▼             ▼
ML           EXTERNAL DATA
   │             │
   └──────┬──────┘
          ▼
     POSTPROCESSING
          │
          ▼
      COMPLETED

Possible failure:

PROCESSING
    │
    ▼
FAILED

23. Data Storage Flow
INPUT
 │
 ▼
BACKEND
 │
 ▼
CREATE ANALYSIS RECORD
 │
 ▼
PROCESSING
 │
 ├─────────────┐
 ▼             ▼
ML RESULT    EXTERNAL DATA
 │             │
 └──────┬──────┘
        ▼
 STORE RESULTS
        │
        ▼
 RETURN TO USER

24. Frontend Architecture

The frontend communicates only with the backend.

USER
 │
 ▼
REACT COMPONENT
 │
 ▼
SERVICE LAYER
 │
 ▼
API REQUEST
 │
 ▼
FASTAPI

Recommended rule:

UI COMPONENT
     ↓
SERVICE
     ↓
API

Avoid putting complex API logic directly inside every UI component.

25. Frontend Visualization Architecture

The frontend receives structured data.

API RESPONSE
      │
      ▼
STATE MANAGEMENT
      │
      ▼
UI COMPONENTS
      │
      ├── MAP
      │
      ├── METRICS
      │
      ├── TIMELINE
      │
      └── INVESTIGATION PANEL

26. Map Architecture

The map is a central visualization system.

MAP
 │
 ├── Base Layer
 │
 ├── Spill Layer
 │
 ├── Origin Layer
 │
 ├── Drift Layer
 │
 └── Vessel Layer

Each layer should be independently controllable.

27. Analysis Result Architecture

A complete analysis result can conceptually contain:

ANALYSIS
│
├── Detection
│
├── Spill Geometry
│
├── Confidence
│
├── Observation Metadata
│
├── Origin Estimate
│
├── Hindcast
│
├── Forecast
│
└── Vessel Investigation

28. API Architecture

The API acts as the communication gateway.

FRONTEND
    │
    ▼
API ROUTE
    │
    ▼
SERVICE
    │
    ├──────────────┐
    ▼              ▼
DATABASE      PROCESSING MODULE
                   │
                   ▼
             EXTERNAL DATA

29. Backend Request Flow

Example:

POST /analysis
       │
       ▼
VALIDATE REQUEST
       │
       ▼
CREATE ANALYSIS
       │
       ▼
START PROCESSING
       │
       ▼
RETURN ANALYSIS ID

Then:

GET /analysis/{id}/status

returns:

PROCESSING

Finally:

GET /analysis/{id}

returns the complete result.

30. Processing Architecture

The processing system should remain modular.

                 ANALYSIS SERVICE
                         │
         ┌───────────────┼───────────────┐
         │               │               │
         ▼               ▼               ▼
    SATELLITE           ML            DRIFT
         │               │               │
         └───────────────┼───────────────┘
                         │
                         ▼
                        AIS

This allows individual modules to be improved independently.

31. Failure Handling

The system should handle failures gracefully.

Possible failures:

Satellite data unavailable

Invalid uploaded file

ML model failure

Environmental data unavailable

AIS data unavailable

The system should not crash completely because one module fails.

Example:

SPILL DETECTION
        ✓ COMPLETED

DRIFT ANALYSIS
        ⚠ DATA UNAVAILABLE

AIS INVESTIGATION
        ✓ COMPLETED

Partial results are better than losing the complete analysis.

32. System Status Architecture

Each module can report its status.

Example:

SATELLITE DATA
✓ AVAILABLE

ML DETECTION
✓ COMPLETED

DRIFT MODEL
PROCESSING

AIS DATA
WAITING

This is useful for both:

Frontend loading states
Debugging

33. Development Architecture

The system should be developed in independent modules.

TEAM DEVELOPMENT
│
├── FRONTEND
│
├── BACKEND
│
├── ML
│
├── DATABASE
│
├── DRIFT
│
└── AIS

All modules integrate through clearly defined interfaces.

34. Integration Architecture

The integration sequence should be:

STEP 1

DATABASE
+
BACKEND FOUNDATION
        ↓

STEP 2

API CONTRACT
        ↓

STEP 3

FRONTEND
        ↓

STEP 4

ML INTEGRATION
        ↓

STEP 5

SATELLITE DATA
        ↓

STEP 6

DRIFT MODULE
        ↓

STEP 7

AIS MODULE
        ↓

STEP 8

FINAL INTEGRATION

This reduces the risk of everyone waiting for everyone else.

35. Hackathon Prototype Architecture

For the 36-hour hackathon, the architecture should prioritize:

WORKING
>
COMPLEX

The prototype should first ensure:

✓ Working frontend

✓ Working backend

✓ At least one ML detection pipeline

✓ Historical event demonstration

✓ Interactive map

✓ Database

✓ Basic drift simulation

✓ Basic vessel investigation

Advanced functionality can be added after the core workflow works.

36. Recommended Demo Architecture

For the final presentation:

SELECT HISTORICAL EVENT
          │
          ▼
LOAD SATELLITE DATA
          │
          ▼
OIL SPILL DETECTED
          │
          ▼
SHOW SPILL ON MAP
          │
          ▼
SHOW AREA + CONFIDENCE
          │
          ▼
SHOW POSSIBLE ORIGIN
          │
          ▼
ANIMATE DRIFT
          │
          ▼
SHOW VESSELS
          │
          ▼
RANK INVESTIGATION TARGETS

This gives the judges a complete story.

37. Master System Workflow

The complete architecture can be summarized as:

                         USER
                           │
                           ▼
                    FRONTEND APP
                           │
                           ▼
                      BACKEND API
                           │
          ┌────────────────┼─────────────────┐
          │                │                 │
          ▼                ▼                 ▼
      DATABASE         PROCESSING       EXTERNAL DATA
                         MODULES
                           │
             ┌─────────────┼─────────────┐
             │             │             │
             ▼             ▼             ▼
        SATELLITE          ML           DRIFT
             │             │             │
             └─────────────┼─────────────┘
                           │
                           ▼
                          AIS
                           │
                           ▼
                    ANALYSIS RESULTS
                           │
                           ▼
                      DATABASE
                           │
                           ▼
                    FRONTEND MAP

38. Architecture Principles

The system should follow these principles:

Modularity

Each module should have one clear responsibility.

Scalability

The architecture should allow new:

Satellite sources
ML models
Drift models
AIS providers

to be added later.

Explainability

Results should provide reasoning and evidence.

Reliability

Failure in one external service should not destroy the entire analysis.

Data Integrity

The system should clearly distinguish:

REAL DATA

MODEL OUTPUT

ESTIMATED DATA

This is especially important for scientific credibility.

39. Final Architecture Summary

The complete system follows:

OBSERVE
   ↓
ACQUIRE DATA
   ↓
DETECT
   ↓
ANALYSE
   ↓
GEOREFERENCE
   ↓
TRACE BACK
   ↓
PREDICT FORWARD
   ↓
INVESTIGATE
   ↓
VISUALIZE

The project is essentially a:

Satellite-powered marine intelligence platform that detects potential oil spills, analyses their spatial characteristics, estimates their movement and possible origin, and supports vessel-based investigation.