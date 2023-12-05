SELECT i.i_product_name AS product_name,
       CONCAT(s.ss_store_sk, ' - ', s.ss_store_name) AS store_name,
       s.ss_addr_sk AS billing_addr_sk,
       b.addr_street_number AS billing_street_number,
       b.addr_street_name AS billing_street_name,
       b.addr_city AS billing_city,
       b.addr_zip_code AS billing_zip_code,
       s.ss_ship_addr_sk AS shipping_addr_sk,
       sh.addr_street_number AS shipping_street_number,
       sh.addr_street_name AS shipping_street_name,
       sh.addr_city AS shipping_city,
       sh.addr_zip_code AS shipping_zip_code,
       COUNT(CASE WHEN YEAR(FROM_UNIXTIME(s.ss_sold_date_sk * 86400)) = 2001 THEN s.ss_item_sk END) AS count_2001,
       COUNT(CASE WHEN YEAR(FROM_UNIXTIME(s.ss_sold_date_sk * 86400)) = 2002 THEN s.ss_item_sk END) AS count_2002,
       SUM(CASE WHEN YEAR(FROM_UNIXTIME(s.ss_sold_date_sk * 86400)) = 2001 THEN s.ss_wholesale_cost END) AS wholesale_cost_2001,
       SUM(CASE WHEN YEAR(FROM_UNIXTIME(s.ss_sold_date_sk * 86400)) = 2002 THEN s.ss_wholesale_cost END) AS wholesale_cost_2002
FROM store_sales s
JOIN item i ON s.ss_item_sk = i.i_item_sk
JOIN <tableName>store AS st ON s.ss_store_sk = st.s_store_sk
JOIN <tableName>customer_address AS b ON s.ss_addr_sk = b.ca_address_sk
JOIN <tableName>customer_address AS sh ON s.ss_ship_addr_sk = sh.ca_address_sk
WHERE (s.ss_sold_date_sk BETWEEN 365 * YEAR(2001-01-01) + 1 AND 365 * YEAR(2002-12-31))
  AND (s.ss_sold_time_sk >= 0)
  AND (s.ss_item_sk IN (SELECT i_item_sk FROM <tableName>item WHERE i_category IN ('Internet', 'Catalog', 'Store')))
GROUP BY i.i_product_name, s.ss_store_sk, s.ss_addr_sk, s.ss_ship_addr_sk, b.addr_street_number, b.addr_street_name, b.addr_city, b.addr_zip_code, sh.addr_street_number, sh.addr_street_name, sh.addr_city, sh.addr_zip_code
ORDER BY i.i_product_name, store_name, count_2002, wholesale_cost_2001, wholesale_cost_2002
LIMIT 100;