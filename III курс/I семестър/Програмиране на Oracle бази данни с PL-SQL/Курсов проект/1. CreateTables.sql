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