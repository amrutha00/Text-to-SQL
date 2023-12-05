SELECT 
    c.c_customer_id,
    c.c_salutation,
    c.c_first_name,
    c.c_last_name,
    c.c_preferred_cust_flag,
    c.c_birth_day,
    c.c_birth_month,
    c.c_birth_year,
    c.c_birth_country,
    c.c_login,
    c.c_email_address,
    c.c_last_review_date_sk,
    SUM(wr.wr_return_amt) AS total_return
FROM 
    customer_total_return ctr
JOIN 
    web_returns wr ON ctr.ctr_customer_sk = wr.wr_refunded_customer_sk
JOIN 
    customer c ON ctr.ctr_customer_sk = c.c_customer_id
JOIN 
    date_dim d ON wr.wr_returned_date_sk = d.d_date_sk
JOIN 
    customer_address ca ON wr.wr_refunded_addr_sk = ca.ca_address_sk
WHERE 
    d.d_year = 2002
    AND ca.ca_state = 'Indiana'
GROUP BY 
    c.c_customer_id,
    c.c_salutation,
    c.c_first_name,
    c.c_last_name,
    c.c_preferred_cust_flag,
    c.c_birth_day,
    c.c_birth_month,
    c.c_birth_year,
    c.c_birth_country,
    c.c_login,
    c.c_email_address,
    c.c_last_review_date_sk
HAVING 
    SUM(wr.wr_return_amt) > (SELECT AVG(wr_return_amt) * 1.2 FROM web_returns WHERE wr_returned_date_sk IN (SELECT d_date_sk FROM date_dim WHERE d_year = 2002) AND wr_refunded_addr_sk IN (SELECT ca_address_sk FROM customer_address WHERE ca_state = 'Indiana'))
ORDER BY 
    c.c_customer_id,
    c.c_salutation,
    c.c_first_name,
    c.c_last_name,
    c.c_preferred_cust_flag,
    c.c_birth_day,
    c.c_birth_month,
    c.c_birth_year,
    c.c_birth_country,
    c.c_login,
    c.c_email_address,
    c.c_last_review_date_sk,
    total_return DESC
LIMIT 
    100;