SELECT c.c_customer_id, c.c_salutation, c.c_first_name, c.c_last_name, 
    ca.ca_street_number, ca.ca_street_name, ca.ca_street_type, ca.ca_suite_number, ca.ca_city, 
    ca.ca_county, ca.ca_state, ca.ca_zip, ca.ca_country, ca.ca_gmt_offset, ca.ca_location_type, 
    ctr.ctr_total_return
FROM customer c
JOIN customer_address ca ON c.c_current_addr_sk = ca.ca_address_sk
JOIN customer_total_return ctr ON c.c_customer_sk = ctr.ctr_customer_sk
WHERE ca.ca_state = 'California' 
    AND d.d_year = 2002 
    AND ctr.ctr_total_return > (SELECT AVG(ctr_total_return) * 1.2 
                                FROM customer_total_return 
                                WHERE ctr_state = 'California')
ORDER BY c.c_customer_id, c.c_salutation, c.c_first_name, c.c_last_name, 
    ca.ca_street_number, ca.ca_street_name, ca.ca_street_type, ca.ca_suite_number, ca.ca_city, 
    ca.ca_county, ca.ca_state, ca.ca_zip, ca.ca_country, ca.ca_gmt_offset, ca.ca_location_type, 
    ctr.ctr_total_return
LIMIT 100;