SELECT t3.fname ,  t3.lname FROM club AS t1 JOIN member_of_club AS t2 ON t1.clubid  =  t2.clubid JOIN student AS t3 ON t2.stuid  =  t3.stuid WHERE t1.clubname  =  "Bootup Baltimore" AND t3.sex  =  "F"