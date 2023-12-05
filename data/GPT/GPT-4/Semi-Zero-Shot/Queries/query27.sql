SELECT 
    i.item_id,
    s.store_state,
    AVG(ss.ss_quantity) AS avg_quantity,
    AVG(ss.ss_list_price) AS avg_list_price,
    AVG(ss.ss_sales_price) AS avg_sales_price,
    AVG(ss.ss_coupon_amt) AS avg_coupon_amount
FROM 
    store_sales ss
JOIN item i ON ss.ss_item_sk = i.item_sk
JOIN date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
JOIN store s ON ss.ss_store_sk = s.store_sk
JOIN customer c ON ss.ss_customer_sk = c.c_customer_sk
WHERE 
    s.store_state IN ('MO', 'AL', 'MI', 'TN', 'LA', 'SC')
    AND d.d_year = 1999
    AND c.c_gender = 'F'
    AND c.c_marital_status = 'D'
    AND c.c_education_status = 'Secondary'
GROUP BY 
    ROLLUP (i.item_id, s.store_state)
ORDER BY 
    i.item_id, s.store_state
LIMIT 100;
