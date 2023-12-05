WITH Year1224WebSales AS (
    SELECT
        ws.category,
        ws.class,
        SUM(ws.net_paid) AS total_net_paid_sales,
        td.location_hierarchy,
        RANK() OVER (PARTITION BY td.location_hierarchy, ws.category ORDER BY SUM(ws.net_paid) DESC) AS sales_rank
    FROM
        web_sales ws
    JOIN
        time_dim td ON ws.time_id = td.time_id
    WHERE
        td.the_year = 1224
    GROUP BY
        ws.category, ws.class, td.location_hierarchy
)
SELECT
    category,
    class,
    total_net_paid_sales,
    location_hierarchy,
    sales_rank
FROM
    Year1224WebSales
ORDER BY
    location_hierarchy DESC, category
LIMIT 100;
