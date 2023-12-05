SELECT
    c.ZIP_CODE,
    SUM(cs.SALES_PRICE) AS total_catalog_sales
FROM
    CUSTOMER c
JOIN
    CATALOG_SALES cs
ON
    c.CUSTOMER_ID = cs.CUSTOMER_ID
JOIN
    DATE_DIM d
ON
    cs.DATE_ID = d.DATE_ID
WHERE
    d.YEAR = 2001
    AND d.QUARTER = 1
GROUP BY
    c.ZIP_CODE
ORDER BY
    total_catalog_sales DESC
LIMIT 100;
