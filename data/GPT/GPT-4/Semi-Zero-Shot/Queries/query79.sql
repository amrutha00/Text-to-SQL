SELECT 
    ss.ss_ticket_number, 
    ss.ss_customer_sk,
    s.s_city,
    SUM(ss.ss_coupon_amt) AS amt,
    SUM(ss.ss_net_profit) AS profit
FROM 
    store_sales ss
JOIN 
    date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
JOIN 
    store s ON ss.ss_store_sk = s.s_store_sk
JOIN 
    customer c ON ss.ss_customer_sk = c.c_customer_sk
JOIN 
    household_demographics hd ON c.c_current_hdemo_sk = hd.hd_demo_sk
WHERE 
    d.d_dow = 1
    AND s.s_number_employees BETWEEN 200 AND 295
    AND hd.hd_dep_count >= 5
    AND hd.hd_vehicle_count > 4
GROUP BY 
    ss.ss_ticket_number, 
    ss.ss_customer_sk, 
    s.s_city
ORDER BY 
    c.c_last_name ASC, 
    c.c_first_name ASC, 
    SUBSTR(s.s_city, 1, 30) ASC, 
    profit ASC
LIMIT 100;
