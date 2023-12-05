SELECT
    s.sales_channel,
    CASE
        WHEN s.sales_channel = 'store' THEN st.store_name
        WHEN s.sales_channel = 'catalog' THEN cp.catalog_page_name
        WHEN s.sales_channel = 'web' THEN ws.web_site_name
    END AS specific_method,
    SUM(s.sales) AS total_sales,
    SUM(s.profit) AS total_profit,
    SUM(s.return_amount) AS total_return_amount,
    CASE
        WHEN s.sales_channel = 'store' THEN SUM(s.sales) - SUM(s.profit) - SUM(s.return_amount)
        ELSE NULL
    END AS net_loss
FROM
    sales s
INNER JOIN
    date_dim d ON s.sales_date = d.d_date
LEFT JOIN
    store_sales ss ON s.sales_id = ss.sales_id
LEFT JOIN
    store st ON ss.store_id = st.store_id
LEFT JOIN
    catalog_sales cs ON s.sales_id = cs.sales_id
LEFT JOIN
    catalog_page cp ON cs.catalog_page_id = cp.catalog_page_id
LEFT JOIN
    web_sales ws ON s.sales_id = ws.sales_id
WHERE
    d.d_date BETWEEN '2000-08-19' AND '2000-09-02' -- Assuming 14-day time frame
GROUP BY
    s.sales_channel, specific_method
ORDER BY
    s.sales_channel, specific_method
LIMIT 100; -- Limit to the top 100 results
