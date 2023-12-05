SELECT 
    s_store_id,
    s_company_name,
    i_brand,
    i_category,
    DATE_TRUNC('month', d_date) AS month,
    ss_ext_sales_price AS monthly_sales,
    (ss_ext_sales_price - AVG(ss_ext_sales_price) OVER (PARTITION BY s_store_sk, i_brand, i_category, DATE_TRUNC('month', d_date))) / AVG(ss_ext_sales_price) OVER (PARTITION BY s_store_sk, i_brand, i_category, DATE_TRUNC('month', d_date))) AS deviation,
    LAG((ss_ext_sales_price - AVG(ss_ext_sales_price) OVER (PARTITION BY s_store_sk, i_brand, i_category, DATE_TRUNC('month', d_date))) / AVG(ss_ext_sales_price) OVER (PARTITION BY s_store_sk, i_brand, i_category, DATE_TRUNC('month', d_date))), 1, NULL) OVER (PARTITION BY s_store_sk, i_brand, i_category ORDER BY DATE_TRUNC('month', d_date)) AS prev_deviation,
    LEAD((ss_ext_sales_price - AVG(ss_ext_sales_price) OVER (PARTITION BY s_store_sk, i_brand, i_category, DATE_TRUNC('month', d_date))) / AVG(ss_ext_sales_price) OVER (PARTITION BY s_store_sk, i_brand, i_category, DATE_TRUNC('month', d_date))), 1, NULL) OVER (PARTITION BY s_store_sk, i_brand, i_category ORDER BY DATE_TRUNC('month', d_date)) AS next_deviation
FROM
    store_sales
JOIN
    item ON store_sales.ss_item_sk = item.i_item_sk
JOIN
    store ON store_sales.ss_store_sk = store.s_store_sk
JOIN
    warehouse ON store.s_store_id = warehouse.w_warehouse_id
JOIN
    date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
WHERE
    d_year = 2001
GROUP BY
    s_store_id,
    s_company_name,
    i_brand,
    i_category,
    month,
    ss_ext_sales_price
HAVING
    ABS((ss_ext_sales_price - AVG(ss_ext_sales_price) OVER (PARTITION BY s_store_sk, i_brand, i_category, DATE_TRUNC('month', d_date))) / AVG(ss_ext_sales_price) OVER (PARTITION BY s_store_sk, i_brand, i_category, DATE_TRUNC('month', d_date)))) > 0.1
ORDER BY
    deviation DESC,
    s_store_id
LIMIT 100;