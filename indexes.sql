-- ============================================================
-- Marine Spill Intelligence System
-- Database Indexes
-- ============================================================


-- Spatial indexes

CREATE INDEX idx_spill_geometry
ON spill_events
USING GIST (geometry);


CREATE INDEX idx_drift_origin_geometry
ON drift_predictions
USING GIST (origin_geometry);


CREATE INDEX idx_drift_trajectory
ON drift_predictions
USING GIST (trajectory);


CREATE INDEX idx_ais_position_geometry
ON ais_positions
USING GIST (geometry);


-- Time indexes

CREATE INDEX idx_spill_detection_time
ON spill_events(detection_time);


CREATE INDEX idx_ais_positions_timestamp
ON ais_positions(timestamp);


-- AIS relationship indexes

CREATE INDEX idx_ais_positions_vessel
ON ais_positions(vessel_id);


-- Vessel correlation indexes

CREATE INDEX idx_correlations_spill
ON vessel_correlations(spill_id);


CREATE INDEX idx_correlations_vessel
ON vessel_correlations(vessel_id);
