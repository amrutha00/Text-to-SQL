SELECT 
    i.i_item_desc,
    w.w_warehouse_name,
    dd.d_week_seq,
    COUNT(DISTINCT CASE WHEN p.p_promo_sk IS NOT NULL THEN cs.cs_order_number END) AS sales_with_promotions,
    COUNT(DISTINCT CASE WHEN p.p_promo_sk IS NULL THEN cs.cs_order_number END) AS sales_without_promotions
FROM 
    catalog_sales cs
JOIN 
    item i ON cs.cs_item_sk = i.i_item_sk
JOIN 
    warehouse w ON cs.cs_warehouse_sk = w.w_warehouse_sk
JOIN 
    date_dim dd ON cs.cs_sold_date_sk = dd.d_date_sk
JOIN 
    promotion p ON cs.cs_promo_sk = p.p_promo_sk
JOIN 
    inventory inv ON cs.cs_item_sk = inv.inv_item_sk AND cs.cs_warehouse_sk = inv.inv_warehouse_sk
JOIN 
    household_demographics hd ON cs.cs_bill_hdemo_sk = hd.hd_demo_sk
JOIN 
    date_dim sd ON cs.cs_sold_date_sk = sd.d_date_sk
JOIN 
    date_dim dd2 ON cs.cs_ship_date_sk = dd2.d_date_sk
WHERE 
    dd.d_week_seq = dd2.d_week_seq
    AND inv.inv_quantity_on_hand < cs.cs_quantity
    AND sd.d_date > dd2.d_date + 5
    AND hd.hd_buy_potential = '501-1000'
    AND hd.hd_marital_status = 'W'
    AND dd.d_year = 2002
GROUP BY 
    i.i_item_desc,
    w.w_warehouse_name,
    dd.d_week_seq
ORDER BY 
    COUNT(DISTINCT cs.cs_order_number) DESC,
    i.i_item_desc,
    w.w_warehouse_name,
    dd.d_week_seq
LIMIT 100;