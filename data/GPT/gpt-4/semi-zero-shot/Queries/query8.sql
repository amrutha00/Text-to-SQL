SELECT
    s.s_store_name,
    SUM(ss.ss_net_profit - COALESCE(sr.sr_net_loss, 0)) AS net_profit
FROM
    store s
JOIN store_sales ss ON ss.ss_store_sk = s.s_store_sk
JOIN date_dim d ON d.d_date_sk = ss.ss_sold_date_sk
LEFT JOIN store_returns sr ON sr.sr_store_sk = s.s_store_sk AND sr.sr_returned_date_sk = ss.ss_sold_date_sk
JOIN customer c ON c.c_customer_sk = ss.ss_customer_sk
JOIN customer_address ca ON ca.ca_address_sk = c.c_current_addr_sk
WHERE
    d.d_year = 1998
    AND d.d_qoy = 2
    AND ca.ca_address_sk IN (
        SELECT ca2.ca_address_sk
        FROM customer_address ca2
        WHERE ca2.ca_county IN (
            SELECT DISTINCT ca_county
            FROM customer_address
            WHERE ca_county LIKE '400%'
            GROUP BY ca_county
            HAVING COUNT(DISTINCT (CASE WHEN c_preferred_cust_flag = 'Y' THEN c_customer_sk ELSE NULL END)) > 10
        )
    )
GROUP BY
    s.s_store_name
ORDER BY
    s.s_store_name ASC
LIMIT 100;
