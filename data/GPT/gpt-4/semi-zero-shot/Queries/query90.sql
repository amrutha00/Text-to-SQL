SELECT 
    ws_sold_time_sk, 
    COUNT(CASE WHEN time_hour BETWEEN 10 AND 11 THEN 1 ELSE NULL END) AS morning_sales,
    COUNT(CASE WHEN time_hour BETWEEN 16 AND 17 THEN 1 ELSE NULL END) AS evening_sales,
    CASE WHEN COUNT(CASE WHEN time_hour BETWEEN 16 AND 17 THEN 1 ELSE NULL END) = 0 
        THEN 0 
        ELSE CAST(COUNT(CASE WHEN time_hour BETWEEN 10 AND 11 THEN 1 ELSE NULL END) AS FLOAT) 
            / COUNT(CASE WHEN time_hour BETWEEN 16 AND 17 THEN 1 ELSE NULL END) 
    END AS ratio
FROM 
    web_sales 
JOIN 
    customer ON web_sales.ws_bill_customer_sk = customer.c_customer_sk
JOIN 
    time_dim ON web_sales.ws_sold_time_sk = time_dim.t_time_sk
JOIN 
    web_site ON web_sales.ws_web_site_sk = web_site.ws_web_site_sk
WHERE 
    customer.c_current_cdemo_sk IS NOT NULL
AND 
    customer.c_number_of_dependent IS NOT NULL -- Assuming you would specify the number of dependents here
AND 
    web_site.ws_content_count BETWEEN 5000 AND 5200
GROUP BY 
    ws_sold_time_sk
HAVING 
    COUNT(CASE WHEN time_hour BETWEEN 10 AND 11 THEN 1 ELSE NULL END) > 0
OR 
    COUNT(CASE WHEN time_hour BETWEEN 16 AND 17 THEN 1 ELSE NULL END) > 0
ORDER BY 
    ratio DESC
LIMIT 100;
