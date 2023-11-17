--Drop tables if exists
DROP TABLE employees;
--Create table
CREATE TABLE employees (
    emp_no INT   NOT NULL,
    emp_title_id VARCHAR NOT NULL,
    birth_date DATE   NOT NULL,
    first_name VARCHAR   NOT NULL,
    last_name VARCHAR   NOT NULL,
    sex VARCHAR   NOT NULL,
    hire_date DATE   NOT NULL,
    PRIMARY KEY (emp_no)
);

--Drop tables if exists
DROP TABLE departments;
--Create table
CREATE TABLE departments(
	dept_no VARCHAR(50) NOT NULL,
	dept_name VARCHAR(50) NOT NULL,
	PRIMARY KEY (dept_no),
	UNIQUE (dept_no)
);

--Drop tables if exists
DROP TABLE titles;
--Create table
CREATE TABLE titles(
	title_id VARCHAR(50) NOT NULL,
	title VARCHAR(50) NOT NULL,
	PRIMARY KEY (title_id)
);

--Drop tables if exists
DROP TABLE salaries;
--Create table
CREATE TABLE salaries(
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no)
);

--Drop tables if exists
DROP TABLE dept_managers;
--Create table
CREATE TABLE dept_managers(
	dept_no VARCHAR(50) NOT NULL,
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no,dept_no)
);

--Drop tables if exists
DROP TABLE dept_emp;
--Create table
CREATE TABLE dept_emp(
	emp_no INT NOT NULL,
	dept_no VARCHAR(50),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no,dept_no)
);


---List the employee number, last name, first name, sex, and salary of each employee
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees AS e
JOIN salaries AS s
ON (e.emp_no = s.emp_no)
ORDER BY emp_no;


---List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '01/01/1986' AND '31-12-1986';


---List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT d.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name
FROM employees AS e
JOIN dept_managers AS m
ON (e.emp_no = m.emp_no)
	JOIN departments AS d
	ON (m.dept_no = d.dept_no)
	ORDER BY d.dept_no;

---List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS d_e
ON (e.emp_no = d_e.emp_no)
	JOIN departments AS d
	ON (d_e.dept_no = d.dept_no)
	ORDER BY e.emp_no;



---List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';



---List each employee in the Sales department, including their employee number, last name, and first name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS d_e
ON (e.emp_no = d_e.emp_no)
	JOIN departments AS d
	ON (d_e.dept_no = d.dept_no)
	WHERE d.dept_name = 'Sales'
	ORDER BY e.emp_no;

---List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS d_e
ON(e.emp_no = d_e.emp_no)
	JOIN departments AS d
	ON (d_e.dept_no = d.dept_no)
	WHERE d.dept_name IN ('Sales','Development')
	ORDER BY e.emp_no;
	
	
---List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(last_name) AS count
FROM employees
GROUP BY last_name
ORDER BY count DESC;



















