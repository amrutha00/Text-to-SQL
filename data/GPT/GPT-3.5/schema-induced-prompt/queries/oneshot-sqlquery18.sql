SELECT
    i.i_item_id,
    ca.ca_country,
    ca.ca_state,
    ca.ca_county,
    AVG(cs.cs_quantity) AS avg_quantity,
    AVG(cs.cs_list_price) AS avg_list_price,
    AVG(cs.cs_coupon_amt) AS avg_coupon_amt,
    AVG(cs.cs_sales_price) AS avg_sales_price,
    AVG(cs.cs_net_profit) AS avg_net_profit,
    AVG(YEAR(CURDATE()) - c.c_birth_year) AS avg_customer_age,
    AVG(cd.cd_dep_count) AS avg_dependents_count
FROM
    catalog_sales cs
JOIN
    customer c ON cs.cs_bill_customer_sk = c.c_customer_sk
JOIN
    customer_demographics cd ON c.c_current_cdemo_sk = cd.cd_demo_sk
JOIN
    customer_address ca ON c.c_current_addr_sk = ca.ca_address_sk
JOIN
    item i ON cs.cs_item_sk = i.i_item_sk
WHERE
    MONTHNAME(FROM_UNIXTIME(c.c_birth_day, c.c_birth_month, c.c_birth_year)) IN ('January', 'February', 'March')
    AND cd.cd_gender IN ('Male', 'Female')
    AND cd.cd_marital_status = 'Married'
GROUP BY
    i.i_item_id,
    ca.ca_country,
    ca.ca_state,
    ca.ca_county
ORDER BY
    ca.ca_country,
    ca.ca_state,
    ca.ca_county,
    i.i_item_id
LIMIT 100;