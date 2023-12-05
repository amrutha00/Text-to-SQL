WITH AggregatedSales AS (
    -- Calculate aggregated sales for each customer for each type for both years
    SELECT 
        ss.ss_customer_sk,
        SUM(CASE WHEN ss.ss_sold_date_sk BETWEEN '1999-01-01' AND '1999-12-31' AND ss.ss_sales_type = 's' THEN ss.ss_net_paid ELSE 0 END) AS in_store_1999,
        SUM(CASE WHEN ss.ss_sold_date_sk BETWEEN '2000-01-01' AND '2000-12-31' AND ss.ss_sales_type = 's' THEN ss.ss_net_paid ELSE 0 END) AS in_store_2000,
        SUM(CASE WHEN cs.cs_sold_date_sk BETWEEN '1999-01-01' AND '1999-12-31' AND cs.ss_sales_type = 'c' THEN cs.cs_net_paid ELSE 0 END) AS catalog_1999,
        SUM(CASE WHEN cs.cs_sold_date_sk BETWEEN '2000-01-01' AND '2000-12-31' AND cs.ss_sales_type = 'c' THEN cs.cs_net_paid ELSE 0 END) AS catalog_2000,
        SUM(CASE WHEN ws.ws_sold_date_sk BETWEEN '1999-01-01' AND '1999-12-31' AND ws.ss_sales_type = 'w' THEN ws.ws_net_paid ELSE 0 END) AS web_1999,
        SUM(CASE WHEN ws.ws_sold_date_sk BETWEEN '2000-01-01' AND '2000-12-31' AND ws.ss_sales_type = 'w' THEN ws.ws_net_paid ELSE 0 END) AS web_2000
    FROM customer c
    LEFT JOIN store_sales ss ON c.c_customer_sk = ss.ss_customer_sk
    LEFT JOIN catalog_sales cs ON c.c_customer_sk = cs.cs_customer_sk
    LEFT JOIN web_sales ws ON c.c_customer_sk = ws.ws_customer_sk
    GROUP BY ss.ss_customer_sk
)

SELECT 
    c.c_customer_id,
    c.c_first_name,
    c.c_last_name,
    c.c_current_country
FROM customer c
JOIN AggregatedSales AS a ON c.c_customer_sk = a.ss_customer_sk
WHERE 
    a.in_store_1999 > 0 AND 
    a.catalog_1999 > 0 AND
    a.web_1999 > 0 AND
    (a.catalog_2000 / NULLIF(a.catalog_1999, 0)) > (a.in_store_2000 / NULLIF(a.in_store_1999, 0)) AND
    (a.catalog_2000 / NULLIF(a.catalog_1999, 0)) > (a.web_2000 / NULLIF(a.web_1999, 0))
ORDER BY 
    c.c_customer_id, 
    c.c_first_name, 
    c.c_last_name, 
    c.c_current_country
LIMIT 100;
