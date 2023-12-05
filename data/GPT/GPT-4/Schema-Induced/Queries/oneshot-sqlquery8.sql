SELECT s_store_name, SUM(ss_net_profit) AS total_net_profit
FROM store_sales AS ss
JOIN store AS s ON ss.ss_store_sk = s.s_store_sk
JOIN date_dim AS d ON ss.ss_sold_date_sk = d.d_date_sk
JOIN customer AS c ON s.s_store_sk = c.c_current_addr_sk
WHERE s_zip LIKE '400%' 
AND c_preferred_cust_flag = 1 
AND d_year = 1998 
AND d_qoy = 2
GROUP BY s_store_name
ORDER BY s_store_name ASC
LIMIT 100;