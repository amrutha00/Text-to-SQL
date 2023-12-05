WITH RelevantCustomers AS (
  SELECT 
    c_customer_sk
  FROM
    customer c
  JOIN customer_address ca ON c.c_current_addr_sk = ca.ca_address_sk
  WHERE
    ca.ca_county IN ('List of Specific Counties')
),
Purchases AS (
  SELECT
    ss_customer_sk
  FROM
    store_sales
  WHERE
    ss_sold_date_sk BETWEEN 'Start Date SK' AND 'End Date SK'
  INTERSECT
  SELECT
    ws_customer_sk
  FROM
    web_sales
  WHERE
    ws_sold_date_sk BETWEEN 'Start Date SK' AND 'End Date SK'
)
SELECT
  c.c_gender,
  c.c_marital_status,
  c.c_education_status,
  c.c_purchase_estimate,
  c.c_credit_rating,
  c.c_dep_count,
  c.c_dep_employed_count,
  c.c_dep_college_count,
  COUNT(*) as customer_count
FROM 
  customer c
JOIN RelevantCustomers rc ON c.c_customer_sk = rc.c_customer_sk
JOIN Purchases p ON c.c_customer_sk = p.ss_customer_sk
GROUP BY
  c.c_gender,
  c.c_marital_status,
  c.c_education_status,
  c.c_purchase_estimate,
  c.c_credit_rating,
  c.c_dep_count,
  c.c_dep_employed_count,
  c.c_dep_college_count
ORDER BY 
  c.c_gender,
  c.c_marital_status,
  c.c_education_status,
  c.c_purchase_estimate,
  c.c_credit_rating,
  c.c_dep_count,
  c.c_dep_employed_count,
  c.c_dep_college_count DESC
LIMIT 100;
