SELECT 
    c.c_last_name,
    ss.ss_ticket_number,
    SUM(ss.ss_ext_sales_price) AS total_extended_sales_price,
    SUM(ss.ss_ext_list_price) AS total_extended_list_price,
    SUM(ss.ss_ext_tax) AS total_extended_tax
FROM
    store_sales ss
JOIN
    customer c ON ss.ss_customer_sk = c.c_customer_sk
JOIN
    store s ON ss.ss_store_sk = s.s_store_sk
WHERE
    s.s_city NOT IN ('Pleasant Hill', 'Five Points')
    AND c.c_city <> s.s_city
    AND EXTRACT(DAY FROM ss.ss_sold_date_sk) BETWEEN 1 AND 2
    AND EXTRACT(YEAR FROM ss.ss_sold_date_sk) BETWEEN 1998 AND 2000
    AND (c.c_dep_count = 8 OR c.c_vehicle_count = 0)
GROUP BY 
    c.c_last_name,
    ss.ss_ticket_number
ORDER BY 
    c.c_last_name,
    ss.ss_ticket_number
LIMIT 100;
