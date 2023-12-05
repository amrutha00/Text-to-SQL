WITH StoreSales_2001 AS (
    SELECT ss_customer_sk,
           SUM(ss_net_paid) AS total_sales_2001
    FROM store_sales
    JOIN date_dim ON ss_sold_date_sk = d_date_sk
    WHERE d_year = 2001
    GROUP BY ss_customer_sk
),

StoreSales_2002 AS (
    SELECT ss_customer_sk,
           SUM(ss_net_paid) AS total_sales_2002
    FROM store_sales
    JOIN date_dim ON ss_sold_date_sk = d_date_sk
    WHERE d_year = 2002
    GROUP BY ss_customer_sk
),

WebSales_2001 AS (
    SELECT ws_customer_sk,
           SUM(ws_net_paid) AS total_sales_2001
    FROM web_sales
    JOIN date_dim ON ws_sold_date_sk = d_date_sk
    WHERE d_year = 2001
    GROUP BY ws_customer_sk
),

WebSales_2002 AS (
    SELECT ws_customer_sk,
           SUM(ws_net_paid) AS total_sales_2002
    FROM web_sales
    JOIN date_dim ON ws_sold_date_sk = d_date_sk
    WHERE d_year = 2002
    GROUP BY ws_customer_sk
)

SELECT c.c_customer_id,
       c.c_first_name,
       c.c_last_name,
       c.c_birth_country
FROM customer c
JOIN StoreSales_2001 s1 ON c.c_customer_sk = s1.ss_customer_sk
JOIN StoreSales_2002 s2 ON c.c_customer_sk = s2.ss_customer_sk
JOIN WebSales_2001 w1 ON c.c_customer_sk = w1.ws_customer_sk
JOIN WebSales_2002 w2 ON c.c_customer_sk = w2.ws_customer_sk
WHERE w2.total_sales_2002 > w1.total_sales_2001
AND w2.total_sales_2002 > s2.total_sales_2002
ORDER BY c.c_customer_id, c.c_first_name, c.c_last_name, c.c_birth_country
LIMIT 100;
