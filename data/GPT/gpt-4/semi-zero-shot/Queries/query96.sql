SELECT 
    s.ss_store_sk, 
    COUNT(s.ss_sales_sk) AS sales_count
FROM 
    store_sales s
JOIN 
    store st ON s.ss_store_sk = st.s_store_sk
JOIN 
    customer c ON s.ss_customer_sk = c.c_customer_sk
JOIN 
    time_dim t ON s.ss_sold_time_sk = t.t_time_sk
WHERE 
    st.s_store_name = 'ese'
AND 
    c.c_dep_count = 3
AND 
    t.t_hour = 8
AND 
    t.t_minute >= 30
GROUP BY 
    s.ss_store_sk
ORDER BY 
    sales_count DESC
LIMIT 
    100;
