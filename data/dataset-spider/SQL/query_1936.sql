SELECT name ,  LOCATION FROM cinema WHERE capacity  >  (SELECT avg(capacity) FROM cinema)