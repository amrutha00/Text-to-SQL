SELECT w.w_warehouse_name, sm.sm_type, ws.web_name,
COUNT(CASE WHEN ws.ws_ship_date_sk - ws.ws_sold_date_sk <= 30 THEN 1 END) AS shipped_within_30_days,
COUNT(CASE WHEN ws.ws_ship_date_sk - ws.ws_sold_date_sk BETWEEN 31 AND 60 THEN 1 END) AS shipped_between_31_and_60_days,
COUNT(CASE WHEN ws.ws_ship_date_sk - ws.ws_sold_date_sk BETWEEN 61 AND 90 THEN 1 END) AS shipped_between_61_and_90_days,
COUNT(CASE WHEN ws.ws_ship_date_sk - ws.ws_sold_date_sk BETWEEN 91 AND 120 THEN 1 END) AS shipped_between_91_and_120_days,
COUNT(CASE WHEN ws.ws_ship_date_sk - ws.ws_sold_date_sk > 120 THEN 1 END) AS shipped_over_120_days
FROM web_sales ws
JOIN warehouse w ON ws.ws_warehouse_sk = w.w_warehouse_sk
JOIN ship_mode sm ON ws.ws_ship_mode_sk = sm.sm_ship_mode_sk
JOIN web_site ws2 ON ws.ws_web_site_sk = ws2.web_site_sk
JOIN date_dim d ON ws.ws_sold_date_sk = d.d_date_sk
WHERE d.d_month_seq /12 = 1194
GROUP BY w.w_warehouse_name, sm.sm_type, ws.web_name
ORDER BY w.w_warehouse_name, sm.sm_type, ws.web_name
LIMIT 100;