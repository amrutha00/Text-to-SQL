SELECT
    i.item_id AS item_id,
    i.item_desc AS item_description,
    i.category AS item_category,
    i.item_class AS item_class,
    i.current_price AS item_current_price,
    SUM(s.sales_price) AS total_sales_revenue,
    SUM(s.sales_price) / SUM(SUM(s.sales_price)) OVER (PARTITION BY i.item_class) AS revenue_ratio_within_class
FROM
    item i
JOIN
    sales s ON i.item_id = s.item_id
WHERE
    s.sale_date BETWEEN '2002-05-20' AND '2002-06-19'
    AND i.category IN ('Sports', 'Music', 'Shoes')
GROUP BY
    i.item_id,
    i.item_desc,
    i.category,
    i.item_class,
    i.current_price
ORDER BY
    i.category,
    i.item_class,
    i.item_id,
    i.item_desc,
    revenue_ratio_within_class;
