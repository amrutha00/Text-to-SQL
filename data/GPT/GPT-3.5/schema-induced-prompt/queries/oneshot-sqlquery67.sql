WITH category_sales AS (
    SELECT i.i_category, 
           i.i_class, 
           i.i_brand, 
           i.i_product_name, 
           EXTRACT(YEAR FROM d.d_date) AS year, 
           EXTRACT(QUARTER FROM d.d_date) AS quarter, 
           EXTRACT(MONTH FROM d.d_date) AS month, 
           ss.ss_store_id, 
           SUM(ss.ss_ext_sales_price) AS total_sales,
           ROW_NUMBER() OVER(PARTITION BY i.i_category, d.d_date, ss.ss_store_id ORDER BY SUM(ss.ss_ext_sales_price) DESC) AS store_rank
    FROM store_sales ss
    JOIN date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
    JOIN item i ON ss.ss_item_sk = i.i_item_sk
    WHERE EXTRACT(YEAR FROM d.d_date) = 1206
    GROUP BY i.i_category, i.i_class, i.i_brand, i.i_product_name, year, quarter, month, ss.ss_store_id
)
SELECT cs.i_category, 
       cs.i_class, 
       cs.i_brand, 
       cs.i_product_name, 
       cs.year, 
       cs.quarter, 
       cs.month, 
       cs.ss_store_id, 
       cs.total_sales,
       cs.store_rank
FROM category_sales cs
WHERE cs.store_rank <= 100
ORDER BY cs.i_category, cs.total_sales DESC, cs.store_rank
LIMIT 100;