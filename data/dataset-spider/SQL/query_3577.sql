SELECT T1.artist_name ,  T1.gender FROM artist AS T1 JOIN song AS T2 ON T1.artist_name  =  T2.artist_name WHERE T2.releasedate LIKE "%Mar%"