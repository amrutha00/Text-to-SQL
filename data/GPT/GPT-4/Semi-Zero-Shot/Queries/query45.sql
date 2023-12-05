SELECT 
    ca.ca_zip,
    ca.ca_city,
    SUM(ws.ws_net_paid) AS total_web_sales
FROM 
    web_sales ws
JOIN 
    customer_address ca ON ws.ws_bill_addr_sk = ca.ca_address_sk
JOIN 
    date_dim dd ON ws.ws_sold_date_sk = dd.d_date_sk
WHERE 
    ca.ca_zip IN (85669, 86197, 88274, 83405, 86475, 85392, 85460, 80348, 81792)
AND 
    dd.d_year = 2000 
AND 
    dd.d_qoy = 2
GROUP BY 
    ca.ca_zip,
    ca.ca_city
ORDER BY 
    ca.ca_zip ASC,
    ca.ca_city ASC
LIMIT 100;
