WITH RelevantSales AS (
  SELECT
    c.customer_id,
    s.sale_id,
    s.sale_date,
    s.sale_amount
  FROM
    customer c
    JOIN store_sales s ON c.customer_id = s.customer_id
  WHERE
    EXTRACT(YEAR FROM s.sale_date) = 1998
    AND EXTRACT(MONTH FROM s.sale_date) BETWEEN 5 AND 7
),
WebCatalogSales AS (
  SELECT
    c.customer_id,
    w.sale_id,
    w.sale_date,
    w.sale_amount
  FROM
    customer c
    JOIN web_sales w ON c.customer_id = w.customer_id
  WHERE
    EXTRACT(YEAR FROM w.sale_date) = 1998
    AND EXTRACT(MONTH FROM w.sale_date) BETWEEN 5 AND 7
),
NearResidenceSales AS (
  SELECT
    c.customer_id,
    sr.sale_id,
    sr.sale_date,
    sr.sale_amount
  FROM
    customer c
    JOIN store_sales sr ON c.customer_id = sr.customer_id
  WHERE
    EXTRACT(YEAR FROM sr.sale_date) = 1998
    AND EXTRACT(MONTH FROM sr.sale_date) BETWEEN 8 AND 10
)
SELECT
  CASE
    WHEN TotalSaleAmount >= 0 AND TotalSaleAmount < 50 THEN '0-49.99'
    WHEN TotalSaleAmount >= 50 AND TotalSaleAmount < 100 THEN '50-99.99'
    -- Add more segments as needed
  END AS RevenueSegment,
  COUNT(*) AS CustomerCount
FROM (
  SELECT
    customer_id,
    SUM(sale_amount) AS TotalSaleAmount
  FROM (
    SELECT customer_id, sale_amount FROM RelevantSales
    UNION ALL
    SELECT customer_id, sale_amount FROM WebCatalogSales
    UNION ALL
    SELECT customer_id, sale_amount FROM NearResidenceSales
  ) AllSales
  GROUP BY customer_id
) SalesByCustomer
GROUP BY RevenueSegment
ORDER BY RevenueSegment;
