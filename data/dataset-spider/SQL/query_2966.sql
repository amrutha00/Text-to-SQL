SELECT T2.name ,  T1.category_id ,  count(*) FROM film_category AS T1 JOIN category AS T2 ON T1.category_id  =  T2.category_id GROUP BY T1.category_id