-- Question 1
select *
from Employees
where salary is null;

-- Question 2
select *
from Orders
where discount is not null;

-- Question 3
select *
from Products
where category is null;

-- Question 4
select count(emp_id) as no_of_emp
from Employees
where manager_id is null;

-- Question 5
select IFNULL(salary, 0) as salary
from Employees;

-- Question 6
select IFNULL(bonus, 1000) as bonus
from Employees;

-- Question 7
select amount, IFNULL(amount, 500) as adjusted_amount
from Orders;

-- Question 8
select IFNULL(stock, 0) as stock
from Products;

-- Question 9
select name, COALESCE(salary, bonus) as earnings
from Employees;

-- Question 10
select name, COALESCE(salary, bonus, 0) as earnings
from Employees;

-- Question 11
select product_name, COALESCE(price, 1000) as product_price
from Products;

-- Question 12
select customer_name, COALESCE(amount, discount, 0) as customer_payment
from Orders;

-- Question 13
select name, NULLIF(salary, 0) as salary
from Employees;

-- Question 14
select customer_name, NULLIF(discount, 0) as discount
from Orders;

-- Question 15
select amount / NULLIF(discount, 0) as ratio
from Orders;

-- Question 16
select NULLIF(coupon_code, 'DISC10') as coupon_code
from Orders;

-- Question 17
select sum(COALESCE(salary, 0) + COALESCE(bonus, 0)) as total_earnings
from Employees;

-- Question 18
select name
from Employees
where salary is null and bonus is null;

-- Question 19
select product_name
from Products
where price is null and category is not null;

-- Question 20
select order_id
from Orders
where amount is null and discount is null;

-- Question 21
select name, COALESCE(salary, bonus, 1000) as income
from Employees;

-- Question 22
select NULLIF(discount, 0) as discount
from Orders;

-- Question 23
select order_id, amount - IFNULL(discount, 0) as payable_amount
from Orders;

-- Question 24
select name
from Employees
where salary is null and manager_id is not null;
