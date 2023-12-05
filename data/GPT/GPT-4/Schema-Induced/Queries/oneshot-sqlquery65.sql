SELECT s.s_store_name, i.i_item_desc, (ss.ss_ext_sales_price - ss.ss_ext_discount_amt) AS revenue,
i.i_current_price, i.i_wholesale_cost, i.i_brand, d.d_month_seq
FROM store s
JOIN store_sales ss ON s.s_store_sk = ss.ss_store_sk
JOIN item i ON ss.ss_item_sk = i.i_item_sk
JOIN date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
WHERE d.d_month_seq BETWEEN 1221 AND (1221 + 11)
AND (ss.ss_ext_sales_price - ss.ss_ext_discount_amt) < 0.1 * (
SELECT AVG(ss1.ss_ext_sales_price - ss1.ss_ext_discount_amt)
FROM store_sales ss1
JOIN item i1 ON ss1.ss_item_sk = i1.i_item_sk
WHERE i1.i_item_sk = i.i_item_sk
AND s.s_store_sk = s.s_store_sk
)
ORDER BY s.s_store_name, i.i_item_desc
LIMIT 100;