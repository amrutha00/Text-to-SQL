SELECT customer_id ,  count(*) FROM Customers_cards GROUP BY customer_id ORDER BY count(*) DESC LIMIT 1