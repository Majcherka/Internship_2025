SELECT
        sector_id,
       ABS(o.planned_delivery_duration / 60 - TIMESTAMPDIFF(SECOND, segment_start_time, segment_end_time) / 60) AS prediction_error
FROM route_segments rs
         JOIN orders o ON rs.order_id = o.order_id
WHERE rs.segment_type = 'STOP' ORDER BY sector_id;
