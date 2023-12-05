WITH SalesData AS (
  SELECT
    s.product_category,
    s.product_class,
    SUM(s.sales_price - s.cogs) AS gross_profit,
    EXTRACT(YEAR FROM d.date) AS sales_year,
    i.item_name
  FROM
    store_sales s
    JOIN date_dim d ON s.date_id = d.date_id
    JOIN item i ON s.item_id = i.item_id
    JOIN store st ON s.store_id = st.store_id
  WHERE
    st.state IN ('SD', 'TN', 'GA', 'SC', 'MO', 'AL', 'MI', 'OH')
    AND EXTRACT(YEAR FROM d.date) = 2002
  GROUP BY
    s.product_category,
    s.product_class,
    EXTRACT(YEAR FROM d.date),
    i.item_name
),
RankingData AS (
  SELECT
    product_category,
    product_class,
    sales_year,
    item_name,
    gross_profit,
    ROW_NUMBER() OVER (PARTITION BY product_category, product_class ORDER BY gross_profit DESC) AS category_class_rank,
    ROW_NUMBER() OVER (PARTITION BY product_category ORDER BY gross_profit DESC) AS category_rank
  FROM
    SalesData
)
SELECT
  product_category,
  product_class,
  sales_year,
  item_name,
  gross_profit,
  COALESCE(category_class_rank, category_rank) AS final_rank
FROM
  RankingData
ORDER BY
  product_category DESC,
  product_class DESC,
  final_rank
LIMIT 100;
