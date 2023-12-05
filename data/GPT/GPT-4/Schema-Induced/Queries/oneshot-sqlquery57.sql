SELECT 
    cc.cc_call_center_id AS call_center,
    i.i_brand AS brand,
    i.i_category AS category,
    EXTRACT(MONTH FROM ds.d_date) AS month,
    SUM(cs.cs_ext_sales_price) AS monthly_sales,
    AVG(SUM(cs.cs_ext_sales_price)) OVER (PARTITION BY cc.cc_call_center_id, i.i_brand, i.i_category, EXTRACT(MONTH FROM ds.d_date)) AS avg_monthly_sales,
    SUM(cs.cs_ext_sales_price) - AVG(SUM(cs.cs_ext_sales_price)) OVER (PARTITION BY cc.cc_call_center_id, i.i_brand, i.i_category, EXTRACT(MONTH FROM ds.d_date)) AS deviation_from_avg,
    LAG(SUM(cs.cs_ext_sales_price)) OVER (PARTITION BY cc.cc_call_center_id, i.i_brand, i.i_category ORDER BY ds.d_date) AS prev_month_sales,
    LAG(SUM(cs.cs_ext_sales_price)) OVER (PARTITION BY cc.cc_call_center_id, i.i_brand, i.i_category ORDER BY ds.d_date) - SUM(cs.cs_ext_sales_price) AS prev_month_deviation,
    LEAD(SUM(cs.cs_ext_sales_price)) OVER (PARTITION BY cc.cc_call_center_id, i.i_brand, i.i_category ORDER BY ds.d_date) AS next_month_sales,
    LEAD(SUM(cs.cs_ext_sales_price)) OVER (PARTITION BY cc.cc_call_center_id, i.i_brand, i.i_category ORDER BY ds.d_date) - SUM(cs.cs_ext_sales_price) AS next_month_deviation
FROM
    catalog_sales cs
JOIN
    date_dim ds ON cs.cs_sold_date_sk = ds.d_date_sk
JOIN
    call_center cc ON cs.cs_call_center_sk = cc.cc_call_center_sk
JOIN
    item i ON cs.cs_item_sk = i.i_item_sk
WHERE
    ds.d_year = 1999
GROUP BY
    cc.cc_call_center_id,
    i.i_brand,
    i.i_category,
    EXTRACT(MONTH FROM ds.d_date)
HAVING
    ABS(SUM(cs.cs_ext_sales_price) - AVG(SUM(cs.cs_ext_sales_price)) OVER (PARTITION BY cc.cc_call_center_id, i.i_brand, i.i_category, EXTRACT(MONTH FROM ds.d_date))) > 0.1 * AVG(SUM(cs.cs_ext_sales_price)) OVER (PARTITION BY cc.cc_call_center_id, i.i_brand, i.i_category, EXTRACT(MONTH FROM ds.d_date)))
ORDER BY
    deviation_from_avg DESC,
    call_center ASC
LIMIT 100;