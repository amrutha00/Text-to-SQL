SELECT cs.cs_ext_discount_amt
FROM catalog_sales cs
JOIN item i ON cs.cs_item_sk = i.i_item_sk
JOIN date_dim d ON cs.cs_sold_date_sk = d.d_date_sk
WHERE i.i_manufact_id = 29
  AND d.d_date >= '1999-01-07'
  AND d.d_date <= '1999-04-07'
  AND cs.cs_ext_discount_amt > 0.3 * (
    SELECT AVG(cs_ext_discount_amt)
    FROM catalog_sales
    JOIN item ON catalog_sales.cs_item_sk = item.i_item_sk
    JOIN date_dim d ON catalog_sales.cs_sold_date_sk = d.d_date_sk
    WHERE d.d_date >= '1999-01-07'
      AND d.d_date <= '1999-04-07'
      AND item.i_manufact_id = 29
  )
ORDER BY cs.cs_ext_discount_amt DESC
LIMIT 100;