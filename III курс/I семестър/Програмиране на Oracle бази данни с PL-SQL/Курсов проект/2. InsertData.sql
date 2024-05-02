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
values (3,'Petar', 'Angelov', '', 'Bulgaria', '0889554790', 'Pet@gmail.com', 'Credit operator', 2);

insert into employees (emp_id, first_name, last_name, addl_name, address, phone, email, job_title, dep_id)
values (4,'Ivan', 'Andonov', '', 'Bulgaria', '0895423500', 'Iva@gmail.com', 'Operator', 1);

insert into employees (emp_id, first_name, last_name, addl_name, address, phone, email, job_title, dep_id)
values (5,'Nikola', 'Ivanov', '', 'Bulgaria', '0899213033', 'Nii@gmail.com', 'Cards', 3);

insert into employees (emp_id, first_name, last_name, addl_name, address, phone, email, job_title, dep_id)
values (6,'Georgi', 'Vasilev', '', 'Bulgaria', '0884523490', 'Gev@gmail.com', 'Credit operator', 2);

insert into employees (emp_id, first_name, last_name, addl_name, address, phone, email, job_title, dep_id)
values (7,'Maria', 'Ivanova', '', 'Bulgaria', '0884832044', 'Mai@gmail.com', 'Cards', 3);

insert into employees (emp_id, first_name, last_name, addl_name, address, phone, email, job_title, dep_id)
values (8,'Gergana', 'Nikolova', '', 'Bulgaria', '0889145503', 'Mai@gmail.com', 'Operator', 1);

insert into employees (emp_id, first_name, last_name, addl_name, address, phone, email, job_title, dep_id)
values (9,'Vladimir', 'Georgiev', '', 'Bulgaria', '0889201837', 'Mai@gmail.com', 'Cards', 3);

insert into customers (cust_id, first_name, last_name, addl_name, address, phone, email)
values (1,'Ivan', 'Ivanov', '', 'France', '0892165', 'iv@gmail.com');

insert into customers (cust_id, first_name, last_name, addl_name, address, phone, email)
values (2,'Georgi', 'Petrov', '', 'Bulgaria', '089216655', 'gi@gmail.com');

insert into customers (cust_id, first_name, last_name, addl_name, address, phone, email)
values (3,'Silvia', 'Ivanova', '', 'Germany', '089215465', 'siv@gmail.com');

insert into customers (cust_id, first_name, last_name, addl_name, address, phone, email)
values (4,'Valentina', 'Georgieva', '', 'Bulgaria', '089212165', 'vag@gmail.com');