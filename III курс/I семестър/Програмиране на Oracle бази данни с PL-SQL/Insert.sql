insert into departments
values (1,'Операции');
insert into departments
values (2,'Кредитен анализ');
insert into departments
values (3,'Картови разплащания');

insert into employees(emp_id, first_name, last_name, addl_name, address, phone, email, job_title, dep_id)
values (1,'Angel', 'Georgiev', '', 'Bulgaria', '0895465456', 'angelbgpl@gmail.com', 'Operator', 1);

insert into employees (emp_id, first_name, last_name, addl_name, address, phone, email, job_title, dep_id)
values (2,'Vasil', 'Grigorov', '', 'Italy', '0895546456', 'vas@gmail.com', 'Cards', 3);

insert into employees (emp_id, first_name, last_name, addl_name, address, phone, email, job_title, dep_id)
values (3,'Petar', 'Angelov', '', 'Bulgaria', '0895454556', 'Pet@gmail.com', 'Credit operator', 2);


insert into customers (cust_id, first_name, last_name, addl_name, address, phone, email)
values (1,'Ivan', 'Ivanov', '', 'France', '0892165', 'iv@gmail.com');

insert into customers (cust_id, first_name, last_name, addl_name, address, phone, email)
values (2,'Georgi', 'Petrov', '', 'Bulgaria', '089216655', 'gi@gmail.com');

insert into customers (cust_id, first_name, last_name, addl_name, address, phone, email)
values (3,'Silvia', 'Ivanova', '', 'Germany', '089215465', 'siv@gmail.com');