WITH MonthlySales AS (
    SELECT
        ss_store_sk,
        d_month_seq,
        SUM(ss_sales_price) AS monthly_sales
    FROM store_sales
    JOIN date_dim ON ss_sold_date_sk = d_date_sk
    WHERE d_year = 2001
    GROUP BY ss_store_sk, d_month_seq
),

AvgSales AS (
    SELECT
        ss_store_sk,
        AVG(monthly_sales) AS avg_sales
    FROM MonthlySales
    GROUP BY ss_store_sk
),

SalesDeviation AS (
    SELECT
        ms.ss_store_sk,
        ms.d_month_seq,
        ms.monthly_sales,
        as.avg_sales,
        (ms.monthly_sales - as.avg_sales) / as.avg_sales * 100 AS deviation_percentage,
        LAG(ms.monthly_sales) OVER(PARTITION BY ms.ss_store_sk ORDER BY ms.d_month_seq) AS prev_month_sales,
        LEAD(ms.monthly_sales) OVER(PARTITION BY ms.ss_store_sk ORDER BY ms.d_month_seq) AS next_month_sales
    FROM MonthlySales ms
    JOIN AvgSales as ON ms.ss_store_sk = as.ss_store_sk
)

SELECT
    s.ss_store_sk,
    s.d_month_seq,
    i.i_brand_id,
    i.i_category_id,
    s.monthly_sales,
    s.avg_sales,
    s.deviation_percentage,
    s.prev_month_sales,
    s.next_month_sales
FROM SalesDeviation s
JOIN store_sales ss ON s.ss_store_sk = ss.ss_store_sk
JOIN item i ON ss.ss_item_sk = i.i_item_sk
WHERE ABS(s.deviation_percentage) > 10
ORDER BY s.deviation_percentage DESC, s.ss_store_sk
LIMIT 100;
