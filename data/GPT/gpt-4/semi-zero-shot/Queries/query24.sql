--- iteration 1
WITH AverageValue AS (
    SELECT AVG(ss.ss_net_paid) AS average_value
    FROM store_sales ss
    JOIN item i ON ss.ss_item_sk = i.i_item_sk
    JOIN customer c ON ss.ss_customer_sk = c.c_customer_sk
    JOIN store s ON ss.ss_store_sk = s.s_store_sk
    WHERE i.i_color = 'beige'
    AND s.s_market_id = 8
    AND c.c_current_country <> c.c_birth_country
    AND c.c_current_addr_sk = s.s_addr_sk
)

SELECT c.c_last_name, c.c_first_name, s.s_store_name, SUM(ss.ss_net_paid) AS total_value
FROM store_sales ss
JOIN item i ON ss.ss_item_sk = i.i_item_sk
JOIN customer c ON ss.ss_customer_sk = c.c_customer_sk
JOIN store s ON ss.ss_store_sk = s.s_store_sk, AverageValue av
WHERE i.i_color = 'beige'
AND s.s_market_id = 8
AND c.c_current_country <> c.c_birth_country
AND c.c_current_addr_sk = s.s_addr_sk
GROUP BY c.c_last_name, c.c_first_name, s.s_store_name
HAVING SUM(ss.ss_net_paid) > 0.05 * av.average_value
ORDER BY c.c_last_name, c.c_first_name, s.s_store_name;

--- Iteration 2
WITH AverageValue AS (
    SELECT AVG(ss.ss_net_paid) AS average_value
    FROM store_sales ss
    JOIN item i ON ss.ss_item_sk = i.i_item_sk
    JOIN customer c ON ss.ss_customer_sk = c.c_customer_sk
    JOIN store s ON ss.ss_store_sk = s.s_store_sk
    WHERE i.i_color = 'blue'
    AND s.s_market_id = 8
    AND c.c_current_country <> c.c_birth_country
    AND c.c_current_addr_sk = s.s_addr_sk
)

SELECT c.c_last_name, c.c_first_name, s.s_store_name, SUM(ss.ss_net_paid) AS total_value
FROM store_sales ss
JOIN item i ON ss.ss_item_sk = i.i_item_sk
JOIN customer c ON ss.ss_customer_sk = c.c_customer_sk
JOIN store s ON ss.ss_store_sk = s.s_store_sk, AverageValue av
WHERE i.i_color = 'blue'
AND s.s_market_id = 8
AND c.c_current_country <> c.c_birth_country
AND c.c_current_addr_sk = s.s_addr_sk
GROUP BY c.c_last_name, c.c_first_name, s.s_store_name
HAVING SUM(ss.ss_net_paid) > 0.05 * av.average_value
ORDER BY c.c_last_name, c.c_first_name, s.s_store_name;
