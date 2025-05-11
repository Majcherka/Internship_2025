WITH delivery_times AS (
   SELECT CEIL(TIMESTAMPDIFF(SECOND, segment_start_time, segment_end_time) / 60) AS delivery_duration_minutes
   FROM route_segments
   WHERE segment_type = 'STOP'
),
ranked_deliveries AS (
    SELECT *,
           NTILE(100) OVER (ORDER BY delivery_duration_minutes) AS bucket
    FROM delivery_times
)
SELECT delivery_duration_minutes FROM ranked_deliveries WHERE bucket BETWEEN 2 AND 99;