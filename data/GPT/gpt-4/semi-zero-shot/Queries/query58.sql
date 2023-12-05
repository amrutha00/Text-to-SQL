WITH
  ss_items AS (
    SELECT ss_item_sk, SUM(ss_net_paid) AS ss_item_rev
    FROM store_sales
    WHERE ss_sold_date_sk IN (SELECT d_date_sk FROM date_dim WHERE d_week_seq = (SELECT d_week_seq FROM date_dim WHERE d_date = '2001-03-24'))
    GROUP BY ss_item_sk
  ),
  cs_items AS (
    SELECT cs_item_sk, SUM(cs_net_paid) AS cs_item_rev
    FROM catalog_sales
    WHERE cs_sold_date_sk IN (SELECT d_date_sk FROM date_dim WHERE d_week_seq = (SELECT d_week_seq FROM date_dim WHERE d_date = '2001-03-24'))
    GROUP BY cs_item_sk
  ),
  ws_items AS (
    SELECT ws_item_sk, SUM(ws_net_paid) AS ws_item_rev
    FROM web_sales
    WHERE ws_sold_date_sk IN (SELECT d_date_sk FROM date_dim WHERE d_week_seq = (SELECT d_week_seq FROM date_dim WHERE d_date = '2001-03-24'))
    GROUP BY ws_item_sk
  )
  
SELECT
  ss_item_sk AS item_id,
  ss_item_rev
FROM ss_items
JOIN cs_items ON ss_item_sk = cs_item_sk
JOIN ws_items ON ss_item_sk = ws_item_sk
WHERE 
  ss_item_rev BETWEEN 0.9 * cs_item_rev AND 1.1 * cs_item_rev
  AND ss_item_rev BETWEEN 0.9 * ws_item_rev AND 1.1 * ws_item_rev
  AND cs_item_rev BETWEEN 0.9 * ss_item_rev AND 1.1 * ss_item_rev
  AND cs_item_rev BETWEEN 0.9 * ws_item_rev AND 1.1 * ws_item_rev
  AND ws_item_rev BETWEEN 0.9 * ss_item_rev AND 1.1 * ss_item_rev
  AND ws_item_rev BETWEEN 0.9 * cs_item_rev AND 1.1 * cs_item_rev
ORDER BY item_id, ss_item_rev DESC
LIMIT 100;
