SELECT t1.Primary_conference FROM university AS t1 JOIN basketball_match AS t2 ON t1.school_id  =  t2.school_id ORDER BY t2.acc_percent LIMIT 1