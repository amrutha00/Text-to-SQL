SELECT 
    i.i_item_id,
    w.w_warehouse_id,
    d.d_month_seq,
    AVG(inv.inv_quantity_on_hand) AS mean,
    SQRT(VAR_POP(inv.inv_quantity_on_hand)) / AVG(inv.inv_quantity_on_hand) AS coefficient_of_variation
FROM 
    inventory inv
    JOIN item i ON inv.inv_item_sk = i.i_item_sk
    JOIN warehouse w ON inv.inv_warehouse_sk = w.w_warehouse_sk
    JOIN date_dim d ON d.d_date_sk = inv.inv_date_sk
WHERE 
    d.d_year = 1998
    AND d.d_month_seq >= 241
    AND d.d_month_seq <= 242
GROUP BY 
    i.i_item_id,
    w.w_warehouse_id,
    d.d_month_seq
HAVING 
    coefficient_of_variation > 1.5
ORDER BY 
    w.w_warehouse_id,
    i.i_item_id,
    d.d_month_seq,
    mean,
    coefficient_of_variation;