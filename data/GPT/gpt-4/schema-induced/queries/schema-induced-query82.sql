SELECT i.i_item_id, i.i_item_desc, i.i_current_price
FROM item i
JOIN store_sales ss ON i.i_item_id = ss.ss_item_sk
JOIN inventory inv ON i.i_item_id = inv.inv_item_sk
JOIN date_dim d ON inv.inv_date_sk = d.d_date_sk
WHERE i.i_item_id IN (639, 169, 138, 339)
AND i.i_current_price BETWEEN 17 AND 47
AND inv.inv_quantity_on_hand BETWEEN 100 AND 500
AND d.d_date_sk BETWEEN 990709 AND 990808
GROUP BY i.i_item_id, i.i_item_desc, i.i_current_price
ORDER BY i.i_item_id
LIMIT 100;