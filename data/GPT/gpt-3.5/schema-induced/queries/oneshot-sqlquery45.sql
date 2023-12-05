SELECT ca_zip AS zip_code, ca_city AS city_name, SUM(ws_ext_sales_price) AS total_web_sales
FROM web_sales
JOIN customer ON ws_bill_customer_sk = c_customer_sk
JOIN customer_address ON c_current_addr_sk = ca_address_sk
JOIN date_dim ON ws_sold_date_sk = d_date_sk
WHERE (ca_zip IN ('85669', '86197', '88274', '83405', '86475', '85392', '85460', '80348', '81792'))
  AND (d_year >= 2000 AND d_year <= 2009)
  AND (d_quarter_name = 'Q2')
GROUP BY ca_zip, ca_city
ORDER BY ca_zip, ca_city
LIMIT 100;