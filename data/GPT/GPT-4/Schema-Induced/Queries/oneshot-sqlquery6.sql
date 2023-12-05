SELECT ca_state, COUNT(DISTINCT c_customer_sk) AS num_customers
FROM customer_address ca
JOIN customer c ON ca.ca_address_sk = c.c_current_addr_sk
JOIN store_sales ss ON c.c_customer_sk = ss.ss_customer_sk
JOIN date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
JOIN item i ON ss.ss_item_sk = i.i_item_sk
WHERE EXTRACT(MONTH FROM d.d_date) = 3 AND EXTRACT(YEAR FROM d.d_date) = 2002
AND i.i_current_price >= 1.2 * (SELECT AVG(i2.i_current_price) FROM item i2 WHERE i2.i_category = i.i_category)
GROUP BY ca_state
ORDER BY num_customers ASC
LIMIT 100;