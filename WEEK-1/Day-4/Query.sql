-- Question 1
select *,
ROW_NUMBER() over(order by salary desc) as row_numbers
from employees;

-- Question 2
select *,
RANK() over(order by salary desc) as salary_rank
from employees;

-- Question 3
select employee_name, salary,
DENSE_RANK() over(order by salary desc) as dense_salary_rank
from employees;

-- Question 4
select *
from (
  select employee_name, salary,
  DENSE_RANK() over(order by salary desc) as dense_salary_rank
  from employees
) x
where dense_salary_rank <= 3;

-- Question 5
select employee_name, department,
RANK() over(partition by department order by salary) as rank_employee
from employees;

-- Question 6
select *
from (
  select employee_name, department, salary,
  RANK() over(partition by department order by salary desc) as rank_employee
  from employees
) x
where rank_employee = 1;

-- Question 7
select order_date, total_amount,
sum(total_amount) over(order by order_date) as running_total
from orders;

-- Question 8
select employee_id, total_amount,
sum(total_amount) over(partition by employee_id order by order_date) as cumulative_sales
from orders;

-- Question 9
select customer_id, order_id, total_amount,
LAG(total_amount) over(partition by customer_id order by order_date) as prev_ordered_amount
from orders;

-- Question 10
select customer_id, order_id, total_amount,
LEAD(total_amount) over(partition by customer_id order by order_date) as next_ordered_amount
from orders;

-- Question 11
select customer_id, order_id, total_amount,
total_amount - LAG(total_amount) over(partition by customer_id order by order_date) as difference
from orders;

-- Question 12
select order_id, customer_id, order_date, total_amount,
avg(total_amount) over(partition by customer_id order by order_date rows between 2 preceding and current row) as moving_avg_3
from orders;

-- Question 13
select employee_name, salary,
NTILE(4) over(order by salary) as salary_quartile
from employees;

-- Question 14
select *
from (
  select order_id, customer_id, order_date,
  ROW_NUMBER() over(partition by customer_id order by order_date) as row_num
  from orders
) x
where row_num = 1;

-- Question 15
select *
from (
  select order_id, customer_id, order_date,
  ROW_NUMBER() over(partition by customer_id order by order_date desc) as row_num
  from orders
) x
where row_num = 1;

-- Question 16
select employee_name, department, salary,
avg(salary) over(partition by department) as dep_avg_salary
from employees;

-- Question 17
select *
from (
  select employee_name, department, salary,
  avg(salary) over(partition by department) as dep_avg_salary
  from employees
) x
where salary > dep_avg_salary;

-- Question 18
select distinct department,
sum(salary) over(partition by department) as dep_payroll
from employees;

-- Question 19
select employee_name, department, salary,
round((salary * 100.0) / sum(salary) over(partition by department), 2) as salary_percentage
from employees;

-- Question 20
select employee_name,
count(employee_id) over() as total_employees
from employees;

-- Question 21
with total_sales as (
  select employee_id, sum(total_amount) as sales
  from orders
  group by employee_id
)
select *
from total_sales;

-- Question 22
with employee_sales as (
  select employee_id, sum(total_amount) as total_sales
  from orders
  group by employee_id
),
company_avg as (
  select avg(total_sales) as avg_sales
  from employee_sales
)
select es.employee_id, es.total_sales
from employee_sales es, company_avg ca
where es.total_sales > ca.avg_sales;

-- Question 23
with customer_orders as (
  select customer_id, sum(total_amount) as total_spending
  from orders
  group by customer_id
),
ranking as (
  select customer_id, total_spending,
  rank() over(order by total_spending desc) as rankers
  from customer_orders
)
select *
from ranking;

-- Question 24
with recursive number as (
  select 1 as num
  union all
  select num + 1
  from number
  where num < 10
)
select *
from number;
