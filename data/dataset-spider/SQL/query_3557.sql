SELECT f_id FROM files WHERE formats  =  "mp4" INTERSECT SELECT f_id FROM song WHERE resolution  <  1000