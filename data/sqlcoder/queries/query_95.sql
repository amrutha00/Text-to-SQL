SELECT COUNT(DISTINCT ws_order_number) AS number_of_orders,
       SUM(ws_ext_ship_cost) AS total_shipping_cost,
       SUM(ws_net_profit) AS total_net_profit
FROM web_sales ws
JOIN date_dim dd ON ws.ws_sold_date_sk = dd.d_date_sk
JOIN customer_address ca ON ws.ws_ship_addr_sk = ca.ca_address_sk
JOIN web_site ws2 ON ws.ws_web_site_sk = ws2.web_site_sk
JOIN web_returns wr ON ws.ws_order_number = wr.wr_order_number
WHERE dd.d_date BETWEEN '2000-01-01' AND '2000-01-60'
  AND ca.ca_state = 'NC'
  AND ws2.web_name = 'pri'
  AND ws.ws_warehouse_sk > 1;