SELECT avg(total_amount_purchased) ,  avg(total_value_purchased) FROM Product_Suppliers WHERE supplier_id  =  (SELECT supplier_id FROM Product_Suppliers GROUP BY supplier_id ORDER BY count(*) DESC LIMIT 1)