SELECT 
  w.w_warehouse_name,
  s.s_name AS shipping_mode,
  ws.wsr_web_site_name AS web_site,
  COUNT(CASE WHEN DATEDIFF(day, o.o_order_date, o.o_ship_date) <= 30 THEN 1 ELSE NULL END) AS shipped_within_30_days,
  COUNT(CASE WHEN DATEDIFF(day, o.o_order_date, o.o_ship_date) BETWEEN 31 AND 60 THEN 1 ELSE NULL END) AS shipped_31_to_60_days,
  COUNT(CASE WHEN DATEDIFF(day, o.o_order_date, o.o_ship_date) BETWEEN 61 AND 90 THEN 1 ELSE NULL END) AS shipped_61_to_90_days,
  COUNT(CASE WHEN DATEDIFF(day, o.o_order_date, o.o_ship_date) BETWEEN 91 AND 120 THEN 1 ELSE NULL END) AS shipped_91_to_120_days,
  COUNT(CASE WHEN DATEDIFF(day, o.o_order_date, o.o_ship_date) > 120 THEN 1 ELSE NULL END) AS shipped_over_120_days
FROM 
  web_sales ws
  JOIN orders o ON ws.ws_order_number = o.o_order_number
  JOIN warehouse w ON o.o_warehouse = w.w_warehouse_sk
  JOIN shipping s ON o.o_ship_mode = s.s_ship_mode_sk
WHERE 
  YEAR(o.o_order_date) = 1194
GROUP BY 
  w.w_warehouse_name, s.s_name, ws.wsr_web_site_name
ORDER BY 
  w.w_warehouse_name, s.s_name, ws.wsr_web_site_name
LIMIT 100;
