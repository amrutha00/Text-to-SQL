SELECT c_customer_id, c_birth_country
FROM customer
WHERE c_customer_sk IN (
    SELECT ss_customer_sk
    FROM store_sales
    WHERE
        ss_sold_date_sk >= 365
        AND ss_sold_date_sk <= 730
        AND ss_sales_price > 0
        AND ss_ext_sales_price > 0
        AND ss_ext_sales_price > (
            SELECT ss_ext_sales_price
            FROM store_sales
            WHERE
                ss_sold_date_sk >= 0
                AND ss_sold_date_sk <= 365
                AND ss_sales_price > 0
                AND ss_ext_sales_price > 0
                AND ss_quantity > 0
                AND ss_ext_sales_price / ss_quantity >= (
                    SELECT AVG(ss_ext_sales_price / ss_quantity)
                    FROM store_sales
                    WHERE
                        ss_sold_date_sk >= 0
                        AND ss_sold_date_sk <= 365
                        AND ss_sales_price > 0
                        AND ss_ext_sales_price > 0
                        AND ss_quantity > 0
                        AND ss_ext_sales_price / ss_quantity > 0
                )
        )
)
ORDER BY c_customer_id
LIMIT 100;