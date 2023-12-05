SELECT 
    i_brand_id,
    i_brand,
    EXTRACT(HOUR FROM COALESCE(t_hour,0)) AS hour,
    EXTRACT(MINUTE FROM COALESCE(t_minute,0)) AS minute,
    SUM(CASE
            WHEN ((d_moy = 12) AND (d_year = 1998)) AND
                ((t_meal_time = 'Breakfast') OR (t_meal_time = 'Dinner')) THEN
                COALESCE(ws_ext_sales_price,0) +
                COALESCE(cs_ext_sales_price,0) +
                COALESCE(ss_ext_sales_price,0)
            ELSE 0
        END) AS total_external_price
FROM
    item
JOIN
    web_sales ON ws_item_sk = i_item_id
JOIN
    catalog_sales ON cs_item_sk = i_item_id
JOIN
    store_sales ON ss_item_sk = i_item_id
JOIN
    date_dim ON (ws_sold_date_sk = d_date_sk) AND (cs_sold_date_sk = d_date_sk) AND (ss_sold_date_sk = d_date_sk)
JOIN
    time_dim ON (ws_sold_time_sk = t_time_sk) AND (cs_sold_time_sk = t_time_sk) AND (ss_sold_time_sk = t_time_sk)
WHERE
    i_manager_id = 1
GROUP BY
    i_brand_id,
    i_brand,
    hour,
    minute
ORDER BY
    total_external_price DESC