Database Design
Marine Spill Intelligence System
SIH26143 | Space Technology

1. Purpose

This document defines the database architecture for the Marine Spill Intelligence System.

The database is responsible for storing:

Historical oil spill events
Analysis records
Detected spill information
Geospatial boundaries
Drift simulation results
Relevant vessel information
Investigation priority results

The system will use:

PostgreSQL + PostGIS

PostGIS is required because the project works extensively with geographic locations, polygons, trajectories, and spatial queries.

2. Database Design Principles

The database should follow these principles:

Store processed data

The database should primarily store:

Analysis results
Geospatial results
Simulation outputs
Investigation results
Avoid storing massive raw datasets

We should not unnecessarily store:

Complete global satellite archives
Entire AIS datasets
Complete oceanographic datasets

These should be fetched or processed externally when required.

3. High-Level Entity Overview

The main entities are:

Historical Event
       │
       │
       ▼
    Analysis
       │
       ├──────────────┐
       ▼              ▼
     Spill       Drift Simulation
       │              │
       │              ├── Hindcast
       │              └── Forecast
       │
       ▼
 Origin Estimate
       │
       ▼
Vessel Investigation
       │
       ▼
 Investigation Ranking

4. Entity Relationship Overview
HISTORICAL_EVENT
        │
        │ 1
        │
        ▼ N
     ANALYSIS
        │
        │ 1
        ▼ N
      SPILL
        │
        ├──────────────┐
        │              │
        ▼              ▼
DRIFT_SIMULATION   VESSEL_INVESTIGATION
        │              │
        ▼              ▼
 ORIGIN_ESTIMATE    VESSEL
                       │
                       ▼
                 PRIORITY_SCORE

A single analysis may produce multiple related results.

5. Historical Events
Table
historical_events

This table stores information about preconfigured historical oil spill events.

Suggested Fields
Field	Type	Description
id	UUID / Integer	Primary key
name	VARCHAR	Event name
description	TEXT	Event description
event_date	TIMESTAMP	Date/time of event
location	GEOMETRY	Event location
source	VARCHAR	Data source reference
created_at	TIMESTAMP	Record creation time
Purpose

Historical events allow the application to provide a reliable demonstration mode.

Example:

User
  ↓
Select Historical Event
  ↓
Load Event Information
  ↓
Load Associated Analysis
  ↓
Display Results

6. Analysis
Table
analyses

Every analysis performed by the system should have a unique record.

An analysis may originate from:

Historical event
Satellite monitoring
User upload
Suggested Fields
Field	Type	Description
id	UUID	Primary key
event_id	UUID	Related historical event
source_type	VARCHAR	monitoring / historical / upload
source_reference	TEXT	Dataset or file reference
analysis_time	TIMESTAMP	Analysis timestamp
observation_time	TIMESTAMP	Satellite observation time
status	VARCHAR	Processing status
created_at	TIMESTAMP	Record creation
Possible Status Values
PENDING
PROCESSING
COMPLETED
FAILED

7. Spill Detection Results
Table
spills

This table stores information about detected oil spills.

One analysis may potentially contain one or more detected spill regions.

Suggested Fields
Field	Type	Description
id	UUID	Primary key
analysis_id	UUID	Related analysis
classification	VARCHAR	Oil Spill / Look-Alike
confidence	FLOAT	Model confidence
area_km2	FLOAT	Estimated area
geometry	GEOMETRY	Spill polygon
centroid	GEOMETRY	Spill center point
observation_time	TIMESTAMP	Observation time
created_at	TIMESTAMP	Record creation
Geospatial Data

The most important field is:

geometry

Recommended concept:

POLYGON

This represents the detected boundary of the oil spill.

Example:

        OIL SPILL
     ┌────────────┐
     │            │
     │   POLYGON  │
     │            │
     └────────────┘

8. Origin Estimation
Table
origin_estimates

This table stores the output of hindcasting.

Suggested Fields
Field	Type	Description
id	UUID	Primary key
spill_id	UUID	Related spill
origin_region	GEOMETRY	Estimated origin zone
estimated_start_time	TIMESTAMP	Possible origin start
estimated_end_time	TIMESTAMP	Possible origin end
confidence	FLOAT	Estimation confidence
created_at	TIMESTAMP	Record creation
Important Note

The origin should be represented as an:

UNCERTAINTY REGION

rather than a single exact point whenever appropriate.

Example:

                Spill
                  ●
                  │
                  │ Hindcasting
                  │
        ┌─────────────────┐
        │ Possible Origin │
        │      Region     │
        └─────────────────┘

9. Drift Simulations
Table
drift_simulations

Stores metadata about each drift simulation.

Suggested Fields
Field	Type	Description
id	UUID	Primary key
spill_id	UUID	Related spill
simulation_type	VARCHAR	hindcast / forecast
start_time	TIMESTAMP	Simulation start
end_time	TIMESTAMP	Simulation end
created_at	TIMESTAMP	Record creation
Simulation Types
HINDCAST
FORECAST

10. Drift Trajectory Points
Table
drift_points

Instead of storing every simulation as one large object, individual important trajectory points can be stored.

Suggested Fields
Field	Type	Description
id	UUID	Primary key
simulation_id	UUID	Related simulation
timestamp	TIMESTAMP	Simulation time
location	GEOMETRY	Geographic point
concentration	FLOAT	Optional concentration
uncertainty	FLOAT	Optional uncertainty
Purpose

This allows the frontend to create:

Animated movement
Timelines
Drift paths
Time-based predictions

Example:

T0       T1       T2       T3

● ─────► ● ─────► ● ─────► ●

11. Vessels
Table
vessels

Stores basic vessel information for vessels relevant to investigations.

Suggested Fields
Field	Type	Description
mmsi	VARCHAR	Primary vessel identifier
name	VARCHAR	Vessel name
vessel_type	VARCHAR	Vessel type
imo	VARCHAR	Optional IMO number
metadata	JSONB	Additional vessel information
Important Principle

We should store vessels that are relevant to our analyses.

We do not need to permanently store every vessel in the world's AIS database.

12. Vessel Positions
Table
vessel_positions

Stores relevant AIS positions.

Suggested Fields
Field	Type	Description
id	UUID	Primary key
mmsi	VARCHAR	Related vessel
timestamp	TIMESTAMP	AIS timestamp
location	GEOMETRY	Vessel position
speed	FLOAT	Vessel speed
course	FLOAT	Vessel course
Purpose

This data supports:

Vessel trajectory visualization
Spatial analysis
Temporal analysis
Behavioural analysis

13. Vessel Investigations
Table
vessel_investigations

This connects a vessel with a specific spill investigation.

Suggested Fields
Field	Type	Description
id	UUID	Primary key
spill_id	UUID	Related spill
mmsi	VARCHAR	Related vessel
proximity_score	FLOAT	Spatial score
temporal_score	FLOAT	Time correlation
trajectory_score	FLOAT	Route correlation
behavioural_score	FLOAT	Behaviour indicators
final_score	FLOAT	Overall priority
rank	INTEGER	Investigation rank
evidence	JSONB	Supporting evidence
created_at	TIMESTAMP	Record creation

14. Investigation Scoring

The investigation score should be calculated outside the database by the AIS/scoring module.

The database stores the final results.

Conceptually:

Final Score
     │
     ├── Proximity Score
     ├── Temporal Score
     ├── Trajectory Score
     └── Behavioural Score

Example:

Vessel: X

Proximity:     90
Temporal:      85
Trajectory:    78
Behaviour:     65

Final Priority Score: 82

15. Database Relationships

The primary relationships are:

historical_events
        │
        │ 1 ─────── N
        ▼
analyses
        │
        │ 1 ─────── N
        ▼
spills
        │
        ├───────────────┐
        │               │
        ▼               ▼
origin_estimates   drift_simulations
        │               │
        │               ▼
        │           drift_points
        │
        ▼
vessel_investigations
        │
        │ N ─────── 1
        ▼
      vessels
        │
        ▼
vessel_positions

16. PostGIS Usage

PostGIS is essential for storing and querying geographical data.

Important Spatial Data
Points

Used for:

Vessel locations
Spill centroids
Important coordinates
POINT(longitude latitude)
Polygons

Used for:

Spill boundaries
Origin zones
Uncertainty regions
Forecast areas
POLYGON(...)
Lines

Used for:

Vessel trajectories
Drift trajectories
LINESTRING(...)

17. Important Spatial Queries

The database should support queries such as:

Find vessels near origin
Find vessels within X kilometres
of the estimated origin region.
Find vessels inside region
Find vessels whose position
intersects the origin polygon.
Find vessels during time window
Find vessels present between
estimated_start_time
and
estimated_end_time.
Combined Query

The AIS module may need:

Vessels
    WHERE
        location near origin_region
    AND
        timestamp within origin_time_window

PostGIS and PostgreSQL allow these spatial and temporal queries to work together.

18. Recommended Indexes

The DB teammate should consider indexes for:

Primary Keys
id
Foreign Keys
event_id
analysis_id
spill_id
mmsi
Time Queries
timestamp
observation_time
Geospatial Queries

Spatial indexes should be created for fields such as:

geometry
location
origin_region

A PostGIS spatial index such as a GiST index should be considered.

19. Suggested Data Types

A possible direction:

Data	Suggested Type
IDs	UUID
Names	VARCHAR
Descriptions	TEXT
Scores	FLOAT / NUMERIC
Metadata	JSONB
Time	TIMESTAMPTZ
Geographic Points	GEOMETRY(Point, 4326)
Spill Boundary	GEOMETRY(Polygon, 4326)
Trajectory	GEOMETRY(LineString, 4326)
Region	GEOMETRY(Polygon, 4326)
Coordinate System

A common initial choice is:

EPSG:4326

This uses standard longitude and latitude coordinates.

For accurate area calculations, the implementation may transform data into an appropriate projected CRS when required.

20. Database Access Pattern

Modules should generally not directly manipulate each other's data.

Recommended flow:

AI Module
    │
    ▼
Backend Service
    │
    ▼
Database
Drift Module
    │
    ▼
Backend Service
    │
    ▼
Database
AIS Module
    │
    ▼
Backend Service
    │
    ▼
Database

The backend remains the central application layer.

21. Data Lifecycle
EXTERNAL DATA
     │
     ▼
PROCESSING MODULE
     │
     ▼
PROCESSED RESULT
     │
     ▼
DATABASE
     │
     ▼
BACKEND API
     │
     ▼
FRONTEND

Raw external data should be stored only when required for reproducibility or the selected historical demo events.

22. Initial Implementation Priority

For the first working prototype, prioritize these tables:

1. historical_events
2. analyses
3. spills
4. origin_estimates
5. drift_simulations
6. drift_points
7. vessels
8. vessel_positions
9. vessel_investigations

The schema can expand as the project develops.

23. Database Summary

The database serves as the system's:

Persistent Storage + Geospatial Intelligence Layer

The main flow is:

SATELLITE IMAGE
      ↓
AI ANALYSIS
      ↓
SPILL RESULT
      ↓
DATABASE
      ↓
DRIFT ANALYSIS
      ↓
ORIGIN ESTIMATE
      ↓
AIS ANALYSIS
      ↓
VESSEL INVESTIGATION
      ↓
DATABASE
      ↓
INTERACTIVE MAP

24. Final Implementation Notes

Before implementing the final schema, the database developer should:

Review this document.
Create a detailed ER diagram.
Confirm table relationships with the backend team.
Define exact PostgreSQL/PostGIS data types.
Create the initial schema.
Add migrations as the schema evolves.
Test spatial queries with sample data.

This document is the database design blueprint, while the actual SQL schema may evolve during development.