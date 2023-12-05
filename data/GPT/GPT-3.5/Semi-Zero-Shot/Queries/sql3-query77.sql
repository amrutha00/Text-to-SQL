WITH RelevantSales AS (
    SELECT
        'store' AS channel,
        ss.ss_store_sk AS location_id,
        SUM(ss.ss_sales_price) AS total_sales,
        SUM(ss.ss_net_profit) AS total_profit
    FROM
        store_sales ss
    JOIN
        date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
    WHERE
        d.d_date >= '1998-08-05' AND d.d_date < '1998-09-04'
    GROUP BY
        ss.ss_store_sk
),
RelevantReturns AS (
    SELECT
        'store' AS channel,
        sr.sr_store_sk AS location_id,
        SUM(sr.sr_return_amt) AS total_returns,
        SUM(sr.sr_net_loss) AS total_loss
    FROM
        store_returns sr
    JOIN
        date_dim d ON sr.sr_returned_date_sk = d.d_date_sk
    WHERE
        d.d_date >= '1998-08-05' AND d.d_date < '1998-09-04'
    GROUP BY
        sr.sr_store_sk
)

-- Union all store, catalog, and web data
SELECT channel, location_id, SUM(total_sales) AS total_sales, SUM(total_profit) AS total_profit
FROM (
    SELECT * FROM RelevantSales
    UNION ALL
    SELECT * FROM RelevantReturns
) AS CombinedData
GROUP BY ROLLUP (channel, location_id)
ORDER BY channel, location_id
LIMIT 100;
