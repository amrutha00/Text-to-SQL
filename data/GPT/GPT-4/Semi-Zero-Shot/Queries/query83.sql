WITH DateFilter AS (
    SELECT d_date_sk
    FROM date_dim
    WHERE d_date IN ('2001-06-06', '2001-09-02', '2001-11-11')
),

ReturnAggregates AS (
    SELECT 
        sr_item_sk,
        SUM(CASE WHEN sr_ticket_number IS NOT NULL THEN sr_return_quantity ELSE 0 END) AS store_return_qty,
        SUM(CASE WHEN cr_order_number IS NOT NULL THEN cr_return_quantity ELSE 0 END) AS catalog_return_qty,
        SUM(CASE WHEN wr_order_number IS NOT NULL THEN wr_return_quantity ELSE 0 END) AS web_return_qty
    FROM store_returns
    LEFT JOIN catalog_returns ON sr_item_sk = cr_item_sk AND sr_returned_date_sk = cr_returned_date_sk
    LEFT JOIN web_returns ON sr_item_sk = wr_item_sk AND sr_returned_date_sk = wr_returned_date_sk
    WHERE sr_returned_date_sk IN (SELECT d_date_sk FROM DateFilter)
    GROUP BY sr_item_sk
),

DeviationCalc AS (
    SELECT
        sr_item_sk,
        store_return_qty,
        catalog_return_qty,
        web_return_qty,
        ABS(store_return_qty - (store_return_qty + catalog_return_qty + web_return_qty)/3.0) / ((store_return_qty + catalog_return_qty + web_return_qty)/3.0) * 100 AS store_deviation,
        ABS(catalog_return_qty - (store_return_qty + catalog_return_qty + web_return_qty)/3.0) / ((store_return_qty + catalog_return_qty + web_return_qty)/3.0) * 100 AS catalog_deviation,
        ABS(web_return_qty - (store_return_qty + catalog_return_qty + web_return_qty)/3.0) / ((store_return_qty + catalog_return_qty + web_return_qty)/3.0) * 100 AS web_deviation
    FROM ReturnAggregates
)

SELECT
    sr_item_sk,
    store_return_qty,
    catalog_return_qty,
    web_return_qty
FROM DeviationCalc
WHERE store_deviation <= 10
    AND catalog_deviation <= 10
    AND web_deviation <= 10
ORDER BY sr_item_sk, store_return_qty
LIMIT 100;
