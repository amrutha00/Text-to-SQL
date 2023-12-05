SELECT i.i_item_id, SUM(sr.sr_return_quantity) AS store_return_quantity
FROM store_returns sr
JOIN item i ON sr.sr_item_sk = i.i_item_sk
JOIN date_dim d ON sr.sr_returned_date_sk = d.d_date_sk
WHERE d.d_date IN ('2001-06-06', '2001-09-02', '2001-11-11')
GROUP BY i.i_item_id
HAVING ABS(SUM(sr.sr_return_quantity) - (SELECT SUM(sr2.sr_return_quantity) FROM store_returns sr2 WHERE sr2.sr_returned_date_sk = sr.sr_returned_date_sk)) <= (0.1 * SUM(sr.sr_return_quantity))
ORDER BY i.i_item_id, store_return_quantity DESC
LIMIT 100;