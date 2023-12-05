SELECT 
    c_last_name,
    c_first_name,
    ca_city AS customer_residence_city,
    s_city AS store_city,
    ss_coupon_amt,
    ss_net_profit
FROM 
    store_sales
JOIN customer c ON ss_customer_sk = c.c_customer_sk
JOIN customer_address ca ON c.c_current_addr_sk = ca.ca_address_sk
JOIN store s ON ss_store_sk = s.s_store_sk
JOIN household_demographics hd ON c.c_current_hdemo_sk = hd.hd_demo_sk
JOIN date_dim d ON ss_sold_date_sk = d.d_date_sk
WHERE 
    ca_location_type = 'Out of Town'
    AND s_city IN ('<City1>', '<City2>', '<City3>', '<City4>', '<City5>')
    AND d_year BETWEEN <StartYear> AND <EndYear>
    AND d_day_name IN ('Saturday', 'Sunday')
    AND hd_dep_count = <DependentCount>
    AND hd_vehicle_count = 0
ORDER BY 
    c_last_name,
    c_first_name,
    ca_city,
    s_city,
    ss_ticket_number
LIMIT 100;