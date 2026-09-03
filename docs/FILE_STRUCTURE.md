File Structure
Marine Spill Intelligence System
SIH26143 | Space Technology

1. Purpose

This document defines the recommended folder and file structure for the Marine Spill Intelligence System.

The structure is designed to keep the project:

Modular
Scalable
Easy to maintain
Easy for multiple team members to work on
Easy to integrate through GitHub

Each major system component is separated into its own module.

2. High-Level Repository Structure
marine-spill-intelligence/
│
├── frontend/
├── backend/
├── ai/
├── drift/
├── ais/
├── database/
├── docs/
│
├── .gitignore
├── README.md
└── docker-compose.yml

3. Frontend Structure

The frontend contains the web application and user interface.

Technologies
React
TypeScript
MapLibre GL or Leaflet
frontend/
│
├── public/
│
├── src/
│   │
│   ├── assets/
│   │
│   ├── components/
│   │   ├── common/
│   │   ├── layout/
│   │   └── map/
│   │
│   ├── pages/
│   │   ├── Dashboard/
│   │   ├── Monitoring/
│   │   ├── HistoricalAnalysis/
│   │   └── UploadAnalysis/
│   │
│   ├── features/
│   │   ├── spill/
│   │   ├── drift/
│   │   ├── vessels/
│   │   └── events/
│   │
│   ├── services/
│   │   └── api/
│   │
│   ├── hooks/
│   │
│   ├── types/
│   │
│   ├── utils/
│   │
│   ├── constants/
│   │
│   ├── App.tsx
│   └── main.tsx
│
├── package.json
└── README.md
Responsibilities

The frontend handles:

User interaction
Dashboard interface
Interactive maps
Data visualization
Historical event selection
File uploads
Displaying analysis results

4. Backend Structure

The backend acts as the central API and orchestration layer.

Technology
FastAPI
backend/
│
├── app/
│   │
│   ├── api/
│   │   ├── routes/
│   │   │   ├── analysis.py
│   │   │   ├── events.py
│   │   │   ├── vessels.py
│   │   │   └── upload.py
│   │   │
│   │   └── dependencies.py
│   │
│   ├── services/
│   │   ├── analysis_service.py
│   │   ├── satellite_service.py
│   │   ├── drift_service.py
│   │   └── ais_service.py
│   │
│   ├── models/
│   │
│   ├── schemas/
│   │
│   ├── database/
│   │   ├── connection.py
│   │   └── repositories/
│   │
│   ├── core/
│   │   ├── config.py
│   │   └── security.py
│   │
│   └── main.py
│
├── requirements.txt
└── README.md
Responsibilities

The backend handles:

API requests
Input validation
Module orchestration
Database communication
External data communication
Returning results to the frontend

5. AI Module Structure

The AI module handles oil spill detection and segmentation.

ai/
│
├── data/
│   ├── samples/
│   └── processed/
│
├── models/
│
├── training/
│   ├── train.py
│   └── evaluate.py
│
├── inference/
│   └── predict.py
│
├── preprocessing/
│   ├── preprocess.py
│   └── tiling.py
│
├── segmentation/
│   └── segment.py
│
├── notebooks/
│
├── requirements.txt
└── README.md
Responsibilities
Satellite Image
       ↓
Preprocessing
       ↓
Detection
       ↓
Classification
       ↓
Segmentation
       ↓
Spill Mask + Confidence

6. Drift Module Structure

The drift module handles oil spill movement analysis.

drift/
│
├── hindcasting/
│   └── hindcast.py
│
├── forecasting/
│   └── forecast.py
│
├── simulation/
│   └── simulation.py
│
├── environmental/
│   ├── currents.py
│   └── wind.py
│
├── utils/
│
├── requirements.txt
└── README.md
Responsibilities
Hindcasting
Current Spill Location
        ↓
Backward Simulation
        ↓
Estimated Origin Region
Forecasting
Current Spill Location
        ↓
Forward Simulation
        ↓
Predicted Movement

7. AIS Module Structure

The AIS module handles vessel data processing and investigation analysis.

ais/
│
├── data/
│   └── samples/
│
├── processing/
│   ├── clean.py
│   └── filter.py
│
├── analysis/
│   ├── spatial_analysis.py
│   ├── temporal_analysis.py
│   └── trajectory_analysis.py
│
├── scoring/
│   └── priority_score.py
│
├── utils/
│
├── requirements.txt
└── README.md
Responsibilities
AIS Data
    ↓
Data Cleaning
    ↓
Spatial Filtering
    ↓
Temporal Filtering
    ↓
Trajectory Analysis
    ↓
Behaviour Analysis
    ↓
Priority Scoring

8. Database Structure

The database folder contains database-related configuration and migrations.

Technology
PostgreSQL
PostGIS
database/
│
├── schema/
│   └── schema.sql
│
├── migrations/
│
├── seeds/
│   └── sample_data.sql
│
└── README.md
Database Responsibilities

The database stores:

Historical events
Analysis results
Spill locations
Spill polygons
Origin regions
Drift simulation results
Relevant vessel information
Investigation scores

Large raw datasets should not be stored directly in the database unless necessary.

9. Documentation Structure

All development documentation is stored inside the docs folder.

docs/
│
├── PROJECT_OVERVIEW.md
├── SYSTEM_ARCHITECTURE.md
├── FILE_STRUCTURE.md
├── MODULE_DOCUMENTATION.md
├── DATABASE_DESIGN.md
├── DATA_FLOW.md
├── API_DOCUMENTATION.md
└── DESIGN_SYSTEM.md

10. Root-Level Files
README.md

The main project introduction.

Contains:

Project description
Problem statement
Main features
Technology stack
Installation instructions
Basic usage
.gitignore

Prevents unnecessary or sensitive files from being uploaded to GitHub.

Examples:

.env
node_modules/
__pycache__/
venv/
.env.local
*.pyc

Sensitive information such as API keys must never be committed.

docker-compose.yml

Optional for the initial prototype.

Can later be used to run multiple services together:

Frontend
Backend
Database

This is useful for deployment and easier team setup.

11. Module Relationship

The repository structure represents the system architecture.

frontend/
    │
    ▼
backend/
    │
    ├──────────────┐
    │              │
    ▼              ▼
ai/             drift/
    │              │
    └──────┬───────┘
           │
           ▼
         ais/
           │
           ▼
       database/

The backend acts as the primary communication layer between the frontend, analytical modules, and database.

12. Development Principles
Modular Development

Each module should focus on one responsibility.

ai/       → Oil Spill Detection
drift/    → Spill Movement Analysis
ais/      → Vessel Investigation
backend/  → API and Orchestration
frontend/ → User Interface
database/ → Persistent Storage
Independent Development

Team members should be able to work on modules independently whenever possible.

For example:

AI Developer
     ↓
Works mainly inside
ai/
Frontend Developer
     ↓
Works mainly inside
frontend/
Database Developer
     ↓
Works mainly inside
database/

Integration should happen through clearly defined backend APIs and data structures.

Avoid Unnecessary Dependencies

Modules should not directly depend on the internal implementation of other modules.

For example:

GOOD

Backend
   ↓
AI Module Interface

Instead of:

NOT RECOMMENDED

Frontend
   ↓
Directly accesses
AI internal files

13. Future Expansion

The structure can later expand to include:

tests/

For automated testing.

scripts/

For utility and automation scripts.

infrastructure/

For cloud deployment configuration.

storage/

For local development data.

These are not required initially and should only be added when needed.

14. Final Repository Structure

The recommended starting structure is:

marine-spill-intelligence/
│
├── frontend/
│
├── backend/
│
├── ai/
│
├── drift/
│
├── ais/
│
├── database/
│
├── docs/
│   ├── PROJECT_OVERVIEW.md
│   ├── SYSTEM_ARCHITECTURE.md
│   ├── FILE_STRUCTURE.md
│   ├── MODULE_DOCUMENTATION.md
│   ├── DATABASE_DESIGN.md
│   ├── DATA_FLOW.md
│   ├── API_DOCUMENTATION.md
│   └── DESIGN_SYSTEM.md
│
├── README.md
├── .gitignore
└── docker-compose.yml

15. Important Note

This structure is a recommended starting architecture.

We should not create every file immediately.

Folders and files should be created as development begins to avoid an unnecessarily large empty repository.

The priority is:

1. Documentation
       ↓
2. Core Project Setup
       ↓
3. Frontend
       ↓
4. Backend
       ↓
5. Database
       ↓
6. AI Module
       ↓
7. Drift Module
       ↓
8. AIS Module