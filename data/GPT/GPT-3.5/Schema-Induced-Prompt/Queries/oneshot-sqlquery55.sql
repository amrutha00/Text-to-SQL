SELECT i_brand_id, i_brand, SUM(ss_ext_sales_price) AS total_sales
FROM store_sales
JOIN item ON ss_item_sk = i_item_sk
WHERE ss_sold_date_sk IN (
    SELECT d_date_sk
    FROM date_dim
    WHERE d_year = 2000 AND d_month_seq = 119 AND d_manager_id = 100
)
GROUP BY i_brand_id, i_brand
ORDER BY total_sales DESC
LIMIT 100;