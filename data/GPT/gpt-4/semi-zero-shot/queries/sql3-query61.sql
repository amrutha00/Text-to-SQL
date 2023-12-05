SELECT
    ((SUM(CASE WHEN item_category = 'Jewelry' AND customer_timezone = -7 THEN sales_price END) /
    SUM(CASE WHEN month = 11 AND year = 1999 THEN sales_price END)) * 100) AS ratio,
    SUM(CASE WHEN item_promotion = 'Promotion' THEN sales_price END) AS sum_promotional_sales_price,
    SUM(sales_price) AS sum_total_sales_price
FROM
    date_dim
JOIN
    sales ON date_dim.date_sk = sales.date_sk
JOIN
    item ON sales.item_sk = item.item_sk
JOIN
    customer ON sales.customer_sk = customer.customer_sk
WHERE
    date_dim.month = 11
    AND date_dim.year = 1999
GROUP BY
    customer_timezone
ORDER BY
    sum_promotional_sales_price + sum_total_sales_price
LIMIT 100;
