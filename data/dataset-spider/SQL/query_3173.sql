SELECT origin FROM train GROUP BY origin HAVING count(*)  >  1