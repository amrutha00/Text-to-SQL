SELECT COUNT(*) AS sale_count
FROM store_sales
JOIN household_demographics ON store_sales.ss_customer_sk = household_demographics.hd_demo_sk
JOIN time_dim ON store_sales.ss_sold_time_sk = time_dim.t_time_sk
JOIN store ON store_sales.ss_store_sk = store.s_store_sk
WHERE store.s_store_name = 'ese'
  AND household_demographics.hd_dep_count = 3
  AND time_dim.t_hour = 8
  AND time_dim.t_minute >= 30
GROUP BY store_sales.ss_ticket_number
ORDER BY sale_count DESC
LIMIT 100;