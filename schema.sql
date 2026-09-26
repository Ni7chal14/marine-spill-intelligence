-- ============================================================
-- Marine Spill Intelligence System
-- Database Schema
-- PostgreSQL + PostGIS
-- ============================================================

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS pgcrypto;


-- ============================================================
-- 1. SATELLITE OBSERVATIONS
-- ============================================================

CREATE TABLE satellite_observations (
    observation_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    satellite VARCHAR(100) NOT NULL,
    sensor VARCHAR(50) NOT NULL,
    acquisition_time TIMESTAMPTZ NOT NULL,

    product_id VARCHAR(255),
    orbit VARCHAR(100),
    image_reference TEXT,

    processing_status VARCHAR(30) NOT NULL DEFAULT 'PENDING',

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================
-- 2. SPILL EVENTS
-- ============================================================

CREATE TABLE spill_events (
    spill_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    observation_id UUID NOT NULL,
    detection_time TIMESTAMPTZ NOT NULL,

    latitude NUMERIC(9,6),
    longitude NUMERIC(9,6),

    geometry GEOMETRY(POLYGON, 4326),

    area NUMERIC(12,4),
    confidence NUMERIC(5,4),
    severity VARCHAR(20),

    status VARCHAR(30) NOT NULL DEFAULT 'ACTIVE',

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_spill_observation
        FOREIGN KEY (observation_id)
        REFERENCES satellite_observations(observation_id),

    CONSTRAINT chk_spill_confidence
        CHECK (confidence >= 0 AND confidence <= 1)
);


-- ============================================================
-- 3. SPILL DETECTIONS
-- ============================================================

CREATE TABLE spill_detections (
    detection_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    spill_id UUID NOT NULL,

    model_name VARCHAR(100) NOT NULL,
    model_version VARCHAR(50),
    sensor VARCHAR(50),

    confidence NUMERIC(5,4),
    oil_area NUMERIC(12,4),

    mask_reference TEXT,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_detection_spill
        FOREIGN KEY (spill_id)
        REFERENCES spill_events(spill_id),

    CONSTRAINT chk_detection_confidence
        CHECK (confidence >= 0 AND confidence <= 1)
);


-- ============================================================
-- 4. DRIFT PREDICTIONS
-- ============================================================

CREATE TABLE drift_predictions (
    prediction_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    spill_id UUID NOT NULL,

    prediction_type VARCHAR(20) NOT NULL,

    model VARCHAR(100),

    run_time TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    start_time TIMESTAMPTZ,
    end_time TIMESTAMPTZ,

    origin_geometry GEOMETRY(POLYGON, 4326),
    trajectory GEOMETRY(LINESTRING, 4326),

    confidence NUMERIC(5,4),

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_prediction_spill
        FOREIGN KEY (spill_id)
        REFERENCES spill_events(spill_id),

    CONSTRAINT chk_prediction_type
        CHECK (prediction_type IN ('HINDCAST', 'FORECAST')),

    CONSTRAINT chk_prediction_confidence
        CHECK (
            confidence IS NULL
            OR (confidence >= 0 AND confidence <= 1)
        )
);


-- ============================================================
-- 5. AIS VESSELS
-- ============================================================

CREATE TABLE ais_vessels (
    vessel_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    mmsi VARCHAR(20) NOT NULL UNIQUE,
    imo VARCHAR(20) UNIQUE,

    vessel_name VARCHAR(255),
    vessel_type VARCHAR(100),
    flag VARCHAR(100),

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================
-- 6. AIS POSITIONS
-- ============================================================

CREATE TABLE ais_positions (
    position_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    vessel_id UUID NOT NULL,

    timestamp TIMESTAMPTZ NOT NULL,

    latitude NUMERIC(9,6),
    longitude NUMERIC(9,6),

    geometry GEOMETRY(POINT, 4326),

    speed NUMERIC(8,3),
    course NUMERIC(6,2),
    heading NUMERIC(6,2),

    navigation_status VARCHAR(100),

    CONSTRAINT fk_position_vessel
        FOREIGN KEY (vessel_id)
        REFERENCES ais_vessels(vessel_id)
);


-- ============================================================
-- 7. VESSEL CORRELATIONS
-- ============================================================

CREATE TABLE vessel_correlations (
    correlation_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    spill_id UUID NOT NULL,
    vessel_id UUID NOT NULL,

    distance_score NUMERIC(5,4),
    time_score NUMERIC(5,4),
    trajectory_score NUMERIC(5,4),
    ais_gap_score NUMERIC(5,4),
    evidence_score NUMERIC(5,4),

    investigation_status VARCHAR(30) DEFAULT 'REVIEW',

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_correlation_spill
        FOREIGN KEY (spill_id)
        REFERENCES spill_events(spill_id),

    CONSTRAINT fk_correlation_vessel
        FOREIGN KEY (vessel_id)
        REFERENCES ais_vessels(vessel_id)
);


-- ============================================================
-- 8. ALERTS
-- ============================================================

CREATE TABLE alerts (
    alert_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    spill_id UUID NOT NULL,

    severity VARCHAR(20) NOT NULL,
    alert_type VARCHAR(100) NOT NULL,

    message TEXT,

    status VARCHAR(30) NOT NULL DEFAULT 'ACTIVE',

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    resolved_at TIMESTAMPTZ,

    CONSTRAINT fk_alert_spill
        FOREIGN KEY (spill_id)
        REFERENCES spill_events(spill_id)
);


-- ============================================================
-- END OF SCHEMA
-- ============================================================
