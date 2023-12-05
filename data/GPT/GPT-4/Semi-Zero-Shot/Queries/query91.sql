SELECT 
    cc_call_center_id AS "Call Center ID",
    cc_name AS "Call Center Name",
    cc_manager AS "Manager",
    SUM(cs_net_loss) AS "Total Returns Loss"
FROM 
    catalog_sales cs
JOIN 
    call_center cc ON cs.cs_call_center_sk = cc.cc_call_center_sk
JOIN 
    customer c ON cs.cs_bill_customer_sk = c.c_customer_sk
JOIN 
    date_dim d ON cs.cs_sold_date_sk = d.d_date_sk
WHERE 
    d.d_month_seq IN (
        SELECT d_date_sk FROM date_dim WHERE d_year = 2001 AND d_month = 11
    )
    AND (
        (c.c_gender = 'M' AND c.c_education_status = 'unknown')
        OR 
        (c.c_gender = 'F' AND c.c_education_status = 'advanced degree')
    )
    AND c.c_buy_potential BETWEEN '1001%' AND '5000%'
    AND cc.cc_gmt_offset = -6
GROUP BY 
    cc_call_center_id, cc_name, cc_manager
ORDER BY 
    "Total Returns Loss" DESC;
