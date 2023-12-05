WITH CustomerStats AS (
  SELECT
    c.c_state AS Customer_State,
    c.c_gender AS Customer_Gender,
    c.c_marital_status AS Customer_Marital_Status,
    COUNT(DISTINCT c.c_customer_id) AS Customer_Count,
    MIN(c.c_dep_count) AS Min_Dependents,
    MAX(c.c_dep_count) AS Max_Dependents,
    AVG(c.c_dep_count) AS Avg_Dependents,
    COUNT(DISTINCT c.c_dep_count) AS Distinct_Dependent_Count,
    SUM(CASE WHEN c.c_dep_employed_count > 0 THEN 1 ELSE 0 END) AS Employed_Dependent_Count,
    SUM(CASE WHEN c.c_dep_college_count > 0 THEN 1 ELSE 0 END) AS Dependents_in_College_Count
  FROM customer c
  JOIN date_dim d ON c.c_first_sales_date_id = d.d_date_sk
  WHERE d.d_year = 2001
    AND d.d_qoy = 4
  GROUP BY c.c_state, c.c_gender, c.c_marital_status
)

SELECT
  Customer_State,
  Customer_Gender,
  Customer_Marital_Status,
  Customer_Count,
  Min_Dependents,
  Max_Dependents,
  Avg_Dependents,
  Distinct_Dependent_Count,
  Employed_Dependent_Count,
  Dependents_in_College_Count
FROM CustomerStats
ORDER BY
  Customer_State,
  Customer_Gender,
  Customer_Marital_Status,
  Customer_Count,
  Employed_Dependent_Count,
  Dependents_in_College_Count
LIMIT 100;
