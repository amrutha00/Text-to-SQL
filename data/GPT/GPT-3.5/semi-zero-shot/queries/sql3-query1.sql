-- Calculate the average return rate for each store in South Dakota in the year 2000
WITH StoreAvgReturn AS (
    SELECT
        s.s_store_id,
        AVG(sr.return_quantity) AS avg_return_quantity
    FROM
        store_sales sr
        JOIN store s ON sr.s_store_sk = s.s_store_sk
        JOIN date_dim dd ON sr.d_date_sk = dd.d_date_sk
        JOIN customer c ON sr.c_customer_sk = c.c_customer_sk
        JOIN household_demographics hd ON c.c_current_hdemo_sk = hd.hd_demo_sk
        JOIN store_returns str ON sr.s_store_sk = str.s_store_sk
    WHERE
        dd.d_year = 2000
        AND hd.hd_state = 'SD'
    GROUP BY
        s.s_store_id
),

-- Calculate the total returns for each customer at each store in the year 2000
CustomerTotalReturns AS (
    SELECT
        c.c_customer_id,
        sr.s_store_id,
        SUM(sr.return_quantity) AS total_return_quantity
    FROM
        store_sales sr
        JOIN customer c ON sr.c_customer_sk = c.c_customer_sk
        JOIN date_dim dd ON sr.d_date_sk = dd.d_date_sk
    WHERE
        dd.d_year = 2000
    GROUP BY
        c.c_customer_id, sr.s_store_id
),

-- Calculate the threshold for significantly more frequent returns (20% above the average)
Threshold AS (
    SELECT
        str.s_store_id,
        sa.avg_return_quantity,
        sa.avg_return_quantity * 1.2 AS threshold_return_quantity
    FROM
        StoreAvgReturn sa
        JOIN store_returns str ON sa.s_store_id = str.s_store_id
)

-- Retrieve the customer IDs of those whose returns exceed the threshold
SELECT
    DISTINCT ctr.c_customer_id
FROM
    CustomerTotalReturns ctr
    JOIN Threshold t ON ctr.s_store_id = t.s_store_id
WHERE
    ctr.total_return_quantity > t.threshold_return_quantity
ORDER BY
    ctr.c_customer_id
LIMIT 100;
