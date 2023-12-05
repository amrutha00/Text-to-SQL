WITH BeforeChange AS (
    SELECT 
        ss_item_sk AS item_id,
        w_state,
        SUM(ss_sales_price) AS total_sales_before
    FROM store_sales
    JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
    JOIN warehouse ON store_sales.ss_warehouse_sk = warehouse.w_warehouse_sk
    WHERE d_date BETWEEN (SELECT MIN(d_date) FROM date_dim WHERE d_month_seq = (SELECT d_month_seq - 1 FROM date_dim WHERE d_current_month = 'Y')) 
                  AND (SELECT MAX(d_date) FROM date_dim WHERE d_month_seq = (SELECT d_month_seq - 1 FROM date_dim WHERE d_current_month = 'Y'))
    GROUP BY ss_item_sk, w_state
),
AfterChange AS (
    SELECT 
        ss_item_sk AS item_id,
        w_state,
        SUM(ss_sales_price) AS total_sales_after
    FROM store_sales
    JOIN date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
    JOIN warehouse ON store_sales.ss_warehouse_sk = warehouse.w_warehouse_sk
    WHERE d_date BETWEEN (SELECT MIN(d_date) FROM date_dim WHERE d_current_month = 'Y') 
                  AND (SELECT MAX(d_date) FROM date_dim WHERE d_current_month = 'Y')
    GROUP BY ss_item_sk, w_state
)

SELECT 
    b.item_id,
    b.w_state,
    b.total_sales_before,
    a.total_sales_after,
    a.total_sales_after - b.total_sales_before AS sales_impact
FROM BeforeChange b
JOIN AfterChange a ON b.item_id = a.item_id AND b.w_state = a.w_state
ORDER BY b.w_state, b.item_id
LIMIT 100;
