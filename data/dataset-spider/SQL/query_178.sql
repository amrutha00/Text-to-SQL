SELECT city ,  COUNT(*) FROM station GROUP BY city HAVING COUNT(*)  >=  15