SELECT home_city FROM driver WHERE age  >  40 GROUP BY home_city HAVING count(*)  >=  2