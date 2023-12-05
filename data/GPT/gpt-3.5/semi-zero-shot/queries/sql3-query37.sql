SELECT
    i_item_id,
    i_item_desc,
    i_current_price
FROM
    catalog_sales cs
JOIN
    item i ON cs.cs_item_sk = i.i_item_sk
WHERE
    i.i_manufact_id IN (856, 707, 1000, 747)
    AND i.i_current_price BETWEEN 45 AND 75
    AND cs.cs_sold_date_sk >= date('1999-02-21') 
    AND cs.cs_sold_date_sk <= date('1999-02-21') + interval '60' day
    AND i.i_qoh BETWEEN 100 AND 500
GROUP BY
    i_item_id,
    i_item_desc,
    i_current_price
ORDER BY
    i_item_id
LIMIT 100;
