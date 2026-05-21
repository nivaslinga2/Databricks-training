select e.emp_name,m.manager_id from employees e left join employees m on e.manager_id = m.emp_id
select emp_id,emp_name,dept_name from employees e left join departments d on e.dept_id = d.dept_id
select e.emp_name,m.emp_name as manager_name from employees e left join employees m on e.manager_id = m.emp_id
select emp_name,emp_name from employees e left join departments d on e.dept_id = d.dept_id where d.dept_id is null
select e.emp_name, p.project_name from employees e left join projects p on e.emp_id = p.emp_id
select e.emp_name,p.project_name from employees e inner join projects p on e.emp_id = p.emp_id
select e.emp_name, p.project_name from employees e right join projects p on e.emp_id = p.emp_id
select e.emp_name,d.dept_name from employees e left join departments d on e.dept_id = d.dept_id
select e.emp_name, d.dept_name from employees e right join departments d on e.dept_id = d.dept_id
select e.emp_name, d.dept_name from employees e left join departments d on e.dept_id = d.dept_id union select e.emp_name, d.dept_name from employees e right join departments d on e.dept_id = d.dept_id
select project_id,project_name,emp_name from employees e left join projects p on e.emp_id = p.emp_id where p.project_id is null
select e.emp_id,emp_name,project_id,project_name from employees e left join projects p on e.emp_id =p.emp_id
select project_id, project_name,e.emp_id,emp_name from projects p left join employees e on p.emp_id = e.emp_id
select e.emp_name,m.emp_name,p.project_id,p.project_name from employees e join employees m on e.manager_id = m.emp_id join projects p on e.emp_id =p.emp_id
select emp_name,dept_name from employees e join departments d on e.dept_id = d.dept_id
select * from(select e.emp_name,d.dept_name,count(d.dept_id) over (partition by e.emo_id) as department_count from employees e join departments d on e.dept_id = d.dept_id) x where department_count>1
select emp_name,dept_name from employees e right join departments d on e.dept_id = d.dept_id
select e.emp_name,p.project_name from employees e join projects p on e.emp_id = p.emp_id left join departments d on e.dept_id = d.dept_id where d.dept_id is null
select dept_name,count(e.emp_id) over(partition by d.dept_id) as Total_employees from departments d left join employees e on d.dept_id = e.dept_id
select e.emp_name,m.emp_name from employees e left join employees m on e.manager_id = m.emp_id where e.manager_id is not null
select e.emp_name,m.emp_name from employees e  left join employees m on e.manager_id = m.emp_id
select d.dept_name,count(e.emp_id)as total_employees from departments d left join employees e on d.dept_id = e.dept_id group by d.dept_id
select emp_name, dept_name from departments d left join employees e on d.dept_id = e.dept_id
select emp_name,project_name from employees e left join projects p on e.emp_id = p.emp_id
select emp_name, dept_name,project_name from employees e left join departments d on e.dept_id = d.dept_id left join projects p on e.emp_id = p.emp_id
select emp_name,dept_name from employees e left join departments d on e.dept_id = d.dept_id
