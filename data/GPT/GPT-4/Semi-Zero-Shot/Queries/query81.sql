WITH CaliforniaAverage AS (
    SELECT AVG(ss_net_paid_inc_tax) AS avg_return_amount
    FROM store_sales
    JOIN customer_address ON store_sales.ss_addr_sk = customer_address.ca_address_sk
    WHERE ca_state = 'CA' AND EXTRACT(YEAR FROM ss_sold_date_sk) = 2002
)

SELECT c.c_customer_sk AS customer_id,
       c.c_salutation,
       c.c_first_name,
       c.c_last_name,
       ca.ca_street_number,
       ca.ca_street_name,
       ca.ca_street_type,
       ca.ca_suite_number,
       ca.ca_city,
       ca.ca_county,
       ca.ca_state,
       ca.ca_zip,
       ca.ca_country,
       ca.ca_gmt_offset,
       ca.ca_location_type,
       SUM(ss_net_paid_inc_tax) AS total_return_amount
FROM customer c
JOIN store_sales ss ON c.c_customer_sk = ss.ss_customer_sk
JOIN customer_address ca ON c.c_current_addr_sk = ca.ca_address_sk
WHERE ca.ca_state = 'CA' AND EXTRACT(YEAR FROM ss.ss_sold_date_sk) = 2002
GROUP BY c.c_customer_sk, c.c_salutation, c.c_first_name, c.c_last_name,
         ca.ca_street_number, ca.ca_street_name, ca.ca_street_type, 
         ca.ca_suite_number, ca.ca_city, ca.ca_county, ca.ca_state, 
         ca.ca_zip, ca.ca_country, ca.ca_gmt_offset, ca.ca_location_type
HAVING SUM(ss_net_paid_inc_tax) > (1.20 * (SELECT avg_return_amount FROM CaliforniaAverage))
ORDER BY c.c_customer_sk, c.c_salutation, c.c_first_name, c.c_last_name,
         ca.ca_street_number, ca.ca_street_name, ca.ca_street_type, 
         ca.ca_suite_number, ca.ca_city, ca.ca_county, ca.ca_state, 
         ca.ca_zip, ca.ca_country, ca.ca_gmt_offset, ca.ca_location_type,
         SUM(ss_net_paid_inc_tax)
LIMIT 100;
