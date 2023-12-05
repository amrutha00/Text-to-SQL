SELECT
    i.item_id,
    SUM(s.sales_price) AS total_sales_amount
FROM
    date_dim d
JOIN
    sales s ON d.date_id = s.date_id
JOIN
    item i ON s.item_id = i.item_id
JOIN
    customer c ON s.customer_id = c.customer_id
WHERE
    EXTRACT(YEAR FROM d.the_date) = 2000
    AND EXTRACT(MONTH FROM d.the_date) = 2
    AND c.time_zone = -6
    AND i.item_color IN ('color1', 'color2', 'color3')
GROUP BY
    i.item_id
ORDER BY
    total_sales_amount DESC
LIMIT 100;
