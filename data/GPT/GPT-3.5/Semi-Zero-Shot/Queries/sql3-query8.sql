SELECT store_name,
       SUM(store_sales - store_cost) AS net_profit
FROM store_sales
JOIN store ON store_sales.store_id = store.store_id
JOIN household_demographics ON store.hd_demo_sk = household_demographics.hd_demo_sk
JOIN customer ON store.hd_demo_sk = customer.hd_demo_sk
WHERE household_demographics.hd_metro_m50 > 400
  AND customer.preferred_cust_flag = 'Y'
  AND date_dim.d_qoy = 2 -- Second quarter (Q2)
  AND date_dim.d_year = 1998
GROUP BY store_name
ORDER BY store_name
LIMIT 100;
