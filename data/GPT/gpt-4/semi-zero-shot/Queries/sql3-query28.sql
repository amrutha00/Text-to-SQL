SELECT
    sales_bucket AS Bucket,
    AVG(list_price) AS Average_List_Price,
    COUNT(list_price) AS Non_Empty_List_Prices,
    COUNT(DISTINCT list_price) AS Distinct_List_Prices
FROM (
    SELECT
        CASE
            WHEN quantity BETWEEN 0 AND 5
                AND list_price BETWEEN 131 AND 141
                AND coupon_amount BETWEEN 16798 AND 17798
                AND wholesale_cost BETWEEN 25 AND 45 THEN 'B1'
            WHEN quantity BETWEEN 6 AND 10
                AND list_price BETWEEN 145 AND 155
                AND coupon_amount BETWEEN 14792 AND 15792
                AND wholesale_cost BETWEEN 46 AND 66 THEN 'B2'
            WHEN quantity BETWEEN 11 AND 15
                AND list_price BETWEEN 150 AND 160
                AND coupon_amount BETWEEN 6600 AND 7600
                AND wholesale_cost BETWEEN 9 AND 29 THEN 'B3'
            WHEN quantity BETWEEN 16 AND 20
                AND list_price BETWEEN 91 AND 101
                AND coupon_amount BETWEEN 13493 AND 14493
                AND wholesale_cost BETWEEN 36 AND 56 THEN 'B4'
            WHEN quantity BETWEEN 21 AND 25
                AND list_price BETWEEN 0 AND 10
                AND coupon_amount BETWEEN 7629 AND 8629
                AND wholesale_cost BETWEEN 6 AND 26 THEN 'B5'
            WHEN quantity BETWEEN 26 AND 30
                AND list_price BETWEEN 89 AND 99
                AND coupon_amount BETWEEN 15257 AND 16257
                AND wholesale_cost BETWEEN 31 AND 51 THEN 'B6'
            ELSE 'Other'
        END AS sales_bucket,
        list_price
    FROM your_sales_data_table -- Replace with your actual table name
    WHERE channel = 'store sales' -- Filter by the store sales channel
) AS sales_buckets
GROUP BY sales_bucket
LIMIT 100;
