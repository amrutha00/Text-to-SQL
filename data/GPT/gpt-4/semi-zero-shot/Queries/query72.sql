SELECT 
    i.i_description AS item_description,
    w.w_warehouse_name AS warehouse_name,
    d1.d_week_seq AS week_sequence,
    SUM(CASE WHEN p.p_promo_sk IS NOT NULL THEN 1 ELSE 0 END) AS with_promotion_count,
    SUM(CASE WHEN p.p_promo_sk IS NULL THEN 1 ELSE 0 END) AS without_promotion_count
FROM 
    item i 
    JOIN catalog_sales cs ON i.i_item_sk = cs.cs_item_sk
    JOIN warehouse w ON cs.cs_warehouse_sk = w.w_warehouse_sk
    JOIN date_dim d1 ON cs.cs_sold_date_sk = d1.d_date_sk
    JOIN date_dim d2 ON cs.cs_ship_date_sk = d2.d_date_sk
    LEFT JOIN promotion p ON cs.cs_promo_sk = p.p_promo_sk
    JOIN inventory inv ON i.i_item_sk = inv.inv_item_sk
    JOIN household_demographics hd ON cs.cs_bill_customer_sk = hd.hd_demo_sk
WHERE 
    d1.d_week_seq = d2.d_week_seq
    AND inv.inv_quantity_on_hand < cs.cs_quantity
    AND d2.d_date - d1.d_date > 5
    AND hd.hd_buy_potential = '501-1000'
    AND hd.hd_marital_status = 'W'
    AND d1.d_year = 2002
GROUP BY 
    i.i_description,
    w.w_warehouse_name,
    d1.d_week_seq
ORDER BY 
    (with_promotion_count + without_promotion_count) DESC,
    i.i_description,
    w.w_warehouse_name,
    d1.d_week_seq
LIMIT 100;
