SELECT 
    ss_ticket_number, 
    ss_customer_sk, 
    LEFT(store.s_city, 30) AS store_city, 
    SUM(ss_coupon_amt) AS amt, 
    SUM(ss_net_profit) AS profit
FROM 
    store_sales
JOIN 
    date_dim ON store_sales.ss_ticket_number = date_dim.d_date_sk
JOIN 
    store ON store_sales.ss_addr_sk = store.s_store_sk
JOIN 
    household_demographics ON store_sales.ss_customer_sk = household_demographics.hd_demo_sk
JOIN 
    customer ON store_sales.ss_customer_sk = customer.c_customer_sk
WHERE 
    date_dim.d_dow = 1
    AND store.s_number_employees BETWEEN 200 AND 295
    AND household_demographics.hd_dep_count >= 5
    AND household_demographics.hd_vehicle_count > 4
GROUP BY 
    ss_ticket_number, 
    ss_customer_sk, 
    store.s_city
ORDER BY 
    customer.c_last_name, 
    customer.c_first_name, 
    LEFT(store.s_city, 30), 
    profit
LIMIT 100;