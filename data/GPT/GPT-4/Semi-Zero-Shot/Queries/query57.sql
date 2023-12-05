WITH MonthlySales AS (
    SELECT
        i_brand,
        i_category,
        cc_call_center_id,
        SUM(ss_net_paid) AS monthly_sales,
        DATE_TRUNC('month', ss_sold_date_sk) AS sales_month
    FROM
        store_sales
    JOIN item ON store_sales.ss_item_sk = item.i_item_sk
    JOIN call_center ON store_sales.ss_call_center_sk = call_center.cc_call_center_sk
    WHERE
        EXTRACT(YEAR FROM DATE(ss_sold_date_sk)) = 1999
    GROUP BY 
        i_brand, 
        i_category,
        cc_call_center_id,
        DATE_TRUNC('month', ss_sold_date_sk)
),
AverageMonthlySales AS (
    SELECT
        i_brand,
        i_category,
        cc_call_center_id,
        AVG(monthly_sales) AS avg_monthly_sales
    FROM
        MonthlySales
    GROUP BY 
        i_brand, 
        i_category,
        cc_call_center_id
)
SELECT
    ms.i_brand,
    ms.i_category,
    ms.cc_call_center_id,
    ms.sales_month,
    ms.monthly_sales,
    ams.avg_monthly_sales,
    LAG(ms.monthly_sales) OVER(PARTITION BY ms.i_brand, ms.i_category, ms.cc_call_center_id ORDER BY ms.sales_month) AS preceding_month_sales,
    LEAD(ms.monthly_sales) OVER(PARTITION BY ms.i_brand, ms.i_category, ms.cc_call_center_id ORDER BY ms.sales_month) AS following_month_sales,
    ABS(ms.monthly_sales - ams.avg_monthly_sales) / ams.avg_monthly_sales * 100 AS sales_deviation_percentage
FROM
    MonthlySales ms
JOIN
    AverageMonthlySales ams ON ms.i_brand = ams.i_brand AND ms.i_category = ams.i_category AND ms.cc_call_center_id = ams.cc_call_center_id
WHERE
    ABS(ms.monthly_sales - ams.avg_monthly_sales) / ams.avg_monthly_sales > 0.10
ORDER BY 
    sales_deviation_percentage DESC,
    ms.cc_call_center_id
LIMIT 100;
