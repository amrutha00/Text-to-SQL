WITH CTE_Customers AS (
  -- Find all customers who made the specific purchases in May 1998
  SELECT DISTINCT cs_bill_customer_sk AS customer_sk
  FROM catalog_sales, date_dim, item
  WHERE cs_sold_date_sk = d_date_sk
    AND cs_item_sk = i_item_sk
    AND i_category = 'Women'
    AND i_class = 'maternity'
    AND d_month_seq BETWEEN 
        (SELECT d_month_seq FROM date_dim WHERE d_year = 1998 AND d_month = 5)
    AND 
        (SELECT d_month_seq FROM date_dim WHERE d_year = 1998 AND d_month = 5)

  UNION

  SELECT DISTINCT ws_bill_customer_sk AS customer_sk
  FROM web_sales, date_dim, item
  WHERE ws_sold_date_sk = d_date_sk
    AND ws_item_sk = i_item_sk
    AND i_category = 'Women'
    AND i_class = 'maternity'
    AND d_month_seq BETWEEN 
        (SELECT d_month_seq FROM date_dim WHERE d_year = 1998 AND d_month = 5)
    AND 
        (SELECT d_month_seq FROM date_dim WHERE d_year = 1998 AND d_month = 5)
),
InStorePurchases AS (
  SELECT ss_customer_sk, SUM(ss_net_paid) AS revenue
  FROM store_sales, date_dim, customer, store
  WHERE ss_sold_date_sk = d_date_sk
    AND ss_customer_sk = c_customer_sk
    AND ss_store_sk = s_store_sk
    AND c_current_addr_sk = s_address_sk
    AND d_month_seq BETWEEN 
        (SELECT d_month_seq FROM date_dim WHERE d_year = 1998 AND d_month = 6)
    AND 
        (SELECT d_month_seq FROM date_dim WHERE d_year = 1998 AND d_month = 8)
  GROUP BY ss_customer_sk
)
SELECT
  CASE 
    WHEN revenue BETWEEN 0 AND 50 THEN '0-50'
    WHEN revenue BETWEEN 50.01 AND 100 THEN '50-100'
    -- ... You can continue this pattern for the higher segments
    ELSE '500+' -- This would be a catch-all for values greater than your highest defined segment
  END AS revenue_segment,
  COUNT(*) AS number_of_customers
FROM InStorePurchases
WHERE ss_customer_sk IN (SELECT customer_sk FROM CTE_Customers)
GROUP BY 1
ORDER BY 1;
