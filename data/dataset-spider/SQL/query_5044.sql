SELECT cName FROM college WHERE enr  >  (SELECT max(enr) FROM college WHERE state  =  'FL')