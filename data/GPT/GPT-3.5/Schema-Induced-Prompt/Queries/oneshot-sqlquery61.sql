SELECT 
    ROUND((SUM(ss_sales_price) FILTER (WHERE i_category = 'Jewelry' AND ca_gmt_offset = -7 AND p_promo_sk IS NOT NULL) / 
           SUM(ss_sales_price) FILTER (WHERE d_month_seq = 199911 AND ca_gmt_offset = -7)) * 100, 2) AS ratio
FROM 
    store_sales
JOIN 
    date_dim ON store_sales.ss_sold_date_sk = date_dim.d_date_sk
JOIN 
    item ON store_sales.ss_item_sk = item.i_item_sk
JOIN 
    customer_address ON store_sales.ss_addr_sk = customer_address.ca_address_sk
LEFT JOIN 
    promotion ON store_sales.ss_promo_sk = promotion.p_promo_sk
WHERE 
    d_month_seq = 199911
    AND i_category = 'Jewelry'
    AND ca_gmt_offset = -7
GROUP BY 
    d_month_seq
ORDER BY 
    SUM(ss_sales_price) FILTER (WHERE i_category = 'Jewelry' AND ca_gmt_offset = -7 AND p_promo_sk IS NOT NULL),
    SUM(ss_sales_price) FILTER (WHERE d_month_seq = 199911 AND ca_gmt_offset = -7)
LIMIT 100;