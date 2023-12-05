WITH CombinedSales AS (
    SELECT ss_customer_sk AS customer_key, ss_sold_date_sk AS date_key
    FROM store_sales
    WHERE ss_sold_date_sk BETWEEN 1184*30 AND 1195*30
    UNION ALL
    SELECT ws_bill_customer_sk AS customer_key, ws_sold_date_sk AS date_key
    FROM web_sales
    WHERE ws_sold_date_sk BETWEEN 1184*30 AND 1195*30
    UNION ALL
    SELECT cs_ship_customer_sk AS customer_key, cs_sold_date_sk AS date_key
    FROM catalog_sales
    WHERE cs_sold_date_sk BETWEEN 1184*30 AND 1195*30
)

SELECT customer_key, date_key
FROM CombinedSales
GROUP BY customer_key, date_key
HAVING COUNT(DISTINCT CASE 
    WHEN customer_key IN (SELECT ss_customer_sk FROM store_sales WHERE ss_sold_date_sk = date_key) THEN 'store'
    WHEN customer_key IN (SELECT ws_bill_customer_sk FROM web_sales WHERE ws_sold_date_sk = date_key) THEN 'web'
    WHEN customer_key IN (SELECT cs_ship_customer_sk FROM catalog_sales WHERE cs_sold_date_sk = date_key) THEN 'catalog'
    END
) = 3
