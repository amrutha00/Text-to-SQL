WITH BucketedSales AS (
    SELECT 
        ss_list_price,
        CASE 
            WHEN ss_quantity BETWEEN 0 AND 5 AND ss_list_price BETWEEN 131 AND 141 AND ss_coupon_amt BETWEEN 16798 AND 17798 AND ss_wholesale_cost BETWEEN 25 AND 45 THEN 'B1'
            WHEN ss_quantity BETWEEN 6 AND 10 AND ss_list_price BETWEEN 145 AND 155 AND ss_coupon_amt BETWEEN 14792 AND 15792 AND ss_wholesale_cost BETWEEN 46 AND 66 THEN 'B2'
            WHEN ss_quantity BETWEEN 11 AND 15 AND ss_list_price BETWEEN 150 AND 160 AND ss_coupon_amt BETWEEN 6600 AND 7600 AND ss_wholesale_cost BETWEEN 9 AND 29 THEN 'B3'
            WHEN ss_quantity BETWEEN 16 AND 20 AND ss_list_price BETWEEN 91 AND 101 AND ss_coupon_amt BETWEEN 13493 AND 14493 AND ss_wholesale_cost BETWEEN 36 AND 56 THEN 'B4'
            WHEN ss_quantity BETWEEN 21 AND 25 AND ss_list_price BETWEEN 0 AND 10 AND ss_coupon_amt BETWEEN 7629 AND 8629 AND ss_wholesale_cost BETWEEN 6 AND 26 THEN 'B5'
            WHEN ss_quantity BETWEEN 26 AND 30 AND ss_list_price BETWEEN 89 AND 99 AND ss_coupon_amt BETWEEN 15257 AND 16257 AND ss_wholesale_cost BETWEEN 31 AND 51 THEN 'B6'
            ELSE NULL
        END AS Bucket
    FROM store_sales
    WHERE ss_sales_channel = 'store' -- Assuming there is a field for the sales channel. Adjust field name if necessary.
)

SELECT 
    Bucket,
    AVG(ss_list_price) AS AvgListPrice,
    COUNT(DISTINCT CASE WHEN ss_list_price IS NOT NULL AND ss_list_price != '' THEN ss_list_price END) AS NonEmptyListPrices,
    COUNT(DISTINCT ss_list_price) AS DistinctListPrices
FROM BucketedSales
WHERE Bucket IS NOT NULL
GROUP BY Bucket
ORDER BY Bucket
LIMIT 100;
