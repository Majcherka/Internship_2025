SELECT CEIL(TIMESTAMPDIFF(SECOND, segment_start_time, segment_end_time) / 60) AS actual_delivery_time,
    	o.planned_delivery_duration / 60 AS planned_delivery_time,
    	ABS(o.planned_delivery_duration / 60 - CEIL(TIMESTAMPDIFF(SECOND, segment_start_time, segment_end_time) / 60)) AS prediction_error
 FROM route_segments rs
 JOIN orders o ON rs.order_id = o.order_id
 WHERE rs.segment_type = 'STOP';