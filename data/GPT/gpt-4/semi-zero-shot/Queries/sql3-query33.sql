SELECT
    m.manufacturer_id,
    SUM(
        CASE
            WHEN s.channel = 'store' THEN s.extended_price
            WHEN s.channel = 'catalog' THEN s.extended_price
            WHEN s.channel = 'web' THEN s.extended_price
            ELSE 0
        END
    ) AS total_monthly_sales
FROM
    store_sales s
JOIN
    date_dim d ON s.date_id = d.date_id
JOIN
    manufacturer m ON s.manufacturer_id = m.manufacturer_id
WHERE
    d.the_year = 2002
    AND d.the_month = 1
    AND d.time_zone = -5
    AND m.category = 'Home'
GROUP BY
    m.manufacturer_id
ORDER BY
    total_monthly_sales DESC
LIMIT 100;
