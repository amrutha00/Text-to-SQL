SELECT count(DISTINCT state) FROM college WHERE enr  >  (SELECT avg(enr) FROM college)