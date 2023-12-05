WITH StoreSales AS (
    SELECT
        ss.ss_item_sk AS item_sk,
        SUM(ss.ss_quantity) AS store_quantity,
        SUM(ss.ss_wholesale_cost) AS store_wholesale_cost,
        SUM(ss.ss_sales_price) AS store_sales_price
    FROM
        store_sales ss
    JOIN
        date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
    WHERE
        d.d_year = 2000
    GROUP BY
        ss.ss_item_sk
),
OtherChannelSales AS (
    SELECT
        os.os_item_sk AS item_sk,
        SUM(os.os_quantity) AS other_channel_quantity,
        SUM(os.os_wholesale_cost) AS other_channel_wholesale_cost,
        SUM(os.os_sales_price) AS other_channel_sales_price
    FROM
        catalog_sales os
    JOIN
        date_dim d ON os.os_sold_date_sk = d.d_date_sk
    WHERE
        d.d_year = 2000
    GROUP BY
        os.os_item_sk
    UNION ALL
    SELECT
        ow.ow_item_sk AS item_sk,
        SUM(ow.ow_quantity) AS other_channel_quantity,
        SUM(ow.ow_wholesale_cost) AS other_channel_wholesale_cost,
        SUM(ow.ow_sales_price) AS other_channel_sales_price
    FROM
        web_sales ow
    JOIN
        date_dim d ON ow.ow_sold_date_sk = d.d_date_sk
    WHERE
        d.d_year = 2000
    GROUP BY
        ow.ow_item_sk
)
-- Calculate the ratio and filter the results
SELECT
    s.item_sk,
    s.store_quantity / NULLIF(o.other_channel_quantity, 0) AS ratio,
    s.store_quantity,
    s.store_wholesale_cost,
    s.store_sales_price,
    o.other_channel_quantity,
    o.other_channel_wholesale_cost,
    o.other_channel_sales_price
FROM
    StoreSales s
JOIN
    OtherChannelSales o
ON
    s.item_sk = o.item_sk
WHERE
    s.store_quantity >= 1 AND o.other_channel_quantity >= 1
    AND s.store_sales_price >= 2 * o.other_channel_sales_price
ORDER BY
    ratio DESC
LIMIT 100;
