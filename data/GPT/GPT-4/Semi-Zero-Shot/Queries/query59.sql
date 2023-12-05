WITH YearlySales AS (
    SELECT 
        s_store_name,
        s_store_id,
        d_week_seq,
        d_dow,
        SUM(ss_sales_price) AS total_sales
    FROM 
        store_sales 
    JOIN 
        date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
    JOIN 
        store ON store_sales.ss_store_sk = store.s_store_sk
    WHERE 
        d_year IN (1196, 1197)
    GROUP BY 
        s_store_name,
        s_store_id,
        d_week_seq,
        d_dow
),
SalesDifference AS (
    SELECT 
        ys1.s_store_name,
        ys1.s_store_id,
        ys1.d_week_seq,
        CASE 
            WHEN ys1.d_dow = 1 THEN 'Sunday'
            WHEN ys1.d_dow = 2 THEN 'Monday'
            WHEN ys1.d_dow = 3 THEN 'Tuesday'
            WHEN ys1.d_dow = 4 THEN 'Wednesday'
            WHEN ys1.d_dow = 5 THEN 'Thursday'
            WHEN ys1.d_dow = 6 THEN 'Friday'
            ELSE 'Saturday'
        END AS day_of_week,
        ys1.total_sales AS sales_1196,
        ys2.total_sales AS sales_1197,
        ys2.total_sales - ys1.total_sales AS sales_difference
    FROM 
        YearlySales ys1
    JOIN 
        YearlySales ys2 ON ys1.s_store_id = ys2.s_store_id 
                        AND ys1.d_week_seq = ys2.d_week_seq
                        AND ys1.d_dow = ys2.d_dow
    WHERE 
        ys1.d_year = 1196 AND ys2.d_year = 1197
)
SELECT 
    s_store_name,
    s_store_id,
    d_week_seq,
    day_of_week,
    sales_difference
FROM 
    SalesDifference
ORDER BY 
    sales_difference DESC
LIMIT 
    100;
