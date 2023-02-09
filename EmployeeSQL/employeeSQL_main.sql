-- create department table 
CREATE TABLE department(
	dept_no VARCHAR(4) PRIMARY KEY,
	dept_name VARCHAR(20) NOT NULL);

-- create salary tables
CREATE TABLE Salaries(
	emp_no INT PRIMARY KEY,
	salary INT);

-- create title tables
CREATE TABLE Titles(
	title_id VARCHAR(5) PRIMARY KEY,
	title VARCHAR(20) NOT NULL);
	
-- create Employees table
CREATE TABLE Employees(
	emp_no INT PRIMARY KEY,
	emp_title_id VARCHAR (5),
	birth_date DATE,
	first_name VARCHAR (30) NOT NULL,
	last_name VARCHAR (30) NOT NULL,
	sex VARCHAR (1),
	hire_date DATE,
	FOREIGN KEY (emp_no) REFERENCES Salaries(emp_no),
	FOREIGN KEY (emp_title_id) REFERENCES Titles(title_id));
	
-- create Department_Employee table
CREATE TABLE Department_Employee(
	dept_emp_no SERIAL PRIMARY KEY,
	emp_no INT,
	dept_no VARCHAR (4),
	FOREIGN KEY (dept_no) REFERENCES department(dept_no),
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no));

-- create Dept_Manager table
CREATE TABLE Department_Manager(
	dept_manager_no SERIAL PRIMARY KEY,
	dept_no VARCHAR (4),
	emp_no INT,
	FOREIGN KEY (dept_no) REFERENCES department(dept_no),
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no));
	


-- Data Analysis	
-- List the employee number, last name, first name, sex, and salary of each employee.
SELECT E.emp_no AS "Employee Numbers",
	E.first_name AS "Employee First Name",
	E.last_name AS "Employee Last Name",
	E.sex, 
	S.salary
FROM Employees AS E
INNER JOIN salaries AS S ON E.emp_no = S.emp_no;

-- List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name AS "Employee First Name",
	last_name AS "Employee Last Name",
	hire_date AS "Hiring Date"
FROM Employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

-- List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT DM.dept_no AS "Department Number",
	DN.dept_name AS "Department Name", 
	E.emp_no AS "Employee Number",
	E.first_name AS "Employee First Name", 
	E.last_name AS "Employee Last Name"
FROM Department_manager AS DM
INNER JOIN Employees AS E ON DM.emp_no = E.emp_no
INNER JOIN Department AS DN ON DM.dept_no = DN.dept_no;

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT E.emp_no AS "Employee Number",
	E.first_name AS "Employee First Name",
	E.last_name AS "Employee Last Name", 
	DN.dept_no AS "Department Number",
	DN.dept_name AS "Dpeartment Name"
FROM Department_employee AS DE
INNER JOIN Employees AS E ON DE.emp_no = E.emp_no
INNER JOIN Department AS DN ON DE.dept_no = DN.dept_no;

-- List the first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT E.first_name AS "Employee First Name", 
	E.last_name AS "Employee Last Name",
	E.sex
FROM Employees AS E
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- List each employee in the Sales department, including their employee number, last name, and first name.
SELECT E.emp_no AS "Employee Number", 
	E.last_name AS "Employee Last Name", 
	E.first_name AS "Employee First Name",
	Department.dept_name AS "Department Name"
FROM Department 
INNER JOIN Department_employee ON Department_employee.dept_no = Department.dept_no
INNER JOIN Employees AS E ON E.emp_no = Department_employee.emp_no
WHERE Department.dept_name = 'Sales';

-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT E.emp_no AS "Employee Number", 
	E.last_name AS "Employee Last Name", 
	E.first_name AS "Employee First Name",
	D.dept_name AS "Department Name"
FROM Department AS D
INNER JOIN Department_employee ON Department_employee.dept_no = D.dept_no
INNER JOIN Employees AS E ON E.emp_no = Department_employee.emp_no
WHERE D.dept_name IN (
	'Sales', 'Development');

-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT COUNT(emp_no) AS "Number of count for employees with same last name", last_name
FROM Employees
GROUP BY last_name
ORDER BY COUNT(emp_no) DESC;


	