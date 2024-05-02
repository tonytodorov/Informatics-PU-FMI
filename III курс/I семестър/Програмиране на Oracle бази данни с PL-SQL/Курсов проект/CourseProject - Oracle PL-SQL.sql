-- 1. Create tables

create table employees
( emp_id NUMBER PRIMARY KEY,
  first_name VARCHAR2(30) NOT NULL,
  last_name VARCHAR2(30)  NOT NULL,
  addl_name VARCHAR2(30),
  address VARCHAR2(100) NOT NULL,
  phone VARCHAR2(20),
  email VARCHAR2(30),
  job_title VARCHAR2(30) NOT NULL,
  dep_id NUMBER NOT NULL
);

create table departments
( dep_id NUMBER PRIMARY KEY,
  name VARCHAR2(100)
);

create table customers
( cust_id NUMBER PRIMARY KEY,
  first_name VARCHAR2(30) NOT NULL,
  last_name VARCHAR2(30)  NOT NULL,
  addl_name VARCHAR2(30),
  address VARCHAR2(100) NOT NULL,
  phone VARCHAR2(20),
  email VARCHAR2(30)
);

ALTER TABLE employees
ADD CONSTRAINT fk_departments
  FOREIGN KEY (dep_id)
  REFERENCES departments(dep_id);
  

-- 2. Insert data

insert into departments
values (1,'Операции');
insert into departments
values (2,'Кредитен анализ');
insert into departments
values (3,'Картови разплащания');

insert into employees(emp_id, first_name, last_name, addl_name, address, phone, email, job_title, dep_id)
values (1,'Angel', 'Georgiev', '', 'Bulgaria', '0895465456', 'angelbgpl@gmail.com', 'Operator', 1);

insert into employees (emp_id, first_name, last_name, addl_name, address, phone, email, job_title, dep_id)
values (2,'Vasil', 'Grigorov', '', 'Italy', '0889312422', 'vas@gmail.com', 'Cards', 3);

insert into employees (emp_id, first_name, last_name, addl_name, address, phone, email, job_title, dep_id)
values (3,'Petar', 'Angelov', '', 'Bulgaria', '0889554790', 'pet@gmail.com', 'Credit operator', 2);

insert into employees (emp_id, first_name, last_name, addl_name, address, phone, email, job_title, dep_id)
values (4,'Georg', 'Andonov', '', 'Bulgaria', '0895812521', 'georg@gmail.com', 'Operator', 1);

insert into employees (emp_id, first_name, last_name, addl_name, address, phone, email, job_title, dep_id)
values (5,'Nikol', 'Ivanova', '', 'Bulgaria', '0899223133', 'nikol@gmail.com', 'Cards', 3);

insert into employees (emp_id, first_name, last_name, addl_name, address, phone, email, job_title, dep_id)
values (6,'Viktor', 'Vaskov', '', 'Bulgaria', '0884523210', 'viktor@gmail.com', 'Credit operator', 2);

insert into employees (emp_id, first_name, last_name, addl_name, address, phone, email, job_title, dep_id)
values (7,'Olya', 'Nikolova', '', 'Bulgaria', '0884231234', 'olya@gmail.com', 'Cards', 3);

insert into employees (emp_id, first_name, last_name, addl_name, address, phone, email, job_title, dep_id)
values (8,'Nik', 'Nikol', '', 'Bulgaria', '0889145503', 'nik@gmail.com', 'Operator', 1);

insert into employees (emp_id, first_name, last_name, addl_name, address, phone, email, job_title, dep_id)
values (9,'Vlad', 'Dimitrov', '', 'Bulgaria', '0889412227', 'vlad@gmail.com', 'Cards', 3);

insert into customers (cust_id, first_name, last_name, addl_name, address, phone, email)
values (1,'Ivan', 'Ivanov', '', 'France', '0892165', 'ivan@gmail.com');

insert into customers (cust_id, first_name, last_name, addl_name, address, phone, email)
values (2,'Georgi', 'Petrov', '', 'Bulgaria', '089216655', 'georgi@gmail.com');

insert into customers (cust_id, first_name, last_name, addl_name, address, phone, email)
values (3,'Silvia', 'Ivanova', '', 'Germany', '089215465', 'silvia@gmail.com');

insert into customers (cust_id, first_name, last_name, addl_name, address, phone, email)
values (4,'Viktoria', 'Nikolova', '', 'Bulgaria', '0892129165', 'viktoria@gmail.com');



-- 3. Bank_account table

create table bank_account
( bank_account_id NUMBER PRIMARY KEY,
  IBAN VARCHAR2(22),
  amount_of_money NUMBER,
  currency VARCHAR2(3)
);

ALTER TABLE bank_account
ADD CONSTRAINT IBAN_unique UNIQUE(IBAN);

alter table customers
add bank_account_id NUMBER;

ALTER TABLE customers
ADD CONSTRAINT fk_bank_account
  FOREIGN KEY (bank_account_id)
  REFERENCES bank_account(bank_account_id);

insert into bank_account (bank_account_id, IBAN, amount_of_money, currency)
values (1,'UA373641552971588321582898779', 2000, 'BGN');

insert into bank_account (bank_account_id, IBAN, amount_of_money, currency)
values (2,'UA669747214546342547799881292', 2500, 'USD');

insert into bank_account (bank_account_id, IBAN, amount_of_money, currency)
values (3,'UA521588754849939299833524437', 3000, 'EUR');


UPDATE customers
SET bank_account_id = 1
WHERE cust_id = 1;

UPDATE customers
SET bank_account_id = 2
WHERE cust_id = 2;

UPDATE customers
SET bank_account_id = 3
WHERE cust_id = 3;

UPDATE customers
SET bank_account_id = 4
WHERE cust_id = 4;


-- 4. Update salary

alter table employees
add salary number;

UPDATE employees
SET salary = 2000
WHERE emp_id = 1;

UPDATE employees
SET salary = 3500
WHERE emp_id = 2;

UPDATE employees
SET salary = 0
WHERE emp_id = 3;

UPDATE employees
SET salary = 1500
WHERE emp_id = 4;

UPDATE employees
SET salary = 2200
WHERE emp_id = 5;

UPDATE employees
SET salary = 2600
WHERE emp_id = 6;

UPDATE employees
SET salary = 1800
WHERE emp_id = 7;

UPDATE employees
SET salary = 3200
WHERE emp_id = 8;

UPDATE employees
SET salary = 1400
WHERE emp_id = 9;


-- 5. Add date_started

alter table employees
add date_started DATE DEFAULT sysdate NOT NULL;


-- 6. Business_part 1

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


-- 7. Business_part 2

create table history_of_emp(
    emp_id NUMBER,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    department_before VARCHAR2(50),
    department_after VARCHAR2(50)
);

-- 1
select * from employees;
insert into history_of_emp (emp_id, first_name, last_name, department_before, department_after)
values (1,'Angel', 'Georgiev', '1', '2');

insert into history_of_emp (emp_id, first_name, last_name, department_before, department_after)
values (3,'Petar', 'Angelov', '2', '3');

insert into history_of_emp (emp_id, first_name, last_name, department_before, department_after)
values (7,'Maria', 'Ivanova', '3', '1');


-- 8. Business_part 3

alter table employees
add employee_status VARCHAR2(50);

UPDATE employees
SET employee_status = 'active'
WHERE emp_id in (1,2,5,7);

UPDATE employees
SET employee_status = 'sick'
WHERE emp_id = 3;

UPDATE employees
SET employee_status = 'injured'
WHERE emp_id = 4;

UPDATE employees
SET employee_status = 'fired'
WHERE emp_id = 6;

UPDATE employees
SET employee_status = 'maternity'
WHERE emp_id = 8;

UPDATE employees
SET employee_status = 'vacation'
WHERE emp_id = 9;

-- 1
select *
from employees
where employee_status = 'fired';

-- 2
select *
from employees
where employee_status = 'maternity';

-- 3
select *
from employees
where employee_status = 'vacation'
or employee_status = 'sick';

alter table employees
add manager_id NUMBER;

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

-- 8
select d.name, round (avg(e.salary)) avg_salary
from departments d
join employees e on e.dep_id = d.dep_id
group by d.name


-- 8. Business_part 4

-- 1
select c.cust_id, c.first_name, c.last_name 
from customers c
join bank_account b on c.bank_account_id = b.bank_account_id
where currency != 'BGN';

-- 2
select c.cust_id, c.first_name, c.last_name 
from customers c
join bank_account b on c.bank_account_id = b.bank_account_id
where amount_of_money = 0;


-- 9. Functional_part

-- 1.

DECLARE
  type array_t is varray(3) of varchar2(10);
  
  l_array array_t := array_t('Matt', 'Joanne', 'Robert');
  
  type array_n is varray(3) of number;
  
  l_array_n array_n := array_n(1, 2, 3);
BEGIN
 for i in 1..l_array.count loop
       dbms_output.put_line(l_array(i));
   end loop;
   
   
 for i in 1..l_array_n.count loop
       dbms_output.put_line(l_array_n(i));
   end loop;
END;

DECLARE
   TYPE names_table IS TABLE OF VARCHAR2(10);
   TYPE grades IS TABLE OF NUMBER;
   
   names names_table;   
   marks grades; 
   total integer; 
BEGIN
   names := names_table('Kavita', 'Pritam', 'Ayan', 'Rishav', 'Aziz');
   marks:= grades(3, 4, 2, 5, 6);
   total := names.count;
   dbms_output.put_line('Total '|| total || ' Students');

   marks.extend;
   marks(marks.count) := 5;
   marks(3) := 9;
   
   FOR i IN 1 .. marks.count LOOP 
      dbms_output.put_line(marks(i)); 
   end loop;
END;

DECLARE
   TYPE salary IS TABLE OF NUMBER INDEX BY VARCHAR2(20); 
   salary_list salary; 
   name   VARCHAR2(20); 
BEGIN
   salary_list('Angel') := 6200; 
   salary_list('Georgi') := 7500; 
   salary_list('Ivan') := 1000; 
   salary_list('Petar') := 7800;  
   
   name := salary_list.FIRST; 
   WHILE name IS NOT null LOOP 
      dbms_output.put_line 
      (name);
      dbms_output.put_line 
      (salary_list(name));
      name := salary_list.NEXT(name); 
   END LOOP; 
END;


DECLARE
  u user_type := user_type();
BEGIN
  u.username := 'angelbgpl4';
  u.password := 'kontence4';
  user_pkg.add_user(u);
END;


create table users
(
id NUMBER generated as identity primary key,
username VARCHAR2(30),
password  VARCHAR2(30)
);


create or replace NONEDITIONABLE TYPE customer_type AS OBJECT (
    cust_id    NUMBER,
    first_name VARCHAR2(30 BYTE),
    last_name  VARCHAR2(30 BYTE),
    addl_name  VARCHAR2(30 BYTE),
    address    VARCHAR2(100 BYTE),
    phone      VARCHAR2(20 BYTE),
    email      VARCHAR2(30 BYTE),
    salary      VARCHAR2(30 BYTE),
    
    constructor function customer_type return self as result
);


create or replace NONEDITIONABLE type body customer_type is

    constructor function customer_type return self as result
    IS
    BEGIN
    RETURN;
    END;
end;


create or replace NONEDITIONABLE TYPE user_type AS OBJECT (
    id NUMBER,
    username VARCHAR2(30 BYTE),
    password  VARCHAR2(30 BYTE)
);

DECLARE
    l_cust_type customer_type;
    l_cust_type_empty customer_type;
BEGIN
    l_cust_type := customer_type(1, 'Angel', 'Georgiev', '', 'Plovdiv',
                                '0892456545', 'angel.georgiev', '2000');

    l_cust_type_empty := customer_type();

    l_cust_type.first_name := 'Nikola';
    dbms_output.put_line(l_cust_type.first_name);
    dbms_output.put_line('Name '||l_cust_type_empty.first_name);
    dbms_output.put_line('Obj '||l_cust_type.obj_to_clob);
    dbms_output.put_line(l_cust_type_empty.salary);
END;

