SELECT i.i_item_id, i.i_item_desc, i.i_current_price
FROM item i
JOIN catalog_sales cs ON i.i_item_id = cs.cs_item_sk
JOIN inventory inv ON cs.cs_item_sk = inv.inv_item_sk
JOIN date_dim d ON inv.inv_date_sk = d.d_date_sk
WHERE i.i_current_price BETWEEN 45 AND 75
AND d.d_date BETWEEN '1999-02-21' AND '1999-04-21'
AND inv.inv_warehouse_sk = 1 /* Replace 1 with the warehouse ID */
AND inv.inv_quantity_on_hand BETWEEN 100 AND 500
AND i.i_item_manufacturer_id IN (856, 707, 1000, 747)
GROUP BY i.i_item_id, i.i_item_desc, i.i_current_price
ORDER BY i.i_item_id
LIMIT 100;