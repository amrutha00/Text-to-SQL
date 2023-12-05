SELECT
    ch.channel_id,
    it.item_id,
    SUM(s.sales_quantity) / SUM(r.return_quantity) AS quantity_ratio,
    SUM(r.return_amount) / SUM(s.net_paid) AS currency_ratio,
    ROW_NUMBER() OVER (PARTITION BY ch.channel_id ORDER BY SUM(s.sales_quantity) / SUM(r.return_quantity) ASC, SUM(r.return_amount) / SUM(s.net_paid) ASC, it.item_id) AS return_rank
FROM
    store_sales s
JOIN
    store_returns r ON s.ss_item_sk = r.sr_item_sk
JOIN
    date_dim d ON s.ss_sold_date_sk = d.d_date_sk
JOIN
    item it ON s.ss_item_sk = it.i_item_sk
JOIN
    customer c ON s.ss_customer_sk = c.c_customer_sk
JOIN
    customer_address ca ON c.c_current_addr_sk = ca.ca_address_sk
JOIN
    channel ch ON ca.ca_channel_id = ch.ch_channel_id
WHERE
    EXTRACT(YEAR FROM d.d_date) = 1999
GROUP BY
    ch.channel_id, it.item_id
HAVING
    COUNT(*) <= 100
ORDER BY
    ch.channel_id ASC, return_rank ASC
LIMIT 100;