-- CREATE A HISTORY_OF_EMP TABLE
create table history_of_emp(
    emp_id NUMBER,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    department_before VARCHAR2(50),
    department_after VARCHAR2(50)
);

-- CREATE TRIGGER
CREATE OR REPLACE TRIGGER employees_after_update
AFTER UPDATE
   ON employees
   FOR EACH ROW
   
   DECLARE
   v_username varchar2(10);

BEGIN

   SELECT user INTO v_username
   FROM dual;
   
   INSERT INTO history_of_emp
   ( dep_id,
     department_before,
     department_after,
     username)
   VALUES
   ( :new.dep_id,
     :old.department,
     :new.department,
     v_username);

END;

-- 1
select * from employees;
insert into history_of_emp (emp_id, first_name, last_name, department_before, department_after)
values (1,'Angel', 'Georgiev', '1', '2');

insert into history_of_emp (emp_id, first_name, last_name, department_before, department_after)
values (3,'Petar', 'Angelov', '2', '3');

insert into history_of_emp (emp_id, first_name, last_name, department_before, department_after)
values (7,'Maria', 'Ivanova', '3', '1');

-- 2
select e. emp_id, e.first_name, e. last_name
from employees e
join history_of_emp he on e.emp_id = he.emp_id
where dep_id > 1
and date_started < add_months(sysdate, -2);

-- 3
select e. emp_id, e.first_name, e. last_name
from employees e
join history_of_emp he on e.emp_id = he.emp_id
where dep_id = 1;