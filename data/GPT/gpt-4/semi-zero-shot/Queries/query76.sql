WITH CombinedSales AS (
    SELECT
        'store' AS channel,
        ss_hdemo_sk AS key_column,
        d.d_year,
        d.d_qoy AS quarter,
        i.i_category,
        1 AS sales_count,
        ss_sales_price AS sales_amount
    FROM store_sales s
    JOIN date_dim d ON s.ss_sold_date_sk = d.d_date_sk
    JOIN item i ON s.ss_item_sk = i.i_item_sk
    WHERE ss_hdemo_sk IS NOT NULL

    UNION ALL

    SELECT
        'web' AS channel,
        ws_bill_addr_sk AS key_column,
        d.d_year,
        d.d_qoy AS quarter,
        i.i_category,
        1 AS sales_count,
        ws_sales_price AS sales_amount
    FROM web_sales w
    JOIN date_dim d ON w.ws_sold_date_sk = d.d_date_sk
    JOIN item i ON w.ws_item_sk = i.i_item_sk
    WHERE ws_bill_addr_sk IS NOT NULL

    UNION ALL

    SELECT
        'catalog' AS channel,
        cs_warehouse_sk AS key_column,
        d.d_year,
        d.d_qoy AS quarter,
        i.i_category,
        1 AS sales_count,
        cs_sales_price AS sales_amount
    FROM catalog_sales c
    JOIN date_dim d ON c.cs_sold_date_sk = d.d_date_sk
    JOIN item i ON c.cs_item_sk = i.i_item_sk
    WHERE cs_warehouse_sk IS NOT NULL
)

SELECT
    channel,
    key_column,
    d_year AS year,
    quarter,
    i_category AS item_category,
    SUM(sales_count) AS total_sales_count,
    SUM(sales_amount) AS total_sales_amount
FROM CombinedSales
GROUP BY channel, key_column, year, quarter, item_category
ORDER BY channel, key_column, year, quarter, item_category
LIMIT 100;
