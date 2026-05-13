--Basic Queries
--creating tables
-- Create Department table
CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Create Employee table
CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    salary DECIMAL(10, 2),
    department_id INT,
    hire_date DATE,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- Create Project table
CREATE TABLE Project (
    project_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- Insert data into Department table
INSERT INTO Department (department_id, name) VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing');

-- Insert data into Employee table
INSERT INTO Employee (emp_id, name, age, salary, department_id, hire_date) VALUES
(1, 'John Doe', 28, 50000.00, 1, '2020-01-15'),
(2, 'Jane Smith', 34, 60000.00, 2, '2019-07-23'),
(3, 'Bob Brown', 45, 80000.00, 1, '2018-02-12'),
(4, 'Alice Blue', 25, 45000.00, 3, '2021-03-22'),
(5, 'Charlie P.', 29, 50000.00, 2, '2019-12-01'),
(6, 'David Green', 38, 70000.00, 4, '2022-05-18'),
(7, 'Eve Black', 40, 55000.00, 3, '2021-08-30');

-- Insert data into Project table
INSERT INTO Project (project_id, name, department_id) VALUES
(1, 'Project Alpha', 1),
(2, 'Project Beta', 2),
(3, 'Project Gamma', 1),
(4, 'Project Delta', 3),
(5, 'Project Epsilon', 4),
(6, 'Project Zeta', 4),
(7, 'Project Eta', 3);


-- Insert additional data into Department table (if needed)
-- No additional departments needed for this data set

-- Insert additional data into Employee table to test edge cases for joins and nested queries
INSERT INTO Employee (emp_id, name, age, salary, department_id, hire_date) VALUES
(8, 'Frank White', 32, 48000.00, NULL, '2021-07-10'),  -- Employee without a department
(9, 'Grace Kelly', 27, 65000.00, 1, '2018-11-13'),
(10, 'Hannah Lee', 30, 53000.00, 4, '2020-02-25');

-- Insert additional data into Project table to test edge cases for joins
INSERT INTO Project (project_id, name, department_id) VALUES
(8, 'Project Theta', 1),
(9, 'Project Iota', NULL);  -- Project without a department
--question 1
SELECT * FROM Employee
--question 2
SELECT
name,
salary
FROM Employee
--question 3
SELECT *
FROM Employee
WHERE age>30
--question 4
SELECT 
name
FROM Department
--question 5
SELECT *
FROM Employee
WHERE department_id=1
--Question 6
SELECT *
FROM Employee
WHERE name LIKE 'J%';
--question 7
SELECT *
FROM Employee
WHERE name LIKE '%e';
--question 8
SELECT *
FROM Employee
WHERE name LIKE '%a%';
--question 9
SELECT *
FROM Employee
WHERE name LIKE '_________';
--question 10
SELECT *
FROM Employee
WHERE name LIKE '_o%';
--question 11
SELECT *
FROM Employee
WHERE YEAR(hire_date) = 2020;
--question 12
SELECT *
FROM Employee
WHERE MONTH(hire_date) = 1;
--question 13
SELECT *
FROM Employee
WHERE hire_date < '2019-01-01';
--question 14
SELECT *
FROM Employee
WHERE hire_date >= '2021-03-01';
--question 15
SELECT *
FROM Employee
WHERE hire_date >= DATEADD(year, -2, CURRENT_DATE());
--question 16
SELECT
  SUM(salary) AS total_salary
FROM Employee;
--question 17
SELECT
  AVG(salary) AS average_salary
FROM Employee;
--question 18
SELECT
  MIN(salary) AS minimum_salary
FROM Employee;
--question 19
SELECT
  department_id,
  COUNT(*) AS employee_count
FROM Employee
GROUP BY department_id;
--question 20
SELECT
  department_id,
  AVG(salary) AS avg_salary
FROM Employee
GROUP BY department_id;
--question 21
SELECT
  department_id,
  SUM(salary) AS total_salary
FROM Employee
GROUP BY department_id;
--question 22
SELECT
  department_id,
  AVG(age) AS average_age
FROM Employee
GROUP BY department_id;
--question 23
SELECT
  YEAR(hire_date) AS hire_year,
  COUNT(*) AS employees_hired
FROM Employee
GROUP BY YEAR(hire_date);
--question 24
SELECT
  department_id,
  MAX(salary) AS highest_salary
FROM Employee
GROUP BY department_id;
--question 25
SELECT
  department_id,
  AVG(salary) AS average_salary
FROM Employee
GROUP BY department_id
ORDER BY average_salary DESC
-- question 26
SELECT
  department_id,
  COUNT(*) AS employee_count
FROM Employee
GROUP BY department_id
HAVING COUNT(*) > 2;
-- question 27
SELECT
  department_id,
  AVG(salary) AS average_salary
FROM Employee
GROUP BY department_id
HAVING AVG(salary) > 55000;
-- question 28
SELECT
  YEAR(hire_date) AS hire_year,
  COUNT(*) AS employees_hired
FROM Employee
GROUP BY YEAR(hire_date)
HAVING COUNT(*) > 1;
-- question 29
SELECT
  department_id,
  SUM(salary) AS total_salary
FROM Employee
GROUP BY department_id
HAVING SUM(salary) < 100000;
-- question 30
SELECT
  department_id,
  MAX(salary) AS max_salary
FROM Employee
GROUP BY department_id
HAVING MAX(salary) > 75000;
--question 31
SELECT *
FROM Employee
ORDER BY salary ASC
--QUESTION 32
SELECT *
FROM Employee
ORDER BY age DESC
--Question 33
SELECT *
FROM Employee
ORDER BY hire_date ASC
--Question 34
SELECT *
FROM Employee
ORDER BY department_id, salary;
--Question 35
SELECT department_id,SUM(salary) AS total_salary
FROM Employee
GROUP BY department_id
ORDER BY total_salary;
--Question 36
SELECT 
Employee.name,
Department.name
FROM Employee
JOIN Department
ON Employee.department_id=Department.department_id
--Question 37
SELECT 
Department.name,
Project.name
FROM Department
JOIN Project
ON Project.department_id=Department.department_id
--Question 38
SELECT 
Employee.name,
Project.name
FROM Project
JOIN Employee
ON Employee.department_id=Project.department_id
--Quesstion 39
SELECT 
Employee.name,
Department.name
FROM Employee
 LEFT JOIN Department
ON Employee.department_id=Department.department_id
--Question 40
SELECT 
Employee.name,
Department.name
FROM Department
LEFT JOIN Employee
ON Employee.department_id=Department.department_id
--Question 41
SELECT 
Employee.name
FROM Employee
LEFT JOIN Project
ON Employee.department_id=Project.department_id
WHERE Project.project_id IS NULL;
--Question 42
SELECT 
Employee.name,
COUNT(Project.project_id) AS total_projects
FROM Employee
JOIN Project
ON Employee.department_id=Project.department_id
GROUP BY Employee.name;
--Question 43
SELECT 
Department.name
FROM Department
LEFT JOIN Employee
ON Employee.department_id=Department.department_id
WHERE Employee.emp_id IS NULL;
--Question 44
SELECT *
FROM Employee
WHERE department_id=1
--Question 45
SELECT 
Department.name,AVG(salary) AS avg_salary
FROM Employee
JOIN Department
ON Employee.department_id=Department.department_id
GROUP BY Department.name
ORDER BY avg_salary DESC
LIMIT 1;
--Question 46
SELECT 
Employee.name,MAX(salary) AS max_salary
FROM Employee
GROUP BY Employee.name
ORDER BY max_salary DESC
LIMIT 1;
--Question 47
SELECT *
FROM Employee
WHERE salary >(
  SELECT AVG(salary)
  FROM Employee
  )
--Question 48
SELECT DISTINCT salary
FROM Employee
ORDER BY salary DESC
LIMIT 1 OFFSET 1;
--Question 49
SELECT Department.name,COUNT(Employee.emp_id) AS total_emp
FROM Employee
JOIN Department
ON Employee.department_id=Department.department_id
GROUP BY Department.name
ORDER BY total_emp DESC
LIMIT 1;
--Question 50
SELECT *
FROM Employee e1
WHERE salary>(
  SELECT AVG(salary)
  FROM Employee e2
  WHERE e1.department_id=e2.department_id
);
--Question 51
SELECT DISTINCT salary
FROM Employee 
ORDER BY salary DESC
LIMIT 1 OFFSET 2;
--Question 52
SELECT *
FROM Employee 
WHERE age>(
  SELECT MAX(age)
  FROM Employee
  WHERE department_id=2
  );
--Question 53
SELECT department_id,AVG(salary)
FROM Employee 
GROUP BY department_id
ORDER BY AVG(salary)>55000
--Question 54
SELECT Employee.name
FROM Employee 
JOIN Project
ON Employee.department_id=Project.Department_id
GROUP BY Employee.name
HAVING COUNT(Project.project_id)>=2;
--Question 55
SELECT *
FROM Employee 
WHERE hire_date='2019-07-23';
--Question 56
SELECT SUM(salary)
FROM Employee 
WHERE YEAR(hire_date)='2020';
--Question 57
SELECT department_id,AVG(salary) AS avg_salary
FROM Employee 
GROUP BY department_id
ORDER BY avg_salary DESC;
--Question 58
SELECT department_id,AVG(salary),COUNT(*) 
FROM Employee 
GROUP BY department_id
HAVING COUNT(*)>1
AND AVG(salary)>55000
--Question 59
SELECT *
FROM Employee 
WHERE hire_date>=YEAR(CURDATE())-2
ORDER BY hire_date
--Question 60
SELECT department_id,count(*) AS total_emp, AVG(salary) AS avg_salary
FROM Employee 
GROUP BY department_id
HAVING COUNT(*)>=2;
--Question 61
SELECT 
    name,
    salary
FROM Employee e
WHERE salary > (
    SELECT AVG(salary)
    FROM Employee
    WHERE department_id = e.department_id
);
--question 62
SELECT name
FROM Employee
WHERE hire_date = (
    SELECT MIN(hire_date)
    FROM Employee
);
--Question 63
SELECT Department.name,COUNT(Project.project_id) AS total_projects
FROM Department
JOIN Project
ON Department.department_id=Project.department_id
GROUP BY Department.name
ORDER BY total_project;
--question 64
SELECT name,salary,department_id
FROM Employee e1
WHERE salary=(
  SELECT MAX(salary)
  FROM Employee e2
  WHERE e1.department_id=e2.department_id
  );
--question 65
SELECT name,salary
FROM Employee
WHERE age> (
  SELECT AVG(age)
  FROM Employee
  );
