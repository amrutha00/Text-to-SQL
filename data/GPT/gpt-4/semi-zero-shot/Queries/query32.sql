WITH AverageDiscount AS (
    SELECT AVG(cs_ext_discount_amt) as avg_discount
    FROM catalog_sales
    JOIN date_dim ON catalog_sales.cs_sold_date_sk = date_dim.d_date_sk
    WHERE date_dim.d_date BETWEEN '1999-01-07' AND '1999-04-07'
)

SELECT cs_item_sk, 
       cs_ext_discount_amt - avg_discount as excess_discount_amount
FROM catalog_sales
JOIN date_dim ON catalog_sales.cs_sold_date_sk = date_dim.d_date_sk
JOIN item ON catalog_sales.cs_item_sk = item.i_item_sk
, AverageDiscount
WHERE date_dim.d_date BETWEEN '1999-01-07' AND '1999-04-07'
AND item.i_manufacturer_id = 29
AND cs_ext_discount_amt > (1.3 * avg_discount)
ORDER BY excess_discount_amount DESC
LIMIT 100;
