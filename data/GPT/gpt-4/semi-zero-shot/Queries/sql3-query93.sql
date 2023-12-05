SELECT
    ss.ss_customer_sk AS customer_id,
    SUM(ss.ss_net_paid) - COALESCE(SUM(sr.sr_return_amt), 0) AS sumsales
FROM
    store_sales ss
JOIN
    store_returns sr
ON
    ss.ss_item_sk = sr.sr_item_sk
    AND ss.ss_ticket_number = sr.sr_ticket_number
JOIN
    reason r
ON
    sr.sr_reason_sk = r.r_reason_sk
WHERE
    r.r_reason_desc = 'duplicate purchase'
GROUP BY
    ss.ss_customer_sk
ORDER BY
    sumsales DESC,
    customer_id
LIMIT 100;
