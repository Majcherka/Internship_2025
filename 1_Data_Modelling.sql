SELECT p.product_id AS productId, p.weight * op.quantity AS totalWeight
 FROM orders o
     	JOIN orders_products op ON o.order_id = op.order_id
     	JOIN products p ON op.product_id = p.product_id
     	JOIN route_segments rs ON rs.order_id = o.order_id
 WHERE o.customer_id = 32 AND rs.segment_type = 'STOP' AND DATE(rs.segment_end_time) = '2024-02-13'
 ORDER BY totalWeight ASC;