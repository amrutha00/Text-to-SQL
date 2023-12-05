WITH CTE_StoreSales AS (
    SELECT 
        ss_item_sk,
        ss_store_sk,
        SUM(ss_net_profit) AS store_net_profit
    FROM store_sales
    JOIN date_dim ON ss_sold_date_sk = d_date_sk
    WHERE d_date BETWEEN '2000-04-01' AND '2000-04-30'
    GROUP BY ss_item_sk, ss_store_sk
),
CTE_CatalogSales AS (
    SELECT 
        cs_item_sk,
        SUM(cs_net_profit) AS catalog_net_profit
    FROM catalog_sales
    JOIN date_dim ON cs_sold_date_sk = d_date_sk
    WHERE d_date BETWEEN '2000-04-01' AND '2000-10-31'
    GROUP BY cs_item_sk
),
CTE_StoreReturns AS (
    SELECT 
        sr_item_sk,
        sr_store_sk,
        SUM(sr_net_loss) AS store_net_loss
    FROM store_returns
    JOIN date_dim ON sr_returned_date_sk = d_date_sk
    WHERE d_date BETWEEN '2000-04-01' AND '2000-04-30'
    GROUP BY sr_item_sk, sr_store_sk
)

SELECT 
    i.i_item_sk,
    i.i_item_desc,
    s.s_store_sk,
    s.s_store_name,
    COALESCE(ss.store_net_profit, 0) AS total_net_profit_from_store,
    COALESCE(sr.store_net_loss, 0) AS total_net_loss_from_store,
    COALESCE(cs.catalog_net_profit, 0) AS total_net_profit_from_catalog
FROM item i
JOIN CTE_StoreSales ss ON i.i_item_sk = ss.ss_item_sk
JOIN CTE_StoreReturns sr ON i.i_item_sk = sr.sr_item_sk AND ss.ss_store_sk = sr.sr_store_sk
JOIN CTE_CatalogSales cs ON i.i_item_sk = cs.cs_item_sk
JOIN store s ON ss.ss_store_sk = s.s_store_sk
ORDER BY i.i_item_sk, i.i_item_desc, s.s_store_sk, s.s_store_name
LIMIT 100;
