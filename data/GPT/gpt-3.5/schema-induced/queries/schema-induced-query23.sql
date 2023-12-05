SELECT f.item_sk, f.itemdesc, f.solddate, f.cnt, s.c_sales_price
FROM frequent_ss_items f
JOIN (
  SELECT c_customer_sk, ssales
  FROM best_ss_customer
  WHERE ssales >= PERCENTILE_CONT(0.05) WITHIN GROUP (ORDER BY ssales) OVER ()
) s ON f.item_sk = s.c_customer_sk
JOIN (
  SELECT cs_sold_date_sk, cs_sales_price
  FROM catalog_sales
  WHERE cs_sold_date_sk BETWEEN 2451557 AND 2455281
) c ON f.solddate = c.cs_sold_date_sk
WHERE DATE_TRUNC('month', to_date(c.cs_sold_date_sk + 2451557 - 1, 'J')) = '2000-01-01'
LIMIT 100;