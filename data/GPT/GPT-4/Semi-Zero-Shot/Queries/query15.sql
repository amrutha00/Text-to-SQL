SELECT cs_bill_customer_sk, cs_bill_cdemo_sk, cs_bill_zip, SUM(cs_sales_price) AS total_sales
FROM catalog_sales
JOIN customer_address ON cs_bill_addr_sk = ca_address_sk
JOIN date_dim ON cs_sold_date_sk = d_date_sk
WHERE (d_year = 2001 AND d_quarter = 1) OR ca_region IN (SELECT region_column FROM selected_regions_table)
GROUP BY cs_bill_customer_sk, cs_bill_cdemo_sk, cs_bill_zip
ORDER BY total_sales DESC
LIMIT 100;
