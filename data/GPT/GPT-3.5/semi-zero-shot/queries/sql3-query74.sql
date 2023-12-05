-- Create a temporary table 'year_total' to calculate standard deviation of net paid sales
CREATE TEMP TABLE year_total AS
SELECT
    c_customer_sk AS customer_id,
    c_first_name AS customer_first_name,
    c_last_name AS customer_last_name,
    's' AS sale_type,
    d_year AS sale_year,
    STDDEV_SAMP(ss_net_paid) AS year_total
FROM
    customer,
    store_sales,
    date_dim
WHERE
    c_customer_sk = ss_customer_sk
    AND d_year IN (1999, 2000)
GROUP BY
    customer_id,
    customer_first_name,
    customer_last_name,
    sale_type,
    sale_year;

INSERT INTO year_total
SELECT
    c_customer_sk AS customer_id,
    c_first_name AS customer_first_name,
    c_last_name AS customer_last_name,
    'w' AS sale_type,
    d_year AS sale_year,
    STDDEV_SAMP(ws_net_paid) AS year_total
FROM
    customer,
    web_sales,
    date_dim
WHERE
    c_customer_sk = ws_bill_customer_sk
    AND d_year IN (1999, 2000)
GROUP BY
    customer_id,
    customer_first_name,
    customer_last_name,
    sale_type,
    sale_year;

-- Select customers who meet the specified conditions
SELECT
    customer_id,
    customer_first_name,
    customer_last_name
FROM
    year_total
WHERE
    ((sale_type = 's' AND sale_year = 1999 AND year_total > 0) OR
     (sale_type = 'w' AND sale_year = 1999 AND year_total > 0)) AND
    ((sale_type = 's' AND sale_year = 2000 AND year_total > 0) OR
     (sale_type = 'w' AND sale_year = 2000 AND year_total > 0))
GROUP BY
    customer_id,
    customer_first_name,
    customer_last_name
HAVING
    SUM(CASE WHEN sale_type = 'w' AND sale_year = 2000 THEN year_total ELSE 0 END) >
    SUM(CASE WHEN sale_type = 's' AND sale_year = 2000 THEN year_total ELSE 0 END)
ORDER BY
    customer_first_name,
    customer_id,
    customer_last_name
LIMIT 100;
