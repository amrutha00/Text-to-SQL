WITH TotalYearlySales AS (
    SELECT 
        SUM(ss_net_paid) AS yearly_sales 
    FROM 
        store_sales
    JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
    WHERE 
        d_year = 1999
),
MonthlySales AS (
    SELECT 
        d_month_seq,
        i_category,
        i_class,
        i_brand,
        SUM(ss_net_paid) AS monthly_sales,
        yearly_sales
    FROM 
        store_sales
    JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
    JOIN item ON store_sales.ss_item_sk = item.i_item_sk
    JOIN TotalYearlySales ON 1=1
    WHERE 
        d_year = 1999
    GROUP BY 
        d_month_seq, i_category, i_class, i_brand, yearly_sales
),
FilteredSales AS (
    SELECT 
        d_month_seq,
        i_category,
        i_class,
        i_brand,
        monthly_sales,
        yearly_sales
    FROM 
        MonthlySales
    WHERE 
        monthly_sales > 0.001 * yearly_sales
)
SELECT 
    date_dim.d_month_seq,
    fs.i_category,
    fs.i_class,
    fs.i_brand,
    fs.monthly_sales,
    store.s_store_name,
    (fs.monthly_sales - (fs.yearly_sales / 12)) AS sales_difference
FROM 
    FilteredSales fs
JOIN date_dim ON fs.d_month_seq = date_dim.d_month_seq
JOIN store_sales ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
JOIN store ON store_sales.ss_store_sk = store.s_store_sk
ORDER BY 
    sales_difference DESC
LIMIT 100;
