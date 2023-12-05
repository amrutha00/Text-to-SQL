SELECT
    sales_channel,
    column_name,
    year,
    quarter,
    item_category,
    COUNT(sales_amount) AS count_of_sales,
    SUM(sales_amount) AS sum_of_sales_amount
FROM (
    SELECT
        'store' AS sales_channel,
        ss.ss_item_sk AS item_sk,
        ss.ss_hdemo_sk AS column_name,
        d.year AS year,
        d.quarter AS quarter,
        i.i_category AS item_category,
        ss.ss_sales_price AS sales_amount
    FROM store_sales ss
    JOIN date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
    JOIN item i ON ss.ss_item_sk = i.i_item_sk
    WHERE ss.ss_hdemo_sk IS NOT NULL
    UNION ALL
    SELECT
        'web' AS sales_channel,
        ws.ws_item_sk AS item_sk,
        ws.ws_bill_addr_sk AS column_name,
        d.year AS year,
        d.quarter AS quarter,
        i.i_category AS item_category,
        ws.ws_sales_price AS sales_amount
    FROM web_sales ws
    JOIN date_dim d ON ws.ws_sold_date_sk = d.d_date_sk
    JOIN item i ON ws.ws_item_sk = i.i_item_sk
    WHERE ws.ws_bill_addr_sk IS NOT NULL
    UNION ALL
    SELECT
        'catalog' AS sales_channel,
        cs.cs_item_sk AS item_sk,
        cs.cs_warehouse_sk AS column_name,
        d.year AS year,
        d.quarter AS quarter,
        i.i_category AS item_category,
        cs.cs_sales_price AS sales_amount
    FROM catalog_sales cs
    JOIN date_dim d ON cs.cs_sold_date_sk = d.d_date_sk
    JOIN item i ON cs.cs_item_sk = i.i_item_sk
    WHERE cs.cs_warehouse_sk IS NOT NULL
) AS combined_data
GROUP BY sales_channel, column_name, year, quarter, item_category
ORDER BY sales_channel, column_name, year, quarter, item_category
LIMIT 100;
