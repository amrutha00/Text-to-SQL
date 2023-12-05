SELECT d.d_year, d.d_moy, s.s_store_name, i.i_category, i.i_class, i.i_brand, 
SUM(ss.ss_sales_price) AS monthly_sales,
(SUM(ss.ss_sales_price) - (SUM(ss.ss_sales_price)/COUNT(DISTINCT d.d_moy))) AS difference_sales
FROM date_dim d
JOIN store_sales ss ON d.d_date_sk = ss.ss_sold_date_sk
JOIN item i ON i.i_item_sk = ss.ss_item_sk
JOIN store s ON s.s_store_sk = ss.ss_store_sk
WHERE d.d_year = 1999
GROUP BY d.d_year, d.d_moy, s.s_store_name, i.i_category, i.i_class, i.i_brand
HAVING SUM(ss.ss_sales_price) > (0.001 * (SELECT SUM(ss_sales_price) FROM store_sales WHERE d_year = 1999))
ORDER BY difference_sales DESC
LIMIT 100;