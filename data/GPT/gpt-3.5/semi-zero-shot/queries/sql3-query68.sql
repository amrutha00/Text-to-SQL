SELECT
    c.c_last_name,
    s.s_ticket_number,
    SUM(wr.w_ext_sales_price) AS per_customer_extended_sales_price,
    SUM(wr.w_ext_list_price) AS per_customer_extended_list_price,
    SUM(wr.w_ext_tax) AS per_customer_extended_tax
FROM
    customer AS c
JOIN
    store_sales AS s
    ON c.c_customer_sk = s.ss_customer_sk
JOIN
    web_sales AS w
    ON s.s_ticket_number = w.ws_ticket_number
JOIN
    store AS st
    ON s.s_store_sk = st.s_store_sk
WHERE
    st.s_city IN ('Pleasant Hill', 'Five Points')
    AND
    EXTRACT(YEAR FROM w.ws_sold_date_sk) IN (1998, 1999, 2000)
    AND
    EXTRACT(MONTH FROM w.ws_sold_date_sk) BETWEEN 1 AND 2
    AND
    (c.c_dep_count = 8 OR c.c_vehicles_count = 0)
    AND
    NOT EXISTS (
        SELECT 1
        FROM
            store AS st2
            JOIN
            customer AS c2
            ON st2.s_store_sk = s.s_store_sk
        WHERE
            c2.c_customer_sk = c.c_customer_sk
            AND
            st2.s_city = st.s_city
    )
GROUP BY
    c.c_last_name,
    s.s_ticket_number
ORDER BY
    c.c_last_name,
    s.s_ticket_number
LIMIT 100;
