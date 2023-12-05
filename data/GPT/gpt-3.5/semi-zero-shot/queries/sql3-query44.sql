SELECT p.product_name,
       s.store_id,
       SUM(ws_ext.sales_price) AS net_profit
FROM web_sales ws
JOIN product p ON ws.ws_item_sk = p.product_sk
JOIN date_dim dd ON ws.ws_sold_date_sk = dd.d_date_sk
JOIN store_sales ss ON ws.ws_order_number = ss.ss_ticket_number
JOIN store s ON ss.ss_store_sk = s.store_sk
WHERE s.store_id = 146
  AND dd.d_month_seq = (SELECT MAX(d_month_seq) FROM date_dim)
GROUP BY p.product_name, s.store_id
ORDER BY net_profit DESC
LIMIT 100
