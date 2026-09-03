API Documentation
Marine Spill Intelligence System
SIH26143 | Space Technology

1. Purpose

This document defines the API architecture and communication contract for the Marine Spill Intelligence System.

The API connects:

FRONTEND
    │
    │ HTTP Requests
    ▼
BACKEND API
    │
    ├── AI Module
    ├── Drift Module
    ├── AIS Module
    └── Database

The frontend should communicate only with the backend API.

2. API Technology
Backend Framework
FastAPI
Communication Format
HTTP/HTTPS
JSON
REST API
Base API Version
/api/v1

Example structure:

/api/v1/analysis
/api/v1/events
/api/v1/monitoring
/api/v1/upload
/api/v1/vessels

3. General Response Structure

Successful API responses should follow a consistent structure.

{
  "success": true,
  "data": {},
  "message": "Request completed successfully"
}
Error Response
{
  "success": false,
  "error": {
    "code": "INVALID_INPUT",
    "message": "The provided coordinates are invalid."
  }
}

4. Analysis Status

Some operations may take time, especially:

AI inference
Satellite data processing
Drift simulation
AIS analysis

Therefore, analysis requests should support status tracking.

Possible statuses:

PENDING
PROCESSING
COMPLETED
FAILED

5. Health Check API
Endpoint
GET /api/v1/health
Purpose

Checks whether the backend service is running.

Response
{
  "success": true,
  "data": {
    "status": "healthy"
  }
}

6. Historical Events API

Historical events are used for demonstration and historical analysis.

6.1 Get All Historical Events
Endpoint
GET /api/v1/events
Response
{
  "success": true,
  "data": [
    {
      "id": "event-001",
      "name": "Example Oil Spill Event",
      "event_date": "2024-01-10T10:00:00Z",
      "description": "Historical marine spill event"
    }
  ]
}

6.2 Get Specific Event
Endpoint
GET /api/v1/events/{event_id}

Example:

GET /api/v1/events/event-001
Response
{
  "success": true,
  "data": {
    "id": "event-001",
    "name": "Example Oil Spill Event",
    "event_date": "2024-01-10T10:00:00Z",
    "description": "Historical event information",
    "location": {
      "latitude": 0.0,
      "longitude": 0.0
    }
  }
}

7. Historical Event Analysis API
Endpoint
POST /api/v1/analysis/historical
Purpose

Starts analysis for a selected historical event.

Request
{
  "event_id": "event-001"
}
Backend Flow
EVENT REQUEST
      ↓
LOAD EVENT
      ↓
LOAD SATELLITE DATA
      ↓
AI ANALYSIS
      ↓
SPILL DETECTION
      ↓
DRIFT ANALYSIS
      ↓
AIS ANALYSIS
      ↓
STORE RESULTS
Response
{
  "success": true,
  "data": {
    "analysis_id": "analysis-001",
    "status": "PROCESSING"
  },
  "message": "Historical analysis started successfully"
}

8. Get Analysis Status
Endpoint
GET /api/v1/analysis/{analysis_id}/status
Response
{
  "success": true,
  "data": {
    "analysis_id": "analysis-001",
    "status": "PROCESSING",
    "progress": 65
  }
}
Possible Progress

Example:

10% → Data Validation
25% → AI Processing
45% → Spill Characterization
65% → Drift Analysis
85% → AIS Analysis
100% → Completed

9. Get Complete Analysis Result
Endpoint
GET /api/v1/analysis/{analysis_id}
Purpose

Returns the complete processed analysis.

Response Structure
{
  "success": true,
  "data": {
    "analysis_id": "analysis-001",
    "status": "COMPLETED",
    "source_type": "historical",
    "observation_time": "2024-01-10T10:00:00Z",
    "detection": {},
    "spills": [],
    "origin_estimate": {},
    "forecast": {},
    "vessel_investigations": []
  }
}

10. AI Detection Result

The detection result may contain:

{
  "classification": "OIL_SPILL",
  "confidence": 0.91,
  "spill_detected": true
}

Possible classifications:

OIL_SPILL
LOOK_ALIKE
NO_SIGNIFICANT_SPILL

11. Spill Data API

Spill results contain geospatial information.

Example:

{
  "id": "spill-001",
  "confidence": 0.91,
  "area_km2": 12.4,
  "centroid": {
    "latitude": 18.52,
    "longitude": 72.85
  },
  "geometry": {
    "type": "Polygon",
    "coordinates": []
  }
}

The frontend uses this information to render the spill on the map.

12. Near-Real-Time Monitoring API
Endpoint
POST /api/v1/monitoring/analyze
Purpose

Requests analysis of the latest available satellite observation for a selected region.

Request
{
  "region": {
    "latitude": 18.52,
    "longitude": 72.85
  },
  "radius_km": 50
}
Backend Flow
REGION REQUEST
      ↓
FIND LATEST AVAILABLE DATA
      ↓
VALIDATE OBSERVATION
      ↓
AI ANALYSIS
      ↓
STORE ANALYSIS
      ↓
RETURN ANALYSIS ID
Response
{
  "success": true,
  "data": {
    "analysis_id": "analysis-002",
    "status": "PROCESSING"
  }
}

13. Get Monitoring Results
Endpoint
GET /api/v1/monitoring/{analysis_id}

This can return the same structured result as the main analysis endpoint.

14. User Upload API
Endpoint
POST /api/v1/upload/analyze
Content Type
multipart/form-data
Input

The user uploads:

GeoTIFF
TIFF
PNG
JPG
JPEG

The exact supported formats should be finalized during implementation.

Backend Flow
FILE UPLOAD
      ↓
FILE VALIDATION
      ↓
METADATA INSPECTION
      │
      ├── Georeferenced?
      │
      └── Normal Image?
      ↓
AI ANALYSIS
      ↓
CREATE ANALYSIS
Response
{
  "success": true,
  "data": {
    "analysis_id": "analysis-003",
    "file_type": "GEOTIFF",
    "georeferenced": true,
    "status": "PROCESSING"
  }
}

15. Upload Capability Response

The system should clearly indicate what analysis is possible.

Example:

{
  "success": true,
  "data": {
    "georeferenced": false,
    "available_analysis": [
      "detection",
      "classification",
      "segmentation"
    ],
    "unavailable_analysis": [
      "geospatial_mapping",
      "drift_simulation",
      "ais_analysis"
    ]
  }
}

This prevents the system from pretending it knows geographic information that does not exist.

16. Drift Analysis API

The drift module may initially be triggered internally by the main analysis workflow.

However, separate endpoints can also be provided.

Hindcast
POST /api/v1/drift/hindcast
Request
{
  "spill_id": "spill-001",
  "duration_hours": 72
}
Response
{
  "success": true,
  "data": {
    "simulation_id": "drift-001",
    "status": "PROCESSING"
  }
}
Forecast
POST /api/v1/drift/forecast
Request
{
  "spill_id": "spill-001",
  "duration_hours": 72
}

17. Origin Estimate API
Endpoint
GET /api/v1/spills/{spill_id}/origin
Response
{
  "success": true,
  "data": {
    "origin_region": {
      "type": "Polygon",
      "coordinates": []
    },
    "estimated_start_time": "2024-01-07T10:00:00Z",
    "estimated_end_time": "2024-01-08T10:00:00Z",
    "confidence": 0.72
  }
}

18. Forecast Results API
Endpoint
GET /api/v1/spills/{spill_id}/forecast
Response
{
  "success": true,
  "data": {
    "trajectory": {
      "type": "LineString",
      "coordinates": []
    },
    "predicted_positions": []
  }
}

19. AIS Vessel Investigation API
Endpoint
POST /api/v1/vessels/analyze
Purpose

Starts vessel investigation using:

Origin region
Estimated time window
Relevant AIS data
Request
{
  "spill_id": "spill-001"
}
Backend Flow
SPILL ID
    ↓
GET ORIGIN ESTIMATE
    ↓
DEFINE SEARCH REGION
    +
TIME WINDOW
    ↓
FETCH AIS DATA
    ↓
FILTER VESSELS
    ↓
ANALYSE TRAJECTORIES
    ↓
CALCULATE PRIORITY SCORES
Response
{
  "success": true,
  "data": {
    "analysis_id": "vessel-analysis-001",
    "status": "PROCESSING"
  }
}

20. Get Vessel Investigation Results
Endpoint
GET /api/v1/spills/{spill_id}/vessels
Response
{
  "success": true,
  "data": [
    {
      "rank": 1,
      "mmsi": "123456789",
      "name": "Example Vessel",
      "priority_score": 82,
      "evidence": [
        "Present near estimated origin region",
        "Present during estimated time window"
      ]
    }
  ]
}

21. Get Specific Vessel Information
Endpoint
GET /api/v1/vessels/{mmsi}
Response
{
  "success": true,
  "data": {
    "mmsi": "123456789",
    "name": "Example Vessel",
    "vessel_type": "Tanker",
    "imo": "1234567"
  }
}

22. Map Data API

The frontend may need a simplified endpoint for map visualization.

Endpoint
GET /api/v1/analysis/{analysis_id}/map
Response
{
  "success": true,
  "data": {
    "spill_geometry": {},
    "origin_region": {},
    "hindcast_trajectory": {},
    "forecast_trajectory": {},
    "vessel_positions": [],
    "vessel_trajectories": []
  }
}

This allows the frontend to load map-specific information efficiently.

23. API Workflow

The primary frontend workflow is:

USER ACTION
     │
     ▼
API REQUEST
     │
     ▼
BACKEND
     │
     ▼
CREATE ANALYSIS
     │
     ▼
RETURN ANALYSIS ID
     │
     ▼
FRONTEND CHECKS STATUS
     │
     ▼
ANALYSIS COMPLETED
     │
     ▼
FETCH RESULTS
     │
     ▼
DISPLAY RESULTS

24. Suggested Analysis Workflow

A complete request lifecycle:

POST /analysis
       │
       ▼
analysis_id
       │
       ▼
GET /analysis/{id}/status
       │
       ▼
PROCESSING
       │
       ▼
COMPLETED
       │
       ▼
GET /analysis/{id}
       │
       ▼
COMPLETE RESULT

25. API Error Handling

The API should use appropriate HTTP status codes.

Status Code	Meaning
200	Successful request
201	Resource created
400	Invalid request
404	Resource not found
422	Validation error
500	Internal server error
503	External service unavailable

26. Example Error Response
{
  "success": false,
  "error": {
    "code": "SATELLITE_DATA_UNAVAILABLE",
    "message": "No suitable satellite observation was found for the selected region."
  }
}

27. API Principles

The API should follow these principles:

Versioning
/api/v1/

Future changes can use:

/api/v2/
Consistency

Responses should follow a consistent structure.

Validation

All input should be validated before processing.

Examples:

Coordinates
File types
Analysis IDs
Date ranges
Simulation durations
Separation of Concerns

API routes should remain lightweight.

Recommended structure:

API Route
    ↓
Service
    ↓
Processing Module
    ↓
Database / External Data

Avoid putting complex AI or drift logic directly inside route files.

28. Proposed Route Structure
/api/v1/
│
├── health
│
├── events/
│   ├── GET /
│   └── GET /{event_id}
│
├── analysis/
│   ├── POST /historical
│   ├── GET /{analysis_id}
│   └── GET /{analysis_id}/status
│
├── monitoring/
│   └── POST /analyze
│
├── upload/
│   └── POST /analyze
│
├── spills/
│   ├── GET /{spill_id}/origin
│   ├── GET /{spill_id}/forecast
│   └── GET /{spill_id}/vessels
│
├── drift/
│   ├── POST /hindcast
│   └── POST /forecast
│
└── vessels/
    ├── POST /analyze
    └── GET /{mmsi}

29. API Security Considerations

For the hackathon prototype:

Keep API keys in environment variables.
Never expose external API keys to the frontend.
Validate uploaded files.
Limit allowed file sizes.
Validate all coordinates and parameters.

Example:

.env

should never be committed to GitHub.

30. API Documentation Tools

Because we're using FastAPI, automatic API documentation can be generated.

Typical development documentation includes:

Swagger UI

and:

OpenAPI

This allows backend developers and frontend developers to test endpoints during development.

31. Final API Architecture
FRONTEND
    │
    │ REST API
    ▼
FASTAPI
    │
    ├───────────────┐
    │               │
    ▼               ▼
DATABASE      PROCESSING SERVICES
                    │
          ┌─────────┼─────────┐
          ▼         ▼         ▼
         AI       DRIFT       AIS
          │         │         │
          └─────────┼─────────┘
                    │
                    ▼
            EXTERNAL DATA

32. API Documentation Summary

The API acts as the communication layer between the frontend and the intelligence system.

The core interaction pattern is:

REQUEST
   ↓
VALIDATE
   ↓
PROCESS
   ↓
STORE
   ↓
RETURN RESULT

The API supports three primary user workflows:

1. Near-Real-Time Monitoring
2. Historical Event Analysis
3. User Upload Analysis

All workflows eventually provide structured data for:

Oil Spill Detection
        ↓
Spill Analysis
        ↓
Drift Modelling
        ↓
AIS Investigation
        ↓
Interactive Visualization