CREATE TABLE IF NOT EXISTS clean_taps AS
SELECT
    tap_id,
    TRIM(card_id) AS card_id,
    CASE
        WHEN UPPER(tap_type) IN ('IN', 'TAP IN') THEN 'IN'
        WHEN UPPER(tap_type) IN ('OUT', 'TAP OUT') THEN 'OUT'
    END AS tap_type,
    tap_time,
    TRIM(stop_name) AS stop_name,
    TRIM(vehicle_code) AS vehicle_code
FROM stg_taps
WHERE
    tap_time IS NOT NULL
    AND card_id IS NOT NULL;
