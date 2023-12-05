SELECT
  CASE
    WHEN quantity_sold BETWEEN 1 AND 20 AND count_transactions > 2,972,190 THEN AVG(external_sales_price)
    WHEN quantity_sold BETWEEN 1 AND 20 THEN AVG(net_profit)
    WHEN quantity_sold BETWEEN 21 AND 40 AND count_transactions > 4,505,785 THEN AVG(external_sales_price)
    WHEN quantity_sold BETWEEN 21 AND 40 THEN AVG(net_profit)
    WHEN quantity_sold BETWEEN 41 AND 60 AND count_transactions > 1,575,726 THEN AVG(external_sales_price)
    WHEN quantity_sold BETWEEN 41 AND 60 THEN AVG(net_profit)
    WHEN quantity_sold BETWEEN 61 AND 80 AND count_transactions > 3,188,917 THEN AVG(external_sales_price)
    WHEN quantity_sold BETWEEN 61 AND 80 THEN AVG(net_profit)
    WHEN quantity_sold BETWEEN 81 AND 100 AND count_transactions > 3,525,216 THEN AVG(external_sales_price)
    WHEN quantity_sold BETWEEN 81 AND 100 THEN AVG(net_profit)
    ELSE NULL -- Handle cases that don't match any of the specified conditions
  END AS bucket_average
FROM
  (
    SELECT
      quantity_sold,
      external_sales_price,
      net_profit,
      COUNT(*) OVER (PARTITION BY quantity_sold) AS count_transactions
    FROM
      your_transaction_table_name
  ) AS subquery
