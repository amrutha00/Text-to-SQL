WITH ss_items AS (
  SELECT
    item_id,
    SUM(ss_ext_sales_price) AS ss_item_rev
  FROM
    store_sales
  WHERE
    ss_sold_date_sk BETWEEN (SELECT d_date_sk FROM date_dim WHERE d_date = '2001-03-18') AND (SELECT d_date_sk FROM date_dim WHERE d_date = '2001-03-24')
  GROUP BY
    item_id
),
cs_items AS (
  SELECT
    item_id,
    SUM(cs_ext_sales_price) AS cs_item_rev
  FROM
    catalog_sales
  WHERE
    cs_sold_date_sk BETWEEN (SELECT d_date_sk FROM date_dim WHERE d_date = '2001-03-18') AND (SELECT d_date_sk FROM date_dim WHERE d_date = '2001-03-24')
  GROUP BY
    item_id
),
ws_items AS (
  SELECT
    item_id,
    SUM(ws_ext_sales_price) AS ws_item_rev
  FROM
    web_sales
  WHERE
    ws_sold_date_sk BETWEEN (SELECT d_date_sk FROM date_dim WHERE d_date = '2001-03-18') AND (SELECT d_date_sk FROM date_dim WHERE d_date = '2001-03-24')
  GROUP BY
    item_id
)
SELECT
  COALESCE(ss.item_id, cs.item_id, ws.item_id) AS item_id,
  COALESCE(ss_item_rev, 0) AS ss_item_rev,
  COALESCE(cs_item_rev, 0) AS cs_item_rev,
  COALESCE(ws_item_rev, 0) AS ws_item_rev
FROM
  ss_items ss
FULL OUTER JOIN cs_items cs
  ON ss.item_id = cs.item_id
FULL OUTER JOIN ws_items ws
  ON COALESCE(ss.item_id, cs.item_id) = ws.item_id
WHERE
  (ss_item_rev BETWEEN 0.9 * cs_item_rev AND 1.1 * cs_item_rev
   OR ss_item_rev BETWEEN 0.9 * ws_item_rev AND 1.1 * ws_item_rev
   OR cs_item_rev BETWEEN 0.9 * ss_item_rev AND 1.1 * ss_item_rev
   OR ws_item_rev BETWEEN 0.9 * ss_item_rev AND 1.1 * ss_item_rev)
ORDER BY
  item_id, ss_item_rev
LIMIT 100;
