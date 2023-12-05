WITH DateRange AS (
    SELECT
        d_month_seq,
        (d_month_seq - 1187) AS month_offset
    FROM
        date_dim
    WHERE
        d_month_seq >= 1188
    AND
        d_month_seq < 1300 -- Assuming 12 months from month 1188
)
SELECT
    p.product_name,
    p.product_brand,
    p.product_class,
    p.product_category,
    AVG(s.quantity_on_hand) AS average_quantity_on_hand
FROM
    product p
JOIN
    store_sales s
ON
    p.product_id = s.product_id
JOIN
    DateRange dr
ON
    s.month_seq = dr.month_offset
GROUP BY
    p.product_name,
    p.product_brand,
    p.product_class,
    p.product_category
ORDER BY
    average_quantity_on_hand ASC,
    p.product_name,
    p.product_brand,
    p.product_class,
    p.product_category
LIMIT 100;
