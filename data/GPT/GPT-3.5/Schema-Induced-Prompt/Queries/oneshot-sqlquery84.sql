SELECT c_customer_id, c_first_name, c_last_name
FROM customer c
INNER JOIN customer_address ca ON c.c_customer_id = ca.ca_address_sk
INNER JOIN income_band ib ON ib.ib_lower_bound <= c.cd_demo_sk AND ib.ib_upper_bound >= c.cd_demo_sk
WHERE ca.ca_city = 'Oakwood' AND ib.ib_lower_bound >= 5806 AND ib.ib_upper_bound <= 55806
ORDER BY c_customer_id
LIMIT 100;