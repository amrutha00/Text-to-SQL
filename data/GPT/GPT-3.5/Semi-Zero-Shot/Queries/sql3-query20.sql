SELECT
    i.item_id,
    i.item_desc,
    i.category,
    i.item_class,
    i.current_price,
    SUM(s.extended_price) AS total_revenue,
    SUM(s.extended_price) / SUM(SUM(s.extended_price)) OVER(PARTITION BY i.item_class) AS revenue_ratio
FROM
    item i
JOIN
    store_sales s ON i.item_id = s.item_id
JOIN
    date_dim dd ON s.ddatekey = dd.datekey
WHERE
    dd.d_date >= '2002-01-26' AND dd.d_date <= '2002-02-25'
    AND i.category IN ('Shoes', 'Books', 'Women')
GROUP BY
    i.item_id,
    i.item_desc,
    i.category,
    i.item_class,
    i.current_price
ORDER BY
    i.category ASC,
    i.item_class ASC,
    i.item_id ASC,
    i.item_desc ASC,
    revenue_ratio ASC
LIMIT 100;
