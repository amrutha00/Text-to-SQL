SELECT 
    c_gender,
    c_marital_status,
    c_education_status,
    c_purchase_estimate,
    c_credit_rating,
    COUNT(*) AS customer_count
FROM customer
JOIN store_sales ON customer.c_customer_sk = store_sales.ss_customer_sk
WHERE c_current_addr_sk IN (
    SELECT ca_address_sk
    FROM customer_address
    WHERE ca_state IN ('TX', 'VA', 'MI')
)
AND ss_sold_date_sk IN (
    SELECT d_date_sk
    FROM date_dim
    WHERE d_year = 2000 AND d_moy BETWEEN 1 AND 3
)
AND NOT EXISTS (
    SELECT 1
    FROM catalog_sales
    WHERE customer.c_customer_sk = catalog_sales.cs_customer_sk
    AND cs_sold_date_sk IN (
        SELECT d_date_sk
        FROM date_dim
        WHERE d_year = 2000 AND d_moy BETWEEN 1 AND 3
    )
)
AND NOT EXISTS (
    SELECT 1
    FROM web_sales
    WHERE customer.c_customer_sk = web_sales.ws_customer_sk
    AND ws_sold_date_sk IN (
        SELECT d_date_sk
        FROM date_dim
        WHERE d_year = 2000 AND d_moy BETWEEN 1 AND 3
    )
)
GROUP BY 
    c_gender, 
    c_marital_status, 
    c_education_status, 
    c_purchase_estimate, 
    c_credit_rating
ORDER BY 
    c_gender ASC, 
    c_marital_status ASC, 
    c_education_status ASC, 
    c_purchase_estimate ASC, 
    c_credit_rating ASC
LIMIT 100;
