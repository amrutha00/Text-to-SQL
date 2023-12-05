SELECT TOP 100
    w.state AS warehouse_state,
    s.item_id,
    SUM(CASE WHEN s.sale_date >= 'start_date' AND s.sale_date <= 'end_date' THEN s.sale_amount ELSE 0 END) AS total_sales_before_price_adjustment,
    SUM(CASE WHEN s.sale_date > 'end_date' AND s.sale_date <= 'adjusted_end_date' THEN s.sale_amount ELSE 0 END) AS total_sales_after_price_adjustment
FROM sales s
JOIN warehouses w ON s.warehouse_id = w.warehouse_id
JOIN items i ON s.item_id = i.item_id
WHERE s.sale_date >= 'start_date' AND s.sale_date <= 'adjusted_end_date'
GROUP BY w.state, s.item_id
ORDER BY w.state, s.item_id;
