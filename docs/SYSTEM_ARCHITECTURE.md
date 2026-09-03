System Architecture
Marine Spill Intelligence System
SIH26143 | Space Technology

1. Purpose

The Marine Spill Intelligence System is an AI-powered geospatial platform designed to detect, analyse, trace, investigate, and predict marine oil spills.

The system integrates:

Satellite imagery
Artificial Intelligence
Environmental data
Drift modelling
AIS vessel data
Geospatial databases
Interactive visualization

The core system workflow is:

Detect → Characterize → Trace → Investigate → Predict → Visualize

2. High-Level Architecture
                              USER
                               │
                               ▼
                    ┌─────────────────────┐
                    │     FRONTEND        │
                    │ React + TypeScript  │
                    │ Interactive Maps    │
                    └──────────┬──────────┘
                               │
                         REST API
                               │
                               ▼
                    ┌─────────────────────┐
                    │      BACKEND        │
                    │       FastAPI       │
                    │ API + Orchestration │
                    └──────────┬──────────┘
                               │
          ┌────────────────────┼────────────────────┐
          │                    │                    │
          ▼                    ▼                    ▼
   ┌─────────────┐      ┌─────────────┐      ┌─────────────┐
   │  AI MODULE  │      │ DRIFT MODULE│      │ AIS MODULE  │
   │             │      │             │      │             │
   │ Detection   │      │ Hindcasting │      │ Vessel Data │
   │ Classification│    │ Forecasting │      │ Filtering   │
   │ Segmentation│      │             │      │ Analysis    │
   └──────┬──────┘      └──────┬──────┘      └──────┬──────┘
          │                    │                    │
          └────────────────────┼────────────────────┘
                               │
                               ▼
                    ┌─────────────────────┐
                    │   DATA ACCESS LAYER │
                    │ Processing Services │
                    └──────────┬──────────┘
                               │
           ┌───────────────────┼───────────────────┐
           │                   │                   │
           ▼                   ▼                   ▼
    SATELLITE DATA      ENVIRONMENTAL DATA      AIS DATA


                               │
                               ▼
                    ┌─────────────────────┐
                    │      DATABASE       │
                    │ PostgreSQL + PostGIS│
                    └─────────────────────┘

3. Major System Components

The system consists of six primary components.

1. Frontend
2. Backend
3. AI Module
4. Drift Analysis Module
5. AIS Vessel Analysis Module
6. Database

External data sources provide the information required by these components.

4. Frontend Architecture
Technology
React
TypeScript
MapLibre GL or Leaflet

The frontend is responsible for user interaction and visualization.

Main User Interfaces: 

1. Near-Real-Time Monitoring

Allows users to:

Select a maritime region
View latest available satellite observations
Analyse potential oil spills
View results on an interactive map
2. Historical Event Analysis

Allows users to:

Select a historical oil spill event
Analyse historical satellite observations
View spill evolution
Investigate vessel activity
Explore the event through a timeline

3. Upload and Analyze

Allows users to upload:

GeoTIFF files
Other supported geospatial raster data
PNG/JPG/JPEG images

The frontend displays the capabilities available for each uploaded file.

4. Interactive Intelligence Dashboard

Displays:

Spill location
Spill boundaries
Origin region
Drift trajectories
Vessel positions
Vessel trajectories
Investigation rankings
Environmental information

5. Backend Architecture
Technology

FastAPI

The backend acts as the central orchestration layer.

It is responsible for:

Receiving requests from the frontend
Validating user inputs
Coordinating AI analysis
Coordinating drift simulations
Coordinating AIS analysis
Communicating with external data sources
Managing database operations
Returning processed results to the frontend

The backend should avoid placing all processing logic directly inside API route files.

Instead:

API Routes
     ↓
Services
     ↓
Processing Modules
     ↓
Database / External Data

6. AI Module

The AI module is responsible for analysing satellite imagery.

Input
Sentinel-1 SAR imagery
Supported uploaded imagery
Processing
Satellite Image
      ↓
Preprocessing
      ↓
AI Detection
      ↓
Classification
      ↓
Segmentation
Classification Output

The system classifies observations into:

Oil Spill
Look-Alike
No Significant Spill
Segmentation Output

When an oil spill is detected:

Spill mask
Spill boundary
Confidence score
Possible Technologies
Python
PyTorch
OpenCV
NumPy
Rasterio

7. Drift Analysis Module

The drift module analyses the movement of detected oil spills.

Primary Framework
OpenDrift
OpenOil
Input

The module receives:

Spill location
Spill geometry
Observation time
Ocean current data
Wind data
Hindcasting

Hindcasting simulates movement backward in time.

Output
Likely origin region
Estimated origin time window
Uncertainty zone
Forecasting

Forecasting simulates possible future movement.

Output
Predicted trajectory
Movement direction
Potential spread region
Time-based predictions

8. AIS Vessel Analysis Module

The AIS module analyses vessel activity near the estimated origin region.

Input
Estimated origin region
Estimated origin time window
Historical AIS data
Processing Pipeline
AIS Data
    ↓
Spatial Filtering
    ↓
Temporal Filtering
    ↓
Trajectory Analysis
    ↓
Behavioural Analysis
    ↓
Priority Scoring
Spatial Filtering

Identify vessels:

Inside the origin region
Near the origin region
Near relevant spill trajectories
Temporal Filtering

Identify vessels present during the relevant estimated time window.

Trajectory Analysis

Analyse:

Vessel routes
Route proximity
Time spent near the origin region
Trajectory intersections
Behavioural Analysis

Potential indicators include:

AIS transmission gaps
Route deviations
Speed changes
Unusual stopping patterns

These indicators are investigation signals and do not establish responsibility.

9. Investigation Priority Engine

The investigation engine combines information from AIS analysis.

Factors
Proximity
+
Temporal Correlation
+
Trajectory Correlation
+
Behavioural Indicators
Output

Each relevant vessel receives:

Investigation priority score
Rank
Supporting evidence

Example:

Vessel A

Priority Score: 87/100

Evidence:
- Present near estimated origin
- Present during relevant time window
- Trajectory crossed investigation zone

The system identifies:

Investigation Priorities

It does not identify confirmed responsible vessels.

10. Database Architecture
Technology

PostgreSQL + PostGIS

The database acts as the persistent storage and geospatial intelligence layer.

Main Data Stored
Historical Events
Event
├── ID
├── Name
├── Location
├── Date
└── Description
Analysis Results
Analysis
├── ID
├── Source
├── Timestamp
├── Detection Result
└── Confidence
Spill Data
Spill
├── Location
├── Polygon
├── Area
├── Shape
└── Observation Time
Origin Estimation
Origin Analysis
├── Estimated Origin Zone
├── Time Window
└── Uncertainty Zone
Drift Results
Drift Simulation
├── Trajectory
├── Predicted Positions
└── Simulation Time
Vessel Investigation
Vessel Investigation
├── Vessel ID / MMSI
├── Vessel Information
├── Priority Score
├── Rank
└── Evidence
Why PostGIS?

PostGIS allows us to perform spatial queries such as:

Find vessels within X km
of the estimated origin zone.

It can also store:

Points
Polygons
Lines
Vessel trajectories
Spill boundaries

11. External Data Sources

The system depends on external datasets and services.

Satellite Data

Used for:

Oil spill detection
Historical analysis
Latest observation monitoring

Example source category:

Sentinel-1 SAR data
Environmental Data

Used for drift modelling.

Includes:

Ocean currents
Wind information
AIS Data

Used for vessel investigation.

Includes:

Vessel positions
Timestamps
Speed
Course
Vessel metadata

12. Complete Data Flow

The primary workflow is:

SATELLITE DATA / USER UPLOAD
            │
            ▼
 DATA VALIDATION & PREPROCESSING
            │
            ▼
        AI MODULE
            │
            ▼
     OIL SPILL DETECTED?
        │          │
       YES         NO
        │          │
        ▼          ▼
   SEGMENTATION   RETURN RESULT
        │
        ▼
 SPILL CHARACTERIZATION
        │
        ├───────────────────┐
        │                   │
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
 VESSEL FILTERING
        │
        ▼
 PRIORITY SCORING
        │
        ▼
DATABASE STORAGE
        │
        ▼
 FRONTEND VISUALIZATION

13. Module Communication

The frontend does not directly communicate with the AI model, database, or external datasets.

All communication goes through the backend.

FRONTEND
    │
    ▼
BACKEND API
    │
    ├──── AI MODULE
    │
    ├──── DRIFT MODULE
    │
    ├──── AIS MODULE
    │
    ├──── DATABASE
    │
    └──── EXTERNAL DATA SOURCES

This keeps the system:

Modular
Secure
Maintainable
Easier to test

14. Architecture Principles

The project should follow these principles.

Modularity

Each major feature should function as an independent module.

AI
Drift
AIS
Database
Frontend

Modules should communicate through clearly defined interfaces.

Separation of Concerns

Frontend should handle:

User interaction and visualization.

Backend should handle:

API orchestration and business logic.

AI module should handle:

Image analysis.

Drift module should handle:

Environmental simulations.

AIS module should handle:

Vessel analysis.

Database should handle:

Persistent and geospatial storage.

Scalability

The architecture should allow modules to be improved independently.

For example:

Replace AI Model
       ↓
Without rebuilding
the entire application.

15. Proposed Deployment Architecture

For the prototype:

                    USER
                      │
                      ▼
                 FRONTEND
                  React
                      │
                      ▼
                  FastAPI
                      │
          ┌───────────┼───────────┐
          ▼           ▼           ▼
         AI         Drift        AIS
       Module       Module      Module
          │           │           │
          └───────────┼───────────┘
                      │
                      ▼
             PostgreSQL/PostGIS

External datasets are accessed when required.

16. Future Architecture Expansion

The architecture can later be expanded to support:

Automated satellite monitoring
Background processing queues
Multiple AI models
Large-scale event analysis
Real-time notifications
Cloud storage
Containerized deployment
Distributed processing

These features are not required for the initial prototype.

17. Technology Mapping
Component	Technology
Frontend	React + TypeScript
Backend	FastAPI
AI/ML	Python + PyTorch
Image Processing	OpenCV
Geospatial Processing	Rasterio, GeoPandas, Shapely
Drift Modelling	OpenDrift / OpenOil
Database	PostgreSQL + PostGIS
Maps	MapLibre GL or Leaflet
Satellite Data	Sentinel-1 SAR
Environmental Data	Ocean Current + Wind Sources
Vessel Data	AIS Data

18. Architecture Summary

The Marine Spill Intelligence System follows a modular architecture where the backend coordinates multiple analytical modules.

The complete intelligence pipeline is:

INPUT
  ↓
VALIDATE
  ↓
DETECT
  ↓
SEGMENT
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

The core components are:

Frontend
    ↓
Backend
    ↓
AI + Drift + AIS
    ↓
PostgreSQL + PostGIS
    ↓
Interactive Intelligence Dashboard