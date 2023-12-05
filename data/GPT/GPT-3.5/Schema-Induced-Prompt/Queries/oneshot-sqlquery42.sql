SELECT date_dim.d_year, item.i_category_id, item.i_category, 
       SUM(store_sales.ss_ext_sales_price) AS total_extended_sales_price
FROM date_dim
JOIN store_sales ON date_dim.d_year = 2002 AND date_dim.d_moy = 11 
                 AND store_sales.ss_ext_sales_price IS NOT NULL
JOIN item ON item.i_category_id = 1
GROUP BY date_dim.d_year, item.i_category_id, item.i_category
ORDER BY total_extended_sales_price DESC
LIMIT 100;