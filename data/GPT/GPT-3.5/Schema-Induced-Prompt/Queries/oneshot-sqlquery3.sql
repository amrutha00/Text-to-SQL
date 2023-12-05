SELECT
    d_year,
    i_brand,
    i_brand_id,
    SUM(ss_ext_sales_price) AS total_extended_sales_price
FROM
    date_dim
JOIN
    store_sales ON date_dim.d_date_sk = store_sales.ss_sold_date_sk
JOIN
    item ON item.i_item_sk = store_sales.ss_item_sk
WHERE
    date_dim.d_year = specific_year
    AND date_dim.d_moy = 11
    AND item.i_manufact_id = 816
GROUP BY
    d_year,
    i_brand,
    i_brand_id
ORDER BY
    d_year DESC,
    total_extended_sales_price DESC
LIMIT 100;
