Iteration 1:
```sql
WITH target_items AS (
  SELECT ss.ss_customer_sk,sum(ss.ss_sales_price) AS total_value
  FROM store_sales AS ss
  JOIN item AS i ON ss.ss_item_sk = i.i_item_sk
  JOIN store AS s ON ss.ss_store_sk = s.s_store_sk
  JOIN customer AS c ON ss.ss_customer_sk = c.c_customer_sk
  JOIN customer_address AS ca ON c.c_current_addr_sk = ca.ca_address_sk
  WHERE i.i_color = 'beige' 
    AND c.c_birth_country != ca.ca_country
    AND s.s_market_id = 8 
    AND ca.ca_location_type = 'neighborhood'
  GROUP BY ss.ss_customer_sk
)
SELECT c.c_last_name, c.c_first_name, s.s_store_name
FROM target_items AS ti
JOIN customer AS c ON ti.ss_customer_sk = c.c_customer_sk
JOIN store AS s ON c.c_customer_sk = s.s_store_sk
WHERE ti.total_value > 0.05 * (SELECT AVG(total_value) FROM target_items)
ORDER BY c.c_last_name, c.c_first_name, s.s_store_name
LIMIT 100;
```

Iteration 2:
```sql
WITH target_items AS (
  SELECT ss.ss_customer_sk,sum(ss.ss_sales_price) AS total_value
  FROM store_sales AS ss
  JOIN item AS i ON ss.ss_item_sk = i.i_item_sk
  JOIN store AS s ON ss.ss_store_sk = s.s_store_sk
  JOIN customer AS c ON ss.ss_customer_sk = c.c_customer_sk
  JOIN customer_address AS ca ON c.c_current_addr_sk = ca.ca_address_sk
  WHERE i.i_color = 'blue' 
    AND c.c_birth_country != ca.ca_country
    AND s.s_market_id = 8 
    AND ca.ca_location_type = 'neighborhood'
  GROUP BY ss.ss_customer_sk
)
SELECT c.c_last_name, c.c_first_name, s.s_store_name
FROM target_items AS ti
JOIN customer AS c ON ti.ss_customer_sk = c.c_customer_sk
JOIN store AS s ON c.c_customer_sk = s.s_store_sk
WHERE ti.total_value > 0.05 * (SELECT AVG(total_value) FROM target_items)
ORDER BY c.c_last_name, c.c_first_name, s.s_store_name
LIMIT 100;
```