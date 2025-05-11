WITH delivery_data AS (
    SELECT
        HOUR(rs.segment_start_time) AS delivery_hour,
        TIMESTAMPDIFF(SECOND, rs.segment_start_time, rs.segment_end_time)/60 AS delivery_minutes
    FROM route_segments rs
             JOIN orders o ON rs.order_id = o.order_id
    WHERE rs.segment_type = 'STOP'
),
     ranked AS (
         SELECT *,
                NTILE(100) OVER (PARTITION BY delivery_hour ORDER BY delivery_minutes) AS bucket
         FROM delivery_data
     )
SELECT
    delivery_hour,
    ROUND(AVG(delivery_minutes), 2) AS avg_trimmed_minutes,
    COUNT(*) AS sample_size
FROM ranked
WHERE bucket BETWEEN 2 AND 99
GROUP BY delivery_hour
ORDER BY delivery_hour;