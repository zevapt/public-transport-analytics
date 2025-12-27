SELECT *
FROM staging_taps_raw
WHERE tap_type IN ('IN', 'OUT');
