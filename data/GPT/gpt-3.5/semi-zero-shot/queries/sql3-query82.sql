SELECT
    i.item_id,
    i.item_description,
    i.current_price
FROM
    item i
JOIN
    store_sales ss
ON
    i.item_id = ss.item_id
JOIN
    date_dim dd
ON
    ss.sale_date = dd.date_sk
WHERE
    i.manufact_id IN (639, 169, 138, 339) -- Filter for specific manufacturers
    AND i.current_price BETWEEN 17 AND 47 -- Filter for price range
    AND dd.the_date BETWEEN '1999-07-09' AND DATEADD(day, 60, '1999-07-09') -- Filter for a 60-day period starting from July 9, 1999
    AND ss.quantity >= 100 AND ss.quantity <= 500 -- Filter for quantity between 100 and 500
GROUP BY
    i.item_id,
    i.item_description,
    i.current_price
ORDER BY
    i.item_id
LIMIT 100; -- Limit to the first 100 results
