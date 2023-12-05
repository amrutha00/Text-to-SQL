SELECT 
    ss_item_sk AS item_id, 
    AVG(ss_quantity) AS avg_quantity,
    AVG(ss_list_price) AS avg_list_price,
    AVG(ss_coupon_amt) AS avg_discount,
    AVG(ss_sales_price) AS avg_sales_price
FROM 
    store_sales ss 
JOIN 
    promotion p ON ss.ss_promo_sk = p.p_promo_sk 
JOIN 
    date_dim d ON ss.ss_sold_date_sk = d.d_date_sk 
JOIN 
    item i ON ss.ss_item_sk = i.i_item_sk 
JOIN 
    customer c ON ss.ss_customer_sk = c.c_customer_sk 
JOIN 
    customer_demographics cd ON c.c_current_cdemo_sk = cd.cd_demo_sk
WHERE 
    d.d_year = 2001 
    AND p.p_channel_mail = 'N'
    AND p.p_channel_event = 'N'
    AND cd.cd_gender = 'F'
    AND cd.cd_marital_status = 'W'
    AND cd.cd_education_status = 'College'
GROUP BY 
    ss_item_sk 
ORDER BY 
    ss_item_sk 
LIMIT 100;
