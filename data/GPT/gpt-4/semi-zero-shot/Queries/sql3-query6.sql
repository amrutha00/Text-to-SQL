SELECT s.s_state AS state, COUNT(DISTINCT c.c_customer_id) AS num_customers
FROM store_sales ss
JOIN date_dim d ON ss.d_date_sk = d.d_date_sk
JOIN customer c ON ss.c_customer_sk = c.c_customer_sk
JOIN item i ON ss.s_item_sk = i.i_item_sk
JOIN store s ON ss.s_store_sk = s.s_store_sk
WHERE d.d_month_seq = 241 -- March 2002
  AND ss.ss_sold_date_sk IS NOT NULL
  AND ss.ss_sold_date_sk BETWEEN d.d_date_sk AND (d.d_date_sk + 30) -- Assuming 30 days in March
  AND ss.ss_list_price > 1.2 * i.i_current_price -- At least 20% higher price
GROUP BY s.s_state
HAVING COUNT(DISTINCT c.c_customer_id) >= 10
ORDER BY num_customers ASC
LIMIT 100;
