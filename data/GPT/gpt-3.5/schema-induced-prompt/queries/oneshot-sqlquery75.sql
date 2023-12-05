SELECT curr_yr.d_year, curr_yr.i_brand, curr_yr.i_class, curr_yr.i_category, curr_yr.i_manufact,
       curr_yr.sales_cnt, prev_yr.sales_cnt,
       (curr_yr.sales_cnt - prev_yr.sales_cnt) AS sales_cnt_diff,
       (curr_yr.sales_amt - prev_yr.sales_amt) AS sales_amt_diff
FROM
   (SELECT d.d_year, i.i_brand, i.i_class, i.i_category, i.i_manufact,
           SUM(cs.cs_quantity) AS sales_cnt,
           SUM(cs.cs_ext_sales_price) AS sales_amt
    FROM catalog_sales AS cs
    JOIN date_dim AS d ON cs.cs_sold_date_sk = d.d_date_sk
    JOIN item AS i ON cs.cs_item_sk = i.i_item_sk
    WHERE d.d_year = 1999 AND i.i_category = 'Home'
    GROUP BY d.d_year, i.i_brand, i.i_class, i.i_category, i.i_manufact) AS curr_yr
JOIN
   (SELECT d.d_year, i.i_brand, i.i_class, i.i_category, i.i_manufact,
           SUM(cs.cs_quantity) AS sales_cnt,
           SUM(cs.cs_ext_sales_price) AS sales_amt
    FROM catalog_sales AS cs
    JOIN date_dim AS d ON cs.cs_sold_date_sk = d.d_date_sk
    JOIN item AS i ON cs.cs_item_sk = i.i_item_sk
    WHERE d.d_year = 1998 AND i.i_category = 'Home'
    GROUP BY d.d_year, i.i_brand, i.i_class, i.i_category, i.i_manufact) AS prev_yr
ON curr_yr.i_brand = prev_yr.i_brand AND
   curr_yr.i_class = prev_yr.i_class AND
   curr_yr.i_category = prev_yr.i_category AND
   curr_yr.i_manufact = prev_yr.i_manufact
WHERE CAST(curr_yr.sales_cnt AS DECIMAL(17,2))/CAST(prev_yr.sales_cnt AS DECIMAL(17,2)) < 0.9
ORDER BY sales_cnt_diff ASC, sales_amt_diff ASC
LIMIT 100;