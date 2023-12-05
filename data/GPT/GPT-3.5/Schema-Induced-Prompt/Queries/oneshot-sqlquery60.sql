SELECT i.i_item_id, SUM(s1.ss_ext_sales_price + s2.cs_ext_sales_price + s3.ws_ext_sales_price) AS total_sales_amount
FROM store_sales s1
JOIN catalog_sales s2 ON s1.ss_item_sk = s2.cs_item_sk
JOIN web_sales s3 ON s1.ss_item_sk = s3.ws_item_sk
JOIN date_dim d ON s1.ss_sold_date_sk = d.d_date_sk
JOIN customer_address ca ON s1.ss_addr_sk = ca.ca_address_sk
JOIN item i ON s1.ss_item_sk = i.i_item_sk
WHERE i.i_category = 'Children'
AND EXTRACT(MONTH FROM d.d_date) = 8
AND ca.ca_gmt_offset = -7
GROUP BY i.i_item_id
ORDER BY i.i_item_id, total_sales_amount DESC
LIMIT 100;