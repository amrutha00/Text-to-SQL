SELECT department_id ,  SUM(salary) FROM employees GROUP BY department_id HAVING count(*)  >=  2