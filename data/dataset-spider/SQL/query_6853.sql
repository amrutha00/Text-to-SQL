SELECT city FROM airports WHERE country  =  'United States' GROUP BY city HAVING count(*)  >  3