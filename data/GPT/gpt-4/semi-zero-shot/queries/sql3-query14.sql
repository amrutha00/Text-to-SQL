WITH SalesData AS (
    SELECT
        s1.channel_id,
        s1.brand_id,
        s1.class_id,
        s1.category_id,
        s1.year_id,
        SUM(s1.quantity * s1.list_price) AS sales
    FROM
        sales s1
    WHERE
        s1.year_id BETWEEN 2000 AND 2002
        AND EXISTS (
            SELECT 1
            FROM
                sales s2
            WHERE
                s2.channel_id = s1.channel_id
                AND s2.brand_id = s1.brand_id
                AND s2.class_id = s1.class_id
                AND s2.category_id = s1.category_id
                AND s2.year_id = s1.year_id - 1
        )
    GROUP BY
        s1.channel_id,
        s1.brand_id,
        s1.class_id,
        s1.category_id,
        s1.year_id
),
AvgSales AS (
    SELECT
        channel_id,
        brand_id,
        class_id,
        category_id,
        AVG(sales) AS average_sales
    FROM
        SalesData
    GROUP BY
        channel_id,
        brand_id,
        class_id,
        category_id
),
TotalSales AS (
    SELECT
        s.channel_id,
        s.brand_id,
        s.class_id,
        s.category_id,
        SUM(s.sales) AS total_sales,
        COUNT(s.sales) AS total_sales_count
    FROM
        SalesData s
    GROUP BY
        s.channel_id,
        s.brand_id,
        s.class_id,
        s.category_id
),
CrossChannelSales AS (
    SELECT
        t.channel_id,
        t.brand_id,
        t.class_id,
        t.category_id,
        t.total_sales,
        t.total_sales_count
    FROM
        TotalSales t
    JOIN AvgSales a ON
        t.channel_id = a.channel_id
        AND t.brand_id = a.brand_id
        AND t.class_id = a.class_id
        AND t.category_id = a.category_id
    WHERE
        t.total_sales > a.average_sales
)
SELECT
    c.channel_id,
    c.brand_id,
    c.class_id,
    c.category_id,
    c.total_sales,
    c.total_sales_count
FROM
    CrossChannelSales c;

WITH StoreSales AS (
    SELECT
        year_id,
        store_id,
        SUM(sales_amount) AS total_sales
    FROM
        store_sales
    WHERE
        year_id IN (2001, 2002)
    GROUP BY
        year_id,
        store_id
)
SELECT
    s1.year_id AS current_year,
    s2.year_id AS previous_year,
    s1.store_id,
    s1.total_sales AS current_year_sales,
    s2.total_sales AS previous_year_sales
FROM
    StoreSales s1
LEFT JOIN StoreSales s2 ON
    s1.year_id = 2002
    AND s2.year_id = 2001
    AND s1.store_id = s2.store_id;
