SELECT i_manager_id AS store_manager,
       d_month_seq AS d_moy,
       SUM(ss_sales_price) AS sum_sales,
       AVG(ss_sales_price) AS avg_monthly_sales
FROM item
JOIN store_sales ON item.i_item_sk = store_sales.ss_item_sk
JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
WHERE (item.i_item_sk, item.i_manager_id) IN (
    -- Categories, Classes, and Brands for the first set of conditions
    SELECT i_item_sk, i_manager_id
    FROM item
    WHERE item.i_item_sk IN (
        -- Categories
        SELECT i_item_sk 
        FROM item
        WHERE i_item_sk IN (
            SELECT i_item_sk 
            FROM item
            WHERE i_item_sk IN (
                SELECT i_item_sk FROM item WHERE i_item_sk IN (
                    SELECT i_item_sk FROM item WHERE column1 = 'Books' OR column1 = 'Children'
                )
                OR column2 = 'Electronics'
            )
            OR column3 = 'Women' OR column3 = 'Music' OR column3 = 'Men'
        )
        -- Classes
        AND column4 = 'personal' OR column4 = 'portable' OR column4 = 'reference' OR column4 = 'self-help'
        -- Brands
        AND column5 = 'scholaramalgamalg #14' OR column5 = 'scholaramalgamalg #7' OR column5 = 'exportiunivamalg #9' OR column5 = 'scholaramalgamalg #9'
    )
    -- Categories, Classes, and Brands for the second set of conditions
    OR (column1 = 'Accessories' OR column1 = 'Classical' OR column1 = 'Fragrances' OR column1 = 'Pants') AND (column2 = 'personal' OR column2 = 'portable' OR column2 = 'reference' OR column2 = 'self-help') AND (column3 = 'scholaramalgamalg #14' OR column3 = 'scholaramalgamalg #7' OR column3 = 'exportiunivamalg #9' OR column3 = 'scholaramalgamalg #9')
)
GROUP BY i_manager_id, d_month_seq
HAVING avg_monthly_sales > 0 AND (sum_sales - avg_monthly_sales) > (0.1 * sum_sales)
ORDER BY i_manager_id, avg_monthly_sales DESC, sum_sales DESC
LIMIT 100;