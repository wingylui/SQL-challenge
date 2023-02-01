SELECT emp.emp_no AS "Employees number", emp.last_name, emp.first_name, emp.sex, s.salary
FROM public."Employees" emp
INNER JOIN public."Salary" s 
ON emp.emp_no=s.emp_no