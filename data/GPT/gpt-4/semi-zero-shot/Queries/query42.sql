SELECT 
    EXTRACT(YEAR FROM s_sold_date) AS year,
    i_category_id,
    i_category,
    SUM(ss_ext_sales_price) AS total_sales
FROM 
    store_sales
JOIN 
    date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
JOIN 
    item ON store_sales.ss_item_sk = item.i_item_sk
WHERE 
    EXTRACT(YEAR FROM d_date) = 2002 
    AND EXTRACT(MONTH FROM d_date) = 11 
    AND i_category_id = 1
GROUP BY 
    EXTRACT(YEAR FROM s_sold_date),
    i_category_id,
    i_category
ORDER BY 
    total_sales DESC
LIMIT 100;
