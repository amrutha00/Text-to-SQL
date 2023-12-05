SELECT i_manufact, SUM(ws_ext_sales_price) AS total_sales
FROM web_sales ws
JOIN item i ON ws.ws_item_sk = i.i_item_sk
JOIN date_dim d ON ws.ws_sold_date_sk = d.d_date_sk
WHERE d.d_year = 2002 AND d.d_moy = 1 AND d.d_gmt_offset = -5
AND i.i_category = 'Home'
GROUP BY i_manufact
ORDER BY total_sales DESC
LIMIT 100;