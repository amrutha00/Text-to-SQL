SELECT open_date FROM church GROUP BY open_date HAVING count(*)  >=  2