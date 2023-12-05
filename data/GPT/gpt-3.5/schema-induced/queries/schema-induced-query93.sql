SELECT ss.ss_customer_sk, SUM(ss.ss_sales_price) - COALESCE(SUM(sr.sr_return_quantity * ss.ss_sales_price), 0) AS sumsales
FROM store_sales ss
LEFT JOIN store_returns sr ON ss.ss_item_sk = sr.sr_item_sk AND ss.ss_ticket_number = sr.sr_ticket_number
JOIN reason r ON sr.sr_reason_sk = r.r_reason_sk
WHERE r.r_reason_desc = 'duplicate purchase'
GROUP BY ss.ss_customer_sk
ORDER BY sumsales DESC, ss.ss_customer_sk
LIMIT 100;