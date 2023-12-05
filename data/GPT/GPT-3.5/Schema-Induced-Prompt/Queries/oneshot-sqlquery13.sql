SELECT AVG(ss_quantity) AS average_sales_quantity,
       AVG(ss_ext_sales_price) AS average_sales_price,
       AVG(ss_ext_wholesale_cost) AS average_wholesale_cost,
       SUM(ss_ext_wholesale_cost) AS total_wholesale_cost
FROM store_sales
JOIN customer_demographics ON store_sales.cd_demo_sk = customer_demographics.cd_demo_sk
JOIN household_demographics ON customer_demographics.cd_demo_sk = household_demographics.hd_demo_sk
JOIN customer_address ON store_sales.ca_address_sk = customer_address.ca_address_sk
JOIN date_dim ON store_sales.d_date_sk = date_dim.d_date_sk
WHERE date_dim.d_year = 2001
  AND customer_demographics.cd_marital_status = 'D'
  AND customer_demographics.cd_education_status = 'Unknown'
  AND store_sales.ss_ext_sales_price BETWEEN 100.00 AND 150.00
  AND household_demographics.hd_dep_count = 3
  AND customer_address.ca_country = 'United States'
  AND (customer_address.ca_state = 'SD' OR customer_address.ca_state = 'KS' OR customer_address.ca_state = 'MI')
UNION
SELECT AVG(ss_quantity) AS average_sales_quantity,
       AVG(ss_ext_sales_price) AS average_sales_price,
       AVG(ss_ext_wholesale_cost) AS average_wholesale_cost,
       SUM(ss_ext_wholesale_cost) AS total_wholesale_cost
FROM store_sales
JOIN customer_demographics ON store_sales.cd_demo_sk = customer_demographics.cd_demo_sk
JOIN household_demographics ON customer_demographics.cd_demo_sk = household_demographics.hd_demo_sk
JOIN customer_address ON store_sales.ca_address_sk = customer_address.ca_address_sk
JOIN date_dim ON store_sales.d_date_sk = date_dim.d_date_sk
WHERE date_dim.d_year = 2001
  AND customer_demographics.cd_marital_status = 'S'
  AND customer_demographics.cd_education_status = 'College'
  AND store_sales.ss_ext_sales_price BETWEEN 50.00 AND 100.00
  AND household_demographics.hd_dep_count = 1
  AND customer_address.ca_country = 'United States'
  AND (customer_address.ca_state = 'MO' OR customer_address.ca_state = 'ND' OR customer_address.ca_state = 'CO')
UNION
SELECT AVG(ss_quantity) AS average_sales_quantity,
       AVG(ss_ext_sales_price) AS average_sales_price,
       AVG(ss_ext_wholesale_cost) AS average_wholesale_cost,
       SUM(ss_ext_wholesale_cost) AS total_wholesale_cost
FROM store_sales
JOIN customer_demographics ON store_sales.cd_demo_sk = customer_demographics.cd_demo_sk
JOIN household_demographics ON customer_demographics.cd_demo_sk = household_demographics.hd_demo_sk
JOIN customer_address ON store_sales.ca_address_sk = customer_address.ca_address_sk
JOIN date_dim ON store_sales.d_date_sk = date_dim.d_date_sk
WHERE date_dim.d_year = 2001
  AND customer_demographics.cd_marital_status = 'M'
  AND customer_demographics.cd_education_status = '4 yr Degree'
  AND store_sales.ss_ext_sales_price BETWEEN 150.00 AND 200.00
  AND household_demographics.hd_dep_count = 1
  AND customer_address.ca_country = 'United States'
  AND (customer_address.ca_state = 'NH' OR customer_address.ca_state = 'OH' OR customer_address.ca_state = 'TX')