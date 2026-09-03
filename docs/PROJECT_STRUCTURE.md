Project Structure
Marine Spill Intelligence System
SIH26143 | Space Technology

1. Purpose

This document defines the recommended repository and folder structure for the Marine Spill Intelligence System.

The project consists of multiple major systems:

Frontend application
Backend API
AI/ML oil spill detection
Drift simulation
AIS vessel investigation
Database
Documentation

The structure should allow all teammates to work independently while keeping the project easy to integrate.

2. High-Level Repository Structure
marine-spill-intelligence/
│
├── frontend/
├── backend/
├── ml/
├── data/
├── database/
├── docs/
├── scripts/
├── tests/
│
├── .env.example
├── .gitignore
├── README.md
└── docker-compose.yml

3. Repository Overview
marine-spill-intelligence
│
├── frontend
│       User Interface
│
├── backend
│       API + Core Application Logic
│
├── ml
│       Oil Spill Detection Models
│
├── data
│       Small sample/demo data
│
├── database
│       Database schema and migrations
│
├── docs
│       Project documentation
│
├── scripts
│       Utility scripts
│
└── tests
        Automated tests

4. Frontend Structure

The frontend is responsible for:

User interface
Interactive maps
Dashboards
Historical events
Upload analysis
Investigation visualization

Recommended structure:

frontend/
│
├── public/
│
├── src/
│   │
│   ├── assets/
│   │
│   ├── components/
│   │   │
│   │   ├── ui/
│   │   ├── layout/
│   │   ├── map/
│   │   ├── analysis/
│   │   └── investigation/
│   │
│   ├── pages/
│   │
│   ├── services/
│   │
│   ├── hooks/
│   │
│   ├── types/
│   │
│   ├── utils/
│   │
│   ├── styles/
│   │
│   ├── App.tsx
│   └── main.tsx
│
├── package.json
└── vite.config.ts

5. Frontend Components
UI Components
components/ui/

Contains reusable components such as:

Button
Card
Badge
Modal
Loader
Input

These components should be generic and reusable.

Layout Components
components/layout/

Contains:

Sidebar
Topbar
PageLayout

These define the application's main structure.

Map Components
components/map/

Contains:

MapView
SpillLayer
DriftLayer
VesselLayer
OriginLayer
LayerControls

These components handle geospatial visualization.

Analysis Components
components/analysis/

Contains:

AnalysisHeader
SpillSummary
DetectionResult
AnalysisProgress
Timeline
Investigation Components
components/investigation/

Contains:

VesselTable
VesselCard
EvidencePanel
PriorityScore

6. Pages Structure
pages/
│
├── Dashboard.tsx
├── Monitoring.tsx
├── HistoricalEvents.tsx
├── EventDetails.tsx
├── UploadAnalysis.tsx
├── Analysis.tsx
└── Investigations.tsx
Page Responsibilities
Dashboard
System overview
Latest analyses
Recent alerts
Map overview
Monitoring
Select region
Request latest satellite data
Start analysis
View monitoring results
Historical Events
Browse historical events
Select event
View event details
Upload Analysis
Upload image
Validate file
Detect metadata
Run AI analysis
Analysis
View spill results
Interactive map
Drift analysis
Origin estimation
Investigations
Ranked vessels
Evidence
Priority scores
Vessel trajectories

7. Frontend Services
frontend/src/services/

Contains API communication.

Example:

api.ts
analysisService.ts
eventService.ts
monitoringService.ts
uploadService.ts
vesselService.ts
Important Rule

Frontend components should not directly contain API request logic everywhere.

Preferred flow:

COMPONENT
    ↓
SERVICE
    ↓
BACKEND API

Example:

Analysis.tsx
      ↓
analysisService.ts
      ↓
/api/v1/analysis

8. Backend Structure

The backend acts as the central application layer.

Recommended structure:

backend/
│
├── app/
│   │
│   ├── api/
│   │   └── v1/
│   │
│   ├── core/
│   │
│   ├── models/
│   │
│   ├── schemas/
│   │
│   ├── services/
│   │
│   ├── modules/
│   │
│   ├── database/
│   │
│   ├── utils/
│   │
│   └── main.py
│
├── requirements.txt
└── Dockerfile

9. Backend API Structure
backend/app/api/v1/
│
├── health.py
├── events.py
├── analysis.py
├── monitoring.py
├── upload.py
├── spills.py
├── drift.py
└── vessels.py

Each file handles a specific group of API endpoints.

10. Backend Core
backend/app/core/

Contains application configuration.

Example:

config.py
security.py
constants.py

11. Backend Models
backend/app/models/

Contains database models.

Example:

analysis.py
spill.py
event.py
vessel.py
simulation.py

These represent database entities.

12. Backend Schemas
backend/app/schemas/

Contains request and response structures.

Example:

analysis.py
event.py
spill.py
vessel.py

Example concept:

API REQUEST
     ↓
PYDANTIC SCHEMA
     ↓
SERVICE
     ↓
DATABASE / MODULE
     ↓
RESPONSE SCHEMA

13. Backend Services
backend/app/services/

This is where most application logic should live.

Example:

analysis_service.py
event_service.py
satellite_service.py
upload_service.py
ais_service.py
drift_service.py

14. Processing Modules
backend/app/modules/

Contains connections to major processing systems.

Example:

ml/
drift/
ais/
satellite/

Structure:

modules/
│
├── ml/
│
├── drift/
│
├── ais/
│
└── satellite/

15. Backend Processing Flow
API ROUTE
    ↓
SERVICE
    ↓
PROCESSING MODULE
    ↓
DATABASE / EXTERNAL DATA
    ↓
SERVICE
    ↓
API RESPONSE

Example:

POST /monitoring/analyze
        ↓
monitoring.py
        ↓
analysis_service.py
        ↓
satellite module
        ↓
ML module
        ↓
database
        ↓
analysis_id

16. ML Structure

The ML directory contains AI-related code.

ml/
│
├── models/
│
├── training/
│
├── inference/
│
├── preprocessing/
│
├── postprocessing/
│
├── datasets/
│
├── notebooks/
│
└── README.md

17. ML Components
Models
ml/models/

Contains:

Model architecture
Model weights reference
Configuration

Large trained model files should generally not be committed directly to GitHub unless they are reasonably small and appropriate for the repository.

Training
ml/training/

Contains:

Training scripts
Configuration
Evaluation logic
Inference
ml/inference/

Contains code used by the actual application.

Example:

predict.py
model_loader.py

The backend should interact primarily with the inference pipeline.

Preprocessing
ml/preprocessing/

Contains:

Image loading
Normalization
Resizing
Band processing
Postprocessing
ml/postprocessing/

Contains:

Segmentation masks
Polygon generation
Confidence processing

18. Drift Module Structure

Drift modelling may initially live inside:

backend/app/modules/drift/

Suggested structure:

drift/
│
├── hindcast.py
├── forecast.py
├── environmental_data.py
├── simulation.py
└── utils.py
Responsibilities
hindcast.py
→ Estimate possible origin

forecast.py
→ Predict future movement

environmental_data.py
→ Fetch wind/current information

simulation.py
→ Core simulation logic

19. AIS Module Structure

Located at:

backend/app/modules/ais/

Suggested structure:

ais/
│
├── data_fetcher.py
├── preprocessing.py
├── spatial_filter.py
├── temporal_filter.py
├── trajectory_analysis.py
├── scoring.py
└── utils.py
AIS Flow
AIS DATA
    ↓
PREPROCESSING
    ↓
SPATIAL FILTERING
    ↓
TEMPORAL FILTERING
    ↓
TRAJECTORY ANALYSIS
    ↓
SCORING
    ↓
VESSEL RANKING

20. Satellite Module

Located at:

backend/app/modules/satellite/

Suggested structure:

satellite/
│
├── data_fetcher.py
├── metadata.py
├── preprocessing.py
└── validation.py
Responsibilities
data_fetcher.py
→ Retrieve satellite data

metadata.py
→ Extract observation information

preprocessing.py
→ Prepare imagery

validation.py
→ Validate satellite data

21. Data Directory
data/

Should contain only manageable project data.

Suggested structure:

data/
│
├── sample/
├── historical/
└── processed/
Important Rule

Do not store massive raw datasets directly in the GitHub repository.

Instead, use:

External dataset sources
Cloud storage
Download scripts
Data references

22. Database Directory
database/
│
├── migrations/
│
├── schema/
│
├── seeds/
│
└── README.md
Schema
database/schema/

Contains:

initial_schema.sql

This defines the starting database structure.

Migrations
database/migrations/

Contains database changes over time.

Example:

001_initial_schema.sql

002_add_spill_geometry.sql

003_add_vessel_scores.sql
Seeds
database/seeds/

Contains sample data.

Example:

historical_events.sql
demo_data.sql

23. Documentation Directory
docs/

Contains all project documentation.

Current structure:

docs/
│
├── DATABASE_DESIGN.md
├── DATA_FLOW.md
├── API_DOCUMENTATION.md
├── DESIGN_SYSTEM.md
├── PROJECT_STRUCTURE.md

Future documents may include:

ARCHITECTURE.md
SETUP_GUIDE.md
CONTRIBUTING.md
DEPLOYMENT.md

24. Scripts Directory
scripts/

Contains utility scripts.

Examples:

download_data.py
setup_database.py
seed_database.py

These scripts should automate repetitive tasks.

25. Tests Structure
tests/
│
├── backend/
├── ml/
├── integration/
└── frontend/
Backend Tests
tests/backend/

Test:

API endpoints
Services
Validation
ML Tests
tests/ml/

Test:

Model loading
Inference pipeline
Input validation
Integration Tests
tests/integration/

Test complete workflows.

Example:

UPLOAD IMAGE
     ↓
AI DETECTION
     ↓
DATABASE
     ↓
API RESPONSE

26. Environment Variables

The project should contain:

.env.example

Example:

DATABASE_URL=

SATELLITE_API_KEY=

AIS_API_KEY=

ENVIRONMENT=development

The actual:

.env

file should not be committed.

27. Git Ignore

The .gitignore should exclude:

.env

node_modules/

__pycache__/

*.pyc

venv/

.venv/

large_model_files/

large_datasets/

The exact .gitignore should be adjusted for the final tech stack.

28. Docker Structure

At a later stage, Docker can help ensure everyone runs the same environment.

Possible structure:

frontend/
    Dockerfile

backend/
    Dockerfile

docker-compose.yml

Conceptually:

DOCKER COMPOSE
│
├── FRONTEND
│
├── BACKEND
│
└── DATABASE

29. Development Ownership

Even though teammates may own different areas, everyone should follow the same repository structure.

Example:

FRONTEND
    ↓
frontend/

BACKEND
    ↓
backend/

AI
    ↓
ml/

DATABASE
    ↓
database/

The goal is:

INDEPENDENT DEVELOPMENT
          +
EASY INTEGRATION

30. Recommended Git Workflow

The main branch should remain stable.

Recommended structure:

main

Development work should happen through feature branches.

Example:

feature/frontend-dashboard

feature/backend-api

feature/ml-detection

feature/database-schema

feature/drift-module

feature/ais-analysis
Workflow
CREATE BRANCH
      ↓
DEVELOP FEATURE
      ↓
TEST
      ↓
PUSH TO GITHUB
      ↓
PULL REQUEST
      ↓
REVIEW
      ↓
MERGE

31. Commit Naming

Use meaningful commit messages.

Good examples:

feat: add oil spill detection endpoint

feat: implement vessel priority scoring

fix: handle invalid GeoTIFF upload

docs: update database design

refactor: improve satellite data service

Avoid:

update

final

done

asdf

😭

32. Complete Project Structure

The final repository may look like:

marine-spill-intelligence/
│
├── frontend/
│   ├── public/
│   ├── src/
│   │   ├── assets/
│   │   ├── components/
│   │   │   ├── ui/
│   │   │   ├── layout/
│   │   │   ├── map/
│   │   │   ├── analysis/
│   │   │   └── investigation/
│   │   │
│   │   ├── pages/
│   │   ├── services/
│   │   ├── hooks/
│   │   ├── types/
│   │   ├── utils/
│   │   ├── styles/
│   │   ├── App.tsx
│   │   └── main.tsx
│   │
│   └── package.json
│
├── backend/
│   ├── app/
│   │   ├── api/
│   │   │   └── v1/
│   │   │
│   │   ├── core/
│   │   ├── models/
│   │   ├── schemas/
│   │   ├── services/
│   │   ├── modules/
│   │   │   ├── ml/
│   │   │   ├── drift/
│   │   │   ├── ais/
│   │   │   └── satellite/
│   │   │
│   │   ├── database/
│   │   ├── utils/
│   │   └── main.py
│   │
│   ├── requirements.txt
│   └── Dockerfile
│
├── ml/
│   ├── models/
│   ├── training/
│   ├── inference/
│   ├── preprocessing/
│   ├── postprocessing/
│   ├── datasets/
│   ├── notebooks/
│   └── README.md
│
├── data/
│   ├── sample/
│   ├── historical/
│   └── processed/
│
├── database/
│   ├── migrations/
│   ├── schema/
│   ├── seeds/
│   └── README.md
│
├── docs/
│   ├── DATABASE_DESIGN.md
│   ├── DATA_FLOW.md
│   ├── API_DOCUMENTATION.md
│   ├── DESIGN_SYSTEM.md
│   └── PROJECT_STRUCTURE.md
│
├── scripts/
│
├── tests/
│   ├── backend/
│   ├── ml/
│   ├── integration/
│   └── frontend/
│
├── .env.example
├── .gitignore
├── README.md
└── docker-compose.yml

33. Core Development Principle

The repository should follow this flow:

FRONTEND
    │
    ▼
BACKEND API
    │
    ├───────────────┐
    ▼               ▼
DATABASE      PROCESSING MODULES
                    │
          ┌─────────┼─────────┐
          ▼         ▼         ▼
         ML       DRIFT       AIS
                    │
                    ▼
              EXTERNAL DATA

Each component should have a clear responsibility.

34. Important Rules for the Team

Rule 1 — Don't Mix Responsibilities

Avoid putting:

Frontend code

inside:

Backend modules

and vice versa.

Rule 2 — Reuse Components

Before creating a new component, check whether an existing one can be reused.

Rule 3 — Don't Commit Secrets

Never commit:

API keys
Passwords
Database credentials
.env files

Rule 4 — Keep Large Data Out of Git

Do not upload:

Huge satellite datasets
Massive AIS datasets
Large training datasets

Use references or download scripts instead.

Rule 5 — Document Major Changes

If architecture changes significantly:

UPDATE THE DOCS

so the team doesn't operate on outdated assumptions.

35. Summary

The project structure separates the system into:

UI
│
├── FRONTEND
│
APPLICATION LOGIC
│
├── BACKEND
│
INTELLIGENCE
│
├── ML
├── DRIFT
└── AIS
│
DATA
│
├── DATABASE
└── EXTERNAL SOURCES
│
DOCUMENTATION
│
└── DOCS