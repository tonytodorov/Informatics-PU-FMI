alter table employees
add salary number;

alter table employees
add date_started DATE DEFAULT sysdate NOT NULL;

UPDATE "BOT"."EMPLOYEES" 
SET SALARY = '15000' 
WHERE ROWID = 'AAATE9AAHAAAAGNAAA';

select rowid, a.* 
from "BOT"."EMPLOYEES" a;

--2
select first_name, last_name, salary
from employees;

--3
select lower(first_name||'.'||last_name||'@bankoftomarow.bg') as email, first_name, last_name, salary
from employees;


--4 

select upper(a.first_name), initcap(email), a.*
from employees a
where upper(a.first_name) like '%S%';


select sysdate + 1/24, 
add_months(sysdate, -60)  
from dual;


select *
from employees
where date_started < add_months(sysdate, -60);


select address, 
       max(first_name), 
       count(ADDL_NAME), 
       count(4), 
       count(1), 
       count(*)
from employees
group by address;


select emp.first_name, emp.last_name, dep.name
from employees emp
join departments dep 
on dep.dep_id = emp.dep_id;
