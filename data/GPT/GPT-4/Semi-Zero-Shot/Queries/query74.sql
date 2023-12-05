CREATE TEMP TABLE year_total AS (
    -- Store sales data for the years 1999 and 2000
    SELECT
        ss.ss_customer_sk AS customer_id,
        c.c_first_name,
        c.c_last_name,
        d.d_year,
        's' AS sale_type,
        STDDEV(ss.ss_net_paid) AS year_stddev
    FROM customer c
    JOIN store_sales ss ON c.c_customer_sk = ss.ss_customer_sk
    JOIN date_dim d ON ss.ss_sold_date_sk = d.d_date_sk
    WHERE d.d_year IN (1999, 2000)
    GROUP BY ss.ss_customer_sk, c.c_first_name, c.c_last_name, d.d_year

    UNION ALL

    -- Web sales data for the years 1999 and 2000
    SELECT
        ws.ws_customer_sk AS customer_id,
        c.c_first_name,
        c.c_last_name,
        d.d_year,
        'w' AS sale_type,
        STDDEV(ws.ws_net_paid) AS year_stddev
    FROM customer c
    JOIN web_sales ws ON c.c_customer_sk = ws.ws_customer_sk
    JOIN date_dim d ON ws.ws_sold_date_sk = d.d_date_sk
    WHERE d.d_year IN (1999, 2000)
    GROUP BY ws.ws_customer_sk, c.c_first_name, c.c_last_name, d.d_year
);

-- Select customers meeting the conditions
SELECT
    s1999.customer_id,
    s1999.c_first_name,
    s1999.c_last_name
FROM (
    SELECT * FROM year_total WHERE d_year = 1999 AND sale_type = 's'
) s1999
JOIN (
    SELECT * FROM year_total WHERE d_year = 2000 AND sale_type = 's'
) s2000 ON s1999.customer_id = s2000.customer_id
JOIN (
    SELECT * FROM year_total WHERE d_year = 1999 AND sale_type = 'w'
) w1999 ON s1999.customer_id = w1999.customer_id
JOIN (
    SELECT * FROM year_total WHERE d_year = 2000 AND sale_type = 'w'
) w2000 ON s1999.customer_id = w2000.customer_id
WHERE 
    s1999.year_stddev > 0 AND
    s2000.year_stddev > 0 AND
    w1999.year_stddev > 0 AND
    w2000.year_stddev > 0 AND
    (w2000.year_stddev - w1999.year_stddev) > (s2000.year_stddev - s1999.year_stddev)
ORDER BY
    s1999.c_first_name,
    s1999.customer_id,
    s1999.c_last_name
LIMIT 100;
