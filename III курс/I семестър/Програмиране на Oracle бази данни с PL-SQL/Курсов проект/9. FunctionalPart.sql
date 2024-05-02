-- 1
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

END;

DECLARE
  u user_type := user_type();
BEGIN
  u.username := 'ivanov14';
  u.password := 'ivivanov12';
  user_pkg.add_user(u);
END;


DECLARE
  type array_t is varray(3) of varchar2(10);
  l_array array_t := array_t('Matt', 'Joanne', 'Robert');
  type array_n is varray(3) of number;
  l_array_n array_n := array_n(1, 2, 3);
BEGIN
 for i in 1..l_array.count loop
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


-- 2

create table accounts
(
id NUMBER generated as identity primary key,
username VARCHAR2(30),
password  VARCHAR2(30)
);

create or replace NONEDITIONABLE TYPE account_type AS OBJECT (
    bank_account_id    NUMBER,
    IBAN VARCHAR2(30 BYTE),
    amount_of_money  NUMBER,
    currency  VARCHAR2(3 BYTE),
    
    constructor function account_type return self as result
);

create or replace NONEDITIONABLE type body account_type is

    constructor function account_type return self as result
    IS
    BEGIN
    RETURN;
    END;
end;

create or replace NONEDITIONABLE TYPE account_type AS OBJECT (
    id NUMBER,
    username VARCHAR2(30 BYTE),
    password  VARCHAR2(30 BYTE)
);

DECLARE
    l_acc_type account_type;
    l_acc_type_empty account_type;
BEGIN
    l_acc_type := account_type(1, 'BG69BNPA94405581929565', '1000', '', 'BGN');
    l_acc_type_empty := account_type();
    l_acc_type.first_name := 'Ivan';
END;

DECLARE
  a account_type := account_type();
BEGIN
  a.username := 'georgi21';
  a.password := 'georgiv12';
  user_pkg.add_account(a);
END;

DECLARE
  type array_t is varray(3) of varchar2(10);
  l_array array_t := array_t('Matt', 'Joanne', 'Robert');
  type array_n is varray(3) of number;
  l_array_n array_n := array_n(1, 2, 3);
BEGIN
 for i in 1..l_array.count loop
   end loop;

for i in 1..l_array_n.count loop
       dbms_output.put_line(l_array_n(i));
   end loop;
END;


DECLARE
   TYPE IBAN IS TABLE OF NUMBER INDEX BY VARCHAR2(22); 
   IBAN_list IBAN; 
   name   VARCHAR2(20); 
BEGIN

   IBAN_list('Angel') := 'BG26UNCR70005951546346'; 
   IBAN_list('Georgi') := 'BG61BNPA94405586711227'; 
   IBAN_list('Ivan') := 'BG57STSA93009841152397'; 
   IBAN_list('Petar') := 'BG07UNCR70006266311494';  
   
   name := IBAN_list.FIRST; 
   WHILE name IS NOT null LOOP 
      dbms_output.put_line 
      (name);
      dbms_output.put_line 
      (IBAN_list(IBAN));
      name := IBAN_list.NEXT(name); 
   END LOOP; 
END;


