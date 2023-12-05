SELECT
    SUM(store_sales) AS total_sales
FROM
    sales s
    JOIN customer c ON s.customer_id = c.customer_id
    JOIN customer_address ca ON c.customer_id = ca.ca_address_id
    JOIN date_dim dd ON s.dd_date_sk = dd.d_date_sk
WHERE
    dd.d_year = 1999
    AND (
        (c.c_marital_status = 'U' AND c.c_education_status = 'Primary' AND s.ss_sales_price BETWEEN 100.00 AND 150.00)
        OR (c.c_marital_status = 'W' AND c.c_education_status = 'College' AND s.ss_sales_price BETWEEN 50.00 AND 100.00)
        OR (c.c_marital_status = 'D' AND c.c_education_status = '2 yr Degree' AND s.ss_sales_price BETWEEN 150.00 AND 200.00)
    )
    AND (
        (ca.ca_state IN ('MD', 'MN', 'IA') AND s.ss_net_profit BETWEEN 0 AND 2000)
        OR (ca.ca_state IN ('VA', 'IL', 'TX') AND s.ss_net_profit BETWEEN 150 AND 3000)
        OR (ca.ca_state IN ('MI', 'WI', 'IN') AND s.ss_net_profit BETWEEN 50 AND 25000)
    );
