SELECT
    s.store_name,
    s.store_zip,
    s.billing_street_number,
    s.billing_street_name,
    s.shipping_street_number,
    s.shipping_street_name,
    s.city,
    s.store_zip,
    p.product_name,
    2001 AS sales_year,
    SUM(CASE WHEN i1.item_id IS NOT NULL THEN 1 ELSE 0 END) AS cross_sale_items_2001,
    SUM(CASE WHEN i2.item_id IS NOT NULL THEN 1 ELSE 0 END) AS cross_sale_items_2002,
    SUM(CASE WHEN i2.item_id IS NOT NULL THEN 1 ELSE 0 END) - SUM(CASE WHEN i1.item_id IS NOT NULL THEN 1 ELSE 0 END) AS item_count_in_second_year,
    MIN(CASE WHEN i1.item_id IS NOT NULL THEN i1.wholesale_cost END) AS wholesale_cost_2001,
    MIN(CASE WHEN i2.item_id IS NOT NULL THEN i2.wholesale_cost END) AS wholesale_cost_2002
FROM
    store s
JOIN
    product p ON s.store_id = p.store_id
LEFT JOIN
    item i1 ON p.product_id = i1.product_id AND i1.sales_year = 2001
LEFT JOIN
    item i2 ON p.product_id = i2.product_id AND i2.sales_year = 2002
WHERE
    i1.sales_year = 2001
    AND i2.sales_year = 2002
    AND (i1.sales_channel = 'Internet' OR i1.sales_channel = 'Catalog' OR i1.sales_channel = 'Store')
    AND (i2.sales_channel = 'Internet' OR i2.sales_channel = 'Catalog' OR i2.sales_channel = 'Store')
GROUP BY
    s.store_name,
    s.store_zip,
    s.billing_street_number,
    s.billing_street_name,
    s.shipping_street_number,
    s.shipping_street_name,
    s.city,
    s.store_zip,
    p.product_name
ORDER BY
    p.product_name,
    s.store_name,
    item_count_in_second_year,
    wholesale_cost_2001,
    wholesale_cost_2002;
