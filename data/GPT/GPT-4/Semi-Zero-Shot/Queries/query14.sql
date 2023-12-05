--- Iteration 1

WITH AvgSales AS (
    SELECT 
        i_brand, 
        i_class, 
        i_category,
        AVG(ss_quantity * ss_list_price) AS avg_sales
    FROM 
        store_sales
    JOIN item ON store_sales.ss_item_sk = item.i_item_sk
    WHERE 
        ss_sold_date_sk BETWEEN '2000-01-01' AND '2002-12-31'
    GROUP BY 
        i_brand, 
        i_class, 
        i_category
    HAVING 
        COUNT(DISTINCT ss_channel) = 3
)

SELECT 
    ss_channel,
    i_brand, 
    i_class, 
    i_category,
    SUM(ss_quantity * ss_list_price) AS total_sales,
    COUNT(*) AS total_sales_count
FROM 
    store_sales
JOIN item ON store_sales.ss_item_sk = item.i_item_sk
JOIN AvgSales AS avg ON 
    item.i_brand = avg.i_brand 
    AND item.i_class = avg.i_class 
    AND item.i_category = avg.i_category
WHERE 
    ss_sold_date_sk BETWEEN '2000-01-01' AND '2002-12-31'
    AND ss_quantity * ss_list_price > avg.avg_sales
GROUP BY 
    ss_channel, 
    i_brand, 
    i_class, 
    i_category;


--- Iteration 2
WITH December2001 AS (
    SELECT 
        i_item_sk,
        SUM(ss_quantity * ss_list_price) AS dec_2001_sales
    FROM 
        store_sales
    JOIN item ON store_sales.ss_item_sk = item.i_item_sk
    WHERE 
        EXTRACT(MONTH FROM ss_sold_date_sk) = 12 
        AND EXTRACT(YEAR FROM ss_sold_date_sk) = 2001
    GROUP BY 
        i_item_sk
),
December2002 AS (
    SELECT 
        i_item_sk,
        SUM(ss_quantity * ss_list_price) AS dec_2002_sales
    FROM 
        store_sales
    JOIN item ON store_sales.ss_item_sk = item.i_item_sk
    WHERE 
        EXTRACT(MONTH FROM ss_sold_date_sk) = 12 
        AND EXTRACT(YEAR FROM ss_sold_date_sk) = 2002
    GROUP BY 
        i_item_sk
)

SELECT 
    a.i_item_sk,
    a.dec_2001_sales,
    b.dec_2002_sales
FROM 
    December2001 a
JOIN December2002 b ON a.i_item_sk = b.i_item_sk;
