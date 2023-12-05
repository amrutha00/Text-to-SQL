SELECT 
    i.i_product_name AS product_name,
    i.i_brand AS brand,
    i.i_class AS class,
    i.i_category AS category,
    AVG(inv.inv_quantity_on_hand) AS avg_quantity_on_hand
FROM 
    inventory inv
INNER JOIN 
    item i ON inv.inv_item_sk = i.i_item_sk
INNER JOIN 
    date_dim d ON inv.inv_date_sk = d.d_date_sk
WHERE 
    d.d_month_seq >= 1188 AND d.d_month_seq < 1300
GROUP BY 
    i.i_product_name, i.i_brand, i.i_class, i.i_category
ORDER BY 
    avg_quantity_on_hand ASC, product_name, brand, class, category
LIMIT 
    100;