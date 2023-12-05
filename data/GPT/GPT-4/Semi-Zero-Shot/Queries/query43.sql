WITH DaywiseSales AS (
    SELECT
        s.s_store_name AS store_name,
        s.s_store_id AS store_id,
        d.d_day_name AS day_name,
        SUM(ss.ss_sales_price) AS total_sales
    FROM store_sales ss
    JOIN store s ON ss.ss_store_sk = s.s_store_sk
    JOIN date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
    WHERE d.d_year = 2000
    AND s.s_gmt_offset = -5
    GROUP BY s.s_store_name, s.s_store_id, d.d_day_name
)

SELECT
    store_name,
    store_id,
    COALESCE(SUM(CASE WHEN day_name = 'Sunday' THEN total_sales END), 0) AS Sunday_sales,
    COALESCE(SUM(CASE WHEN day_name = 'Monday' THEN total_sales END), 0) AS Monday_sales,
    COALESCE(SUM(CASE WHEN day_name = 'Tuesday' THEN total_sales END), 0) AS Tuesday_sales,
    COALESCE(SUM(CASE WHEN day_name = 'Wednesday' THEN total_sales END), 0) AS Wednesday_sales,
    COALESCE(SUM(CASE WHEN day_name = 'Thursday' THEN total_sales END), 0) AS Thursday_sales,
    COALESCE(SUM(CASE WHEN day_name = 'Friday' THEN total_sales END), 0) AS Friday_sales,
    COALESCE(SUM(CASE WHEN day_name = 'Saturday' THEN total_sales END), 0) AS Saturday_sales
FROM DaywiseSales
GROUP BY store_name, store_id
ORDER BY store_name, store_id, Sunday_sales, Monday_sales, Tuesday_sales, Wednesday_sales, Thursday_sales, Friday_sales, Saturday_sales
LIMIT 100;
