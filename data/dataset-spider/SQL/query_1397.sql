SELECT title FROM course GROUP BY title HAVING count(*)  >  1