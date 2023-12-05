SELECT 
    i_item_id AS "Item ID",
    i_item_desc AS "Item Description",
    i_current_price AS "Current Price"
FROM 
    item,
    store_sales,
    date_dim,
    inventory
WHERE 
    s_item_sk = i_item_sk 
    AND i_manufact_id IN (639, 169, 138, 339) 
    AND i_current_price BETWEEN 17 AND 47 
    AND s_sales_date_sk = d_date_sk 
    AND d_date BETWEEN '1999-07-09' AND '1999-09-07' 
    AND inv_item_sk = i_item_sk 
    AND inv_quantity_on_hand BETWEEN 100 AND 500 
    AND s_channel = 'store'
GROUP BY 
    i_item_id, 
    i_item_desc, 
    i_current_price
ORDER BY 
    i_item_id 
LIMIT 
    100;
