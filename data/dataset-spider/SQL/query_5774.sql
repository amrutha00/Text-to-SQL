SELECT town_city FROM customers WHERE customer_type_code  =  "Good Credit Rating" GROUP BY town_city ORDER BY count(*) LIMIT 1