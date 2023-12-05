WITH CategorizedReturns AS (
    SELECT
        wr.web_return_reason,
        c.marital_status,
        c.education,
        c.state,
        s.sales_type,
        s.profit,
        AVG(wr.return_quantity) AS avg_sales_quantity,
        AVG(wr.refunded_cash) AS avg_refunded_cash,
        AVG(wr.return_fee) AS avg_return_fee
    FROM
        web_returns wr
    JOIN
        customer c
    ON
        wr.customer_id = c.customer_id
    JOIN
        sales s
    ON
        wr.sales_id = s.sales_id
    WHERE
        c.marital_status IN ('M', 'S', 'W')
        AND c.education IN ('4 yr Degree', 'Secondary', 'Advanced Degree')
        AND c.state IN ('FL', 'TX', 'DE', 'IN', 'ND', 'ID', 'MT', 'IL', 'OH')
        AND s.profit BETWEEN 100 AND 200
        AND s.profit BETWEEN 150 AND 300
        AND s.profit BETWEEN 50 AND 250
    GROUP BY
        wr.web_return_reason,
        c.marital_status,
        c.education,
        c.state,
        s.sales_type,
        s.profit
)
SELECT
    LEFT(wr.web_return_reason, 20) AS reason_description,
    AVG(cr.avg_sales_quantity) AS avg_sales_quantity,
    AVG(cr.avg_refunded_cash) AS avg_refunded_cash,
    AVG(cr.avg_return_fee) AS avg_return_fee
FROM
    CategorizedReturns cr
GROUP BY
    LEFT(wr.web_return_reason, 20) -- Get the first 20 characters of the reason description
ORDER BY
    reason_description
LIMIT 100; -- Limit to the top 100 records
