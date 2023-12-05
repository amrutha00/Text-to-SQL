SELECT 
    cd_gender, 
    cd_marital_status, 
    cd_education_status, 
    cd_purchase_estimate, 
    cd_credit_rating, 
    COUNT(*) AS customer_count
FROM 
    customer_demographics
JOIN 
    customer ON customer_demographics.cd_demo_sk = customer.c_current_cdemo_sk
JOIN 
    customer_address ON customer.c_current_addr_sk = customer_address.ca_address_sk
WHERE 
    ca_state IN ('TX', 'VA', 'MI')
    AND EXISTS (
        SELECT *
        FROM 
            store_sales
        JOIN 
            date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
        WHERE 
            store_sales.ss_customer_sk = customer.c_customer_sk
            AND date_dim.d_year = 2000
            AND date_dim.d_qoy <= 3
    )
    AND NOT EXISTS (
        SELECT *
        FROM 
            catalog_sales
        WHERE 
            catalog_sales.cs_customer_sk = customer.c_customer_sk
            AND catalog_sales.cs_sold_date_sk BETWEEN '2000-01-01' AND '2000-03-31'
    )
    AND NOT EXISTS (
        SELECT *
        FROM 
            web_sales
        WHERE 
            web_sales.ws_customer_sk = customer.c_customer_sk
            AND web_sales.ws_sold_date_sk BETWEEN '2000-01-01' AND '2000-03-31'
    )
GROUP BY 
    cd_gender, 
    cd_marital_status, 
    cd_education_status, 
    cd_purchase_estimate, 
    cd_credit_rating
ORDER BY 
    cd_gender, 
    cd_marital_status, 
    cd_education_status, 
    cd_purchase_estimate, 
    cd_credit_rating
LIMIT 100;