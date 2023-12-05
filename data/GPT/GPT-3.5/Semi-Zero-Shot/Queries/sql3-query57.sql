SELECT
    ic.brand_name,
    ic.category_name,
    ss.call_center_id,
    ss.year,
    ss.month,
    ss.sales_amount,
    (ss.sales_amount - AVG(ss.sales_amount) OVER (PARTITION BY ss.call_center_id, ss.year, ss.month)) / AVG(ss.sales_amount) OVER (PARTITION BY ss.call_center_id, ss.year, ss.month) AS sales_deviation,
    LAG(ss.sales_amount, 1, NULL) OVER (PARTITION BY ss.call_center_id, ss.year ORDER BY ss.month) AS prev_month_sales,
    LEAD(ss.sales_amount, 1, NULL) OVER (PARTITION BY ss.call_center_id, ss.year ORDER BY ss.month) AS next_month_sales
FROM
    sales ss
JOIN
    items i ON ss.item_id = i.item_id
JOIN
    brands b ON i.brand_id = b.brand_id
JOIN
    categories c ON i.category_id = c.category_id
JOIN
    call_centers cc ON ss.call_center_id = cc.call_center_id
WHERE
    ss.year = 1999
HAVING
    ABS((ss.sales_amount - AVG(ss.sales_amount) OVER (PARTITION BY ss.call_center_id, ss.year, ss.month)) / AVG(ss.sales_amount) OVER (PARTITION BY ss.call_center_id, ss.year, ss.month)) > 0.1
ORDER BY
    sales_deviation DESC, ss.call_center_id
LIMIT 100;
