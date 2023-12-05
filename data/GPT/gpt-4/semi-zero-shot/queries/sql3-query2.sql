WITH sales_data AS (
    SELECT
        TO_CHAR(sale_date, 'YYYY') AS year,
        TO_CHAR(sale_date, 'D') AS day_of_week,
        week_sequence,
        SUM(CASE WHEN source = 'web' THEN amount ELSE 0 END) AS web_sales,
        SUM(CASE WHEN source = 'catalog' THEN amount ELSE 0 END) AS catalog_sales
    FROM
        (
            SELECT sale_date, amount, 'web' AS source, week_sequence
            FROM web_sales
            UNION ALL
            SELECT sale_date, amount, 'catalog' AS source, week_sequence
            FROM catalog_sales
        ) merged_data
    GROUP BY year, day_of_week, week_sequence
)

SELECT
    week_sequence,
    year AS current_year,
    day_of_week,
    (web_sales - LAG(web_sales) OVER (PARTITION BY day_of_week, week_sequence ORDER BY year)) / LAG(web_sales) OVER (PARTITION BY day_of_week, week_sequence ORDER BY year) AS web_sales_increase_ratio,
    (catalog_sales - LAG(catalog_sales) OVER (PARTITION BY day_of_week, week_sequence ORDER BY year)) / LAG(catalog_sales) OVER (PARTITION BY day_of_week, week_sequence ORDER BY year) AS catalog_sales_increase_ratio
FROM
    sales_data
ORDER BY
    week_sequence, year, day_of_week;
