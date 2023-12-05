SELECT 
    ca_state AS state, 
    cd_gender AS gender, 
    cd_marital_status AS marital_status, 
    COUNT(*) AS customer_count,
    MIN(cd_dep_count) AS min_dependents,
    MAX(cd_dep_count) AS max_dependents,
    AVG(cd_dep_count) AS avg_dependents,
    COUNT(DISTINCT cd_dep_count) AS distinct_dependents
FROM 
    customer c
JOIN 
    customer_address ca ON c.c_current_addr_sk = ca.ca_address_sk
JOIN 
    customer_demographics cd ON c.c_current_cdemo_sk = cd.cd_demo_sk
JOIN 
    store_sales ss ON c.c_customer_sk = ss.ss_customer_sk
JOIN 
    catalog_sales cs ON c.c_customer_sk = cs.cs_bill_customer_sk
JOIN 
    web_sales ws ON c.c_customer_sk = ws.ws_bill_customer_sk
JOIN 
    date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
WHERE 
    d.d_year = 2001
    AND d.d_qoy > 3
GROUP BY 
    ca_state, cd_gender, cd_marital_status
ORDER BY 
    ca_state, cd_gender, cd_marital_status, cd_dep_count, cd_dep_employed_count, cd_dep_college_count
LIMIT 
    100;