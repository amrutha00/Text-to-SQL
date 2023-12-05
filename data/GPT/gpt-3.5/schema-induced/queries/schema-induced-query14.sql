Iteration 1:
```
WITH cross_channel_sales AS (
    SELECT i_brand, i_class, i_category, s.ss_sold_date_sk
    FROM store_sales s
    JOIN item i ON s.ss_item_sk = i.i_item_sk
    UNION
    SELECT i_brand, i_class, i_category, c.cs_sold_date_sk
    FROM catalog_sales c
    JOIN item i ON c.cs_item_sk = i.i_item_sk
    UNION
    SELECT i_brand, i_class, i_category, w.ws_sold_date_sk
    FROM web_sales w
    JOIN item i ON w.ws_item_sk = i.i_item_sk
    WHERE w.ws_sold_date_sk BETWEEN 20000101 AND 20021231 -- Year 2000 to 2002
)
SELECT i_brand, i_class, i_category, SUM(qty * list_price) AS total_sales, COUNT(*) AS total_sales_count
FROM (
    SELECT i_brand, i_class, i_category, ss_sold_date_sk, ss_quantity AS qty, ss_list_price AS list_price
    FROM store_sales s
    JOIN cross_channel_sales c ON s.ss_sold_date_sk = c.ss_sold_date_sk AND s.ss_item_sk = i.i_item_sk
    JOIN item i ON s.ss_item_sk = i.i_item_sk
    WHERE s.ss_sold_date_sk BETWEEN 20000101 AND 20021231 -- Year 2000 to 2002
    UNION ALL
    SELECT i_brand, i_class, i_category, cs_sold_date_sk, cs_quantity AS qty, cs_list_price AS list_price
    FROM catalog_sales c
    JOIN cross_channel_sales c ON c.cs_sold_date_sk = c.ss_sold_date_sk AND c.cs_item_sk = i.i_item_sk
    JOIN item i ON c.cs_item_sk = i.i_item_sk
    WHERE c.cs_sold_date_sk BETWEEN 20000101 AND 20021231 -- Year 2000 to 2002
    UNION ALL
    SELECT i_brand, i_class, i_category, ws_sold_date_sk, ws_quantity AS qty, ws_list_price AS list_price
    FROM web_sales w
    JOIN cross_channel_sales c ON w.ws_sold_date_sk = c.ss_sold_date_sk AND w.ws_item_sk = i.i_item_sk
    JOIN item i ON w.ws_item_sk = i.i_item_sk
    WHERE w.ws_sold_date_sk BETWEEN 20000101 AND 20021231 -- Year 2000 to 2002
) t
GROUP BY i_brand, i_class, i_category
HAVING SUM(qty * list_price) > AVG(qty * list_price)
```

Iteration 2:
```
SELECT 
    s.ss_sold_date_sk, 
    s.ss_quantity,
    s.ss_list_price,
    p.ss_quantity,
    p.ss_list_price
FROM 
    store_sales s
JOIN 
    store_sales p 
    ON s.ss_item_sk = p.ss_item_sk
    AND s.ss_sold_date_sk = DATE_ADD(p.ss_sold_date_sk, INTERVAL -1 YEAR)
WHERE 
    MONTH(s.ss_sold_date_sk) = 12
    AND YEAR(s.ss_sold_date_sk) = 2002
```