-- Temporary table for store sales
CREATE TEMP TABLE ss AS (
  SELECT
    s_county,
    s_qtr_id,
    s_year,
    SUM(s_net_paid) AS total_store_sales
  FROM store_sales
  JOIN date_dim ON store_sales.s_sold_date_sk = date_dim.d_date_sk
  WHERE s_year = 2000 AND s_qtr_id IN (1, 2, 3)
  GROUP BY s_county, s_qtr_id, s_year
);

-- Temporary table for web sales
CREATE TEMP TABLE ws AS (
  SELECT
    ws_county,
    ws_qtr_id,
    ws_year,
    SUM(ws_net_paid) AS total_web_sales
  FROM web_sales
  JOIN date_dim ON web_sales.ws_sold_date_sk = date_dim.d_date_sk
  WHERE ws_year = 2000 AND ws_qtr_id IN (1, 2, 3)
  GROUP BY ws_county, ws_qtr_id, ws_year
);

-- Main query
SELECT
  ss.s_county,
  ss.s_year,
  (ws.total_web_sales - LAG(ws.total_web_sales) OVER(PARTITION BY ws.ws_county ORDER BY ws.ws_qtr_id)) / NULLIF(LAG(ws.total_web_sales) OVER(PARTITION BY ws.ws_county ORDER BY ws.ws_qtr_id), 0) AS web_q1_q2_increase,
  (ss.total_store_sales - LAG(ss.total_store_sales) OVER(PARTITION BY ss.s_county ORDER BY ss.s_qtr_id)) / NULLIF(LAG(ss.total_store_sales) OVER(PARTITION BY ss.s_county ORDER BY ss.s_qtr_id), 0) AS store_q1_q2_increase
FROM ss
JOIN ws ON ss.s_county = ws.ws_county AND ss.s_qtr_id = ws.ws_qtr_id AND ss.s_year = ws.ws_year
WHERE
  web_q1_q2_increase > store_q1_q2_increase
ORDER BY web_q1_q2_increase DESC;
