WITH ssci AS (
  SELECT ss_customer_sk, ss_item_sk
  FROM store_sales
  WHERE ss_sold_date_sk >= <start_date> AND ss_sold_date_sk <= <end_date>
),
csci AS (
  SELECT cs_bill_customer_sk, cs_item_sk
  FROM catalog_sales
  WHERE cs_sold_date_sk >= <start_date> AND cs_sold_date_sk <= <end_date>
),
store_only AS (
  SELECT COUNT(*) AS count_store_only
  FROM ssci
  LEFT JOIN csci ON ssci.ss_customer_sk = csci.cs_bill_customer_sk AND ssci.ss_item_sk = csci.cs_item_sk
  WHERE csci.cs_bill_customer_sk IS NULL
),
catalog_only AS (
  SELECT COUNT(*) AS count_catalog_only
  FROM ssci
  RIGHT JOIN csci ON ssci.ss_customer_sk = csci.cs_bill_customer_sk AND ssci.ss_item_sk = csci.cs_item_sk
  WHERE ssci.ss_customer_sk IS NULL
),
store_and_catalog AS (
  SELECT COUNT(*) AS count_store_and_catalog
  FROM ssci
  INNER JOIN csci ON ssci.ss_customer_sk = csci.cs_bill_customer_sk AND ssci.ss_item_sk = csci.cs_item_sk
),
ratio AS (
  SELECT count_store_only / count_store_and_catalog AS sales_ratio
  FROM store_only, store_and_catalog
)
SELECT *
FROM ratio
LIMIT 100;