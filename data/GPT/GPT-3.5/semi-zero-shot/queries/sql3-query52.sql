SELECT
    year,
    brand,
    brand_id,
    SUM(extended_sales_price) AS total_extended_sales_price
FROM
    sales s
    JOIN time_dim t ON s.time_id = t.time_id
    JOIN item i ON s.item_id = i.item_id
    JOIN item_brand ib ON i.item_id = ib.item_id
WHERE
    t.year = 2002
    AND t.month = 12
    AND ib.brand_name = 'YourBrand' -- Replace 'YourBrand' with the specific brand you're interested in
GROUP BY
    year,
    brand,
    brand_id
ORDER BY
    year DESC,
    total_extended_sales_price DESC,
    brand_id
LIMIT 100;
