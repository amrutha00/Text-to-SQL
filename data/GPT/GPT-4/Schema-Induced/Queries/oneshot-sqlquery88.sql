SELECT
COUNT(*) FILTER (WHERE t_hour = 8 AND t_minute >= 30 AND t_minute < 60) AS h8_30_to_9,
COUNT(*) FILTER (WHERE t_hour = 9 AND t_minute >= 0 AND t_minute < 30) AS h9_to_9_30,
COUNT(*) FILTER (WHERE t_hour = 9 AND t_minute >= 30 AND t_minute < 60) AS h9_30_to_10,
COUNT(*) FILTER (WHERE t_hour = 10 AND t_minute >= 0 AND t_minute < 30) AS h10_to_10_30,
COUNT(*) FILTER (WHERE t_hour = 10 AND t_minute >= 30 AND t_minute < 60) AS h10_30_to_11,
COUNT(*) FILTER (WHERE t_hour = 11 AND t_minute >= 0 AND t_minute < 30) AS h11_to_11_30,
COUNT(*) FILTER (WHERE t_hour = 11 AND t_minute >= 30 AND t_minute < 60) AS h11_30_to_12
FROM store_sales ss
JOIN time_dim t ON ss.ss_sold_time_sk = t.t_time_sk
JOIN household_demographics hd ON ss.ss_hdemo_sk = hd.hd_demo_sk
JOIN store s ON ss.ss_store_sk = s.s_store_sk
WHERE s.s_store_name = 'ese'
AND ((hd.hd_dep_count = 1 AND hd.hd_vehicle_count <= 2) 
OR (hd.hd_dep_count = 2 AND hd.hd_vehicle_count <= 4) 
OR (hd.hd_dep_count = 3 AND hd.hd_vehicle_count <= 5));