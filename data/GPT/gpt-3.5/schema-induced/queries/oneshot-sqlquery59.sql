SELECT TOP 100 s.s_store_name, s.s_store_id, WEEK(d.d_date) as week_number, 
SUM(CASE 
    WHEN d.d_year = 1196 THEN ss.ss_ext_sales_price
    WHEN d.d_year = 1197 THEN -ss.ss_ext_sales_price
    ELSE NULL 
END) as sales_difference
FROM store_sales ss
JOIN date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
JOIN store s ON ss.ss_store_sk = s.s_store_sk
WHERE d.d_year IN (1196, 1197)
GROUP BY s.s_store_name, s.s_store_id, week_number
ORDER BY s.s_store_name, s.s_store_id, week_number;