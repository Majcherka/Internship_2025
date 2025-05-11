SELECT CEIL(TIMESTAMPDIFF(SECOND, segment_start_time, segment_end_time) / 60) AS delivery_duration_minutes
FROM route_segments
WHERE segment_type = 'STOP';