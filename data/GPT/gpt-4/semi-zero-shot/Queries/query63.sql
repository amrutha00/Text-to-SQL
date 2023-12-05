WITH MonthlySales AS (
    SELECT 
        s_store.s_manager_id,
        d_date.d_moy,
        SUM(ss_ext_sales_price) AS sum_sales
    FROM 
        store_sales
    JOIN item ON store_sales.ss_item_sk = item.i_item_sk
    JOIN date_dim AS d_date ON store_sales.ss_sold_date_sk = d_date.d_date_sk
    JOIN store AS s_store ON store_sales.ss_store_sk = s_store.s_store_sk
    WHERE 
        (
            i_category IN ('Books', 'Children', 'Electronics')
            AND i_class IN ('personal', 'portable', 'reference', 'self-help')
            AND i_brand IN ('scholaramalgamalg #14', 'scholaramalgamalg #7', 'exportiunivamalg #9', 'scholaramalgamalg #9')
        )
        OR 
        (
            i_category IN ('Women', 'Music', 'Men')
            AND i_class IN ('accessories', 'classical', 'fragrances', 'pants')
            AND i_brand IN ('amalgimporto #1', 'edu packscholar #1', 'exportiimporto #1', 'importoamalg #1')
        )
        AND EXTRACT(YEAR FROM d_date.d_date) = 'YOUR SPECIFIC YEAR HERE'
    GROUP BY 
        s_store.s_manager_id,
        d_date.d_moy
)

SELECT 
    s_manager_id,
    d_moy,
    sum_sales,
    AVG(sum_sales) OVER (PARTITION BY s_manager_id) AS avg_monthly_sales
FROM 
    MonthlySales
WHERE 
    avg_monthly_sales > 0 
    AND ABS(sum_sales - avg_monthly_sales)/avg_monthly_sales > 0.10
ORDER BY 
    s_manager_id,
    avg_monthly_sales DESC,
    sum_sales DESC
LIMIT 100;
