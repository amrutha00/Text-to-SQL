SELECT ca_zip, SUM(cs_ext_sales_price) AS total_sales
FROM catalog_sales
JOIN customer_address ON cs_ship_addr_sk = ca_address_sk
JOIN date_dim ON cs_sold_date_sk = d_date_sk
WHERE d_year = 2001
    AND d_fy_quarter_seq = 1
GROUP BY ca_zip
ORDER BY total_sales DESC
LIMIT 100;