SELECT 
    ss.ss_customer_sk, 
    SUM(ss.ss_net_paid - COALESCE(sr.ss_net_loss, 0)) AS sumsales
FROM 
    store_sales ss
LEFT JOIN 
    store_returns sr 
    ON ss.ss_item_sk = sr.sr_item_sk 
    AND ss.ss_ticket_number = sr.sr_ticket_number
JOIN 
    reason r 
    ON sr.sr_reason_sk = r.r_reason_sk
WHERE 
    r.r_reason_description = 'duplicate purchase'
GROUP BY 
    ss.ss_customer_sk
ORDER BY 
    sumsales DESC, 
    ss.ss_customer_sk ASC
LIMIT 100;
