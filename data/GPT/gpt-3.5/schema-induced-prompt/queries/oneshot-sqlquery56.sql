SELECT i.i_item_id, SUM(ws.ws_sales_price) AS total_sales_amount
FROM web_sales AS ws
JOIN item AS i ON ws.ws_item_sk = i.i_item_sk
JOIN customer_address AS ca ON ws.ws_ship_addr_sk = ca.ca_address_sk
JOIN date_dim AS d ON ws.ws_sold_date_sk = d.d_date_sk
WHERE i.i_color IN ('color1', 'color2', 'color3')
AND d.d_month_seq = (SELECT d_month_seq FROM date_dim WHERE d_year = 2000 AND d_moy = 2)
AND ca.ca_gmt_offset = -6
GROUP BY i.i_item_id
ORDER BY total_sales_amount DESC
LIMIT 100;