SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM (
    SELECT customer_id
    FROM store_sales ss
    JOIN time_dim ts ON ss.time_id = ts.time_id
    WHERE ts.the_month >= 1184 AND ts.the_month <= 1195
    UNION
    SELECT customer_id
    FROM web_sales ws
    JOIN time_dim tw ON ws.time_id = tw.time_id
    WHERE tw.the_month >= 1184 AND tw.the_month <= 1195
    UNION
    SELECT customer_id
    FROM catalog_sales cs
    JOIN time_dim tc ON cs.time_id = tc.time_id
    WHERE tc.the_month >= 1184 AND tc.the_month <= 1195
) AS combined_sales;
