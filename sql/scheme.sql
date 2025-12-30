-- =====================================================
-- Public Transportation Analytics
-- Focus      : TransJakarta Corridor 9
-- Data Model : Raw tap-in / tap-out transaction model
-- Purpose    : Support passenger demand analysis,
--              peak hour detection, OD analysis,
--              and route utilization
-- =====================================================


-- =====================
-- TABLE: routes
-- =====================
-- Represents Corridor 9 as a single analyzed route
CREATE TABLE IF NOT EXISTS routes (
    route_id SERIAL PRIMARY KEY,
    corridor_code VARCHAR(10) DEFAULT '9',
    corridor_name VARCHAR(50) DEFAULT 'TransJakarta Corridor 9',
    is_active BOOLEAN DEFAULT TRUE
);

COMMENT ON TABLE routes IS 'Master route table for TransJakarta Corridor 9';


-- =====================
-- TABLE: vehicles
-- =====================
-- Represents individual bus units operating on the corridor
CREATE TABLE IF NOT EXISTS vehicles (
    vehicle_id SERIAL PRIMARY KEY,
    route_id INT NOT NULL,
    vehicle_code VARCHAR(10), -- e.g. TJ9-01, TJ9-02
    capacity INT,

    CONSTRAINT fk_vehicle_route
        FOREIGN KEY (route_id)
        REFERENCES routes(route_id)
);

COMMENT ON TABLE vehicles IS 'Bus units operating on Corridor 9';


-- =====================
-- TABLE: stops
-- =====================
-- Ordered stops for each travel direction
CREATE TABLE IF NOT EXISTS stops (
    stop_id SERIAL PRIMARY KEY,
    stop_name VARCHAR(50) NOT NULL,
    stop_sequence INT NOT NULL,
    direction VARCHAR(10) CHECK (direction IN ('OUTBOUND', 'INBOUND'))
);

COMMENT ON TABLE stops IS 'Stops along Corridor 9 by travel direction';
COMMENT ON COLUMN stops.direction IS 
    'OUTBOUND: Pinang Ranti → Pluit, INBOUND: Pluit → Pinang Ranti';


-- =====================
-- TABLE: stg_taps (RAW STAGING)
-- =====================
CREATE TABLE IF NOT EXISTS stg_taps (
    tap_id BIGSERIAL PRIMARY KEY,
    card_id TEXT,
    tap_type TEXT,
    tap_time TIMESTAMP,
    stop_name TEXT,
    vehicle_code TEXT,
    source_file TEXT,
    load_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE stg_taps IS 'Raw tap-in / tap-out data loaded directly from Excel';


-- =====================
-- TABLE: fact_taps (CLEANED)
-- =====================
CREATE TABLE IF NOT EXISTS fact_taps (
    tap_id BIGSERIAL PRIMARY KEY,
    card_id VARCHAR(30) NOT NULL,
    tap_type VARCHAR(10)
        CHECK (tap_type IN ('IN', 'OUT')),
    tap_time TIMESTAMP NOT NULL,
    stop_id INT NOT NULL,
    vehicle_id INT,

    CONSTRAINT fk_stop
        FOREIGN KEY (stop_id)
        REFERENCES stops(stop_id),

    CONSTRAINT fk_vehicle
        FOREIGN KEY (vehicle_id)
        REFERENCES vehicles(vehicle_id)
);


-- =====================
-- Calendar dimension
-- =====================
CREATE TABLE IF NOT EXISTS calendar (
    date DATE PRIMARY KEY,
    day_name VARCHAR(10),
    is_weekend BOOLEAN,
    month INT,
    year INT
);

COMMENT ON TABLE calendar IS 'Date dimension for time-based analysis';


-- =====================
-- INDEXES (ANALYTICAL PERFORMANCE)
-- =====================
CREATE UNIQUE INDEX IF NOT EXISTS idx_vehicles_code
    ON vehicles(vehicle_code);

CREATE INDEX IF NOT EXISTS idx_vehicles_route
    ON vehicles(route_id);

CREATE INDEX IF NOT EXISTS idx_stops_name
    ON stops(stop_name);

CREATE INDEX IF NOT EXISTS idx_stops_direction_sequence
    ON stops(direction, stop_sequence);

CREATE INDEX IF NOT EXISTS idx_stg_taps_time
    ON stg_taps(tap_time);

CREATE INDEX IF NOT EXISTS idx_stg_taps_card
    ON stg_taps(card_id);

CREATE INDEX IF NOT EXISTS idx_fact_taps_time
    ON fact_taps(tap_time);

CREATE INDEX IF NOT EXISTS idx_fact_taps_card_time
    ON fact_taps(card_id, tap_time);

CREATE INDEX IF NOT EXISTS idx_fact_taps_stop
    ON fact_taps(stop_id);

CREATE INDEX IF NOT EXISTS idx_fact_taps_vehicle
    ON fact_taps(vehicle_id);
