SELECT DISTINCT T2.problem_id ,  T2.problem_log_id FROM staff AS T1 JOIN problem_log AS T2 ON T1.staff_id = T2.assigned_to_staff_id WHERE T1.staff_first_name = "Rylan" AND T1.staff_last_name = "Homenick"