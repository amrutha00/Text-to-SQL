SELECT count(*) ,  t1.name FROM manufacturer AS t1 JOIN furniture_manufacte AS t2 ON t1.manufacturer_id  =  t2.manufacturer_id GROUP BY t1.manufacturer_id