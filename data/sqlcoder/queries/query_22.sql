SELECT i.i_product_name,
       i.i_brand,
       i.i_class,
       i.i_category,
       AVG(inv.inv_quantity_on_hand) AS qoh
FROM inventory inv
JOIN item i ON inv.inv_item_sk = i.i_item_sk
JOIN date_dim d ON inv.inv_date_sk = d.d_date_sk
WHERE d.d_month_seq BETWEEN 1188 AND 1188 + 11
GROUP BY ROLLUP (i.i_product_name,
                 i.i_brand,
                 i.i_class,
                 i.i_category)
ORDER BY qoh ASC,
         i.i_product_name ASC,
         i.i_brand ASC,
         i.i_class ASC,
         i.i_category ASC
LIMIT 100;