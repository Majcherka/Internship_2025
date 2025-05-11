WITH delivery_times AS (
   SELECT o.sector_id, TIMESTAMPDIFF(SECOND, rs.segment_start_time, rs.segment_end_time) / 60 AS avg_delivery_time
   FROM route_segments rs
            JOIN orders o ON rs.order_id = o.order_id
   WHERE rs.segment_type = 'STOP'
),
ranked AS (
   SELECT *,
          NTILE(100) OVER (PARTITION BY sector_id ORDER BY avg_delivery_time) AS bucket
   FROM delivery_times
)
SELECT sector_id, AVG(avg_delivery_time) FROM ranked WHERE bucket BETWEEN 2 AND 99 GROUP BY sector_id;