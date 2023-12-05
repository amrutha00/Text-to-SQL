WITH MonthlySales AS (
    SELECT 
        i_manufact_id,
        SUM(ss_ext_sales_price) AS monthly_sales,
        TRUNC(ss_sold_date_sk / 100) AS month_seq
    FROM 
        store_sales
    JOIN 
        item ON store_sales.ss_item_sk = item.i_item_sk
    WHERE 
        (i_category IN ('Books', 'Children', 'Electronics') 
        AND i_class IN ('personal', 'portable', 'reference', 'self-help') 
        AND i_brand IN ('scholaramalgamalg #14', 'scholaramalgamalg #7', 'exportiunivamalg #9', 'scholaramalgamalg #9'))
    OR 
        (i_category IN ('Women', 'Music', 'Men') 
        AND i_class IN ('accessories', 'classical', 'fragrances', 'pants') 
        AND i_brand IN ('amalgimporto #1', 'edu packscholar #1', 'exportiimporto #1', 'importoamalg #1'))
    GROUP BY 
        i_manufact_id,
        TRUNC(ss_sold_date_sk / 100)
),

QuarterlySales AS (
    SELECT 
        i_manufact_id,
        SUM(ss_ext_sales_price) AS quarterly_sales,
        TRUNC(ss_sold_date_sk / 100 / 3) AS quarter_seq
    FROM 
        store_sales
    JOIN 
        item ON store_sales.ss_item_sk = item.i_item_sk
    WHERE 
        (i_category IN ('Books', 'Children', 'Electronics') 
        AND i_class IN ('personal', 'portable', 'reference', 'self-help') 
        AND i_brand IN ('scholaramalgamalg #14', 'scholaramalgamalg #7', 'exportiunivamalg #9', 'scholaramalgamalg #9'))
    OR 
        (i_category IN ('Women', 'Music', 'Men') 
        AND i_class IN ('accessories', 'classical', 'fragrances', 'pants') 
        AND i_brand IN ('amalgimporto #1', 'edu packscholar #1', 'exportiimporto #1', 'importoamalg #1'))
    GROUP BY 
        i_manufact_id,
        TRUNC(ss_sold_date_sk / 100 / 3)
)

SELECT 
    q.i_manufact_id,
    AVG(q.quarterly_sales) AS avg_quarterly_sales,
    SUM(q.quarterly_sales) AS total_quarterly_sales,
    SUM(m.monthly_sales) AS total_annual_sales
FROM 
    MonthlySales m
JOIN 
    QuarterlySales q ON m.i_manufact_id = q.i_manufact_id
WHERE 
    AVG(q.quarterly_sales) > 0.1 * SUM(m.monthly_sales)
GROUP BY 
    q.i_manufact_id
ORDER BY 
    AVG(q.quarterly_sales) DESC, 
    SUM(q.quarterly_sales) DESC, 
    q.i_manufact_id 
LIMIT 
    100;
