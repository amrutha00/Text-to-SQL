SELECT
    c.c_gender,
    c.c_marital_status,
    c.c_education_status,
    c.c_purchase_estimate,
    c.c_credit_rating,
    COUNT(*) AS customer_count
FROM
    customer AS c
JOIN
    store_sales AS ss
    ON c.c_customer_sk = ss.ss_customer_sk
JOIN
    date_dim AS dd
    ON ss.ss_sold_date_sk = dd.d_date_sk
WHERE
    c.c_state IN ('TX', 'VA', 'MI')
    AND
    EXTRACT(YEAR FROM dd.d_date) = 2000
    AND
    EXTRACT(MONTH FROM dd.d_date) BETWEEN 1 AND 3
GROUP BY
    c.c_gender,
    c.c_marital_status,
    c.c_education_status,
    c.c_purchase_estimate,
    c.c_credit_rating
ORDER BY
    c.c_gender,
    c.c_marital_status,
    c.c_education_status,
    c.c_purchase_estimate,
    c.c_credit_rating
LIMIT 100;
