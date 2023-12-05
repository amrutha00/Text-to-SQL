SELECT i_brand_id, i_brand, i_manufact_id, i_manufact, SUM(ss_ext_sales_price) AS ext_price
FROM store_sales ss
JOIN item i ON ss.ss_item_sk = i.i_item_sk
JOIN customer c ON ss.ss_customer_sk = c.c_customer_sk
JOIN store s ON ss.ss_store_sk = s.s_store_sk
WHERE c.c_birth_country <> 'USA'
  AND c.c_birth_month = 11
  AND c.c_birth_year = 1998
  AND s.s_manager = 'MANAGER.01'
  AND i.i_rec_start_date <= '1998-11-30'
  AND (i.i_rec_end_date IS NULL OR i.i_rec_end_date > '1998-11-30')
GROUP BY i_brand_id, i_brand, i_manufact_id, i_manufact
ORDER BY ext_price DESC
LIMIT 100;