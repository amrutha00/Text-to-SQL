SELECT 
    c.c_customer_id,
    c.c_first_name,
    c.c_last_name,
    c.c_salutation,
    c.c_pref_customer_flag
FROM 
    customer c
JOIN 
    store_sales ss ON c.c_customer_id = ss.ss_customer_sk
JOIN 
    date_dim dd ON ss.ss_sold_date_sk = dd.d_date_sk
JOIN 
    store s ON ss.ss_store_sk = s.s_store_sk
JOIN 
    customer_demographics cd ON c.c_customer_id = cd.cd_demo_sk
WHERE 
    ss.ss_item_sk BETWEEN 15 AND 20
AND
    dd.d_month IN (1, 2, 11, 12) -- Beginning or end of each month
AND
    dd.d_year IN (2000, 2001, 2002) -- Three consecutive years
AND
    s.s_county IN ('County1', 'County2', 'County3', 'County4', 'County5', 'County6', 'County7', 'County8') -- Eight specific counties
AND
    (cd.cd_dep_count / cd.cd_vehicle_count) > 1.2
ORDER BY 
    c.c_last_name DESC,
    c.c_first_name DESC,
    c.c_salutation DESC,
    c.c_pref_customer_flag DESC,
    c.c_customer_id; -- Tie-breaking based on customer ID
