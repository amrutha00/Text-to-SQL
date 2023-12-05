WITH NetProfit AS (
    SELECT 
        ss_item_sk,
        SUM(ss_net_profit) as total_net_profit
    FROM store_sales
    JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
    JOIN item ON store_sales.ss_item_sk = item.i_item_sk
    WHERE ss_store_sk = 146
    GROUP BY ss_item_sk
)
, RankedProducts AS (
    SELECT 
        ss_item_sk,
        total_net_profit,
        ROW_NUMBER() OVER (ORDER BY total_net_profit ASC) as asc_rank,
        ROW_NUMBER() OVER (ORDER BY total_net_profit DESC) as desc_rank
    FROM NetProfit
)
SELECT 
    i_item_id,
    i_item_desc,
    total_net_profit
FROM RankedProducts
JOIN item ON RankedProducts.ss_item_sk = item.i_item_sk
WHERE asc_rank <= 100 OR desc_rank <= 100
ORDER BY 
    CASE 
        WHEN asc_rank <= 100 THEN asc_rank 
        ELSE desc_rank 
    END ASC;
