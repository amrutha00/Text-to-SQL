SELECT T2.song_name FROM files AS T1 JOIN song AS T2 ON T1.f_id  =  T2.f_id WHERE T1.formats  =  "mp3" INTERSECT SELECT song_name FROM song WHERE resolution  <  1000