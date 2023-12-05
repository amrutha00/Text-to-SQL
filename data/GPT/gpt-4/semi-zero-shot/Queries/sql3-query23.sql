WITH frequently_sold_items_subquery AS (
    SELECT
        item_id
    FROM
        store_sales
    WHERE
        sale_date BETWEEN '2000-01-01' AND '2003-12-31'
    GROUP BY
        item_id
    HAVING
        COUNT(DISTINCT sale_date) > 4
),

max_store_sales_subquery AS (
    SELECT
        MAX(total_sales) AS max_store_sales
    FROM
        (SELECT
            customer_id,
            SUM(sales_price) AS total_sales
        FROM
            store_sales
        WHERE
            sale_date BETWEEN '2000-01-01' AND '2003-12-31'
        GROUP BY
            customer_id) subquery
),

best_customers_subquery AS (
    SELECT
        customer_id
    FROM
        (SELECT
            customer_id,
            SUM(sales_price) AS total_sales
        FROM
            store_sales
        WHERE
            sale_date BETWEEN '2000-01-01' AND '2003-12-31'
        GROUP BY
            customer_id) subquery
    WHERE
        total_sales >= (SELECT PERCENTILE_CONT(0.05) WITHIN GROUP (ORDER BY total_sales)
                        FROM
                            (SELECT
                                customer_id,
                                SUM(sales_price) AS total_sales
                            FROM
                                store_sales
                            WHERE
                                sale_date BETWEEN '2000-01-01' AND '2003-12-31'
                            GROUP BY
                                customer_id)
                        )
),

total_sales_for_specific_month AS (
    SELECT
        SUM(sales_price) AS total_sales
    FROM
        store_sales
    WHERE
        sale_date BETWEEN '2000-01-01' AND '2000-01-31'
        AND customer_id IN (SELECT customer_id FROM best_customers_subquery)
        AND item_id IN (SELECT item_id FROM frequently_sold_items_subquery)
    UNION
    SELECT
        SUM(sales_price) AS total_sales
    FROM
        web_sales
    WHERE
        sale_date BETWEEN '2000-01-01' AND '2000-01-31'
        AND customer_id IN (SELECT customer_id FROM best_customers_subquery)
        AND item_id IN (SELECT item_id FROM frequently_sold_items_subquery)
)

SELECT
    *
FROM
    total_sales_for_specific_month
LIMIT 100;
