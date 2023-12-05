SELECT
    EXTRACT(YEAR FROM c_date) AS year,
    i_brand,
    i_brand_id,
    SUM(ss_ext_sales_price) AS total_extended_sales_price
FROM
    store_sales
JOIN
    date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
JOIN
    item ON store_sales.ss_item_sk = item.i_item_sk
WHERE
    EXTRACT(YEAR FROM c_date) = 2002
    AND EXTRACT(MONTH FROM c_date) = 12
    AND i_brand IS NOT NULL
GROUP BY
    EXTRACT(YEAR FROM c_date),
    i_brand,
    i_brand_id
ORDER BY
    EXTRACT(YEAR FROM c_date) DESC,
    total_extended_sales_price DESC,
    i_brand_id
LIMIT 100;
