-- Question 1
select student_name, department_name
from Student s
join Department d
on s.department_id = d.department_id;

-- Question 2
select staff_name, department_name
from Staff s
left join Department d
on s.department_id = d.department_id;

-- Question 3
select department_name
from Department d
left join Student s
on d.department_id = s.department_id
where s.department_id is null;

-- Question 4
select student_name
from Student s
left join Mark m
on s.student_id = m.student_id
where m.student_id is null;

-- Question 5
select subject_name
from Subject s
left join Staff sa
on s.staff_id = sa.staff_id
where s.staff_id is null;

-- Question 6
select d.department_id, d.department_name, avg(cgpa) as avg_cgpa
from Department d
left join Student s
on d.department_id = s.department_id
group by d.department_id, d.department_name;

-- Question 7
select d.department_id, d.department_name, avg(cgpa) as avg_cgpa
from Department d
left join Student s
on d.department_id = s.department_id
group by d.department_id, d.department_name
having avg(cgpa) > 8.0;

-- Question 8
select d.department_id, department_name, count(s.student_id) as total_students
from Department d
left join Student s
on d.department_id = s.department_id
group by d.department_id, department_name;

-- Question 9
select s.subject_id, subject_name, max(marks) as highest_mark, min(marks) as lowest_mark
from Subject s
left join Mark m
on s.subject_id = m.subject_id
group by s.subject_id, subject_name;

-- Question 10
select student_name, marks
from Student s
left join Mark m
on s.student_id = m.student_id
where marks > 90;

-- Question 11
select student_name
from Student s
left join Department d
on s.department_id = d.department_id
where department_name = 'Computer Science';

-- Question 12
select staff_name, count(subject_id) as number_of_subjects
from Staff st
left join Subject sb
on st.staff_id = sb.staff_id
group by staff_name;

-- Question 13
select student_name, sum(marks) as total_marks
from Student s
left join Mark m
on s.student_id = m.student_id
group by s.student_name;

-- Question 14
select department_name, count(staff_id) as total_staff
from Department d
left join Staff s
on d.department_id = s.department_id
group by d.department_id, department_name
having count(staff_id) > 2;

-- Question 15
select student_name
from Student
where cgpa > (
  select avg(cgpa)
  from Student
);

-- Question 16
select staff_name, salary
from Staff s
where salary > (
  select avg(salary)
  from Staff st
  where s.department_id = st.department_id
);

-- Question 17
select max(salary) as second_highest_salary
from Staff
where salary < (
  select max(salary)
  from Staff
);

-- Question 18
select s.student_name, sub.subject_name, m.marks
from Mark m
join Student s
on m.student_id = s.student_id
join Subject sub
on m.subject_id = sub.subject_id
where m.marks = (
  select max(m2.marks)
  from Mark m2
  where m.subject_id = m2.subject_id
);

-- Question 19
select *
from Student s
left join Mark m
on s.student_id = m.student_id;

-- Question 20
select subject_name, avg(marks)
from Subject s
left join Mark m
on s.subject_id = m.subject_id
group by s.subject_id, subject_name
having avg(marks) < 70;

-- Question 21
select student_name, cgpa
from Student
order by cgpa desc;

-- Question 22
select department_name, sum(salary)
from Department d
left join Staff s
on d.department_id = s.department_id
group by d.department_id, department_name;

-- Question 23
select department_name, sum(salary) as total_salary
from Department d
left join Staff s
on d.department_id = s.department_id
group by d.department_id, department_name
having sum(salary) > 200000;

-- Question 24
select student_name, admission_year
from Student
where admission_year > 2021 and cgpa > 7.5;

-- Question 25
select admission_year, count(student_id)
from Student
group by admission_year;

-- Question 26
select city, count(student_id) as number_of_students
from Student
group by city
having count(student_id) = (
  select max(student_count)
  from (
    select count(student_id) as student_count
    from Student
    group by city
  ) x
);

-- Question 27
select department_name, count(staff_id)
from Department d
left join Staff s
on d.department_id = s.department_id
group by d.department_id, department_name;

-- Question 28
select student_name, marks
from Student s
left join Mark m
on s.student_id = m.student_id
where marks < 50;

-- Question 29
select staff_id, staff_name, hire_date
from Staff
where hire_date < '2018-01-01';

-- Question 30
select d.department_id, department_name
from Department d
join Staff s
on d.department_id = s.department_id
group by d.department_id, department_name
having sum(case when s.salary is null then 1 else 0 end) = 0;

-- Question 31
select student_name, cgpa,
row_number() over(order by cgpa desc) as row_numbers
from Student;

-- Question 32
select student_id, student_name, cgpa,
rank() over(order by cgpa desc) as rank_of_students
from Student;

-- Question 33
select staff_name, salary,
dense_rank() over(order by salary desc) as staff_rank
from Staff;

-- Question 34
select *
from (
  select student_name, cgpa,
  dense_rank() over(order by cgpa desc) as student_ranks
  from Student
) x
where student_ranks <= 3;

-- Question 35
select s.student_id, student_name,
sum(m.marks) over(partition by s.student_id order by m.subject_id) as running_total
from Student s
left join Mark m
on s.student_id = m.student_id;

-- Question 36
select s.student_id, student_name, m.subject_id,
avg(marks) over(partition by m.subject_id) as subject_avg_marks
from Student s
left join Mark m
on s.student_id = m.student_id;

-- Question 37
select s.student_id, student_name, m.subject_id, marks,
lag(marks) over(partition by s.student_id order by m.subject_id) as previous_marks
from Student s
left join Mark m
on s.student_id = m.student_id;

-- Question 38
select s.student_id, student_name, m.subject_id, marks,
lead(marks) over(partition by s.student_id order by m.subject_id) as next_exam_marks
from Student s
left join Mark m
on s.student_id = m.student_id;

-- Question 39
select s.subject_id, subject_name,
max(marks) over(partition by s.subject_id) as maximum_marks
from Subject s
left join Mark m
on s.subject_id = m.subject_id;

-- Question 40
select exam_date,
avg(marks) over(order by exam_date) as cumulative_avg_mark
from Mark;

-- Question 41
select student_id, student_name, department_name
from (
  select s.student_id, student_name, department_name,
  dense_rank() over(partition by s.department_id order by s.admission_year) as admission_rank
  from Student s
  left join Department d
  on s.department_id = d.department_id
) x
where admission_rank = 1;

-- Question 42
select *
from (
  select staff_id, staff_name, hire_date,
  dense_rank() over(partition by s.department_id order by hire_date desc) as hire_rank
  from Staff s
  left join Department d
  on s.department_id = d.department_id
) x
where hire_rank = 1;

-- Question 43
select student_id, student_name, cgpa,
ntile(4) over(order by cgpa desc) as cgpa_quartile
from Student;

-- Question 44
select student_id, student_name, cgpa,
percent_rank() over(order by cgpa desc) as rank_percentage
from Student;

-- Question 45
select staff_name, salary,
cume_dist() over(order by salary) as cumulative_distribution
from Staff;

-- Question 46
select *
from (
  select s.student_name, sub.subject_name, m.marks,
  avg(m.marks) over(partition by m.subject_id) as subject_avg
  from Mark m
  join Student s
  on m.student_id = s.student_id
  join Subject sub
  on m.subject_id = sub.subject_id
) x
where marks > subject_avg;

-- Question 47
select distinct department_name, salary_avg, overall_avg
from (
  select d.department_id, d.department_name,
  avg(s.salary) over(partition by d.department_id) as salary_avg,
  avg(s.salary) over() as overall_avg
  from Staff s
  join Department d
  on s.department_id = d.department_id
) x
where salary_avg > overall_avg;

-- Question 48
select distinct student_name
from (
  select s.student_id, student_name, marks,
  avg(m.marks) over(partition by s.department_id) as department_avg
  from Mark m
  join Student s
  on m.student_id = s.student_id
  join Department d
  on s.department_id = d.department_id
) x
where marks > department_avg;

-- Question 49
select *
from (
  select marks,
  dense_rank() over(order by marks desc) as dense_ran
  from Mark
) x
where dense_ran = 3;

-- Question 50
select s.student_name, d.department_name, sub.subject_name, m.exam_type, m.marks,
avg(m.marks) over(partition by d.department_id) as department_average,
dense_rank() over(order by m.marks desc) as overall_rank
from Mark m
join Student s
on m.student_id = s.student_id
join Department d
on s.department_id = d.department_id
join Subject sub
on m.subject_id = sub.subject_id;
