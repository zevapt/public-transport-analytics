INSERT INTO fact_taps (
    tap_id,
    card_id,
    tap_type,
    tap_time,
    stop_id,
    direction,
    vehicle_id
)
SELECT
    r.tap_id,
    r.card_id,
    r.tap_type,
    r.tap_time,
    s.stop_id,
    s.direction,
    v.vehicle_id
FROM staging_taps_raw r
JOIN stops s
  ON r.stop_name = s.stop_name
JOIN vehicles v
  ON r.vehicle_code = v.vehicle_code;
