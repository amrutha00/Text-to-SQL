WITH BucketCounts AS (
    SELECT
        CASE 
            WHEN ss_quantity BETWEEN 1 AND 20 THEN 1
            WHEN ss_quantity BETWEEN 21 AND 40 THEN 2
            WHEN ss_quantity BETWEEN 41 AND 60 THEN 3
            WHEN ss_quantity BETWEEN 61 AND 80 THEN 4
            WHEN ss_quantity BETWEEN 81 AND 100 THEN 5
        END AS bucket,
        COUNT(*) AS trans_count
    FROM store_sales
    GROUP BY 
        CASE 
            WHEN ss_quantity BETWEEN 1 AND 20 THEN 1
            WHEN ss_quantity BETWEEN 21 AND 40 THEN 2
            WHEN ss_quantity BETWEEN 41 AND 60 THEN 3
            WHEN ss_quantity BETWEEN 61 AND 80 THEN 4
            WHEN ss_quantity BETWEEN 81 AND 100 THEN 5
        END
)

SELECT
    CASE 
        WHEN ss_quantity BETWEEN 1 AND 20 THEN 1
        WHEN ss_quantity BETWEEN 21 AND 40 THEN 2
        WHEN ss_quantity BETWEEN 41 AND 60 THEN 3
        WHEN ss_quantity BETWEEN 61 AND 80 THEN 4
        WHEN ss_quantity BETWEEN 81 AND 100 THEN 5
    END AS bucket,
    CASE 
        WHEN ss_quantity BETWEEN 1 AND 20 AND trans_count > 2972190 THEN AVG(ss_ext_sales_price)
        WHEN ss_quantity BETWEEN 21 AND 40 AND trans_count > 4505785 THEN AVG(ss_ext_sales_price)
        WHEN ss_quantity BETWEEN 41 AND 60 AND trans_count > 1575726 THEN AVG(ss_ext_sales_price)
        WHEN ss_quantity BETWEEN 61 AND 80 AND trans_count > 3188917 THEN AVG(ss_ext_sales_price)
        WHEN ss_quantity BETWEEN 81 AND 100 AND trans_count > 3525216 THEN AVG(ss_ext_sales_price)
        ELSE AVG(ss_net_profit)
    END AS average_value
FROM store_sales
JOIN BucketCounts
    ON CASE 
        WHEN ss_quantity BETWEEN 1 AND 20 THEN 1
        WHEN ss_quantity BETWEEN 21 AND 40 THEN 2
        WHEN ss_quantity BETWEEN 41 AND 60 THEN 3
        WHEN ss_quantity BETWEEN 61 AND 80 THEN 4
        WHEN ss_quantity BETWEEN 81 AND 100 THEN 5
    END = BucketCounts.bucket
GROUP BY
    CASE 
        WHEN ss_quantity BETWEEN 1 AND 20 THEN 1
        WHEN ss_quantity BETWEEN 21 AND 40 THEN 2
        WHEN ss_quantity BETWEEN 41 AND 60 THEN 3
        WHEN ss_quantity BETWEEN 61 AND 80 THEN 4
        WHEN ss_quantity BETWEEN 81 AND 100 THEN 5
    END,
    trans_count
ORDER BY bucket;
