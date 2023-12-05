WITH SalesAggregated AS (
    SELECT
        d_year,
        i_brand,
        i_class,
        i_category,
        i_manufacturer,
        SUM(cs_sales_count) AS sales_cnt,
        SUM(cs_sales_amount) AS sales_amt
    FROM catalog_sales
    JOIN date_dim ON cs_sold_date_sk = d_date_sk
    JOIN item ON cs_item_sk = i_item_sk
    WHERE i_category = 'Home' AND (d_year = 1998 OR d_year = 1999)
    GROUP BY d_year, i_brand, i_class, i_category, i_manufacturer
    UNION ALL
    SELECT
        d_year,
        i_brand,
        i_class,
        i_category,
        i_manufacturer,
        SUM(ss_sales_count) AS sales_cnt,
        SUM(ss_sales_amount) AS sales_amt
    FROM store_sales
    JOIN date_dim ON ss_sold_date_sk = d_date_sk
    JOIN item ON ss_item_sk = i_item_sk
    WHERE i_category = 'Home' AND (d_year = 1998 OR d_year = 1999)
    GROUP BY d_year, i_brand, i_class, i_category, i_manufacturer
    UNION ALL
    SELECT
        d_year,
        i_brand,
        i_class,
        i_category,
        i_manufacturer,
        SUM(ws_sales_count) AS sales_cnt,
        SUM(ws_sales_amount) AS sales_amt
    FROM web_sales
    JOIN date_dim ON ws_sold_date_sk = d_date_sk
    JOIN item ON ws_item_sk = i_item_sk
    WHERE i_category = 'Home' AND (d_year = 1998 OR d_year = 1999)
    GROUP BY d_year, i_brand, i_class, i_category, i_manufacturer
),
SalesComparison AS (
    SELECT
        curr.sales_cnt AS curr_sales_cnt,
        prev.sales_cnt AS prev_sales_cnt,
        curr.sales_amt AS curr_sales_amt,
        prev.sales_amt AS prev_sales_amt,
        curr.i_brand,
        curr.i_class,
        curr.i_category,
        curr.i_manufacturer
    FROM SalesAggregated curr
    JOIN SalesAggregated prev ON curr.i_brand = prev.i_brand
        AND curr.i_class = prev.i_class
        AND curr.i_category = prev.i_category
        AND curr.i_manufacturer = prev.i_manufacturer
        AND curr.d_year = 1999
        AND prev.d_year = 1998
)
SELECT
    i_brand,
    i_class,
    i_category,
    i_manufacturer,
    curr_sales_cnt,
    prev_sales_cnt,
    curr_sales_amt,
    prev_sales_amt,
    (curr_sales_cnt - prev_sales_cnt) AS sales_cnt_diff,
    (curr_sales_amt - prev_sales_amt) AS sales_amt_diff
FROM SalesComparison
WHERE CAST(curr_sales_cnt AS DECIMAL(17,2)) / CAST(prev_sales_cnt AS DECIMAL(17,2)) < 0.9
ORDER BY sales_cnt_diff ASC, sales_amt_diff ASC
LIMIT 100;
