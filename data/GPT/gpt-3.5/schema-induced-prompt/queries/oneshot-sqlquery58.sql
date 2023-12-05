SELECT i.i_item_id, SUM(ss.ss_ext_sales_price + cs.cs_ext_sales_price + ws.ws_ext_sales_price) AS total_revenue
FROM item i
JOIN store_sales ss ON i.i_item_sk = ss.ss_item_sk
JOIN catalog_sales cs ON i.i_item_sk = cs.cs_item_sk
JOIN web_sales ws ON i.i_item_sk = ws.ws_item_sk
WHERE ws.ws_sold_date_sk = (SELECT d.d_date_sk FROM date_dim d WHERE d.d_date = '2001-03-24')
GROUP BY i.i_item_id
HAVING ABS((ss.ss_ext_sales_price + cs.cs_ext_sales_price + ws.ws_ext_sales_price) - 
           AVG(ss.ss_ext_sales_price + cs.cs_ext_sales_price + ws.ws_ext_sales_price)) /
           AVG(ss.ss_ext_sales_price + cs.cs_ext_sales_price + ws.ws_ext_sales_price) <= 0.1
ORDER BY i.i_item_id, total_revenue DESC
LIMIT 100;