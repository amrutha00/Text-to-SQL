SELECT first_name ,  last_name ,  hire_date FROM employees WHERE department_id  =  ( SELECT department_id FROM employees WHERE first_name  =  "Clara") AND first_name != "Clara"