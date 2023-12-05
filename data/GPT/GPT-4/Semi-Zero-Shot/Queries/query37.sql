SELECT 
    i.i_item_id, 
    i.i_item_desc, 
    i.i_current_price
FROM 
    item i
JOIN 
    catalog_sales cs ON i.i_item_id = cs.cs_item_sk
WHERE 
    i.i_manufacturer_id IN (856, 707, 1000, 747)
    AND i.i_current_price BETWEEN 45 AND 75
    AND EXISTS (
        SELECT 1
        FROM inventory inv
        WHERE inv.inv_item_sk = i.i_item_id
        AND inv.inv_quantity_on_hand BETWEEN 100 AND 500
        AND inv.inv_date BETWEEN '1999-02-21' AND '1999-04-22' -- 60 days later from Feb 21, 1999
    )
GROUP BY 
    i.i_item_id, 
    i.i_item_desc, 
    i.i_current_price
ORDER BY 
    i.i_item_id
LIMIT 100;
