WITH MonthlySales AS (
    SELECT
        s.store_name,
        c.company_name,
        i.brand_name,
        c.category_name,
        TO_DATE(t.calendar_date, 'YYYY-MM-DD') AS sales_date,
        SUM(f.sales_price) AS monthly_sales
    FROM
        store_sales s
        JOIN date_dim t ON s.date_id = t.date_id
        JOIN item i ON s.item_id = i.item_id
        JOIN category c ON i.category_id = c.category_id
    WHERE
        EXTRACT(YEAR FROM TO_DATE(t.calendar_date, 'YYYY-MM-DD')) = 2001
    GROUP BY
        s.store_name,
        c.company_name,
        i.brand_name,
        c.category_name,
        sales_date
),
MonthlyAvgSales AS (
    SELECT
        store_name,
        company_name,
        brand_name,
        category_name,
        sales_date,
        AVG(monthly_sales) OVER (PARTITION BY store_name, company_name, brand_name, category_name, EXTRACT(MONTH FROM sales_date)) AS avg_monthly_sales
    FROM
        MonthlySales
),
SalesDeviation AS (
    SELECT
        store_name,
        company_name,
        brand_name,
        category_name,
        sales_date,
        monthly_sales,
        avg_monthly_sales,
        (monthly_sales - avg_monthly_sales) / avg_monthly_sales AS deviation,
        LAG((monthly_sales - avg_monthly_sales) / avg_monthly_sales) OVER (PARTITION BY store_name, company_name, brand_name, category_name ORDER BY sales_date) AS prev_deviation,
        LEAD((monthly_sales - avg_monthly_sales) / avg_monthly_sales) OVER (PARTITION BY store_name, company_name, brand_name, category_name ORDER BY sales_date) AS next_deviation
    FROM
        MonthlyAvgSales
)
SELECT
    store_name,
    company_name,
    brand_name,
    category_name,
    sales_date,
    monthly_sales,
    avg_monthly_sales,
    deviation,
    prev_deviation,
    next_deviation
FROM
    SalesDeviation
WHERE
    ABS(deviation) > 0.10
ORDER BY
    ABS(deviation) DESC,
    store_name,
    sales_date
LIMIT 100;
