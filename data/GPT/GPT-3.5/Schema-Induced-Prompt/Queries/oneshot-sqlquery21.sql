SELECT 
    w.w_warehouse_name,
    i.i_item_id,
    (SUM(CASE WHEN d.d_date >= DATE_SUB('2002-02-27', INTERVAL 30 DAY) AND d.d_date < '2002-02-27' THEN inv.inv_quantity_on_hand ELSE 0 END) - 
    SUM(CASE WHEN d.d_date > '2002-02-27' AND d.d_date <= DATE_ADD('2002-02-27', INTERVAL 30 DAY) THEN inv.inv_quantity_on_hand ELSE 0 END)) / 
    SUM(CASE WHEN d.d_date >= DATE_SUB('2002-02-27', INTERVAL 30 DAY) AND d.d_date <= DATE_ADD('2002-02-27', INTERVAL 30 DAY) THEN inv.inv_quantity_on_hand ELSE 0 END) * 100 AS percentage_change
FROM 
    inventory inv
    JOIN warehouse w ON inv.inv_warehouse_sk = w.w_warehouse_sk
    JOIN item i ON inv.inv_item_sk = i.i_item_sk
    JOIN date_dim d ON inv.inv_date_sk = d.d_date_sk
WHERE 
    i.i_current_price BETWEEN 0.99 AND 1.49
    AND d.d_date = '2002-02-27'
GROUP BY 
    w.w_warehouse_name,
    i.i_item_id
ORDER BY 
    w.w_warehouse_name,
    i.i_item_id
LIMIT 100;