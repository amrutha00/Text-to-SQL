SELECT
    store_name,
    store_id,
    SUM(CASE WHEN day_of_week = 'Sunday' THEN sales ELSE 0 END) AS Sunday_sales,
    SUM(CASE WHEN day_of_week = 'Monday' THEN sales ELSE 0 END) AS Monday_sales,
    SUM(CASE WHEN day_of_week = 'Tuesday' THEN sales ELSE 0 END) AS Tuesday_sales,
    SUM(CASE WHEN day_of_week = 'Wednesday' THEN sales ELSE 0 END) AS Wednesday_sales,
    SUM(CASE WHEN day_of_week = 'Thursday' THEN sales ELSE 0 END) AS Thursday_sales,
    SUM(CASE WHEN day_of_week = 'Friday' THEN sales ELSE 0 END) AS Friday_sales,
    SUM(CASE WHEN day_of_week = 'Saturday' THEN sales ELSE 0 END) AS Saturday_sales
FROM
    your_sales_table
WHERE
    date BETWEEN '2000-01-01' AND '2000-12-31'
    AND gmt_offset = -5
GROUP BY
    store_name, store_id
ORDER BY
    store_name, store_id, Sunday_sales, Monday_sales, Tuesday_sales, Wednesday_sales, Thursday_sales, Friday_sales, Saturday_sales
LIMIT 100;
