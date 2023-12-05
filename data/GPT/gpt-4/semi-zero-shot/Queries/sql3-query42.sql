SELECT
    d.d_year,
    i.i_category_id,
    i.i_category,
    SUM(ss.ss_ext_sales_price) AS total_extended_sales_price
FROM
    date_dim AS d
JOIN
    store_sales AS ss ON d.d_date_sk = ss.ss_sold_date_sk
JOIN
    item AS i ON ss.ss_item_sk = i.i_item_id
WHERE
    d.d_year = 2002
    AND d.d_month = 11
    AND i.i_category_id = 1
GROUP BY
    d.d_year,
    i.i_category_id,
    i.i_category
ORDER BY
    total_extended_sales_price DESC
LIMIT 100;
