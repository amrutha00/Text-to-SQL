SELECT title FROM vocals AS T1 JOIN songs AS T2 ON T1.songid  =  T2.songid GROUP BY T1.songid ORDER BY count(*) DESC LIMIT 1