SELECT
    m.manufacturer_id,
    SUM(CASE WHEN t.month_sequence BETWEEN start_month_seq AND end_month_seq THEN t.sales_price END) AS quarterly_sales,
    SUM(CASE WHEN t.month_sequence BETWEEN start_month_seq AND end_month_seq THEN t.sales_price END) * 4 AS annual_sales
FROM
    manufacturer m
JOIN
    item i ON m.manufacturer_id = i.manufacturer_id
JOIN
    item_category ic ON i.item_id = ic.item_id
JOIN
    item_class icl ON i.item_id = icl.item_id
JOIN
    item_brand ib ON i.item_id = ib.item_id
JOIN
    item_class_category iccl ON icl.item_class_id = iccl.item_class_id AND ic.item_category_id = iccl.item_category_id
WHERE
    (ic.category IN ('Books', 'Children', 'Electronics') AND icl.item_class_name IN ('personal', 'portable', 'reference', 'self-help') AND ib.brand_name IN ('scholaramalgamalg #14', 'scholaramalgamalg #7', 'exportiunivamalg #9', 'scholaramalgamalg #9'))
    OR
    (ic.category IN ('Women', 'Music', 'Men') AND icl.item_class_name IN ('accessories', 'classical', 'fragrances', 'pants') AND ib.brand_name IN ('amalgimporto #1', 'edu packscholar #1', 'exportiimporto #1', 'importoamalg #1'))
GROUP BY
    m.manufacturer_id
HAVING
    SUM(CASE WHEN t.month_sequence BETWEEN start_month_seq AND end_month_seq THEN t.sales_price END) > 0.1 * SUM(CASE WHEN t.month_sequence = specific_month_seq THEN t.sales_price END)
ORDER BY
    quarterly_sales,
    annual_sales,
    m.manufacturer_id
LIMIT 100;
