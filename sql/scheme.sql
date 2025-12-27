-- =====================================================
-- Public Transportation Analytics
-- Focus      : TransJakarta Corridor 9
-- Data Model : Aggregated tap-in / tap-out passenger flows
-- Purpose    : Support demand analysis, peak hour detection,
--              route utilization, and underutilized segment analysis
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

COMMENT ON TABLE routes IS 'Master table for TransJakarta Corridor 9';


-- =====================
-- TABLE: vehicles
-- =====================
-- Represents individual bus units operating on the corridor
CREATE TABLE IF NOT EXISTS vehicles (
    vehicle_id SERIAL PRIMARY KEY,
    vehicle_code VARCHAR(10), -- e.g. TJ9-01, TJ9-02
    capacity INT
);

COMMENT ON TABLE vehicles IS 'Bus units operating on Corridor 9';


-- =====================
-- TABLE: stops
-- =====================
-- Ordered stops for each direction
CREATE TABLE IF NOT EXISTS stops (
    stop_id SERIAL PRIMARY KEY,
    stop_name VARCHAR(50) NOT NULL,
    stop_sequence INT NOT NULL,
    direction VARCHAR(10) CHECK (direction IN ('OUTBOUND', 'INBOUND'))
);

COMMENT ON TABLE stops IS 'Stops along Corridor 9 by travel direction';
COMMENT ON COLUMN stops.direction IS 'OUTBOUND: Pinang Ranti → Pluit, INBOUND: Pluit → Pinang Ranti';


-- =====================
-- TABLE: trips
-- =====================
-- Represents a single bus trip (one direction, one bus)
CREATE TABLE IF NOT EXISTS trips (
    trip_id BIGSERIAL PRIMARY KEY,
    route_id INT NOT NULL,
    vehicle_id INT NOT NULL,
    trip_date DATE NOT NULL,
    direction VARCHAR(10) CHECK (direction IN ('OUTBOUND', 'INBOUND')),
    departure_time TIME,
    arrival_time TIME,
    passenger_count INT CHECK (passenger_count >= 0),

    CONSTRAINT fk_route
        FOREIGN KEY (route_id)
        REFERENCES routes(route_id),

    CONSTRAINT fk_vehicle
        FOREIGN KEY (vehicle_id)
        REFERENCES vehicles(vehicle_id)
);

COMMENT ON TABLE trips IS 'Bus operations representing service supply per direction';


-- =====================
-- TABLE: passenger_flows
-- =====================
-- Aggregated passenger movements derived from tap-in / tap-out
CREATE TABLE IF NOT EXISTS passenger_flows (
    flow_id BIGSERIAL PRIMARY KEY,
    trip_date DATE NOT NULL,
    direction VARCHAR(10) CHECK (direction IN ('OUTBOUND', 'INBOUND')),
    from_stop_id INT NOT NULL,
    to_stop_id INT NOT NULL,
    boarding_hour INT CHECK (boarding_hour BETWEEN 0 AND 23),
    alighting_hour INT CHECK (alighting_hour BETWEEN 0 AND 23),
    passenger_count INT CHECK (passenger_count >= 0),

    CONSTRAINT fk_from_stop
        FOREIGN KEY (from_stop_id)
        REFERENCES stops(stop_id),

    CONSTRAINT fk_to_stop
        FOREIGN KEY (to_stop_id)
        REFERENCES stops(stop_id)
);

COMMENT ON TABLE passenger_flows IS 'Aggregated passenger demand per stop segment and direction';


-- =====================
-- OPTIONAL: calendar dimension
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
CREATE INDEX IF NOT EXISTS idx_trips_date
    ON trips(trip_date);

CREATE INDEX IF NOT EXISTS idx_trips_vehicle
    ON trips(vehicle_id);

CREATE INDEX IF NOT EXISTS idx_passenger_flows_date
    ON passenger_flows(trip_date);

CREATE INDEX IF NOT EXISTS idx_passenger_flows_direction
    ON passenger_flows(direction);

CREATE INDEX IF NOT EXISTS idx_passenger_flows_boarding_hour
    ON passenger_flows(boarding_hour);

CREATE INDEX IF NOT EXISTS idx_stops_direction_sequence
    ON stops(direction, stop_sequence);
