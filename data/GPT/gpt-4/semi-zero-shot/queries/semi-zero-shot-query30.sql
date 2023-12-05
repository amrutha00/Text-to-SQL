SELECT
    c.c_customer_sk AS customer_id,
    c.c_salutation AS salutation,
    c.c_first_name AS first_name,
    c.c_last_name AS last_name,
    c.c_preferred_cust_flag AS preferred_customer_flag,
    c.c_birth_day AS birth_day,
    c.c_birth_month AS birth_month,
    c.c_birth_year AS birth_year,
    c.c_birth_country AS birth_country,
    c.c_login AS login,
    c.c_email_address AS email_address,
    c.c_last_review_date AS last_review_date,
    SUM(cr.cr_return_amt) AS total_return_amount
FROM
    customer AS c
JOIN
    web_sales AS ws
    ON c.c_customer_sk = ws.ws_bill_customer_sk
JOIN
    catalog_sales AS cs
    ON c.c_customer_sk = cs.cs_bill_customer_sk
JOIN
    date_dim AS dd
    ON ws.ws_sold_date_sk = dd.d_date_sk
    AND cs.cs_sold_date_sk = dd.d_date_sk
JOIN
    catalog_returns AS cr
    ON cs.cs_order_number = cr.cr_order_number
WHERE
    dd.d_year = 2002
    AND c.c_birth_country = 'INDIA'
GROUP BY
    c.c_customer_sk,
    c.c_salutation,
    c.c_first_name,
    c.c_last_name,
    c.c_preferred_cust_flag,
    c.c_birth_day,
    c.c_birth_month,
    c.c_birth_year,
    c.c_birth_country,
    c.c_login,
    c.c_email_address,
    c.c_last_review_date
HAVING
    SUM(cr.cr_return_amt) > 1.2 * (
        SELECT
            AVG(SUM(cr2.cr_return_amt))
        FROM
            customer AS c2
        JOIN
            catalog_sales AS cs2
            ON c2.c_customer_sk = cs2.cs_bill_customer_sk
        JOIN
            catalog_returns AS cr2
            ON cs2.cs_order_number = cr2.cr_order_number
        JOIN
            date_dim AS dd2
            ON cs2.cs_sold_date_sk = dd2.d_date_sk
        WHERE
            dd2.d_year = 2002
            AND c2.c_birth_country = 'INDIA'
        GROUP BY
            c2.c_customer_sk
    )
ORDER BY
    c.c_customer_sk,
    c.c_salutation,
    c.c_first_name,
    c.c_last_name,
    c.c_preferred_cust_flag,
    c.c_birth_day,
    c.c_birth_month,
    c.c_birth_year,
    c.c_birth_country,
    c.c_login,
    c.c_email_address,
    c.c_last_review_date
LIMIT 100;
