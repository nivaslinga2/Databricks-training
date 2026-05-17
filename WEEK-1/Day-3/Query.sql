-- Question 1
select s.student_name, c.course_name
from students s
left join enrollments e
on s.student_id = e.student_id
left join courses c
on e.course_id = c.course_id;

-- Question 2
select c.course_name
from courses c
left join enrollments e
on c.course_id = e.course_id
where e.enrollment_id is null;

-- Question 3
select i.instructor_name, c.course_name
from instructors i
left join courses c
on i.instructor_id = c.instructor_id;

-- Question 4
select c.course_name
from courses c
left join instructors i
on c.instructor_id = i.instructor_id
where c.instructor_id is null;

-- Question 5
select s.student_name, e.enrollment_id, e.course_id, e.enrollment_date
from enrollments e
right join students s
on e.student_id = s.student_id;

-- Question 6
select s.student_name
from students s
left join enrollments e
on s.student_id = e.student_id
where e.student_id is null;

-- Question 7
select s.student_name, e.enrollment_id, e.course_id, e.enrollment_date
from students s
full outer join enrollments e
on s.student_id = e.student_id;

-- Question 8
select c.course_name
from courses c
left join enrollments e
on c.course_id = e.course_id
where e.course_id is null;

-- Question 9
select i.instructor_name, c.course_name
from instructors i
full outer join courses c
on i.instructor_id = c.instructor_id;

-- Question 10
select s.student_name, c.course_name, i.instructor_name
from students s
left join enrollments e
on s.student_id = e.student_id
left join courses c
on e.course_id = c.course_id
left join instructors i
on c.instructor_id = i.instructor_id;

-- Question 11
select s.student_name, c.course_name
from students s
cross join courses c;
