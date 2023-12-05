CREATE TEMP TABLE ssci AS 
SELECT ss.ss_customer_sk, ss.ss_item_sk
FROM store_sales ss
JOIN date_dim dd ON ss.ss_sold_date_sk = dd.d_date_sk
WHERE dd.d_date BETWEEN '1214-12-01' AND '1215-11-30';

CREATE TEMP TABLE csci AS 
SELECT cs.cs_customer_sk, cs.cs_item_sk
FROM catalog_sales cs
JOIN date_dim dd ON cs.cs_sold_date_sk = dd.d_date_sk
WHERE dd.d_date BETWEEN '1214-12-01' AND '1215-11-30';
WITH Counts AS (
    SELECT 
        COALESCE(ssci.ss_customer_sk, csci.cs_customer_sk) AS customer_sk,
        COALESCE(ssci.ss_item_sk, csci.cs_item_sk) AS item_sk,
        CASE WHEN ssci.ss_customer_sk IS NOT NULL AND csci.cs_customer_sk IS NULL THEN 1 ELSE 0 END AS store_only,
        CASE WHEN ssci.ss_customer_sk IS NULL AND csci.cs_customer_sk IS NOT NULL THEN 1 ELSE 0 END AS catalog_only,
        CASE WHEN ssci.ss_customer_sk IS NOT NULL AND csci.cs_customer_sk IS NOT NULL THEN 1 ELSE 0 END AS store_and_catalog
    FROM ssci 
    FULL OUTER JOIN csci ON ssci.ss_customer_sk = csci.cs_customer_sk AND ssci.ss_item_sk = csci.cs_item_sk
)
SELECT 
    customer_sk, 
    item_sk, 
    SUM(store_only) AS store_only_count, 
    SUM(catalog_only) AS catalog_only_count, 
    SUM(store_and_catalog) AS store_and_catalog_count
FROM Counts c
JOIN web_sales ws ON c.customer_sk = ws.ws_customer_sk AND c.item_sk = ws.ws_item_sk
JOIN date_dim dd ON ws.ws_sold_date_sk = dd.d_date_sk AND dd.d_date BETWEEN '1214-12-01' AND '1215-11-30'
JOIN item i ON ws.ws_item_sk = i.i_item_sk AND i.i_category = 'SPECIFIED_CATEGORY' --Replace with the actual category
JOIN customer cust ON ws.ws_customer_sk = cust.c_customer_sk AND cust.c_current_cdemo_sk = 'SPECIFIED_TIME_ZONE' --Replace with the actual time zone
GROUP BY customer_sk, item_sk
LIMIT 100;
