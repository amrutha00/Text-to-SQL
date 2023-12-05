WITH StoreSales AS (
    SELECT ss_item_sk
    FROM store_sales ss
    JOIN date_dim dd ON ss.ss_sold_date_sk = dd.d_date_sk
    WHERE dd.d_year = 2001 AND dd.d_qoy = 1
),
StoreReturns AS (
    SELECT sr_item_sk
    FROM store_returns sr
    JOIN date_dim dd ON sr.sr_returned_date_sk = dd.d_date_sk
    WHERE dd.d_year = 2001 AND dd.d_qoy BETWEEN 2 AND 4
),
CatalogSales AS (
    SELECT cs_item_sk
    FROM catalog_sales cs
    JOIN date_dim dd ON cs.cs_sold_date_sk = dd.d_date_sk
    WHERE dd.d_year IN (2001, 2002) AND dd.d_qoy BETWEEN 1 AND 3
)

SELECT
    i.i_item_id,
    i.i_item_desc,
    ca.ca_state,
    COUNT(DISTINCT ss.ss_item_sk) AS store_sales_count,
    AVG(ss.ss_quantity) AS store_sales_avg,
    STDDEV(ss.ss_quantity) AS store_sales_stddev,
    COUNT(DISTINCT sr.sr_item_sk) AS store_returns_count,
    AVG(sr.sr_quantity) AS store_returns_avg,
    STDDEV(sr.sr_quantity) AS store_returns_stddev,
    COUNT(DISTINCT cs.cs_item_sk) AS catalog_sales_count,
    AVG(cs.cs_quantity) AS catalog_sales_avg,
    STDDEV(cs.cs_quantity) AS catalog_sales_stddev
FROM item i
JOIN StoreSales ss ON i.i_item_sk = ss.ss_item_sk
JOIN StoreReturns sr ON i.i_item_sk = sr.sr_item_sk
JOIN CatalogSales cs ON i.i_item_sk = cs.cs_item_sk
JOIN customer_address ca ON cs.cs_bill_cdemo_sk = ca.ca_address_sk
GROUP BY i.i_item_id, i.i_item_desc, ca.ca_state
ORDER BY i.i_item_id, i.i_item_desc, ca.ca_state
LIMIT 100;
