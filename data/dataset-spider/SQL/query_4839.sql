SELECT t1.name ,  t1.age FROM pilot AS t1 JOIN MATCH AS t2 ON t1.pilot_id  =  t2.winning_pilot WHERE t1.age  <  30 GROUP BY t2.winning_pilot ORDER BY count(*) DESC LIMIT 1