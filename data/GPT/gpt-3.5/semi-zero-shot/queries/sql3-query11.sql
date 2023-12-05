SELECT
    c.c_customer_sk AS customer_id,
    c.c_first_name AS first_name,
    c.c_last_name AS last_name,
    c.c_birth_country AS birth_country
FROM
    customer c
INNER JOIN
    store_sales ss ON c.c_customer_sk = ss.ss_customer_sk
INNER JOIN
    web_sales ws ON c.c_customer_sk = ws.ws_customer_sk
WHERE
    DATEPART(YEAR, ss.ss_sold_date) = 2001
    AND DATEPART(YEAR, ws.ws_sold_date) = 2002
    AND (ws.ws_sales_price - ss.ss_sales_price) / ss.ss_sales_price >= 0.1
ORDER BY
    customer_id,
    first_name,
    last_name,
    birth_country
LIMIT 100;
