alter table employees
add salary number;

alter table employees
add date_started DATE DEFAULT sysdate NOT NULL;

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