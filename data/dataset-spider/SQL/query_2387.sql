SELECT sum(t1.graduate) FROM discipline_enrollments AS t1 JOIN campuses AS t2 ON t1.campus  =  t2.id WHERE t1.year  =  2004 AND t2.campus  =  "San Francisco State University"