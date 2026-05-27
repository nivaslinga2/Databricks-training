QUESTION Schema-1: Employee Compensation Classification

	Table Structure

	CREATE TABLE employee_payments (

	emp_id INT PRIMARY KEY,

	emp_name VARCHAR(50),

	department VARCHAR(30),

	base_salary DECIMAL(10,2),

	bonus DECIMAL(10,2),

	joining_date DATE

       );


	INSERT INTO employee_payments VALUES

	(1,'karthik','Data',75000.75,5000.50,'2019-03-15'),

	(2,'veena','HR',65000.40,4000.25,'2021-06-20'),

	(3,'ravi','Data',85000.90,6000.75,'2016-01-10'),

	(4,'anil','Finance',70000.10,NULL,'2020-09-01'),

	(5,'suresh','HR',60000.55,3000.30,'2022-11-25');

Query-1

For each employee:

· Convert emp_name to proper case ---upper /lower ---Initcap (CamelCase)

· Calculate total income = base_salary + bonus (NULL safe) +

· Round total income to nearest integer

· Extract joining year

· Use CASE to classify:

     Senior if experience > 7 years

     Mid if between 4 and 7

     Junior otherwise


Answer:

select 
    
    upper(emp_name) as upper_name,
    
    lower(emp_name) as lower_name,
    
    initcap(emp_name) as proper_case_name,
    
    department,
    
    round(base_salary + coalesce(bonus,0)) as total_income,
    
    extract(year from joining_date) as joining_year,
    
    case
        when extract(year from current_date) - extract(year from joining_date) > 7
            then 'Senior'
            
        when extract(year from current_date) - extract(year from joining_date) 
             between 4 and 7
            then 'Mid'
            
        else 'Junior'
    end as employee_level

from employee_payments

-----------------------------------------------------------------------------------------------------------------------------------------------


QUESTION Schema-2: Order Delivery Delay Analysis

	Table Structure

	CREATE TABLE orders_delivery (

	order_id INT,

	customer_name VARCHAR(50),

	order_date DATE,

	delivery_date DATE,

	order_amount DECIMAL(10,2)

	);

	INSERT INTO orders_delivery VALUES
	
	(101,'rajesh','2025-01-01','2025-01-05',12500.75),

	(102,'meena','2025-01-10','2025-01-10',8400.40),

	(103,'arun','2025-01-15','2025-01-20',15600.90),

	(104,'pooja','2025-01-18',NULL,9200.10);

Query-2:

	For each order:

	· Uppercase customer name

	· Calculate delivery days using date difference

	· Replace NULL delivery date with today

	· Truncate order amount to 1 decimal

	· Use CASE:

	     o Same-day

	     o Delayed (>3 days)

	     o Pending

Answer:

select

    upper(customer_name) as customer_name,

    order_date,

    coalesce(delivery_date,current_date) as final_delivery_date,

    coalesce(delivery_date,current_date) - order_date as delivery_days,

    trunc(order_amount,1) as truncated_amount,

    case

        when delivery_date is null
            then 'Pending'

        when delivery_date - order_date = 0
            then 'Same-day'

        when delivery_date - order_date > 3
            then 'Delayed'

        else 'On-time'

    end as delivery_status

from orders_delivery

-----------------------------------------------------------------------------------------------------------------------------------------------

QUESTION Schema-3: Customer Spending Pattern

	Table Structure

	CREATE TABLE customer_spending (

	cust_id INT,

	cust_name VARCHAR(50),

	city VARCHAR(30),

	purchase_amount DECIMAL(10,2),

	purchase_date DATE

	);


	INSERT INTO customer_spending VALUES

	(1,'amit','mumbai',12000.75,'2024-12-01'),

	(2,'neha','delhi',8500.40,'2024-12-15'),

	(3,'rohit','mumbai',15500.90,'2024-11-20'),

	(4,'kavya','chennai',6000.10,'2024-10-05');

Query:

	Display:

	· Customer name with first letter capitalized

	· Month name of purchase

	· Rounded purchase amount

	· Absolute value of purchase (defensive logic)

	· CASE:

	     o High spender > 15000

	     o Medium 8000–15000

	     o Low otherwise

Answer:

select

    initcap(cust_name) as customer_name,

    to_char(purchase_date,'Month') as purchase_month,

    round(purchase_amount) as rounded_amount,

    abs(purchase_amount) as absolute_amount,

    case

        when purchase_amount > 15000
            then 'High spender'

        when purchase_amount between 8000 and 15000
            then 'Medium spender'

        else 'Low spender'

    end as spending_category

from customer_spending

-----------------------------------------------------------------------------------------------------------------------------------------------


QUESTION Schema-4: Subscription Validity Check


	CREATE TABLE subscriptions (

	user_id INT,

	user_email VARCHAR(100),

	start_date DATE,

	end_date DATE,

	subscription_fee DECIMAL(10,2)

	);

	INSERT INTO subscriptions VALUES

	(1,'karthik@gmail.com','2024-01-01','2025-01-01',12000.50),

	(2,'veena@yahoo.com','2024-06-15','2024-12-15',8500.75),

	(3,'ravi@hotmail.com','2023-03-01','2024-03-01',15000.90);

Query:

	For each user:

	· Extract email domain

	· Calculate subscription duration in months

	· Format fee with commas

	· Find remaining days from today

	· CASE:

	     o Active

	     o Expiring Soon (≤30 days)

 	     o Expired

Answer:

select

    user_email,

    split_part(user_email,'@',2) as email_domain,

    extract(year from age(end_date,start_date)) * 12 +
    extract(month from age(end_date,start_date)) as subscription_months,

    to_char(subscription_fee,'99,99,999.99') as formatted_fee,

    end_date - current_date as remaining_days,

    case

        when end_date < current_date
            then 'Expired'

        when end_date - current_date <= 30
            then 'Expiring Soon'

        else 'Active'

    end as subscription_status

from subscriptions

-----------------------------------------------------------------------------------------------------------------------------------------------

QUESTION Schema-5: Loan EMI Risk Categorization


	CREATE TABLE loan_details (

	loan_id INT,

	customer_name VARCHAR(50),

	loan_amount DECIMAL(12,2),

	interest_rate DECIMAL(5,2),

	loan_start DATE

	);


	INSERT INTO loan_details VALUES

	(201,'suresh',500000.75,8.5,'2022-01-10'),

	(202,'mahesh',750000.40,9.2,'2021-05-20'),

	(203,'anita',300000.90,7.8,'2023-07-01');

Query:

	Compute:

	· Monthly interest using power function

	· Years since loan start

	· Round EMI

	· Uppercase customer name

	· CASE:

	     o High Risk if interest > 9

       	     o Medium Risk

	     o Low Risk

Answer:

select

    upper(customer_name) as customer_name,

    loan_amount,

    interest_rate,

    round(
        (
            loan_amount *
            (interest_rate / 12 / 100) *
            power(
                1 + (interest_rate / 12 / 100),
                12 * 5
            )
        ) /
        (
            power(
                1 + (interest_rate / 12 / 100),
                12 * 5
            ) - 1
        )
    ) as emi,

    round(loan_amount * power((1 + interest_rate / 100),1/12.0),2)
    as monthly_interest,

    extract(year from age(current_date,loan_start))
    as years_since_loan,

    case

        when interest_rate > 9
            then 'High Risk'

        when interest_rate between 8 and 9
            then 'Medium Risk'

        else 'Low Risk'

    end as risk_category

from loan_details

-----------------------------------------------------------------------------------------------------------------------------------------------

QUESTION Schema-6: Employee Attendance Evaluation


	CREATE TABLE attendance (

	emp_id INT,

	emp_name VARCHAR(50),

	total_days INT,

	present_days INT,

	record_date DATE

	);


	INSERT INTO attendance VALUES

	(1,'karthik',30,28,'2025-01-31'),

	(2,'veena',30,22,'2025-01-31'),

	(3,'ravi',30,18,'2025-01-31');

Query:

	Calculate:

	· Attendance percentage (rounded)

	· Month name

	· Difference between total and present days

	· Lowercase employee name

	· CASE:

	     o Excellent ≥90%

	     o Average 75–89%

	     o Poor otherwise

Answer:

select

    lower(emp_name) as employee_name,

    round((present_days * 100.0) / total_days,2)
    as attendance_percentage,

    to_char(record_date,'Month') as month_name,

    total_days - present_days as absent_days,

    case

        when (present_days * 100.0) / total_days >= 90
            then 'Excellent'

        when (present_days * 100.0) / total_days between 75 and 89
            then 'Average'

        else 'Poor'

    end as attendance_status

from attendance

-----------------------------------------------------------------------------------------------------------------------------------------------

QUESTION Schema-7: Product Discount Validation

	CREATE TABLE product_sales (

	product_id INT,

	product_name VARCHAR(50),

	mrp DECIMAL(10,2),

	selling_price DECIMAL(10,2),

	sale_date DATE

	);


	INSERT INTO product_sales VALUES

	(1,'Laptop',75000.75,68000.50,'2025-01-10'),

	(2,'Mobile',35000.40,33000.25,'2025-01-12'),

	(3,'Tablet',25000.90,26000.75,'2025-01-15');

Query:

	Derive:

	· Discount amount (absolute)

	· Discount percentage

	· Day name of sale

	· Proper case product name

	· CASE:

	     o Valid Discount

	     o Overpriced

	     o No Discount

Answer:

select

    initcap(product_name) as product_name,

    abs(mrp - selling_price) as discount_amount,

    round(((mrp - selling_price) / mrp) * 100,2)
    as discount_percentage,

    to_char(sale_date,'Day') as sale_day,

    case

        when selling_price < mrp
            then 'Valid Discount'

        when selling_price > mrp
            then 'Overpriced'

        else 'No Discount'

    end as discount_status

from product_sales

-----------------------------------------------------------------------------------------------------------------------------------------------

QUESTION Schema-8: Insurance Policy Aging

	CREATE TABLE insurance_policies (

	policy_id INT,

	holder_name VARCHAR(50),

	premium_amount DECIMAL(10,2),

	policy_start DATE,

	policy_end DATE

	);


	INSERT INTO insurance_policies VALUES

	(301,'arjun',12000.50,'2023-01-01','2026-01-01'),

	(302,'megha',8500.75,'2022-06-15','2025-06-15'),

	(303,'vinod',15000.90,'2021-03-01','2024-03-01');

Query:

	Show:

	· Policy duration in years

	· Remaining days

	· Rounded premium

	· Uppercase holder name

	· CASE:

	     o Long Term

	     o Mid Term

	     o Expired

Answer:

select

    upper(holder_name) as holder_name,

    round(premium_amount) as rounded_premium,

    extract(year from age(policy_end,policy_start))
    as policy_duration_years,

    policy_end - current_date as remaining_days,

    case

        when policy_end < current_date
            then 'Expired'

        when extract(year from age(policy_end,policy_start)) >= 3
            then 'Long Term'

        else 'Mid Term'

    end as policy_status

from insurance_policies

-----------------------------------------------------------------------------------------------------------------------------------------------

QUESTION Schema-9: Salary Increment Simulation

	CREATE TABLE salary_revision (

	emp_id INT,

	emp_name VARCHAR(50),

	current_salary DECIMAL(10,2),

	rating INT,

	last_hike DATE

	);


	INSERT INTO salary_revision VALUES

	(1,'karthik',75000.75,5,'2023-01-01'),

	(2,'veena',65000.40,4,'2024-01-01'),

	(3,'ravi',85000.90,3,'2022-01-01');

Query:

	Calculate:

	· Years since last hike

	· Increment using rating logic

	· New salary (rounded)

	· Lowercase name

	· CASE:

	     o High Increment

	     o Moderate

	     o No Increment

Answer:

select

    lower(emp_name) as employee_name,

    current_salary,

    extract(year from age(current_date,last_hike))
    as years_since_last_hike,

    case

        when rating = 5
            then current_salary * 0.20

        when rating = 4
            then current_salary * 0.10

        else 0

    end as increment_amount,

    round(
        current_salary +
        case

            when rating = 5
                then current_salary * 0.20

            when rating = 4
                then current_salary * 0.10

            else 0

        end
    ) as new_salary,

    case

        when rating = 5
            then 'High Increment'

        when rating = 4
            then 'Moderate'

        else 'No Increment'

    end as increment_status

from salary_revision

-----------------------------------------------------------------------------------------------------------------------------------------------

QUESTION Schema-10: Customer Account Status Evaluation

	CREATE TABLE bank_accounts (

	account_id INT,

	customer_name VARCHAR(50),

	balance DECIMAL(12,2),

	last_transaction DATE,

	branch VARCHAR(30)

	);


	INSERT INTO bank_accounts VALUES

	(501,'ramesh',125000.75,'2024-12-20','hyderabad'),

	(502,'sita',8500.40,'2023-06-15','delhi'),

	(503,'manoj',-2500.90,'2025-01-05','mumbai');

Query:

	Determine:

	· Absolute balance

	· Days since last transaction

	· Proper case branch name

	· Sign of balance

	· CASE:

	     o Active

	     o Dormant

	     o Overdrawn

Answer:

select

    customer_name,

    abs(balance) as absolute_balance,

    current_date - last_transaction
    as days_since_last_transaction,

    initcap(branch) as branch_name,

    sign(balance) as balance_sign,

    case

        when balance < 0
            then 'Overdrawn'

        when current_date - last_transaction > 365
            then 'Dormant'

        else 'Active'

    end as account_status

from bank_accounts

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------					
					  													LEVEL-1
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

QUESTION Schema-1 – Salary Risk Flagging Based on Tax Shock

	CREATE TABLE salary_audit (

	emp_id INT,

	emp_name VARCHAR(50),

	salary DECIMAL(10,2),

	tax_percent DECIMAL(5,2),

	last_revision DATE

	);


	INSERT INTO salary_audit VALUES

	(1,'karthik',75000.75,10.5,'2022-01-15'),

	(2,'veena',65000.40,18.0,'2023-06-01'),

	(3,'ravi',85000.90,25.0,'2020-11-20');

Query:

	For each employee:

	· Normalize name to lowercase

	· Calculate net salary after tax and round it

	· Extract revision year

	· Find months since revision

	· Use CASE:

	     o Flag Tax Shock if tax > 20 AND months > 24

 	     o Flag Review Needed if tax between 15–20

	     o Else Stable

Answer:

select

    lower(emp_name) as employee_name,

    round(
        salary - (salary * tax_percent / 100)
    ) as net_salary,

    extract(year from last_revision)
    as revision_year,

    (
        extract(year from age(current_date,last_revision)) * 12
        +
        extract(month from age(current_date,last_revision))
    ) as months_since_revision,

    case

        when tax_percent > 20
             and
             (
                extract(year from age(current_date,last_revision)) * 12
                +
                extract(month from age(current_date,last_revision))
             ) > 24
            then 'Flag Tax Shock'

        when tax_percent between 15 and 20
            then 'Flag Review Needed'

        else 'Stable'

    end as audit_status

from salary_audit

-----------------------------------------------------------------------------------------------------------------------------------------------

QUESTION Schema-2 – Bonus Abuse Detection

	CREATE TABLE bonus_monitor (

	emp_code INT,

	emp_name VARCHAR(50),

	base_salary DECIMAL(10,2),

	bonus DECIMAL(10,2),

	bonus_date DATE

	);

	INSERT INTO bonus_monitor VALUES

	(101,'Anil',70000.10,30000.00,'2025-01-10'),

	(102,'Suresh',60000.55,3000.30,'2024-03-15'),

	(103,'Ravi',85000.90,15000.75,'2023-12-01');

Query:

	For each record:

	· Convert name to proper case

	· Calculate bonus percentage of salary (rounded)

	· Extract day name of bonus

	· Find absolute salary–bonus difference

	· CASE:

      	     o Suspicious if bonus > 30% AND weekend

	     o Normal if bonus <= 20%

	     o Audit

Answer:

select

    initcap(emp_name) as employee_name,

    round((bonus * 100.0) / base_salary,2)
    as bonus_percentage,

    to_char(bonus_date,'Day') as bonus_day,

    abs(base_salary - bonus)
    as salary_bonus_difference,

    case

        when ((bonus * 100.0) / base_salary) > 30
             and
             extract(dow from bonus_date) in (0,6)
            then 'Suspicious'

        when ((bonus * 100.0) / base_salary) <= 20
            then 'Normal'

        else 'Audit'

    end as bonus_status

from bonus_monitor

-----------------------------------------------------------------------------------------------------------------------------------------------

QUESTION Schema-3 – Experience Parity Validation


	CREATE TABLE employee_experience (

	emp_id INT,

	emp_name VARCHAR(50),

	joining_date DATE,

	declared_experience INT,

	salary DECIMAL(10,2)

	);

	INSERT INTO employee_experience VALUES

	(1,'Veena','2018-07-01',4,65000.40),

	(2,'Ravi','2014-01-10',12,85000.90),

	(3,'Anil','2020-09-01',3,70000.10);

Query:

	For each employee:

	· Uppercase name

	· Calculate actual experience from date

	· Find difference between declared and actual experience

	· Floor salary

	· CASE:

	     o Overstated if declared > actual

	     o Understated if declared < actual

	     o Matched

Answer:

select

    upper(emp_name) as employee_name,

    extract(year from age(current_date,joining_date))
    as actual_experience,

    abs(
        declared_experience -
        extract(year from age(current_date,joining_date))
    ) as experience_difference,

    floor(salary) as floor_salary,

    case

        when declared_experience >
             extract(year from age(current_date,joining_date))
            then 'Overstated'

        when declared_experience <
             extract(year from age(current_date,joining_date))
            then 'Understated'

        else 'Matched'

    end as experience_status

from employee_experience

-----------------------------------------------------------------------------------------------------------------------------------------------

QUESTION Schema-4 – Salary Digit Pattern Analysis

	CREATE TABLE salary_digits (

	emp_id INT,

	emp_name VARCHAR(50),

	salary DECIMAL(10,2),

	credit_date DATE

	);


	INSERT INTO salary_digits VALUES

	(1,'Karthik',75000.75,'2025-01-01'),

	(2,'Veena',65000.40,'2025-01-02'),

	(3,'Suresh',60000.55,'2025-01-03');

Query:

	For each employee:

	· Extract last two characters of name

	· Get day of month from credit date

	· Truncate salary to integer

	· Use MOD on salary

	· CASE:

	     o Pattern Match if salary MOD 10 equals day

	     o No Match otherwise

Answer:

select

    right(emp_name,2) as last_two_characters,

    extract(day from credit_date)
    as day_of_month,

    trunc(salary)
    as truncated_salary,

    mod(trunc(salary),10)
    as salary_mod_value,

    case

        when mod(trunc(salary),10) =
             extract(day from credit_date)
            then 'Pattern Match'

        else 'No Match'

    end as pattern_status

from salary_digits

-----------------------------------------------------------------------------------------------------------------------------------------------

QUESTION Schema-5: Odd–Even Salary Compliance

	CREATE TABLE payroll_control (

	emp_id INT,

	emp_name VARCHAR(50),

	salary DECIMAL(10,2),

	payment_date DATE

	);


	INSERT INTO payroll_control VALUES

	(1,'Ravi',85000.90,'2025-01-15'),

	(2,'Anil',70000.10,'2025-01-16'),

	(3,'Veena',65000.40,'2025-01-17');

Query:

	For each employee:

	· Lowercase name

	· Extract weekday

	· Round salary

	· Apply MOD on salary

	· CASE:

	     o Violation if even salary paid on odd weekday

	     o Compliant otherwise

Answer:

select

    lower(emp_name) as employee_name,

    to_char(payment_date,'Day')
    as weekday_name,

    round(salary) as rounded_salary,

    mod(round(salary),2)
    as salary_mod_value,

    case

        when mod(round(salary),2) = 0
             and
             mod(extract(day from payment_date),2) = 1
            then 'Violation'

        else 'Compliant'

    end as compliance_status

from payroll_control

-----------------------------------------------------------------------------------------------------------------------------------------------

QUESTION Schema-6: Salary Inflation Drift

	CREATE TABLE inflation_watch (

	emp_id INT,

	emp_name VARCHAR(50),

	salary DECIMAL(10,2),

	last_hike DATE

	);


	INSERT INTO inflation_watch VALUES

	(1,'Karthik',75000.75,'2019-01-01'),

	(2,'Veena',65000.40,'2022-01-01'),

	(3,'Ravi',85000.90,'2017-01-01');

Query:

	For each employee:

	· Proper case name

	· Calculate years since hike

	· Apply POWER on years

	· Round salary impact

	· CASE:

	     o High Inflation Risk if years > 5

	     o Moderate

 	     o Low

Answer:

select

    initcap(emp_name) as employee_name,

    extract(year from age(current_date,last_hike))
    as years_since_hike,

    power(
        extract(year from age(current_date,last_hike)),
        2
    ) as power_value,

    round(
        salary *
        power(
            1.05,
            extract(year from age(current_date,last_hike))
        )
    ) as salary_impact,

    case

        when extract(year from age(current_date,last_hike)) > 5
            then 'High Inflation Risk'

        when extract(year from age(current_date,last_hike))
             between 3 and 5
            then 'Moderate'

        else 'Low'

    end as inflation_status

from inflation_watch

-----------------------------------------------------------------------------------------------------------------------------------------------

QUESTION Schema-7:  Salary Sign Integrity Check


	CREATE TABLE salary_integrity (

	emp_id INT,

	emp_name VARCHAR(50),

	salary DECIMAL(10,2),

	record_date DATE

	);


	INSERT INTO salary_integrity VALUES

	(1,'Anil',-70000.10,'2025-01-10'),

	(2,'Veena',65000.40,'2025-01-10'),

	(3,'Ravi',0.00,'2025-01-10');

Query:

	For each employee:

	· Uppercase name

	· Extract year

	· Apply SIGN on salary

	· ABS salary

	· CASE:

	     o Negative Error

	     o Zero Salary

	     o Valid

Answer:

select

    upper(emp_name) as employee_name,

    extract(year from record_date)
    as record_year,

    sign(salary) as salary_sign,

    abs(salary) as absolute_salary,

    case

        when sign(salary) = -1
            then 'Negative Error'

        when sign(salary) = 0
            then 'Zero Salary'

        else 'Valid'

    end as salary_status

from salary_integrity

-----------------------------------------------------------------------------------------------------------------------------------------------

QUESTION Schema-8:  Name Length vs Salary Correlation


	CREATE TABLE name_salary (

	emp_id INT,

	emp_name VARCHAR(50),

	salary DECIMAL(10,2),

	join_date DATE

	);


	INSERT INTO name_salary VALUES

	(1,'Karthik',75000.75,'2019-03-15'),

	(2,'Veena',65000.40,'2021-06-20'),

	(3,'Ravi',85000.90,'2016-01-10');

Query:

	For each employee:

	· Calculate name length

	· Calculate years of service

	· Round salary

	· Compare name length vs years

	· CASE:

	     o Name Bias if length > years

	     o Neutral

Answer:

select

    emp_name,

    length(emp_name) as name_length,

    extract(year from age(current_date,join_date))
    as years_of_service,

    round(salary) as rounded_salary,

    case

        when length(emp_name) >
             extract(year from age(current_date,join_date))
            then 'Name Bias'

        else 'Neutral'

    end as comparison_status

from name_salary

-----------------------------------------------------------------------------------------------------------------------------------------------


QUESTION Schema-9:  Salary Spike Detection by Month


	CREATE TABLE salary_monthly (

	emp_id INT,

	emp_name VARCHAR(50),

	salary DECIMAL(10,2),

	paid_date DATE

	);


	INSERT INTO salary_monthly VALUES

	(1,'Karthik',75000.75,'2025-01-31'),

	(2,'Veena',65000.40,'2025-02-28'),

	(3,'Ravi',85000.90,'2025-03-31');

Query:

	For each record:

	· Extract month name

	· CEIL salary

	· Check last day of month

	· CASE:

	     o End Month Spike

	     o Regular

Answer:

select

    emp_name,

    to_char(paid_date,'Month')
    as month_name,

    ceil(salary) as ceil_salary,

    last_day(paid_date) as month_last_day,

    case

        when paid_date = last_day(paid_date)
            then 'End Month Spike'

        else 'Regular'

    end as spike_status

from salary_monthly

-----------------------------------------------------------------------------------------------------------------------------------------------

QUESTION Schema-10:  Salary Digit Sum Audit


	CREATE TABLE digit_audit (

	emp_id INT,

	emp_name VARCHAR(50),

	salary DECIMAL(10,2),

	audit_date DATE

	);


	INSERT INTO digit_audit VALUES

	(1,'Anil',70000.10,'2025-01-01'),

	(2,'Veena',65000.40,'2025-01-02');

Query:

	For each employee:

	· Extract first character of name

	· Truncate salary

	· Sum digits logically

	· Extract day

	· CASE:

	     o Digit Alert

	     o Normal

Answer:

select

    left(emp_name,1) as first_character,

    trunc(salary) as truncated_salary,

    (
        select sum(cast(digit as int))
        from regexp_split_to_table(
            trunc(salary)::text,
            ''
        ) as digit
        where digit ~ '[0-9]'
    ) as digit_sum,

    extract(day from audit_date)
    as audit_day,

    case

        when (
            select sum(cast(digit as int))
            from regexp_split_to_table(
                trunc(salary)::text,
                ''
            ) as digit
            where digit ~ '[0-9]'
        ) > extract(day from audit_date)
            then 'Digit Alert'

        else 'Normal'

    end as audit_status

from digit_audit

-----------------------------------------------------------------------------------------------------------------------------------------------

QUESTION Schema-11: Weekend Salary Credit Fraud Detection


	CREATE TABLE salary_credit_audit (

	emp_id INT,

	emp_name VARCHAR(50),

	salary DECIMAL(10,2),

	credit_date DATE,

	bank_code VARCHAR(10)

	);


	INSERT INTO salary_credit_audit VALUES

	(1,'Karthik',75000.75,'2025-01-04','HDFC01'),

	(2,'Veena',65000.40,'2025-01-06','ICIC02'),

	(3,'Ravi',85000.90,'2025-01-05','SBIN03'),

	(4,'Anil',70000.10,'2025-01-07','AXIS04'),

	(5,'Suresh',60000.55,'2025-01-11','HDFC01');

Query:

	For each record:

	· Extract bank prefix from bank_code

	· Identify weekday name of credit_date

	· Round salary

	· Apply MOD on salary

	· CASE:

	     o Weekend Fraud if credited on Saturday/Sunday AND salary MOD 5 = 0

	     o Bank Review if bank is HDFC

	     o Else Normal

Answer:

select

    left(bank_code,4) as bank_prefix,

    to_char(credit_date,'Day')
    as weekday_name,

    round(salary) as rounded_salary,

    mod(round(salary),5)
    as salary_mod_value,

    case

        when extract(dow from credit_date) in (0,6)
             and
             mod(round(salary),5) = 0
            then 'Weekend Fraud'

        when left(bank_code,4) = 'HDFC'
            then 'Bank Review'

        else 'Normal'

    end as fraud_status

from salary_credit_audit

-----------------------------------------------------------------------------------------------------------------------------------------------

QUESTION Schema-12:  Salary Credit Time Drift Analysis


	CREATE TABLE salary_time_drift (

	emp_id INT,

	emp_name VARCHAR(50),

	salary DECIMAL(10,2),

	credit_ts DATETIME

	);


	INSERT INTO salary_time_drift VALUES

	(1,'Karthik',75000.75,'2025-01-10 23:45:00'),

	(2,'Veena',65000.40,'2025-01-10 09:15:00'),

	(3,'Ravi',85000.90,'2025-01-11 00:10:00'),

	(4,'Anil',70000.10,'2025-01-09 18:30:00'),

	(5,'Suresh',60000.55,'2025-01-10 02:50:00');

Query:

	For each employee:

	· Extract hour from credit timestamp

	· Convert emp_name to lowercase

	· Floor salary

	· Calculate difference between salary and hour

	· CASE:

	     o Midnight Drift if hour between 0–3

	     o After Hours

	     o Business Hours

Answer:

select

    lower(emp_name) as employee_name,

    extract(hour from credit_ts)
    as credit_hour,

    floor(salary) as floor_salary,

    abs(
        floor(salary) -
        extract(hour from credit_ts)
    ) as salary_hour_difference,

    case

        when extract(hour from credit_ts)
             between 0 and 3
            then 'Midnight Drift'

        when extract(hour from credit_ts) < 9
             or
             extract(hour from credit_ts) > 18
            then 'After Hours'

        else 'Business Hours'

    end as drift_status

from salary_time_drift

-----------------------------------------------------------------------------------------------------------------------------------------------

QUESTION Schema-13:  Salary Decimal Precision Audit


	CREATE TABLE salary_precision (

	emp_id INT,

	emp_name VARCHAR(50),

	salary DECIMAL(10,4),

	record_date DATE

	);


	INSERT INTO salary_precision VALUES

	(1,'Karthik',75000.7567,'2025-01-01'),

	(2,'Veena',65000.4044,'2025-01-02'),

	(3,'Ravi',85000.9099,'2025-01-03'),

	(4,'Anil',70000.1001,'2025-01-04'),

	(5,'Suresh',60000.5555,'2025-01-05');

Query:

	For each record:

	· Truncate salary to 2 decimals

	· Calculate difference between rounded and truncated value

	· Extract day name

	· Get length of emp_name

	· CASE:

	     o Precision Loss if difference > 0.01

	     o Safe

Answer:

select

    emp_name,

    trunc(salary,2) as truncated_salary,

    abs(
        round(salary,2) -
        trunc(salary,2)
    ) as precision_difference,

    to_char(record_date,'Day')
    as day_name,

    length(emp_name) as name_length,

    case

        when abs(
                round(salary,2) -
                trunc(salary,2)
             ) > 0.01
            then 'Precision Loss'

        else 'Safe'

    end as precision_status

from salary_precision

-----------------------------------------------------------------------------------------------------------------------------------------------

QUESTION Schema-14:  Salary Growth Power Index


	CREATE TABLE salary_growth (

	emp_id INT,

	emp_name VARCHAR(50),

	base_salary DECIMAL(10,2),

	growth_rate DECIMAL(5,2),

	last_hike DATE

	);


	INSERT INTO salary_growth VALUES

	(1,'Karthik',75000.75,1.08,'2019-01-01'),

	(2,'Veena',65000.40,1.05,'2021-01-01'),

	(3,'Ravi',85000.90,1.12,'2017-01-01'),

	(4,'Anil',70000.10,1.03,'2022-01-01'),

	(5,'Suresh',60000.55,1.06,'2020-01-01');

Query:

	For each employee:

	· Calculate years since last hike

	· Apply POWER using growth_rate and years

	· Round projected salary
	
	· Uppercase emp_name

	· CASE:

	     o Explosive Growth if projected > 150000

	     o Controlled

	     o Stagnant

Answer:

select

    upper(emp_name) as employee_name,

    extract(year from age(current_date,last_hike))
    as years_since_hike,

    power(
        growth_rate,
        extract(year from age(current_date,last_hike))
    ) as growth_power,

    round(
        base_salary *
        power(
            growth_rate,
            extract(year from age(current_date,last_hike))
        )
    ) as projected_salary,

    case

        when round(
                base_salary *
                power(
                    growth_rate,
                    extract(year from age(current_date,last_hike))
                )
             ) > 150000
            then 'Explosive Growth'

        when round(
                base_salary *
                power(
                    growth_rate,
                    extract(year from age(current_date,last_hike))
                )
             ) between 90000 and 150000
            then 'Controlled'

        else 'Stagnant'

    end as growth_status

from salary_growth

-----------------------------------------------------------------------------------------------------------------------------------------------

QUESTION Schema-15:  Salary Symmetry Check


	CREATE TABLE salary_symmetry (

	emp_id INT,

	emp_name VARCHAR(50),

	salary DECIMAL(10,2),

	processed_date DATE

	);


	INSERT INTO salary_symmetry VALUES

	(1,'Karthik',75557.75,'2025-01-15'),

	(2,'Veena',64446.40,'2025-01-16'),

	(3,'Ravi',85858.90,'2025-01-17'),

	(4,'Anil',70007.10,'2025-01-18'),

	(5,'Suresh',60000.55,'2025-01-19');

Query:

	For each record:

	· Remove decimals from salary

	· Reverse salary digits

	· Extract weekday

	· Proper case emp_name

	· CASE:

	     o Symmetric Pay if reversed equals original

	     o Asymmetric

Answer:

select

    initcap(emp_name) as employee_name,

    trunc(salary) as salary_without_decimals,

    reverse(trunc(salary)::text)
    as reversed_salary,

    to_char(processed_date,'Day')
    as weekday_name,

    case

        when trunc(salary)::text =
             reverse(trunc(salary)::text)
            then 'Symmetric Pay'

        else 'Asymmetric'

    end as symmetry_status

from salary_symmetry

-----------------------------------------------------------------------------------------------------------------------------------------------

QUESTION Schema-16:  Leap Year Salary Adjustment Audit


	CREATE TABLE leap_salary (

	emp_id INT,

	emp_name VARCHAR(50),

	salary DECIMAL(10,2),

	credit_date DATE

	);


	INSERT INTO leap_salary VALUES

	(1,'Karthik',75000.75,'2024-02-29'),

	(2,'Veena',65000.40,'2025-02-28'),

	(3,'Ravi',85000.90,'2020-02-29'),

	(4,'Anil',70000.10,'2023-02-28'),

	(5,'Suresh',60000.55,'2024-02-28');

Query:

	For each employee:

	· Extract year

	· Check leap year logic

	· CEIL salary

	· Calculate day of year

	· CASE:

	     o Leap Credit

	     o Non-Leap Credit

Answer:

select

    emp_name,

    extract(year from credit_date)
    as credit_year,

    case

        when (
                mod(extract(year from credit_date),4) = 0
                and
                mod(extract(year from credit_date),100) <> 0
             )
             or
             mod(extract(year from credit_date),400) = 0
            then 'Leap Year'

        else 'Non-Leap Year'

    end as leap_year_status,

    ceil(salary) as ceil_salary,

    extract(doy from credit_date)
    as day_of_year,

    case

        when extract(month from credit_date) = 2
             and
             extract(day from credit_date) = 29
            then 'Leap Credit'

        else 'Non-Leap Credit'

    end as credit_status

from leap_salary

-----------------------------------------------------------------------------------------------------------------------------------------------

QUESTION Schema-17:  Fiscal Year Boundary Salary Check


	CREATE TABLE fiscal_salary (

	emp_id INT,

	emp_name VARCHAR(50),

	salary DECIMAL(10,2),

	credit_date DATE

	);


	INSERT INTO fiscal_salary VALUES

	(1,'Karthik',75000.75,'2025-03-31'),

	(2,'Veena',65000.40,'2025-04-01'),

	(3,'Ravi',85000.90,'2024-03-30'),

	(4,'Anil',70000.10,'2024-04-02'),

	(5,'Suresh',60000.55,'2025-03-29');

Query:

	For each record:

	· Determine fiscal year

	· Extract month

	· Format salary

	· Lowercase emp_name

	· CASE:

	     o Year End Credit

	     o Year Start Credit

	     o Mid Year

Answer:

select

    lower(emp_name) as employee_name,

    case

        when extract(month from credit_date) >= 4
            then concat(
                    extract(year from credit_date),
                    '-',
                    extract(year from credit_date) + 1
                 )

        else concat(
                    extract(year from credit_date) - 1,
                    '-',
                    extract(year from credit_date)
                 )

    end as fiscal_year,

    extract(month from credit_date)
    as credit_month,

    to_char(salary,'99,99,999.99')
    as formatted_salary,

    case

        when extract(month from credit_date) = 3
             and
             extract(day from credit_date) >= 29
            then 'Year End Credit'

        when extract(month from credit_date) = 4
             and
             extract(day from credit_date) <= 2
            then 'Year Start Credit'

        else 'Mid Year'

    end as fiscal_status

from fiscal_salary

-----------------------------------------------------------------------------------------------------------------------------------------------

QUESTION Schema-18:  Salary Random Sampling for Audit


	CREATE TABLE salary_sampling (

	emp_id INT,

	emp_name VARCHAR(50),

	salary DECIMAL(10,2),

	record_date DATE

	);


	INSERT INTO salary_sampling VALUES

	(1,'Karthik',75000.75,'2025-01-01'),

	(2,'Veena',65000.40,'2025-01-02'),

	(3,'Ravi',85000.90,'2025-01-03'),

	(4,'Anil',70000.10,'2025-01-04'),

	(5,'Suresh',60000.55,'2025-01-05'),

	(6,'Amit',72000.60,'2025-01-06'),

	(7,'Neha',68000.80,'2025-01-07');

Query:

	For each record:

	· Generate random value

	· Round salary

	· Extract day name

	· Extract first character of emp_name

	· CASE:

	     o Sampled if RAND() > 0.7

	     o Skipped

Answer:

select

    left(emp_name,1) as first_character,

    round(salary) as rounded_salary,

    to_char(record_date,'Day')
    as day_name,

    random() as random_value,

    case

        when random() > 0.7
            then 'Sampled'

        else 'Skipped'

    end as sampling_status

from salary_sampling

-----------------------------------------------------------------------------------------------------------------------------------------------

QUESTION Schema-19:  Salary ASCII Integrity Check


	CREATE TABLE salary_ascii (

	emp_id INT,

	emp_name VARCHAR(50),

	salary DECIMAL(10,2),

	join_date DATE

	);


	INSERT INTO salary_ascii VALUES

	(1,'Karthik',75000.75,'2019-03-15'),

	(2,'Veena',65000.40,'2021-06-20'),

	(3,'Ravi',85000.90,'2016-01-10'),

	(4,'Anil',70000.10,'2020-09-01'),

	(5,'Suresh',60000.55,'2022-11-25');

Query:

	For each employee:

	· Extract ASCII value of first character

	· Calculate years since joining

	· Floor salary

	· Compare ASCII vs years

	· CASE:

	     o Name Dominates

	     o Experience Dominates

Answer:

select

    ascii(left(emp_name,1))
    as first_character_ascii,

    extract(year from age(current_date,join_date))
    as years_since_joining,

    floor(salary) as floor_salary,

    case

        when ascii(left(emp_name,1)) >
             extract(year from age(current_date,join_date))
            then 'Name Dominates'

        else 'Experience Dominates'

    end as dominance_status

from salary_ascii

-----------------------------------------------------------------------------------------------------------------------------------------------

QUESTION Schema-20:  Salary vs Calendar Symmetry Logic


	CREATE TABLE salary_calendar (

	emp_id INT,

	emp_name VARCHAR(50),

	salary DECIMAL(10,2),

	credit_date DATE

	);


	INSERT INTO salary_calendar VALUES

	(1,'Karthik',75000.75,'2025-01-15'),

	(2,'Veena',65000.40,'2025-02-14'),

	(3,'Ravi',85000.90,'2025-03-31'),

	(4,'Anil',70000.10,'2025-04-04'),

	(5,'Suresh',60000.55,'2025-05-05');

Query:

	For each record:

	· Extract day and month

	· Extract last two digits of salary

	· Uppercase emp_name

	· Absolute difference between day and month

	· CASE:

	     o Calendar Match if day = month OR salary digits match

	     o Calendar Drift

Answer:

select

    upper(emp_name) as employee_name,

    extract(day from credit_date)
    as credit_day,

    extract(month from credit_date)
    as credit_month,

    right(trunc(salary)::text,2)
    as last_two_salary_digits,

    abs(
        extract(day from credit_date) -
        extract(month from credit_date)
    ) as day_month_difference,

    case

        when extract(day from credit_date) =
             extract(month from credit_date)

             or

             right(trunc(salary)::text,2) =
             lpad(
                 extract(month from credit_date)::text,
                 2,
                 '0'
             )

            then 'Calendar Match'

        else 'Calendar Drift'

    end as calendar_status

from salary_calendar

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
					                                                 LEVEL-2
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

QUESTION Schema-1:  Employee Login Discipline & Performance Classification


	CREATE TABLE employee_login (

	emp_id INT,

	emp_name VARCHAR(50),

	login_time DATETIME,

	logout_time DATETIME

	);


	INSERT INTO employee_login VALUES

	(1,'Karthik','2025-01-15 09:05:00','2025-01-15 18:10:00'),

	(2,'Veena','2025-01-14 10:30:00','2025-01-14 16:00:00'),

	(3,'Ravi','2025-01-13 09:00:00','2025-01-13 20:00:00'),

	(4,'Anil','2025-01-12 11:00:00','2025-01-12 14:00:00'),

	(5,'Suresh','2025-01-11 09:15:00','2025-01-11 17:00:00');

Query:

	For each employee:

	· Convert emp_name to proper case

	· Identify whether login date is Weekday or Weekend

	· Calculate total working hours (logout – login)

	· Round working hours to 2 decimals

	· Use CASE:

	      o Good Performer if weekday AND working hours ≥ 8

	      o Bad Performer if weekday AND working hours < 6

	      o Weekend Login otherwise

Answer:

select

    initcap(emp_name) as employee_name,

    case

        when extract(dow from login_time) in (0,6)
            then 'Weekend'

        else 'Weekday'

    end as login_day_type,

    round(
        extract(epoch from (logout_time - login_time)) / 3600,
        2
    ) as working_hours,

    case

        when extract(dow from login_time) not in (0,6)
             and
             (
                extract(epoch from (logout_time - login_time)) / 3600
             ) >= 8
            then 'Good Performer'

        when extract(dow from login_time) not in (0,6)
             and
             (
                extract(epoch from (logout_time - login_time)) / 3600
             ) < 6
            then 'Bad Performer'

        else 'Weekend Login'

    end as performance_status

from employee_login

-----------------------------------------------------------------------------------------------------------------------------------------------

QUESTION Schema-2:  Past 7 Days Attendance & Productivity Check


	CREATE TABLE attendance_log (

	emp_id INT,

	emp_name VARCHAR(50),

	login_date DATE,

	login_time TIME,

	logout_time TIME

	);


	INSERT INTO attendance_log VALUES

	(1,'Karthik','2025-01-14','09:00:00','18:00:00'),

	(2,'Karthik','2025-01-13','09:15:00','17:30:00'),

	(3,'Veena','2025-01-12','10:00:00','15:00:00'),

	(4,'Ravi','2025-01-10','09:00:00','19:00:00'),

	(5,'Anil','2025-01-08','11:00:00','14:00:00');

Query:

	For each record:

	· Uppercase employee name

	· Check if login_date falls within last 7 days from today

	· Identify Weekday / Weekend

	· Calculate working hours using TIMEDIFF

	· Use CASE:

	      o Active & Productive if last 7 days AND hours ≥ 8

	      o Active but Low Hours if last 7 days AND hours < 8

	      o Absent from Last 7 Days

Answer:

select

    upper(emp_name) as employee_name,

    login_date,

    case

        when login_date >= current_date - interval '7 days'
            then 'Within Last 7 Days'

        else 'Older Record'

    end as attendance_period,

    case

        when extract(dow from login_date) in (0,6)
            then 'Weekend'

        else 'Weekday'

    end as day_type,

    round(
        extract(
            epoch from
            (logout_time - login_time)
        ) / 3600,
        2
    ) as working_hours,

    case

        when login_date >= current_date - interval '7 days'
             and
             (
                extract(
                    epoch from
                    (logout_time - login_time)
                ) / 3600
             ) >= 8
            then 'Active & Productive'

        when login_date >= current_date - interval '7 days'
             and
             (
                extract(
                    epoch from
                    (logout_time - login_time)
                ) / 3600
             ) < 8
            then 'Active but Low Hours'

        else 'Absent from Last 7 Days'

    end as productivity_status

from attendance_log

-----------------------------------------------------------------------------------------------------------------------------------------------

QUESTION Schema-3:  Weekend Work Abuse Detection


	CREATE TABLE weekend_monitor (

	emp_id INT,

	emp_name VARCHAR(50),

	work_date DATE,

	login_time TIME,

	logout_time TIME

	);


	INSERT INTO weekend_monitor VALUES

	(1,'Ravi','2025-01-11','09:00:00','21:00:00'),

	(2,'Veena','2025-01-12','10:00:00','13:00:00'),

	(3,'Karthik','2025-01-10','09:00:00','18:00:00'),

	(4,'Anil','2025-01-09','11:00:00','14:00:00');

Query:

	For each employee:

	· Extract day name from work_date

	· Lowercase employee name

	· Calculate working hours

	· Apply CEIL on hours

	· Use CASE:

	      o Weekend Overtime if Saturday/Sunday AND hours ≥ 8

	      o Suspicious Login if weekend AND hours < 4

	      o Normal Working Day

Answer:

select

    lower(emp_name) as employee_name,

    to_char(work_date,'Day')
    as day_name,

    round(
        extract(
            epoch from
            (logout_time - login_time)
        ) / 3600,
        2
    ) as working_hours,

    ceil(
        extract(
            epoch from
            (logout_time - login_time)
        ) / 3600
    ) as ceil_hours,

    case

        when extract(dow from work_date) in (0,6)
             and
             (
                extract(
                    epoch from
                    (logout_time - login_time)
                ) / 3600
             ) >= 8
            then 'Weekend Overtime'

        when extract(dow from work_date) in (0,6)
             and
             (
                extract(
                    epoch from
                    (logout_time - login_time)
                ) / 3600
             ) < 4
            then 'Suspicious Login'

        else 'Normal Working Day'

    end as work_status

from weekend_monitor

-----------------------------------------------------------------------------------------------------------------------------------------------

QUESTION Schema-4:  Login Time Deviation & Discipline Score


	CREATE TABLE login_discipline (

	emp_id INT,

	emp_name VARCHAR(50),

	login_datetime DATETIME,

	logout_datetime DATETIME

	);


	INSERT INTO login_discipline VALUES

	(1,'Karthik','2025-01-15 08:55:00','2025-01-15 18:10:00'),

	(2,'Veena','2025-01-15 10:45:00','2025-01-15 16:00:00'),

	(3,'Ravi','2025-01-15 09:00:00','2025-01-15 20:30:00'),

	(4,'Anil','2025-01-15 11:30:00','2025-01-15 14:00:00');

Query:

	For each employee:

	· Extract login hour

	· Calculate total working hours

	· Truncate working hours to 1 decimal

	· Get weekday name

	· Use CASE:

	      o Disciplined if weekday AND login before 9 AND hours ≥ 8

	      o Late Comer if weekday AND login after 10

	      o Poor Discipline otherwise

Answer:

select

    emp_name,

    extract(hour from login_datetime)
    as login_hour,

    round(
        extract(
            epoch from
            (logout_datetime - login_datetime)
        ) / 3600,
        2
    ) as working_hours,

    trunc(
        extract(
            epoch from
            (logout_datetime - login_datetime)
        ) / 3600,
        1
    ) as truncated_hours,

    to_char(login_datetime,'Day')
    as weekday_name,

    case

        when extract(dow from login_datetime) not in (0,6)
             and
             extract(hour from login_datetime) < 9
             and
             (
                extract(
                    epoch from
                    (logout_datetime - login_datetime)
                ) / 3600
             ) >= 8
            then 'Disciplined'

        when extract(dow from login_datetime) not in (0,6)
             and
             extract(hour from login_datetime) > 10
            then 'Late Comer'

        else 'Poor Discipline'

    end as discipline_status

from login_discipline

-----------------------------------------------------------------------------------------------------------------------------------------------

QUESTION Sechma-5:  Absenteeism vs Performance Correlation


	CREATE TABLE performance_tracker (

	emp_id INT,

	emp_name VARCHAR(50),

	work_date DATE,

	login_time TIME,

	logout_time TIME

	);


	INSERT INTO performance_tracker VALUES

	(1,'Karthik','2025-01-09','09:00:00','18:00:00'),

	(2,'Karthik','2025-01-10','09:10:00','17:50:00'),

	(3,'Veena','2025-01-05','10:00:00','15:00:00'),

	(4,'Ravi','2025-01-14','09:00:00','19:00:00'),

	(5,'Anil','2025-01-03','11:00:00','14:00:00');

Query:

	For each record:

	· Identify whether work_date is within last 7 days

	· Identify weekday or weekend

	· Calculate total hours worked

	· Apply FLOOR to hours

	· Use CASE:

	      o Consistent Performer if last 7 days AND weekday AND hours ≥ 8

	      o Irregular Performer if hours < 6

	      o Absent / Old Record

Answer:

select

    emp_name,

    case

        when work_date >= current_date - interval '7 days'
            then 'Within Last 7 Days'

        else 'Old Record'

    end as attendance_status,

    case

        when extract(dow from work_date) in (0,6)
            then 'Weekend'

        else 'Weekday'

    end as day_type,

    round(
        extract(
            epoch from
            (logout_time - login_time)
        ) / 3600,
        2
    ) as total_hours,

    floor(
        extract(
            epoch from
            (logout_time - login_time)
        ) / 3600
    ) as floor_hours,

    case

        when work_date >= current_date - interval '7 days'
             and
             extract(dow from work_date) not in (0,6)
             and
             (
                extract(
                    epoch from
                    (logout_time - login_time)
                ) / 3600
             ) >= 8
            then 'Consistent Performer'

        when (
                extract(
                    epoch from
                    (logout_time - login_time)
                ) / 3600
             ) < 6
            then 'Irregular Performer'

        else 'Absent / Old Record'

    end as performance_result

from performance_tracker
