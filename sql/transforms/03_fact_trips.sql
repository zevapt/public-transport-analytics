CREATE TABLE fact_trips AS
SELECT
    card_id,
    MIN(tap_time) AS boarding_time,
    MAX(tap_time) AS alighting_time,
    MIN(stop_id) AS from_stop_id,
    MAX(stop_id) AS to_stop_id,
    direction
FROM fact_taps
GROUP BY card_id, DATE(tap_time), direction;
