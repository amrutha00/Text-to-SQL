SELECT c_customer_id
FROM customer_returns ctr
JOIN store_returns sr ON ctr.ctr_store_sk = sr.sr_store_sk AND ctr.ctr_customer_sk = sr.sr_customer_sk
JOIN store s ON sr.sr_store_sk = s.s_store_sk
JOIN date_dim d ON sr.sr_returned_date_sk = d.d_date_sk
WHERE s.s_state = 'South Dakota' AND d.d_year = 2000
GROUP BY c_customer_id
HAVING SUM(ctr.ctr_total_return) > 1.2 * (SELECT AVG(sr_return_amt_inc_tax) FROM store_returns WHERE s_state = 'South Dakota' AND d_year = 2000)
ORDER BY c_customer_id
LIMIT 100;