SELECT 
    p_brand_id AS "Brand ID",
    p_brand AS "Brand",
    EXTRACT(HOUR FROM ss_sold_time_sk) AS "Hour",
    EXTRACT(MINUTE FROM ss_sold_time_sk) AS "Minute",
    SUM(ss_ext_sales_price) AS "Sum of External Prices"
FROM
    store_sales
JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
JOIN product ON store_sales.ss_item_sk = product.p_product_sk
WHERE 
    (EXTRACT(HOUR FROM ss_sold_time_sk) BETWEEN 6 AND 11 OR EXTRACT(HOUR FROM ss_sold_time_sk) BETWEEN 17 AND 22) -- Breakfast or Dinner time
    AND EXTRACT(MONTH FROM d_date) = 12
    AND EXTRACT(YEAR FROM d_date) = 1998
    AND ss_sales_manager_sk = 1
GROUP BY 
    p_brand_id,
    p_brand,
    EXTRACT(HOUR FROM ss_sold_time_sk),
    EXTRACT(MINUTE FROM ss_sold_time_sk)
ORDER BY 
    "Sum of External Prices" DESC;
