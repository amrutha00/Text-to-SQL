SELECT COUNT(DISTINCT c_customer_sk) AS total_customers
FROM customer c
WHERE EXISTS (
    SELECT 1
    FROM store_sales ss
    JOIN date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
    WHERE ss.ss_customer_sk = c.c_customer_sk
    AND d.d_month_seq BETWEEN 1184 AND 1195
)
AND EXISTS (
    SELECT 1
    FROM catalog_sales cs
    JOIN date_dim d ON cs.cs_sold_date_sk = d.d_date_sk
    WHERE cs.cs_bill_customer_sk = c.c_customer_sk
    AND d.d_month_seq BETWEEN 1184 AND 1195
)
AND EXISTS (
    SELECT 1
    FROM web_sales ws
    JOIN date_dim d ON ws.ws_sold_date_sk = d.d_date_sk
    WHERE ws.ws_bill_customer_sk = c.c_customer_sk
    AND d.d_month_seq BETWEEN 1184 AND 1195
);