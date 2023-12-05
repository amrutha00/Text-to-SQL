SELECT s.s_store_name, s.s_store_id,
   SUM(CASE WHEN d.d_day_name = 'Sunday' THEN ss.ss_ext_sales_price ELSE 0 END) AS Sunday_sales,
   SUM(CASE WHEN d.d_day_name = 'Monday' THEN ss.ss_ext_sales_price ELSE 0 END) AS Monday_sales,
   SUM(CASE WHEN d.d_day_name = 'Tuesday' THEN ss.ss_ext_sales_price ELSE 0 END) AS Tuesday_sales,
   SUM(CASE WHEN d.d_day_name = 'Wednesday' THEN ss.ss_ext_sales_price ELSE 0 END) AS Wednesday_sales,
   SUM(CASE WHEN d.d_day_name = 'Thursday' THEN ss.ss_ext_sales_price ELSE 0 END) AS Thursday_sales,
   SUM(CASE WHEN d.d_day_name = 'Friday' THEN ss.ss_ext_sales_price ELSE 0 END) AS Friday_sales,
   SUM(CASE WHEN d.d_day_name = 'Saturday' THEN ss.ss_ext_sales_price ELSE 0 END) AS Saturday_sales
FROM store_sales ss
JOIN store s ON ss.ss_store_sk = s.s_store_sk
JOIN date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
WHERE d.d_year = 2000 AND s.s_gmt_offset = -5
GROUP BY s.s_store_name, s.s_store_id
ORDER BY s.s_store_name, s.s_store_id, Sunday_sales, Monday_sales, Tuesday_sales, Wednesday_sales, Thursday_sales, Friday_sales, Saturday_sales
LIMIT 100;