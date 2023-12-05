SELECT
  AVG(ss_list_price) AS average_list_price,
  COUNT(CASE WHEN ss_list_price IS NOT NULL THEN 1 END) AS num_non_empty_list_prices,
  COUNT(DISTINCT ss_list_price) AS num_distinct_list_prices
FROM
  store_sales
WHERE
  (ss_quantity BETWEEN 0 AND 5 AND ss_list_price BETWEEN 131 AND 141 AND ss_coupon_amt BETWEEN 16798 AND 17798 AND ss_wholesale_cost BETWEEN 25 AND 45)
  OR (ss_quantity BETWEEN 6 AND 10 AND ss_list_price BETWEEN 145 AND 155 AND ss_coupon_amt BETWEEN 14792 AND 15792 AND ss_wholesale_cost BETWEEN 46 AND 66)
  OR (ss_quantity BETWEEN 11 AND 15 AND ss_list_price BETWEEN 150 AND 160 AND ss_coupon_amt BETWEEN 6600 AND 7600 AND ss_wholesale_cost BETWEEN 9 AND 29)
  OR (ss_quantity BETWEEN 16 AND 20 AND ss_list_price BETWEEN 91 AND 101 AND ss_coupon_amt BETWEEN 13493 AND 14493 AND ss_wholesale_cost BETWEEN 36 AND 56)
  OR (ss_quantity BETWEEN 21 AND 25 AND ss_list_price BETWEEN 0 AND 10 AND ss_coupon_amt BETWEEN 7629 AND 8629 AND ss_wholesale_cost BETWEEN 6 AND 26)
  OR (ss_quantity BETWEEN 26 AND 30 AND ss_list_price BETWEEN 89 AND 99 AND ss_coupon_amt BETWEEN 15257 AND 16257 AND ss_wholesale_cost BETWEEN 31 AND 51)
LIMIT 100;