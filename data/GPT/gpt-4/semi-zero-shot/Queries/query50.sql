WITH ReturnIntervals AS (
    SELECT
        ss.ss_store_sk,
        sr.ss_item_sk,
        CASE
            WHEN DATEDIFF('day', ds1.d_date, ds2.d_date) <= 30 THEN '30 days'
            WHEN DATEDIFF('day', ds1.d_date, ds2.d_date) BETWEEN 31 AND 60 THEN '31-60 days'
            WHEN DATEDIFF('day', ds1.d_date, ds2.d_date) BETWEEN 61 AND 90 THEN '61-90 days'
            WHEN DATEDIFF('day', ds1.d_date, ds2.d_date) BETWEEN 91 AND 120 THEN '91-120 days'
            ELSE '>120 days'
        END AS return_interval
    FROM store_sales ss
    JOIN store_returns sr ON ss.ss_ticket_number = sr.sr_ticket_number
    JOIN date_dim ds1 ON ss.ss_sold_date_sk = ds1.d_date_sk
    JOIN date_dim ds2 ON sr.sr_returned_date_sk = ds2.d_date_sk
    WHERE ds1.d_year = 2001 AND ds1.d_moy = 8
)

SELECT
    s.s_store_name,
    s.s_company_id,
    s.s_address,
    s.s_zip,
    return_interval,
    COUNT(*) AS items_returned_count
FROM ReturnIntervals
JOIN store s ON ReturnIntervals.ss_store_sk = s.s_store_sk
GROUP BY 
    s.s_store_name,
    s.s_company_id,
    s.s_address,
    s.s_zip,
    return_interval
ORDER BY 
    s.s_store_name,
    s.s_company_id,
    s.s_address,
    s.s_zip,
    return_interval
LIMIT 100;
