SELECT t1.dname FROM department AS t1 JOIN dept_locations AS t2 ON t1.dnumber  =  t2.dnumber WHERE t2.dlocation  =  'Houston'