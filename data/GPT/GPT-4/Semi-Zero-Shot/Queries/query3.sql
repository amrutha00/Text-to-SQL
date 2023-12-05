SELECT 
    d_year,
    i_brand,
    i_brand_id,
    SUM(ss_ext_sales_price) AS total_sales_price
FROM 
    store_sales
JOIN 
    date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
JOIN 
    item ON store_sales.ss_item_sk = item.i_item_sk
WHERE 
    i_manufacturer_id = 816 
    AND d_moy = 11
GROUP BY 
    d_year,
    i_brand,
    i_brand_id
ORDER BY 
    d_year DESC,
    total_sales_price DESC
LIMIT 100;
