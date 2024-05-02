-- 1
select name from departments;

-- 2
select first_name, last_name, salary
from employees;

-- 3
select lower(first_name||'.'||last_name||'@bankoftomarow.bg') as email, first_name, last_name
from employees;

-- 4
select *
from employees
where date_started < add_months(sysdate, -60);

-- 5
select first_name, last_name, addl_name  
from employees 
where first_name LIKE '%l%'
or last_name LIKE '%l%'
or addl_name LIKE '%l%';