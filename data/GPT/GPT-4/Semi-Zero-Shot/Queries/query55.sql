SELECT
    i.brand_id,
    i.brand,
    SUM(ss_ext_sales_price) AS total_ext_sales_price
FROM
    store_sales ss
JOIN date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
JOIN store s ON ss.ss_store_sk = s.s_store_sk
JOIN item i ON ss.ss_item_sk = i.i_item_sk
WHERE
    d.d_year = 2000 AND
    d.d_month_seq IN (SELECT d_month_seq FROM date_dim WHERE d_month = 12 AND d_year = 2000) AND
    s.s_manager_id = 100
GROUP BY
    i.brand_id, i.brand
ORDER BY
    total_ext_sales_price DESC
LIMIT 100;
