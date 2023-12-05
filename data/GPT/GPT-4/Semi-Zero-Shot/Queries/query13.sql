WITH filtered_customers AS (
    SELECT ss_sold_date_sk, ss_sales_price, ss_quantity, ss_wholesale_cost
    FROM store_sales
    JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
    JOIN customer ON store_sales.ss_customer_sk = customer.c_customer_sk
    JOIN household_demographics ON customer.c_current_hdemo_sk = household_demographics.hd_demo_sk
    WHERE (date_dim.d_year = 2001)
        AND (household_demographics.hd_dep_count IN (1,3))
        AND (
            (customer.c_marital_status = 'D' AND customer.c_education_status = 'Unknown' AND ss_sales_price BETWEEN 100 AND 150 AND household_demographics.hd_dep_count = 3)
            OR (customer.c_marital_status = 'S' AND customer.c_education_status = 'College' AND ss_sales_price BETWEEN 50 AND 100 AND household_demographics.hd_dep_count = 1)
            OR (customer.c_marital_status = 'M' AND customer.c_education_status = '4 yr Degree' AND ss_sales_price BETWEEN 150 AND 200 AND household_demographics.hd_dep_count = 1)
        )
)

, states_segment AS (
    SELECT ss_sold_date_sk, ss_sales_price, ss_quantity, ss_wholesale_cost
    FROM store_sales
    JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
    JOIN store ON store_sales.ss_store_sk = store.s_store_sk
    WHERE (date_dim.d_year = 2001)
        AND (
            store.s_state IN ('SD', 'KS', 'MI')
            OR store.s_state IN ('MO', 'ND', 'CO')
            OR store.s_state IN ('NH', 'OH', 'TX')
        )
        AND store.s_country = 'United States'
)

SELECT
    AVG(ss_sales_price) AS avg_sales_price,
    AVG(ss_quantity) AS avg_sales_quantity,
    AVG(ss_wholesale_cost) AS avg_wholesale_cost,
    SUM(ss_wholesale_cost) AS total_wholesale_cost
FROM (
    SELECT * FROM filtered_customers
    UNION
    SELECT * FROM states_segment
) AS combined_data;
