SELECT LEFT(w.w_warehouse_name, 20) AS warehouse_name, 
       sm.sm_type AS shipping_mode, 
       cc.cc_name AS call_center_name, 
       COUNT(*) AS order_count
FROM catalog_sales cs
JOIN warehouse w ON cs.cs_warehouse_sk = w.w_warehouse_sk
JOIN ship_mode sm ON cs.cs_ship_mode_sk = sm.sm_ship_mode_sk
JOIN call_center cc ON cs.cs_call_center_sk = cc.cc_call_center_sk
JOIN date_dim d ON cs.cs_ship_date_sk = d.d_date_sk
WHERE d.d_date_sk >= 43986 AND d.d_date_sk <= 44350 -- Year 1224
  AND DATEDIFF(day, cs.cs_sold_date_sk, cs.cs_ship_date_sk) <= 30 -- Shipped within 30 days
GROUP BY warehouse_name, shipping_mode, call_center_name
ORDER BY warehouse_name, shipping_mode, call_center_name
LIMIT 100;