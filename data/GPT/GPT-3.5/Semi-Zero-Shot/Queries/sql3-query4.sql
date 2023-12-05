WITH SalesData AS (
    SELECT
        c.c_customer_id AS CustomerID,
        c.c_first_name AS FirstName,
        c.c_last_name AS LastName,
        c.c_country AS CountryOfOrigin,
        s.sale_type AS SaleType,
        s.s_year AS SaleYear,
        SUM(s.s_net_profit) AS TotalSalesAmount
    FROM
        customer AS c
    JOIN
        store_sales AS s
    ON
        c.c_customer_sk = s.s_customer_sk
    WHERE
        (s.sale_type = 's' OR s.sale_type = 'c' OR sale_type = 'w')
        AND (s.s_year = 1999 OR s.s_year = 2000)
    GROUP BY
        c.c_customer_id,
        c.c_first_name,
        c.c_last_name,
        c.c_country,
        s.sale_type,
        s.s_year
),
SalesData2000 AS (
    SELECT
        CustomerID,
        SaleType,
        SUM(TotalSalesAmount) AS TotalSales2000
    FROM
        SalesData
    WHERE
        SaleYear = 2000
    GROUP BY
        CustomerID,
        SaleType
),
SalesData1999 AS (
    SELECT
        CustomerID,
        SaleType,
        SUM(TotalSalesAmount) AS TotalSales1999
    FROM
        SalesData
    WHERE
        SaleYear = 1999
    GROUP BY
        CustomerID,
        SaleType
)
SELECT DISTINCT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    c.CountryOfOrigin
FROM (
    SELECT
        a.CustomerID,
        a.SaleType,
        a.TotalSales2000 / b.TotalSales1999 AS CatalogRatio2000,
        c.TotalSales2000 / d.TotalSales1999 AS InStoreRatio2000,
        e.TotalSales2000 / f.TotalSales1999 AS WebRatio2000
    FROM
        SalesData2000 AS a
    JOIN
        SalesData1999 AS b
    ON
        a.CustomerID = b.CustomerID
        AND a.SaleType = 'c' AND b.SaleType = 'c'
    JOIN
        SalesData2000 AS c
    ON
        a.CustomerID = c.CustomerID
        AND a.SaleType = 's' AND c.SaleType = 's'
    JOIN
        SalesData2000 AS e
    ON
        a.CustomerID = e.CustomerID
        AND a.SaleType = 'w' AND e.SaleType = 'w'
    JOIN
        SalesData1999 AS d
    ON
        a.CustomerID = d.CustomerID
        AND a.SaleType = 's' AND d.SaleType = 's'
    JOIN
        SalesData1999 AS f
    ON
        a.CustomerID = f.CustomerID
        AND a.SaleType = 'w' AND f.SaleType = 'w'
    WHERE
        a.TotalSales2000 / b.TotalSales1999 > c.TotalSales2000 / d.TotalSales1999
        AND a.TotalSales2000 / b.TotalSales1999 > e.TotalSales2000 / f.TotalSales1999
) AS ValidCustomers
JOIN
    customer AS c
ON
    ValidCustomers.CustomerID = c.c_customer_id
ORDER BY
    c.CustomerID,
    c.FirstName,
    c.LastName,
    c.CountryOfOrigin
LIMIT 100;
