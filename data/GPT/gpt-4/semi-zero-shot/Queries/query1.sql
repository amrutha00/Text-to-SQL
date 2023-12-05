WITH StoreAverage AS (
    SELECT 
        ss_store_sk,
        AVG(ss_net_profit) AS avg_net_profit
    FROM
        store_sales
    JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
    JOIN store ON store_sales.ss_store_sk = store.s_store_sk
    WHERE
        date_dim.d_year = 2000
        AND store.s_state = 'SD'
    GROUP BY
        ss_store_sk
),

CustomerReturns AS (
    SELECT 
        ss_customer_sk,
        ss_store_sk,
        SUM(ss_net_profit) AS total_net_profit
    FROM
        store_sales
    JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
    WHERE
        date_dim.d_year = 2000
    GROUP BY
        ss_customer_sk, ss_store_sk
)

SELECT 
    cr.ss_customer_sk
FROM
    CustomerReturns cr
JOIN StoreAverage sa ON cr.ss_store_sk = sa.ss_store_sk
WHERE
    cr.total_net_profit < sa.avg_net_profit * 0.8
ORDER BY
    cr.ss_customer_sk
LIMIT 100;
