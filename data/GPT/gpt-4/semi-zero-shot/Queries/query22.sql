SELECT 
    product_name,
    brand,
    class,
    category,
    AVG(quantity_on_hand) AS avg_qoh
FROM 
    item i
JOIN 
    inventory inv ON i.item_sk = inv.inv_item_sk
JOIN 
    date_dim d ON inv.inv_date_sk = d.date_sk
WHERE 
    d.month_seq BETWEEN 1188 AND 1199  -- Assuming month_seq represents the sequence of months.
GROUP BY 
    ROLLUP (product_name, brand, class, category)
ORDER BY 
    avg_qoh ASC,
    product_name ASC,
    brand ASC,
    class ASC,
    category ASC
LIMIT 100;
