SELECT 
    ss_ticket_number,
    c_last_name,
    sum(ss_ext_sales_price) AS extended_sales_price,
    sum(ss_ext_list_price) AS extended_list_price,
    sum(ss_ext_tax) AS extended_tax
FROM 
    store_sales
JOIN 
    date_dim ON (store_sales.ss_sold_date_sk = date_dim.d_date_sk)
JOIN 
    store ON (store_sales.ss_store_sk = store.s_store_sk)
JOIN 
    household_demographics ON (store_sales.ss_cdemo_sk = household_demographics.hd_demo_sk)
JOIN 
    customer_address ON (customer_address.ca_city != store.s_city)
JOIN 
    customer ON (store_sales.ss_customer_sk = customer.c_customer_sk AND customer.c_dep_count = 8 OR customer.c_vehicle_count = 0)
WHERE 
    (date_dim.d_year = 1998 AND date_dim.d_month_seq <= 2)
    OR (date_dim.d_year = 1999)
    OR (date_dim.d_year = 2000 AND date_dim.d_month_seq <= 2)
GROUP BY 
    ss_ticket_number, c_last_name
ORDER BY 
    c_last_name, ss_ticket_number
LIMIT 100