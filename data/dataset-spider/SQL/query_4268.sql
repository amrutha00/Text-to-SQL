SELECT count(*) FROM club AS t1 JOIN member_of_club AS t2 ON t1.clubid  =  t2.clubid JOIN student AS t3 ON t2.stuid  =  t3.stuid WHERE t3.fname  =  "Linda" AND t3.lname  =  "Smith"