-- Question 1
select * from Employees;

-- Question 2
select emp_name, salary from Employees;

-- Question 3
select emp_name, department from Employees;

-- Question 4
select * from Employees
where department = 'IT';

-- Question 5
select emp_name, experience from Employees;

-- Question 6
select emp_name from Employees
where salary > 70000;

-- Question 7
select * from Employees
where city = 'Hyderabad';

-- Question 8
select * from Employees
where experience < 4;

-- Question 9
select * from Employees
where department = 'Finance';

-- Question 10
select * from Employees
where salary = 52000;

-- Question 11
select department, sum(salary) as total_salary
from Employees
group by department;

-- Question 12
select department, avg(salary) as average_salary
from Employees
group by department;

-- Question 13
select city, count(emp_id) as employees_in_city
from Employees
group by city;

-- Question 14
select department, max(salary) as maximum_salary
from Employees
group by department;

-- Question 15
select department, min(experience) as minimum_experience
from Employees
group by department;

-- Question 16
select department, count(emp_id) as employee_count
from Employees
group by department
having count(emp_id) > 3;

-- Question 17
select department, avg(salary) as average_salary
from Employees
group by department
having avg(salary) > 60000;

-- Question 18
select city, count(emp_id) as employee_count
from Employees
group by city
having count(emp_id) > 2;

-- Question 19
select department, sum(salary) as total_salary
from Employees
group by department
having sum(salary) > 200000;

-- Question 20
select department, max(salary) as maximum_salary
from Employees
group by department
having max(salary) > 90000;

-- Question 21
select *
from Employees
order by salary desc
limit 5;

-- Question 22
select *
from Employees
order by experience desc
limit 3;

-- Question 23
select *
from Employees
where department = 'Finance'
order by salary desc
limit 2;

-- Question 24
select *
from Employees
where city = 'Hyderabad'
limit 4;

-- Question 25
select *
from Employees
order by salary desc
limit 1;

-- Question 26
select distinct department from Employees;

-- Question 27
select distinct city from Employees;

-- Question 28
select distinct salary from Employees;

-- Question 29
select distinct department, city from Employees;

-- Question 30
select distinct experience from Employees;

-- Question 31
select * from Employees
where salary >= 80000;

-- Question 32
select * from Employees
where experience <= 3;

-- Question 33
select * from Employees
where salary <> 45000;

-- Question 34
select * from Employees
where salary < 50000;

-- Question 35
select * from Employees
where experience > 5;

-- Question 36
select * from Employees
where department = 'IT' and salary > 70000;

-- Question 37
select * from Employees
where city = 'Hyderabad' or city = 'Bangalore';

-- Question 38
select * from Employees
where department = 'HR' and experience < 3;

-- Question 39
select * from Employees
where salary > 60000 or experience > 6;

-- Question 40
select * from Employees
where department <> 'Sales';

-- Question 41
select * from Employees
where city in ('Hyderabad', 'Mumbai');

-- Question 42
select * from Employees
where department in ('IT', 'Finance');

-- Question 43
select * from Employees
where city not in ('Chennai', 'Pune');

-- Question 44
select * from Employees
where salary in (45000, 75000, 91000);

-- Question 45
select * from Employees
where department not in ('HR', 'Sales');

-- Question 46
select * from Employees
where salary between 50000 and 80000;

-- Question 47
select * from Employees
where experience between 3 and 6;

-- Question 48
select * from Employees
where emp_id between 105 and 112;

-- Question 49
select * from Employees
where salary not between 40000 and 60000;

-- Question 50
select * from Employees
where experience between 2 and 4;

-- Question 51
select * from Employees
where emp_name like 'R%';

-- Question 52
select * from Employees
where emp_name like '%a';

-- Question 53
select * from Employees
where emp_name like '%v%';

-- Question 54
select * from Employees
where city like 'B%';

-- Question 55
select * from Employees
where department like '%s';
