WITH WebCumulative AS (
    SELECT 
        ws_item_sk AS item_sk,
        ws_sold_date_sk AS date_sk,
        SUM(ws_sales_price) OVER (PARTITION BY ws_item_sk ORDER BY ws_sold_date_sk) AS web_cumulative
    FROM web_sales
),
StoreCumulative AS (
    SELECT 
        ss_item_sk AS item_sk,
        ss_sold_date_sk AS date_sk,
        SUM(ss_sales_price) OVER (PARTITION BY ss_item_sk ORDER BY ss_sold_date_sk) AS store_cumulative
    FROM store_sales
),
MaxCumulative AS (
    SELECT 
        COALESCE(w.item_sk, s.item_sk) AS item_sk,
        COALESCE(w.date_sk, s.date_sk) AS date_sk,
        MAX(w.web_cumulative) AS max_web_cumulative,
        MAX(s.store_cumulative) AS max_store_cumulative
    FROM WebCumulative w
    FULL JOIN StoreCumulative s ON w.item_sk = s.item_sk AND w.date_sk = s.date_sk
    GROUP BY COALESCE(w.item_sk, s.item_sk), COALESCE(w.date_sk, s.date_sk)
)
SELECT 
    m.item_sk,
    d.d_date,
    m.max_web_cumulative,
    m.max_store_cumulative
FROM MaxCumulative m
JOIN date_dim d ON m.date_sk = d.d_date_sk
JOIN item i ON m.item_sk = i.i_item_sk
WHERE m.max_web_cumulative > m.max_store_cumulative
AND i.i_category IN ('SPECIFIC_CATEGORIES') -- Replace 'SPECIFIC_CATEGORIES' with the desired categories
AND d.d_date BETWEEN 'START_DATE' AND 'END_DATE' -- Replace 'START_DATE' and 'END_DATE' with the desired date range
ORDER BY m.item_sk, d.d_date
LIMIT 100;
