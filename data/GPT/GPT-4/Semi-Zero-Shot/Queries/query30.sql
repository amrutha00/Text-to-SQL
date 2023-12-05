WITH AvgReturns AS (
    SELECT 
        ws_bill_customer_sk AS customer_sk,
        SUM(wr_return_amt) AS total_return_amt
    FROM
        web_sales
    JOIN
        web_returns ON web_sales.ws_order_number = web_returns.wr_order_number
    JOIN
        date_dim ON web_sales.ws_sold_date_sk = date_dim.d_date_sk
    JOIN
        customer_address ON web_sales.ws_bill_addr_sk = customer_address.ca_address_sk
    WHERE
        date_dim.d_year = 2002
        AND customer_address.ca_state = 'IN'
    GROUP BY
        ws_bill_customer_sk
),
AvgValue AS (
    SELECT
        AVG(total_return_amt) AS avg_return_amt
    FROM
        AvgReturns
)

SELECT 
    customer.c_customer_sk AS customer_id,
    customer.c_salutation,
    customer.c_first_name,
    customer.c_last_name,
    customer.c_preferred_cust_flag,
    customer.c_birth_day,
    customer.c_birth_month,
    customer.c_birth_year,
    customer.c_birth_country,
    customer.c_login,
    customer.c_email_address,
    customer.c_last_review_date,
    AvgReturns.total_return_amt AS total_return_amount
FROM
    customer
JOIN
    AvgReturns ON customer.c_customer_sk = AvgReturns.customer_sk
JOIN
    AvgValue
WHERE
    AvgReturns.total_return_amt > 1.20 * AvgValue.avg_return_amt
ORDER BY
    customer.c_customer_sk, 
    customer.c_salutation, 
    customer.c_first_name, 
    customer.c_last_name, 
    customer.c_preferred_cust_flag, 
    customer.c_birth_day, 
    customer.c_birth_month, 
    customer.c_birth_year, 
    customer.c_birth_country, 
    customer.c_login, 
    customer.c_email_address, 
    customer.c_last_review_date, 
    AvgReturns.total_return_amt
LIMIT 100;
