-- ADD EMP_STATUS COLUMN
alter table employees
add emp_status VARCHAR2(30);

-- UPDATE EMP_STATUS COLUMN
UPDATE employees
SET emp_status = 'active'
WHERE emp_id in (1,2,5,7);

UPDATE employees
SET emp_status = 'sick'
WHERE emp_id = 3;

UPDATE employees
SET emp_status = 'injured'
WHERE emp_id = 4;

UPDATE employees
SET emp_status = 'fired'
WHERE emp_id = 6;

UPDATE employees
SET emp_status = 'maternity'
WHERE emp_id = 8;

UPDATE employees
SET emp_status = 'vacation'
WHERE emp_id = 9;

-- 1
select *
from employees
where emp_status = 'fired';

-- 2
select *
from employees
where emp_status = 'maternity';

-- 3
select *
from employees
where emp_status = 'vacation'
or emp_status = 'sick';

-- ADD MANAGER_ID COLUMN
alter table employees
add manager_id NUMBER;

-- UPDATE MANAGER_ID IN EMPLOYEES
UPDATE employees
SET manager_id = 1
WHERE emp_id = 2;

UPDATE employees
SET manager_id = 2
WHERE emp_id = 4;

UPDATE employees
SET manager_id = 3
WHERE emp_id = 6;

-- 4
select *
from employees
where manager_id is null;

-- 5 
select * 
from employees
where date_started < add_months(sysdate, -60)
and salary > 5000
order by first_name;

-- 6
select first_name, dep_id, salary
from employees e
where e.salary IN
(
select max(salary)
from employees
group by dep_id
);

-- 7
select first_name, last_name, salary, name
from employees e, departments d
where e.dep_id = d.dep_id and (e.dep_id,e.salary) in
( 
select dep_id, min(salary)
from employees
group by dep_id
);

-- 8
select d.name, round (avg(e.salary)) avg_salary
from departments d
join employees e on e.dep_id = d.dep_id
group by d.name
