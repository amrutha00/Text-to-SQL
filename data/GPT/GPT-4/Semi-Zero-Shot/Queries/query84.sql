SELECT *
FROM customer
WHERE c_current_addr_sk IN (
    SELECT ca_address_sk
    FROM customer_address
    WHERE ca_city = 'Oakwood' 
    AND ca_income BETWEEN 5806 AND 55806
)
ORDER BY c_customer_sk
LIMIT 100;
