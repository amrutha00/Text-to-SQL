WITH sales_data AS (
  SELECT
    s.s_store_sk,
    i.i_item_sk,
    d.d_year,
    s.ss_ext_sales_price - s.ss_net_profit AS gross_profit
  FROM
    store_sales s
    JOIN date_dim d ON s.ss_sold_date_sk = d.d_date_sk
    JOIN item i ON s.ss_item_sk = i.i_item_sk
    JOIN store st ON s.ss_store_sk = st.s_store_sk
  WHERE
    st.s_state IN ('SD', 'TN', 'GA', 'SC', 'MO', 'AL', 'MI', 'OH')
    AND d.d_year = 2002
),
item_rank AS (
  SELECT
    i_item_sk,
    SUM(gross_profit) AS total_gross_profit,
    RANK() OVER (ORDER BY SUM(gross_profit) DESC) AS item_rank
  FROM
    sales_data
  GROUP BY
    i_item_sk
),
category_rank AS (
  SELECT
    i.i_category,
    SUM(gross_profit) AS total_gross_profit,
    RANK() OVER (ORDER BY SUM(gross_profit) DESC) AS category_rank
  FROM
    sales_data s
    JOIN item i ON s.i_item_sk = i.i_item_sk
  GROUP BY
    i_category
),
final_rank AS (
  SELECT
    i.i_category,
    i.i_class,
    COALESCE(cat.category_rank, item.item_rank) AS overall_rank
  FROM
    item_rank item
    JOIN item i ON item.i_item_sk = i.i_item_sk
    LEFT JOIN category_rank cat ON i.i_category = cat.i_category
  ORDER BY
    COALESCE(cat.category_rank, item.item_rank) ASC,
    i.i_category DESC,
    i.i_class DESC
  LIMIT 100
)
SELECT
  i_category,
  i_class,
  overall_rank
FROM
  final_rank;