WITH MonthlySales AS (
    SELECT
        ts.the_year,
        ts.the_month,
        s.s_store_name AS store_name,
        i.icategory AS item_category,
        i.iclass AS item_class,
        i.ibrand AS item_brand,
        SUM(ss.ss_sales_price) AS monthly_sales
    FROM
        store_sales ss
    JOIN
        time_dim ts ON ss.t_time_id = ts.time_id
    JOIN
        item i ON ss.i_item_sk = i.i_item_sk
    JOIN
        store s ON ss.ss_store_sk = s.s_store_sk
    WHERE
        ts.the_year = 1999
    GROUP BY
        ts.the_year, ts.the_month, s.s_store_name, i.icategory, i.iclass, i.ibrand
),
YearlySales AS (
    SELECT
        ts.the_year,
        SUM(ss.ss_sales_price) AS total_yearly_sales
    FROM
        store_sales ss
    JOIN
        time_dim ts ON ss.t_time_id = ts.time_id
    WHERE
        ts.the_year = 1999
    GROUP BY
        ts.the_year
)
SELECT
    MS.the_month,
    MS.store_name,
    MS.item_category,
    MS.item_class,
    MS.item_brand,
    MS.monthly_sales,
    YS.total_yearly_sales,
    AVG(MS.monthly_sales) OVER (PARTITION BY MS.the_month) AS avg_monthly_sales,
    MS.monthly_sales - AVG(MS.monthly_sales) OVER (PARTITION BY MS.the_month) AS sales_difference
FROM
    MonthlySales MS
JOIN
    YearlySales YS ON MS.the_year = YS.the_year
WHERE
    MS.monthly_sales > 0.001 * YS.total_yearly_sales -- Exceeding 0.1% threshold
ORDER BY
    sales_difference DESC
LIMIT 100;
