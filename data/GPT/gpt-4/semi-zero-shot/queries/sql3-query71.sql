SELECT
    p_brand_id AS brand_id,
    p_brand AS brand,
    EXTRACT(HOUR FROM s_sold_time) AS hour,
    EXTRACT(MINUTE FROM s_sold_time) AS minute,
    SUM(s_ext_price) AS total_external_price
FROM
    date_dim,
    store_sales,
    product
WHERE
    date_dim.d_year = 1998
    AND date_dim.d_moy = 12
    AND (
        (date_dim.d_date_sk = store_sales.s_sold_date_sk
        AND (store_sales.s_net_profit > 0)
        AND (date_dim.d_day_name = 'Saturday' OR date_dim.d_day_name = 'Sunday')
        AND (date_dim.d_holiday = 'Y' OR date_dim.d_weekend = 'Y'))
    )
    AND (store_sales.s_product_id = product.p_product_sk)
    AND (product.p_manager_id = 1)
GROUP BY
    brand_id,
    brand,
    hour,
    minute
ORDER BY
    total_external_price DESC;
