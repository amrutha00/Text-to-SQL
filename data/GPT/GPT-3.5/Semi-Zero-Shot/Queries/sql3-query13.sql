SELECT
    AVG(ss_quantity) AS avg_sales_quantity,
    AVG(ss_sales_price) AS avg_sales_price,
    AVG(ss_wholesale_cost) AS avg_wholesale_cost,
    SUM(ss_wholesale_cost) AS total_wholesale_cost
FROM
    store_sales
JOIN
    date_dim ON store_sales.d_date_sk = date_dim.d_date_sk
JOIN
    customer_demographics ON store_sales.cd_demo_sk = customer_demographics.cd_demo_sk
JOIN
    customer ON customer_demographics.cd_gender = customer.cd_gender
    AND customer_demographics.cd_marital_status = customer.cd_marital_status
    AND customer_demographics.cd_education_status = customer.cd_education_status
    AND customer_demographics.cd_household_income = customer.cd_income_band
    AND customer_demographics.cd_purchase_estimate = customer.cd_purchase_band
JOIN
    household_demographics ON store_sales.hd_demo_sk = household_demographics.hd_demo_sk
JOIN
    item ON store_sales.ss_item_sk = item.i_item_sk
WHERE
    date_dim.d_year = 2001
    AND (
        (customer.cd_marital_status = 'D' AND customer.cd_education_status = 'Unknown'
        AND store_sales.ss_sales_price BETWEEN 100.00 AND 150.00
        AND customer_demographics.cd_dep_count = 3)
        OR
        (customer.cd_marital_status = 'S' AND customer.cd_education_status = 'College'
        AND store_sales.ss_sales_price BETWEEN 50.00 AND 100.00
        AND customer_demographics.cd_dep_count = 1)
        OR
        (customer.cd_marital_status = 'M' AND customer.cd_education_status = '4 yr Degree'
        AND store_sales.ss_sales_price BETWEEN 150.00 AND 200.00
        AND customer_demographics.cd_dep_count = 1)
    )
    AND customer_demographics.cd_english_country_name = 'United States'
    AND customer_demographics.cd_state IN ('SD', 'KS', 'MI', 'MO', 'ND', 'CO', 'NH', 'OH', 'TX')
GROUP BY
    customer.cd_marital_status,
    customer.cd_education_status,
    customer_demographics.cd_state
