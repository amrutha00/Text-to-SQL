SELECT
    c.c_last_name,
    c.c_first_name,
    c.c_current_city AS customer_residence_city,
    s.s_city AS store_city,
    t.coupon_amount,
    t.net_profit,
    t.t_ticket_number
FROM
    customer AS c
JOIN
    store_sales AS t ON c.c_customer_sk = t.ss_customer_sk
JOIN
    store AS s ON t.ss_store_sk = s.s_store_sk
WHERE
    c.c_carrier_id IS NULL
    AND c.c_current_city NOT IN ('city1', 'city2', 'city3', 'city4', 'city5')
    AND t.d_weekend IN ('Saturday', 'Sunday')
    AND t.d_year BETWEEN <start_year> AND <end_year>
    AND c.c_dep_count = <specified_dependents_count>
LIMIT 100
ORDER BY
    c.c_last_name,
    c.c_first_name,
    c.c_current_city,
    s.s_city,
    t.t_ticket_number;
