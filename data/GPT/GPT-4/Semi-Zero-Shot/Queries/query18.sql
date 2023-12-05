SELECT 
    ca.ca_country AS country, 
    ca.ca_state AS state, 
    ca.ca_county AS county, 
    cs.cs_item_sk AS item_id,
    AVG(cs.cs_quantity) AS avg_quantity, 
    AVG(cs.cs_list_price) AS avg_list_price,
    AVG(cs.cs_coupon_amt) AS avg_coupon_amount,
    AVG(cs.cs_sales_price) AS avg_sales_price, 
    AVG(cs.cs_net_profit) AS avg_net_profit,
    AVG(DATE_PART('year', CURRENT_DATE) - c.c_birth_year) AS avg_age,
    AVG(cd.cd_dep_count) AS avg_number_of_dependents
FROM 
    catalog_sales cs
JOIN 
    customer c ON cs.cs_sold_customer_sk = c.c_customer_sk
JOIN 
    customer_address ca ON c.c_current_addr_sk = ca.ca_address_sk
JOIN 
    customer_demographics cd ON c.c_current_cdemo_sk = cd.cd_demo_sk
WHERE 
    c.c_birth_month IN (/* Specify birth months here */) 
AND 
    ca.ca_state IN (/* Specify states here */) 
-- More conditions for the demographic characteristics can be added to the WHERE clause.
GROUP BY 
    ca.ca_country, ca.ca_state, ca.ca_county, cs.cs_item_sk
ORDER BY 
    ca.ca_country, ca.ca_state, ca.ca_county, cs.cs_item_sk
LIMIT 100;
