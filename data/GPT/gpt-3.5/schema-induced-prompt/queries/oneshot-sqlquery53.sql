SELECT 
   i.i_manufact_id AS manufacturer_id,
   QUARTER(s.d_date) AS quarter,
   SUM(ss.ss_ext_sales_price) AS quarterly_sales,
   SUM(ss.ss_ext_sales_price) / COUNT(DISTINCT s.d_month_seq) AS annual_sales
FROM 
   item AS i
JOIN 
   store_sales AS ss ON i.i_item_sk = ss.ss_item_sk
JOIN 
   date_dim AS s ON ss.ss_sold_date_sk = s.d_date_sk
JOIN 
   (SELECT 
       i_item_id
    FROM 
       item
       WHERE (i_category = 'Books' AND i_class IN ('personal', 'portable', 'reference', 'self-help') AND i_brand IN ('scholaramalgamalg #14', 'scholaramalgamalg #7', 'exportiunivamalg #9', 'scholaramalgamalg #9'))
          OR (i_category IN ('Women', 'Music', 'Men') AND i_class IN ('accessories', 'classical', 'fragrances', 'pants') AND i_brand IN ('amalgimporto #1', 'edu packscholar #1', 'exportiimporto #1', 'importoamalg #1'))
    ) AS filt ON i.i_item_id = filt.i_item_id
WHERE 
   s.d_month_seq = <specific_month_sequence>
GROUP BY 
   i.i_manufact_id,
   quarter
HAVING 
   SUM(ss.ss_ext_sales_price) / COUNT(DISTINCT s.d_month_seq) > 0.1 * SUM(ss.ss_ext_sales_price)
ORDER BY 
   AVG(quarterly_sales) DESC,
   SUM(quarterly_sales) DESC,
   manufacturer_id
LIMIT 100;