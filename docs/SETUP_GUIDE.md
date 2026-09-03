Setup Guide
Marine Spill Intelligence System
SIH26143 | Space Technology

1. Purpose

This guide explains how to set up and run the Marine Spill Intelligence System locally.

It is intended to help any team member:

Clone the project
Set up the frontend
Set up the backend
Configure environment variables
Set up the database
Run the application locally

The goal is that a new teammate should be able to start the project without needing to manually figure out the setup.

2. Technology Stack

The planned technology stack is:

Frontend
→ React
→ TypeScript
→ Vite

Backend
→ Python
→ FastAPI

Database
→ PostgreSQL
→ PostGIS

ML / AI
→ Python

Version Control
→ Git + GitHub

Some technologies may be updated during development. This guide should be updated accordingly.

3. Prerequisites

Before starting, install the following.

Required
Git

Used for version control.

Verify installation:

git --version
Node.js

Required for the frontend.

Verify installation:

node --version

Also verify npm:

npm --version

Recommended:

Node.js LTS version
Python

Required for:

Backend
ML modules
Processing scripts

Verify installation:

python --version

or:

python3 --version

Recommended version:

Python 3.11+
PostgreSQL

Required for the database.

Verify installation:

psql --version

4. Clone the Repository

Clone the project repository.

git clone <REPOSITORY_URL>

Move into the project directory:

cd marine-spill-intelligence

5. Verify Project Structure

The repository should look similar to:

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

Not every folder needs to contain final code immediately.

6. Frontend Setup

Move into the frontend directory:

cd frontend

Install dependencies:

npm install

Start the development server:

npm run dev

The terminal should display a local development URL similar to:

http://localhost:5173

Open it in your browser.

7. Frontend Environment Variables

The frontend may require environment variables.

Example:

frontend/.env

Example structure:

VITE_API_BASE_URL=http://localhost:8000/api/v1

Important:

.env

files should generally not be committed if they contain sensitive information.

A safe example should be provided through:

.env.example

8. Backend Setup

Return to the project root if necessary.

Example:

cd ..

Then move into the backend directory:

cd backend

9. Create a Python Virtual Environment

Create a virtual environment:

python -m venv .venv
Activate the Environment
Windows
.venv\Scripts\activate
macOS / Linux
source .venv/bin/activate

After activation, the terminal should indicate that the virtual environment is active.

10. Install Backend Dependencies

Install dependencies:

pip install -r requirements.txt

If the requirements file does not yet exist, the backend developer will create it during initial setup.

Typical dependencies may include:

fastapi
uvicorn
sqlalchemy
psycopg
pydantic
python-dotenv

Additional dependencies will be added based on implementation requirements.

11. Backend Environment Variables

Create:

backend/.env

Example:

DATABASE_URL=

ENVIRONMENT=development

SATELLITE_API_KEY=

AIS_API_KEY=

The exact variables depend on the external services used.

Important Rule

Never commit:

backend/.env

to GitHub.

Instead, maintain:

backend/.env.example

Example:

DATABASE_URL=
ENVIRONMENT=development
SATELLITE_API_KEY=
AIS_API_KEY=

12. Run the Backend

From the backend directory:

uvicorn app.main:app --reload

The backend should run locally on something similar to:

http://localhost:8000
API Documentation

FastAPI provides automatic documentation.

Once running, documentation is typically available at:

http://localhost:8000/docs

This allows developers to:

View API endpoints
Test requests
Inspect request schemas
Inspect response schemas

13. Database Setup

The project uses:

PostgreSQL
+
PostGIS

PostGIS provides geospatial functionality required for:

Coordinates
Spill polygons
Spatial queries
Vessel trajectories
Geographic filtering

14. Create the Database

The exact database setup may vary depending on the development environment.

Conceptually:

PostgreSQL Server
        │
        ▼
marine_spill_db
        │
        ▼
PostGIS Enabled

Suggested database name:

marine_spill_db

15. Database Connection

The backend connects using:

DATABASE_URL

Example conceptual format:

postgresql://USERNAME:PASSWORD@localhost:5432/marine_spill_db

Do not commit real credentials to GitHub.

16. Enable PostGIS

PostGIS should be enabled for the project database.

Conceptually:

CREATE EXTENSION IF NOT EXISTS postgis;

This should be performed once the PostgreSQL database is created.

17. Database Migrations

Database changes should not be made manually without documentation.

The project may use migrations for changes.

Example structure:

database/migrations/
│
├── 001_initial_schema.sql
├── 002_add_spill_geometry.sql
└── 003_add_vessel_scores.sql

When the schema changes:

UPDATE SCHEMA
      ↓
CREATE MIGRATION
      ↓
TEST LOCALLY
      ↓
COMMIT MIGRATION

18. ML Environment Setup

The ML module uses Python.

Move into:

cd ml

The exact setup will depend on the selected ML framework.

Potential libraries may include:

PyTorch

TensorFlow

Rasterio

NumPy

OpenCV

GeoPandas

These should be finalized once the ML model and data pipeline are selected.

19. ML Data Setup

Large datasets should not be directly committed to GitHub.

Instead:

DATASET SOURCE
       ↓
DOWNLOAD SCRIPT
       ↓
LOCAL STORAGE
       ↓
PROCESSING

Example:

scripts/
    download_data.py

The project should document:

Dataset source
Dataset license
Download process
Required preprocessing

20. Running the Complete Application

During development, the frontend and backend run separately.

Terminal 1 — Backend
cd backend

Activate environment:

.venv\Scripts\activate

Then:

uvicorn app.main:app --reload
Terminal 2 — Frontend
cd frontend

Run:

npm run dev
Result
FRONTEND
http://localhost:5173
        │
        │ API Requests
        ▼
BACKEND
http://localhost:8000
        │
        ▼
DATABASE
PostgreSQL + PostGIS

21. Development Workflow

Before starting work:

git pull origin main

Create a feature branch:

git checkout -b feature/your-feature-name

Example:

git checkout -b feature/ml-detection
After Development

Check changes:

git status

Add changes:

git add .

Commit:

git commit -m "feat: add oil spill detection pipeline"

Push:

git push origin feature/your-feature-name

Then create a Pull Request.

22. Recommended Branch Naming

Use clear branch names.

Examples:

feature/frontend-dashboard

feature/backend-api

feature/ml-detection

feature/database-schema

feature/drift-module

feature/ais-analysis

For bug fixes:

fix/upload-validation

fix/api-error-handling

For documentation:

docs/setup-guide

23. Common Commands
Git

Check status:

git status

Pull latest changes:

git pull origin main

View branches:

git branch

Switch branch:

git checkout branch-name
Frontend

Install dependencies:

npm install

Run development server:

npm run dev

Build production version:

npm run build
Backend

Activate virtual environment.

Windows:

.venv\Scripts\activate

macOS/Linux:

source .venv/bin/activate

Run server:

uvicorn app.main:app --reload

24. Updating Dependencies

If frontend dependencies change:

npm install

If backend dependencies change:

pip install -r requirements.txt

After adding a new Python dependency, update:

requirements.txt

The exact method should be standardized by the backend team.

25. Common Problems
Problem: npm install fails

Possible causes:

Incorrect Node.js version
Corrupted dependency installation

Try:

npm install

If necessary, remove generated dependency folders and reinstall.

Problem: Backend does not start

Check:

Python version

Virtual environment

Installed dependencies

Environment variables

Also verify that you are running the command from the correct backend directory.

Problem: Database connection fails

Check:

PostgreSQL is running

Database exists

DATABASE_URL is correct

Username is correct

Password is correct

Port is correct
Problem: Frontend cannot connect to backend

Check:

Backend is running

API URL is correct

Frontend environment variable is correct

Expected architecture:

FRONTEND
localhost:5173
      │
      ▼
BACKEND
localhost:8000

26. Environment Variable Checklist

Before running the complete system, verify:

✓ DATABASE_URL configured

✓ Backend .env configured

✓ Frontend API URL configured

✓ Required external API keys configured

✓ PostgreSQL running

27. Before Pushing Code

Before pushing:

✓ Application runs locally

✓ No API keys committed

✓ No .env files committed

✓ Code is in the correct folder

✓ Commit message is meaningful

✓ Large datasets are not included

✓ Large model files are not accidentally included

28. Team Setup Checklist

A new team member should complete:

STEP 1
Clone repository
        ↓
STEP 2
Install prerequisites
        ↓
STEP 3
Set up frontend
        ↓
STEP 4
Set up backend
        ↓
STEP 5
Configure environment variables
        ↓
STEP 6
Set up database
        ↓
STEP 7
Run backend
        ↓
STEP 8
Run frontend
        ↓
STEP 9
Verify API connection

29. Complete Local Development Architecture
                         LOCAL MACHINE
                               │
              ┌────────────────┼────────────────┐
              │                │                │
              ▼                ▼                ▼
         FRONTEND           BACKEND          DATABASE
          React             FastAPI       PostgreSQL
          TypeScript         Python         PostGIS
              │                │
              │ REST API       │
              └────────────────┘
                       │
                       ▼
                 ML MODULES
                       │
            ┌──────────┼──────────┐
            ▼          ▼          ▼
           ML        DRIFT       AIS
           
30. Docker Setup

Docker support may be added later.

The intended architecture is:

docker-compose.yml
        │
        ├── frontend
        │
        ├── backend
        │
        └── database

For the initial development phase, the team may run services locally.

Docker can later simplify:

ONE COMMAND
      ↓
RUN COMPLETE SYSTEM

31. Important Development Rule

If the setup process changes:

Update this document immediately.

The setup guide should always reflect the actual project.

32. Setup Summary

The basic development process is:

CLONE
  ↓
INSTALL DEPENDENCIES
  ↓
CONFIGURE ENVIRONMENT
  ↓
SET UP DATABASE
  ↓
RUN BACKEND
  ↓
RUN FRONTEND
  ↓
START DEVELOPMENT