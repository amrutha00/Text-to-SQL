SELECT 
    SUM(ss.ss_sales_price) AS total_sales
FROM 
    store_sales AS ss
JOIN 
    customer AS c ON ss.ss_customer_sk = c.c_customer_sk
JOIN 
    customer_demographics AS cd ON c.c_current_cdemo_sk = cd.cd_demo_sk
JOIN 
    customer_address AS ca ON c.c_current_addr_sk = ca.ca_address_sk
WHERE 
    ss.ss_sold_date_sk IN (
        SELECT 
            d.d_date_sk
        FROM 
            date_dim AS d
        WHERE 
            d.d_year = 1999
    )
    AND (
        (cd.cd_marital_status = 'U' AND cd.cd_education_status = 'Primary' AND ss.ss_sales_price BETWEEN 100.00 AND 150.00)
        OR (cd.cd_marital_status = 'W' AND cd.cd_education_status = 'College' AND ss.ss_sales_price BETWEEN 50.00 AND 100.00)
        OR (cd.cd_marital_status = 'D' AND cd.cd_education_status = '2 yr Degree' AND ss.ss_sales_price BETWEEN 150.00 AND 200.00)
    )
    AND (
        (ca.ca_state IN ('MD', 'MN', 'IA') AND ss.ss_net_profit BETWEEN 0 AND 2000)
        OR (ca.ca_state IN ('VA', 'IL', 'TX') AND ss.ss_net_profit BETWEEN 150 AND 3000)
        OR (ca.ca_state IN ('MI', 'WI', 'IN') AND ss.ss_net_profit BETWEEN 50 AND 25000)
    );