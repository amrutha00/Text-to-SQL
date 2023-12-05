WITH FilteredSales AS (
    SELECT ss_customer_sk, ss_sold_date_sk, ss_item_sk, COUNT(ss_item_sk) as item_count, ss_county
    FROM store_sales
    JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
    JOIN store ON store_sales.ss_store_sk = store.s_store_sk
    WHERE date_dim.d_year IN (2000, 2001, 2002)
    AND date_dim.d_day_of_month BETWEEN 1 AND 2
    AND store.s_county IN ('Fairfield County', 'Walker County', 'Daviess County', 'Barrow County')
    GROUP BY ss_customer_sk, ss_sold_date_sk, ss_item_sk, ss_county
    HAVING COUNT(ss_item_sk) BETWEEN 1 AND 5
)

, YearlyPurchases AS (
    SELECT ss_customer_sk
    FROM FilteredSales
    GROUP BY ss_customer_sk, EXTRACT(YEAR FROM ss_sold_date_sk)
    HAVING COUNT(DISTINCT ss_county) = 4
)

, ValidCustomers AS (
    SELECT ss_customer_sk
    FROM YearlyPurchases
    GROUP BY ss_customer_sk
    HAVING COUNT(ss_customer_sk) = 3
)

SELECT vc.ss_customer_sk, c.c_last_name, SUM(fs.item_count) as total_items
FROM ValidCustomers vc
JOIN FilteredSales fs ON vc.ss_customer_sk = fs.ss_customer_sk
JOIN customer c ON vc.ss_customer_sk = c.c_customer_sk
WHERE (c.c_dependent_count::FLOAT / NULLIF(c.c_vehicle_count,0)::FLOAT) > 1
AND c.c_buy_potential IN ('<list of specific buy potentials>')
GROUP BY vc.ss_customer_sk, c.c_last_name
ORDER BY total_items DESC, c.c_last_name ASC;
