SELECT
    brand_id,
    brand_name,
    SUM(external_sales_price) AS total_external_sales
FROM
    store_sales,
    store,
    time_dim,
    item
WHERE
    store_sales.date_key = time_dim.time_key
    AND store_sales.store_key = store.store_key
    AND store_sales.item_key = item.item_key
    AND time_dim.the_year = 2000
    AND time_dim.the_month = 12
    AND store.store_manager = 100
GROUP BY
    brand_id, brand_name
ORDER BY
    total_external_sales DESC
LIMIT 100;
