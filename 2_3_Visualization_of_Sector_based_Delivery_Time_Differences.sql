SELECT o.sector_id, AVG(TIMESTAMPDIFF(SECOND, rs.segment_start_time, rs.segment_end_time) / 60) AS avg_delivery_time
  FROM route_segments rs
 	JOIN orders o ON rs.order_id = o.order_id
 WHERE rs.segment_type = 'STOP'
 GROUP BY o.sector_id;