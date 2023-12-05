SELECT
    ca.ca_city AS customer_city, -- City where customer resided
    s.s_city AS store_city,      -- City of the store
    ss.ss_coupon_amt,            -- Coupon amount
    ss.ss_net_profit             -- Net profit
FROM
    customer c
JOIN customer_address ca
    ON c.c_current_addr_sk = ca.ca_address_sk
JOIN store_sales ss
    ON c.c_customer_sk = ss.ss_customer_sk
JOIN date_dim d
    ON ss.ss_sold_date_sk = d.d_date_sk
JOIN store s
    ON ss.ss_store_sk = s.s_store_sk
WHERE
    ca.ca_city <> s.s_city                 -- Customers who reside out of town
    AND d.d_day_name IN ('Saturday', 'Sunday') -- Purchases made on weekends
    AND s.s_city IN ('City1', 'City2', 'City3', 'City4', 'City5') -- Replace with the specific cities
    AND d.d_year BETWEEN 2022 AND 2024    -- Span of three consecutive years, replace with actual years
    AND c.c_dep_count = SPECIFIED_NUMBER  -- Replace with specified number of dependents
    AND c.c_vehicle_count = 0             -- Customers with no vehicles
ORDER BY
    c.c_last_name,
    c.c_first_name,
    ca.ca_city,
    s.s_city,
    ss.ss_ticket_number
LIMIT 100;
