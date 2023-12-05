SELECT
    cd_gender,
    cd_marital_status,
    cd_education_status,
    cd_purchase_estimate,
    cd_credit_rating,
    cd_dep_count,
    cd_dep_employed_count,
    cd_dep_college_count,
    COUNT(DISTINCT c_customer_sk) AS customer_count
FROM
    customer_demographics
JOIN
    customer ON customer_demographics.cd_demo_sk = customer.c_current_cdemo_sk
JOIN
    customer_address ON customer.c_current_addr_sk = customer_address.ca_address_sk
JOIN
    store_sales ON customer.c_customer_sk = store_sales.ss_customer_sk
JOIN
    web_sales ON customer.c_customer_sk = web_sales.ws_bill_customer_sk
    AND store_sales.ss_sold_date_sk = web_sales.ws_sold_date_sk
JOIN
    date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
WHERE
    date_dim.d_year = given_year
    AND date_dim.d_month_seq BETWEEN given_month_seq - 2 AND given_month_seq
    AND ca_county IS NOT NULL
GROUP BY
    cd_gender,
    cd_marital_status,
    cd_education_status,
    cd_purchase_estimate,
    cd_credit_rating,
    cd_dep_count,
    cd_dep_employed_count,
    cd_dep_college_count
ORDER BY
    cd_gender,
    cd_marital_status,
    cd_education_status,
    cd_purchase_estimate,
    cd_credit_rating,
    cd_dep_count,
    cd_dep_employed_count,
    cd_dep_college_count
LIMIT 100;