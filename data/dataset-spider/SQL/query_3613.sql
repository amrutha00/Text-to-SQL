SELECT T1.country FROM artist AS T1 JOIN song AS T2 ON T1.artist_name  =  T2.artist_name GROUP BY T2.artist_name ORDER BY count(*) LIMIT 1