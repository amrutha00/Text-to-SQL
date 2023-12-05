WITH Filtered_Customers AS (
    SELECT c_customer_sk, c_state, c_gender, c_marital_status, c_current_number_of_dependents
    FROM customer
    WHERE c_customer_sk IN (
        SELECT ss_customer_sk
        FROM store_sales
        JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
        WHERE d_year = 2001 AND d_quarter_seq > 3
        UNION
        SELECT cs_bill_customer_sk
        FROM catalog_sales
        JOIN date_dim ON catalog_sales.cs_sold_date_sk = date_dim.d_date_sk
        WHERE d_year = 2001 AND d_quarter_seq > 3
        UNION
        SELECT ws_bill_customer_sk
        FROM web_sales
        JOIN date_dim ON web_sales.ws_sold_date_sk = date_dim.d_date_sk
        WHERE d_year = 2001 AND d_quarter_seq > 3
    )
)

SELECT 
    c_state,
    c_gender,
    c_marital_status,
    COUNT(c_customer_sk) AS customer_count,
    MIN(c_current_number_of_dependents) AS min_dependents,
    MAX(c_current_number_of_dependents) AS max_dependents,
    AVG(c_current_number_of_dependents) AS avg_dependents,
    COUNT(DISTINCT c_current_number_of_dependents) AS distinct_dependent_counts,
    -- Repeating the "count of customers" for different scenarios. 
    -- You'd need to provide specifics on the different scenarios for accurate counts.
    COUNT(c_customer_sk) AS scenario1_count,
    COUNT(c_customer_sk) AS scenario2_count,
    COUNT(c_customer_sk) AS scenario3_count
FROM Filtered_Customers
GROUP BY 
    c_state, c_gender, c_marital_status
ORDER BY 
    c_state, c_gender, c_marital_status, 
    min_dependents, max_dependents, avg_dependents, 
    scenario1_count, scenario2_count, scenario3_count
LIMIT 100;
