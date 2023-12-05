WITH Store_Ratios AS (
    SELECT
        'store' AS channel,
        ss_item_sk AS item,
        SUM(ss_quantity) AS total_sales_qty,
        SUM(sr_quantity) AS total_returns_qty,
        SUM(ss_net_paid) AS total_net_paid,
        SUM(sr_return_amt) AS total_return_amt
    FROM
        store_sales ss
    JOIN store_returns sr ON ss.ss_item_sk = sr.sr_item_sk
    WHERE
        EXTRACT(YEAR FROM ss.ss_sold_date_sk) = 1999 AND 
        EXTRACT(YEAR FROM sr.sr_returned_date_sk) = 1999
    GROUP BY
        ss_item_sk
),

Store_Ratios_Ranked AS (
    SELECT
        channel,
        item,
        CASE WHEN total_sales_qty = 0 THEN 0 ELSE total_sales_qty / total_returns_qty END AS qty_ratio,
        CASE WHEN total_net_paid = 0 THEN 0 ELSE total_return_amt / total_net_paid END AS currency_ratio,
        RANK() OVER (ORDER BY CASE WHEN total_sales_qty = 0 THEN 0 ELSE total_sales_qty / total_returns_qty END ASC) AS return_rank,
        RANK() OVER (ORDER BY CASE WHEN total_net_paid = 0 THEN 0 ELSE total_return_amt / total_net_paid END ASC) AS currency_rank
    FROM
        Store_Ratios
)

SELECT 
    channel,
    item,
    qty_ratio,
    currency_ratio,
    return_rank,
    currency_rank
FROM 
    Store_Ratios_Ranked
ORDER BY 
    channel, 
    return_rank, 
    currency_rank, 
    item 
LIMIT 100;
