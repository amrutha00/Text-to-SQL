SELECT
    s.item_id,
    s.manufacturer_id,
    SUM(s.discount_amount) AS total_discount
FROM
    sales s
WHERE
    s.sale_date BETWEEN DATE '2002-02-26' AND DATE '2002-05-26' -- 90-day period
    AND s.web_sale = 1 -- Only web sales
    AND s.manufacturer_id = 320 -- Manufacturer ID 320
    AND s.discount_amount > (
        SELECT
            AVG(discount_amount) * 1.3 -- 30% over the average discount
        FROM
            sales
        WHERE
            sale_date BETWEEN DATE '2002-02-26' AND DATE '2002-05-26'
            AND web_sale = 1
            AND manufacturer_id = 320
    )
GROUP BY
    s.item_id, s.manufacturer_id
ORDER BY
    total_discount DESC
LIMIT
    100; -- Limit to the top 100 records
