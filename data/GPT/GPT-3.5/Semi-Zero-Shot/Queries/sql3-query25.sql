SELECT TOP 100
    i.i_item_id AS item_id,
    i.i_item_desc AS item_description,
    s.s_store_id AS store_id,
    s.s_store_name AS store_name,
    SUM(CASE WHEN (t1.t_date_sk >= 2451227 AND t1.t_date_sk <= 2451259) THEN (ss.ss_net_profit - sr.sr_net_loss) ELSE 0 END) AS total_net_profit
FROM
    store_sales AS ss
    INNER JOIN store_returns AS sr ON ss.ss_ticket_number = sr.sr_ticket_number
    INNER JOIN catalog_sales AS cs ON ss.ss_item_sk = cs.cs_item_sk
    INNER JOIN date_dim AS t1 ON ss.ss_sold_date_sk = t1.d_date_sk
    INNER JOIN date_dim AS t2 ON cs.cs_sold_date_sk = t2.d_date_sk
    INNER JOIN item AS i ON ss.ss_item_sk = i.i_item_sk
    INNER JOIN store AS s ON ss.ss_store_sk = s.s_store_sk
WHERE
    ((t1.t_date_sk >= 2451227 AND t1.t_date_sk <= 2451259) OR (t2.t_date_sk >= 2451227 AND t2.t_date_sk <= 2451290))
GROUP BY
    i.i_item_id,
    i.i_item_desc,
    s.s_store_id,
    s.s_store_name
ORDER BY
    item_id,
    item_description,
    store_id,
    store_name;
