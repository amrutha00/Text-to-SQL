SELECT 
    i.i_item_id,
    s.s_state,
    ROUND(AVG(ss.ss_quantity), 2) AS average_quantity,
    ROUND(AVG(ss.ss_list_price), 2) AS average_list_price,
    ROUND(AVG(ss.ss_sales_price), 2) AS average_sales_price,
    ROUND(AVG(ss.ss_coupon_amt), 2) AS average_coupon_amount
FROM 
    store_sales ss
JOIN 
    store s ON ss.ss_store_sk = s.s_store_sk
JOIN 
    customer_demographics cd ON ss.ss_customer_sk = cd.cd_demo_sk
JOIN 
    item i ON ss.ss_item_sk = i.i_item_sk
WHERE 
    s.s_state IN ('MO', 'AL', 'MI', 'TN', 'LA', 'SC')
    AND YEAR(ss.ss_sold_date_sk) = 1999
    AND cd.cd_gender = 'F'
    AND cd.cd_marital_status = 'D'
    AND cd.cd_education_status = '2nd-4th grade'
GROUP BY 
    i.i_item_id, s.s_state WITH ROLLUP
ORDER BY 
    i.i_item_id, s.s_state
LIMIT 100;