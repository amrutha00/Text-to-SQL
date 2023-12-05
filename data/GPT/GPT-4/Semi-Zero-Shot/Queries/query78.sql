WITH StoreChannel AS (
    SELECT
        ss_customer_sk,
        ss_item_sk,
        SUM(ss_quantity) AS store_qty,
        SUM(ss_wholesale_cost) AS store_wholesale_cost,
        SUM(ss_sales_price) AS store_sales_price
    FROM store_sales
    JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
    WHERE d_year = 2000
    GROUP BY ss_customer_sk, ss_item_sk
    HAVING SUM(ss_quantity) > 0
),

OtherChannels AS (
    SELECT
        ws_bill_customer_sk AS customer_sk,
        ws_item_sk AS item_sk,
        SUM(ws_quantity) AS other_qty,
        SUM(ws_wholesale_cost) AS other_wholesale_cost,
        SUM(ws_sales_price) AS other_sales_price
    FROM web_sales
    JOIN date_dim ON web_sales.ws_sold_date_sk = date_dim.d_date_sk
    WHERE d_year = 2000
    GROUP BY ws_bill_customer_sk, ws_item_sk
    UNION ALL
    SELECT
        cs_bill_customer_sk AS customer_sk,
        cs_item_sk AS item_sk,
        SUM(cs_quantity) AS other_qty,
        SUM(cs_wholesale_cost) AS other_wholesale_cost,
        SUM(cs_sales_price) AS other_sales_price
    FROM catalog_sales
    JOIN date_dim ON catalog_sales.cs_sold_date_sk = date_dim.d_date_sk
    WHERE d_year = 2000
    GROUP BY cs_bill_customer_sk, cs_item_sk
),

AggregatedOtherChannels AS (
    SELECT
        customer_sk,
        item_sk,
        SUM(other_qty) AS total_other_qty,
        SUM(other_wholesale_cost) AS total_other_wholesale_cost,
        SUM(other_sales_price) AS total_other_sales_price
    FROM OtherChannels
    GROUP BY customer_sk, item_sk
    HAVING SUM(other_qty) > 0
)

SELECT
    s.ss_customer_sk,
    s.ss_item_sk AS item_stock_number,
    s.store_qty / a.total_other_qty AS calculated_ratio,
    s.store_qty,
    s.store_wholesale_cost,
    s.store_sales_price,
    a.total_other_qty,
    a.total_other_wholesale_cost,
    a.total_other_sales_price
FROM StoreChannel s
JOIN AggregatedOtherChannels a ON s.ss_customer_sk = a.customer_sk AND s.ss_item_sk = a.item_sk
WHERE (s.store_qty / a.total_other_qty) >= 2
ORDER BY (s.store_qty / a.total_other_qty) DESC
LIMIT 100;
