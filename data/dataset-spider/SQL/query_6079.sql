SELECT t3.address_content FROM customers AS t1 JOIN customer_addresses AS t2 ON t1.customer_id  =  t2.customer_id JOIN addresses AS t3 ON t2.address_id  =  t3.address_id WHERE t1.customer_name  =  "Maudie Kertzmann"