SELECT t1.channel,
       t1.item,
       t1.quantity_ratio,
       t1.currency_ratio,
       ROW_NUMBER() OVER(PARTITION BY t1.channel ORDER BY t1.quantity_ratio, t1.currency_ratio, t1.item) AS return_rank
FROM (
    SELECT c.channel,
           a.item,
           COALESCE(b.sales_quantity, 0) / COALESCE(d.return_quantity, 1) AS quantity_ratio,
           COALESCE(b.sales_return_amt, 0) / COALESCE(d.return_net_paid_amt, 1) AS currency_ratio,
           ROW_NUMBER() OVER(PARTITION BY c.channel ORDER BY COALESCE(b.sales_quantity, 0) / COALESCE(d.return_quantity, 1), COALESCE(b.sales_return_amt, 0) / COALESCE(d.return_net_paid_amt, 1), a.item) AS currency_rank
    FROM (
        SELECT DISTINCT cs_catalog_page_sk AS item
        FROM catalog_sales
        WHERE cs_sold_date_sk >= 19990101 AND cs_sold_date_sk <= 19991231
    ) a
    LEFT JOIN (
        SELECT cs_catalog_page_sk AS item,
               SUM(cs_quantity) AS sales_quantity,
               SUM(cs_ext_sales_price) AS sales_return_amt
        FROM catalog_sales
        WHERE cs_sold_date_sk >= 19990101 AND cs_sold_date_sk <= 19991231
        GROUP BY cs_catalog_page_sk
    ) b ON a.item = b.item
    LEFT JOIN (
        SELECT cr_item_sk AS item,
               SUM(cr_return_quantity) AS return_quantity,
               SUM(cr_return_amt) AS return_net_paid_amt
        FROM catalog_returns
        WHERE cr_returned_date_sk >= 19990101 AND cr_returned_date_sk <= 19991231
        GROUP BY cr_item_sk
    ) d ON a.item = d.item
    JOIN call_center c ON b.call_center_sk = c.cc_call_center_sk
) t1
WHERE t1.return_rank <= 100
ORDER BY t1.channel, t1.return_rank, t1.currency_rank, t1.item;