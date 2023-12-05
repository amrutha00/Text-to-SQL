SELECT i.i_item_id,
       i.i_item_desc,
       i.i_current_price
FROM item i
JOIN inventory inv ON i.i_item_sk = inv.inv_item_sk
JOIN date_dim d ON inv.inv_date_sk = d.d_date_sk
WHERE i.i_manufact_id IN (856,
                          707,
                          1000,
                          747)
  AND i.i_current_price BETWEEN 45 AND 75
  AND inv.inv_quantity_on_hand BETWEEN 100 AND 500
  AND d.d_date BETWEEN '1999-02-21' AND '1999-03-20'
GROUP BY i.i_item_id,
         i.i_item_desc,
         i.i_current_price
ORDER BY i.i_item_id
LIMIT 100;