WITH CustomerConditions AS (
    SELECT c_customer_sk
    FROM customer
    WHERE 
        (c_current_cdemo_sk IS NOT NULL AND 
         (
           (c_dep_count = 1 AND c_vehicle_count <= 2) OR 
           (c_dep_count = 2 AND c_vehicle_count <= 4) OR 
           (c_dep_count = 3 AND c_vehicle_count <= 5)
         )
        )
)

SELECT 
    SUM(CASE WHEN s_time BETWEEN '08:30' AND '09:00' THEN ss_quantity ELSE 0 END) AS h8_30_to_9,
    SUM(CASE WHEN s_time BETWEEN '09:00' AND '09:30' THEN ss_quantity ELSE 0 END) AS h9_to_9_30,
    SUM(CASE WHEN s_time BETWEEN '09:30' AND '10:00' THEN ss_quantity ELSE 0 END) AS h9_30_to_10,
    SUM(CASE WHEN s_time BETWEEN '10:00' AND '10:30' THEN ss_quantity ELSE 0 END) AS h10_to_10_30,
    SUM(CASE WHEN s_time BETWEEN '10:30' AND '11:00' THEN ss_quantity ELSE 0 END) AS h10_30_to_11,
    SUM(CASE WHEN s_time BETWEEN '11:00' AND '11:30' THEN ss_quantity ELSE 0 END) AS h11_to_11_30,
    SUM(CASE WHEN s_time BETWEEN '11:30' AND '12:00' THEN ss_quantity ELSE 0 END) AS h11_30_to_12
FROM store_sales
JOIN CustomerConditions ON store_sales.ss_customer_sk = CustomerConditions.c_customer_sk
JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
JOIN store ON store_sales.ss_store_sk = store.s_store_sk
JOIN time_dim ON date_dim.d_time_sk = time_dim.t_time_sk
WHERE s_store_name = 'ese'
GROUP BY 
    CASE 
        WHEN s_time BETWEEN '08:30' AND '09:00' THEN 'h8_30_to_9'
        WHEN s_time BETWEEN '09:00' AND '09:30' THEN 'h9_to_9_30'
        WHEN s_time BETWEEN '09:30' AND '10:00' THEN 'h9_30_to_10'
        WHEN s_time BETWEEN '10:00' AND '10:30' THEN 'h10_to_10_30'
        WHEN s_time BETWEEN '10:30' AND '11:00' THEN 'h10_30_to_11'
        WHEN s_time BETWEEN '11:00' AND '11:30' THEN 'h11_to_11_30'
        WHEN s_time BETWEEN '11:30' AND '12:00' THEN 'h11_30_to_12'
    END
ORDER BY 1;
