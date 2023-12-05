SELECT COUNT(DISTINCT ws_order_number) AS distinct_order_numbers,
       SUM(ws_ext_ship_cost) AS total_shipping_cost,
       SUM(ws_net_profit) AS total_net_profit
FROM web_sales
JOIN customer_address ON ws_ship_addr_sk = ca_address_sk
JOIN web_site ON ws_web_site_sk = web_site_sk
JOIN date_dim ON ws_sold_date_sk = d_date_sk
WHERE d_date >= '2000-02-01' AND d_date < '2000-04-02'
  AND ca_state = 'Oklahoma'
  AND web_name = 'pri'
  AND ws_ext_ship_cost > 0
  AND ws_ext_wholesale_cost != ws_sales_price
GROUP BY ws_order_number
HAVING COUNT(DISTINCT ws_warehouse_sk) > 1
ORDER BY distinct_order_numbers DESC
LIMIT 100;