SELECT c_customer_id, c_first_name, c_last_name, c_birth_country
FROM customer
WHERE c_customer_id IN (
    SELECT ss_customer_sk
    FROM store_sales
    WHERE ss_sold_date_sk IN (
        SELECT d_date_sk
        FROM date_dim
        WHERE d_year = 2002 AND d_following_holiday = 'Y'
    )
    GROUP BY ss_customer_sk
    HAVING SUM(
        CASE
            WHEN ss_sold_date_sk IN (
                SELECT d_date_sk
                FROM date_dim
                WHERE d_year = 2002
            ) THEN ss_sales_price
            ELSE 0
        END
    ) > (
        SELECT SUM(ss_sales_price)
        FROM store_sales
        WHERE ss_sold_date_sk IN (
            SELECT d_date_sk
            FROM date_dim
            WHERE d_year = 2001
        )
        GROUP BY ss_customer_sk
    )
)
ORDER BY c_customer_id, c_first_name, c_last_name, c_birth_country
LIMIT 100;