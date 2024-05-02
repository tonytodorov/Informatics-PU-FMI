CREATE TABLE STUDENTS 
(
	F_NUM  varchar (15) NOT NULL,
	NAME   varchar (50) NOT NULL,
    PHONE  varchar (15)
)

--ADD COLUMN
ALTER TABLE STUDENTS
ADD ADDRESS VARCHAR (30)

--CHANGE DATATYPE OF COLUMN
ALTER TABLE STUDENTS
ALTER COLUMN ADDRESS TEXT

--DROP COLUMN
ALTER TABLE STUDENTS
DROP COLUMN PHONE

--DROP TABLE
DROP TABLE STUDENTS

--DROP DATABASE
DROP DATABASE ---------

----------------------------DML--------------------------

CREATE TABLE STUDENTS 
(
	F_NUM  varchar (15) NOT NULL PRIMARY KEY,
	NAME   varchar (50) NOT NULL,
    PHONE  varchar (15) NULL,
	GENDER CHAR (1) NULL DEFAULT 'M' CHECK (GENDER IN('M','F'))
)

--INSERT:

--1) 1 ROW
INSERT INTO STUDENTS (F_NUM, NAME, PHONE)
VALUES('100', 'Иван Иванов', '089527342')

--2)
INSERT INTO STUDENTS
VALUES('101', 'Иван Иванов', '089527342', NULL)

--3)
INSERT INTO STUDENTS
VALUES('102', 'Мария Илиева', '089382342', 'F'), 
      ('103', 'Мари Милева', '089527342', 'F'),
	  ('104', 'Теодор Теодоров', '089527342', DEFAULT),
	  ('105', 'Мира Тодорова', NULL, 'F')


SELECT * FROM STUDENTS
	  
--UPDATE
UPDATE STUDENTS
SET NAME = NAME + '-Иванова'
WHERE F_NUM = '105'

UPDATE STUDENTS
SET NAME = NAME + '-Иванова'
WHERE F_NUM IN ('105', '103')

--DELETE
DELETE FROM STUDENTS
WHERE F_NUM = '105'




--alter database current collate cyrillic_general_ci_ai;

CREATE TABLE REGIONS 
(
	REGION_ID SMALLINT NOT NULL PRIMARY KEY IDENTITY(1,1),
	NAME VARCHAR (25) NOT NULL UNIQUE,
)

CREATE TABLE COUNTRIES
(
	COUNTRY_ID CHAR (2) NOT NULL,
	NAME VARCHAR (40) NOT NULL,
	REGION_ID SMALLINT NULL,
	CONSTRAINT PK_COUNTRIES PRIMARY KEY (COUNTRY_ID),
	CONSTRAINT FK_COUNTRIES_REGIONS FOREIGN KEY (REGION_ID) REFERENCES REGIONS (REGION_ID),
)

CREATE TABLE CUSTOMERS
(
	CUSTOMER_ID NUMERIC (6) NOT NULL PRIMARY KEY,
	COUNTRY_ID CHAR (2) NOT NULL,
	FNAME VARCHAR (20) NOT NULL,
	LNAME VARCHAR (20) NOT NULL,
	ADDRESS TEXT,
	EMAIL VARCHAR (30),
	GENDER CHAR (1) DEFAULT 'M' CHECK (GENDER IS NULL OR (GENDER IN ('M','F')))
)

ALTER TABLE CUSTOMERS 
ADD CONSTRAINT FK_CUSTOMERS_COUNTRIES FOREIGN KEY (COUNTRY_ID) REFERENCES COUNTRIES (COUNTRY_ID)

CREATE TABLE JOBS
(
	JOB_ID VARCHAR (10) NOT NULL PRIMARY KEY,
	JOB_TITLE VARCHAR (35) NOT NULL,
	MIN_SALARY NUMERIC (6) NULL,
	MAX_SALARY NUMERIC (6) NULL
)

CREATE TABLE EMPLOYEES
(
	EMPLOYEE_ID INT NOT NULL PRIMARY KEY,
	FNAME VARCHAR (20) NOT NULL,
	LNAME VARCHAR (25) NOT NULL,
	EMAIL VARCHAR (40) NOT NULL UNIQUE,
	PHONE VARCHAR (20) NOT NULL,
	HIRE_DATE DATETIME NOT NULL,
	SALARY NUMERIC (8,2) NOT NULL CHECK (SALARY > 0),
	JOB_ID VARCHAR (10) NOT NULL REFERENCES JOBS,
	MANAGER_ID INT NULL,
	DEPARTMENT_ID INT NULL,
	CONSTRAINT FK_EMPLOYEES_MANAGERS FOREIGN KEY (MANAGER_ID) REFERENCES EMPLOYEES (EMPLOYEE_ID)
)

CREATE TABLE DEPARTMENTS
(
	DEPARTMENT_ID INT NOT NULL,
	NAME VARCHAR (30) NOT NULL,
	MANAGER_ID INT,
	COUNTRY_ID CHAR (2) NOT NULL,
	CITY VARCHAR (30) NOT NULL,
	STATE VARCHAR (25),
	ADDRESS VARCHAR (40),
	POSTAL_CODE VARCHAR (12),
	CONSTRAINT PK_DEPARTMENTS PRIMARY KEY (DEPARTMENT_ID),
	CONSTRAINT FK_DEPARTMENTS_MANG FOREIGN KEY (MANAGER_ID) REFERENCES EMPLOYEES (EMPLOYEE_ID),
	CONSTRAINT FK_DEPARTMENTS_COUNTRIES FOREIGN KEY (COUNTRY_ID) REFERENCES COUNTRIES (COUNTRY_ID)

)


ALTER TABLE EMPLOYEES
ADD CONSTRAINT FK_EMPLOYEES_DEPARTMENTS FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENTS (DEPARTMENT_ID)

CREATE TABLE ORDERS
(
	ORDER_ID INT NOT NULL PRIMARY KEY,
	ORDER_DATE DATETIME NOT NULL,
	CUSTOMER_ID NUMERIC (6) NOT NULL REFERENCES CUSTOMERS,
	EMPLOYEE_ID INT NOT NULL FOREIGN KEY REFERENCES EMPLOYEES,
	SHIP_ADDRESS VARCHAR (150) NULL
)

CREATE TABLE PRODUCTS 
(
	PRODUCT_ID INT NOT NULL PRIMARY KEY,
	NAME VARCHAR (70) NOT NULL,
	PRICE NUMERIC (8, 2) NOT NULL,
	DESCR VARCHAR (2000)
)

CREATE TABLE ORDER_ITEMS
(
	ORDER_ID INT NOT NULL,
	PRODUCT_ID INTEGER NOT NULL,
	UNIT_PRICE NUMERIC (8, 2) NOT NULL,
	QUANTITY NUMERIC (8),

	CONSTRAINT PK_OI PRIMARY KEY (ORDER_ID, PRODUCT_ID),
	CONSTRAINT FK_OI_O FOREIGN KEY (ORDER_ID) REFERENCES ORDERS(ORDER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_OI_P FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCTS(PRODUCT_ID)
)


-------------------INSERT---------------------
INSERT INTO REGIONS (NAME)
VALUES ('Източна Европа')

SELECT * FROM REGIONS


INSERT INTO COUNTRIES (COUNTRY_ID, NAME, REGION_ID)
VALUES ('BG', 'България', 1)

SELECT * FROM COUNTRIES

--SELECT * FROM REGIONS JOIN COUNTRIES ON REGIONS.REGION_ID = COUNTRIES.REGION_ID

INSERT INTO CUSTOMERS (CUSTOMER_ID, COUNTRY_ID, FNAME, LNAME, ADDRESS, EMAIL, GENDER)
VALUES (1001, 'BG', 'Мария', 'Милева', 'бул. "България" 100, гр. Пловдив', 'mm@abv.bg', 'F')

SELECT * FROM CUSTOMERS

INSERT INTO JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
VALUES ('SA_REP', 'Търговски представител', 9000, 10000)

SELECT * FROM JOBS

INSERT INTO DEPARTMENTS (DEPARTMENT_ID, NAME, COUNTRY_ID, CITY, STATE, ADDRESS, POSTAL_CODE)
VALUES (80, 'Продажби', 'BG', 'Пловдив', 'Пловдив', 'бул. Марица 10', '4000')

SELECT * FROM DEPARTMENTS

INSERT INTO EMPLOYEES (EMPLOYEE_ID, FNAME, LNAME, EMAIL, PHONE, HIRE_DATE, SALARY, JOB_ID, DEPARTMENT_ID)
VALUES (1501, 'Петър', 'Петров', 'peter@gmail.com', '0897 724 3242', CONVERT(DATE, '19-01-2022', 105), 9000, 'SA_REP', 80)

SELECT * FROM EMPLOYEES

INSERT INTO PRODUCTS (PRODUCT_ID, NAME, PRICE, DESCR)
VALUES (20001, 'FLASH ADATA', 30, 'ADATA 2GB')

SELECT * FROM PRODUCTS

INSERT INTO ORDERS (ORDER_ID, ORDER_DATE, CUSTOMER_ID, EMPLOYEE_ID, SHIP_ADDRESS)
VALUES (1, CONVERT(DATETIME, '20-01-2022 10:00', 105), 1001, 1501, 'гр. Пловдив, бул. Марица 105')

SELECT * FROM ORDERS

INSERT INTO ORDER_ITEMS (ORDER_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY)
VALUES (1, 20001, 29.98, 20)

SELECT * FROM ORDER_ITEMS


--Демо: 
    --Промяна на заплатата на служител с даден идентификатор:

	UPDATE EMPLOYEES
	SET SALARY = 9500
	WHERE EMPLOYEE_ID = 1501
	
	SELECT * FROM EMPLOYEES

--Демо: 
    --Поръчката е анулирана -  изтрий реда и от таблицата ORDERS:
	SELECT * FROM ORDERS
	SELECT * FROM ORDER_ITEMS

	-- ON DELETE CASCADE (тъй като таблиците са свързани)
	DELETE FROM ORDERS 
	WHERE ORDER_ID = 1
 
/* Задачи:
Задача 3-1. 
    Да се изтрият всички редове от всички таблици в базата от данни, след което да
    се въведат данните чрез командите от inserts_mssql.sql файла. */
 
	DELETE FROM PRODUCTS
	DELETE FROM EMPLOYEES
	DELETE FROM DEPARTMENTS
	DELETE FROM JOBS
	DELETE FROM CUSTOMERS
	DELETE FROM COUNTRIES
	DELETE FROM REGIONS
 
/*Задача 3-2. 
    Да се увеличи количеството с 2 броя и да се намали единичната цена с 5% на
    продукт с идентификатор 2254 в поръчка с идентификатор 2354.*/
 
	SELECT *FROM ORDER_ITEMS
	WHERE PRODUCT_ID = 2254 AND ORDER_ID = 2354
	
	UPDATE ORDER_ITEMS
	SET UNIT_PRICE *= 0.95, QUANTITY += 2 
	WHERE PRODUCT_ID = 2254 AND ORDER_ID = 2354

--Задача 3-3.
    --Да се изтрие служител с идентификатор 183.
 
	DELETE FROM EMPLOYEES
	WHERE EMPLOYEE_ID = 183


-------------------------------------------------------------------------------------------
--Пример 4-1. -- Д.Р
    --Да се изведат имената, датите на назначаване и заплатите на всички служители.

	SELECT FNAME, LNAME, HIRE_DATE, SALARY
	FROM EMPLOYEES
 
/*Пример 4-2. -- Д.Р
    Да се изведат всички данни за продуктите, с цена по-голяма от 2000. Резултатът
    нека бъде подреден по цена на продукт възходящо.*/
 
	SELECT * FROM PRODUCTS 
	WHERE PRICE > 2000
	ORDER BY PRICE ASC

--Пример 4-3.
    --Да се изведе броя на всички служители.
	--AGG: COUNT(*), COUNT(COLUMN), SUM(), MAX(), MIN(), AVG() 

	SELECT COUNT (EMPLOYEE_ID) AS [Броя на всички служители]
	FROM EMPLOYEES

--Пример 4-4. -- Д.Р
    --Да се изведе броя служители, групирани по отдела, в който работят.

	SELECT COUNT (EMPLOYEE_ID), DEPARTMENT_ID FROM EMPLOYEES
	GROUP BY DEPARTMENT_ID
 
-------------------------------------------------------------------------------------------
--4.2.1. Задачи
--Задача 4-1. -- Д.Р
    --Да се изведат имената, заплатите и идентификаторите на длъжностите на
    --служителите, работещи в отдели 50 и 80. Резултатът да е подреден по фамилия на служител във възходящ ред.
	
	SELECT FNAME, LNAME, SALARY, JOB_ID, DEPARTMENT_ID
	FROM EMPLOYEES
	WHERE DEPARTMENT_ID = 50 OR DEPARTMENT_ID = 80
	ORDER BY LNAME ASC

	
 
--Задача 4-2. 
    --Да се изведат общата сума на заплатите и броя служители в отдел 60.

	SELECT SUM(SALARY) AS [Сума на заплатите], 
	       COUNT(EMPLOYEE_ID) AS [Броя служители в отдел 60]
	FROM EMPLOYEES 
	WHERE DEPARTMENT_ID = 60
 
--Задача 4-3. 
    --За всички поръчки да се изведат идентификатор на поръчка и обща стойност на
    --поръчката. Резултатът да е подреден по стойност на поръчката в низходящ ред.
 
	SELECT ORDER_ID, SUM(UNIT_PRICE * QUANTITY) AS TOTAL
	FROM ORDER_ITEMS
	GROUP BY ORDER_ID
	ORDER BY TOTAL DESC


--DESC/ASC - низходящ/възходящ ред



--Обхват – BETWEEN, NOT BETWEEN
	SELECT * FROM PRODUCTS
	WHERE PRICE NOT BETWEEN 1 AND 1000
 ------------------------------------------------------
 
--Принадлежност към множество – IN, NOT IN.
	SELECT * FROM CUSTOMERS
	WHERE COUNTRY_ID in ('BG', 'DE')
 ------------------------------------------------------
--Търсене на неизвестни стойности – IS [NOT] NULL.
 
 /*Поле със стойност NULL е празно поле. Това е липса на стойност. Стойността на NULL е различна от 0 или интервал.  
Ако column в таблица е разрешено да сърържа null стойности можете да вмъкнете нов запис или да актуализирате запис, без да добавите стойност в нея. Тогава полето ще бъде запазено с NULL стойност. 
Не е. възможно да се тестват стойности за NULL с оператори за сравнение =, <, <>. Вместо тях използваме операторите IS NULL и IS NOT NULL.
*/
	SELECT * FROM EMPLOYEES
	WHERE MANAGER_ID is not null
 
	SELECT * FROM EMPLOYEES
	WHERE MANAGER_ID is  null
  ------------------------------------------------------
/*Наколко условия за търсене се обединяват с AND или/и OR.
 
Приоритетът на логическите оператори е 
1). NOT
2). AND 
3). OR
Скобите променят приоритета.
*/
 
	SELECT * FROM Customers
	WHERE COUNTRY_ID='BG' AND (GENDER='F' OR LNAME='Петров')
 
---Wildcards [more info: https://www.w3schools.com/sql/sql_wildcards.asp ]
	SELECT * FROM Customers
	WHERE ADDRESS LIKE '%, София%'




--------------------------------Homework----------------------------------------------------
--Пример 4-1. 
    --Да се изведат имената, датите на назначаване и заплатите на всички служители.
 
/*Пример 4-2. 
    Да се изведат всички данни за продуктите, с цена по-голяма от 2000. Резултатът
    нека бъде подреден по цена на продукт възходящо.*/
 
--Пример 4-4. 
    --Да се изведе броя служители, групирани по отдела, в който работят.
 
-------------------------------------------------------------------------------------------
--4.2.1. Задачи
--Задача 4-1. 
    --Да се изведат имената, заплатите и идентификаторите на длъжностите на
    --служителите, работещи в отдели 50 и 80. Резултатът да е подреден по фамилия на служител във възходящ ред.
 
 
-------------------------------------------------------------------------------------------
-------------------------------------Set operators-----------------------------------------
---------------------------------------UNION ----------------------------------------------
/*  Резултатните набори, които се обединяват, трябва да отговарят на следните условия:
        -Всяка заявка в оператора UNION трябва да има еднакъв брой колони;
        -Колоните трябва да имат съвместими типове от данни;
        -В целия израз може да присъства само една клауза ORDER BY накрая, 
        сортираща обединения резултат. 
*/
 
--Пример 4-5. 
    --Да се изведат идентификаторите на държавите, в които има клиенти или отдели на фирмата.

	SELECT COUNTRY_ID FROM CUSTOMERS
	UNION
	SELECT COUNTRY_ID FROM DEPARTMENTS

 
--Пример 4-6. 
    --Да се изведат идентификаторите на държавите, в които има клиенти или отдели на фирмата. 
    --Нека в резултатния набор участват и дублиращите се записи.

	SELECT COUNTRY_ID FROM CUSTOMERS
	UNION ALL
	SELECT COUNTRY_ID FROM DEPARTMENTS
 
 
/*
4.3.1. Задачи
Задача 4-4. 
    Да се изведат всички малки имена на клиенти и служители с евентуалните
    повторения, сортирани в низходящ ред по име. */
 
	SELECT FNAME FROM CUSTOMERS
	UNION ALL
	SELECT FNAME FROM EMPLOYEES
	ORDER BY 1 DESC
	

/*Задача 4-5.
    Да се изведат име и фамилия на клиенти и служители без повторения, а като
    трета колона за клиентите да се използва израз, генериращ низа „Клиент
    (<идентификатор>)“, за служителите – „Служител (<идентификатор>)“. */
 
	SELECT FNAME, LNAME, 'Клиент ('+ COUNTRY_ID +')' FROM CUSTOMERS
	UNION
	SELECT FNAME, LNAME, 'Служител ('+ CAST (DEPARTMENT_ID AS VARCHAR)+')' FROM EMPLOYEES
	ORDER BY 2 DESC
 
----------------------------------INTERSECT(сечение)---------------------------------------
/*резултата съдържа общите за двата резултатни набора редове, без дубликати.
условия:
     -Броят на колоните във всички заявки трябва да бъде еднакъв;
     -Колоните трябва да бъдат от съвместими типове от данни.
 
Пример 4-7. 
    Да се изведат id на държавите, в които има клиенти и отдели на фирмата едновременно.
*/
	
	SELECT COUNTRY_ID FROM CUSTOMERS 
	INTERSECT
	SELECT COUNTRY_ID FROM DEPARTMENTS 

	SELECT DISTINCT COUNTRY_ID FROM CUSTOMERS 
	WHERE COUNTRY_ID IN (SELECT COUNTRY_ID FROM DEPARTMENTS) 

	SELECT DISTINCT COUNTRY_ID FROM CUSTOMERS 
	WHERE COUNTRY_ID = ANY (SELECT COUNTRY_ID FROM DEPARTMENTS) 

	SELECT DISTINCT COUNTRY_ID FROM CUSTOMERS 
	WHERE EXISTS (SELECT * FROM DEPARTMENTS WHERE DEPARTMENTS.COUNTRY_ID = CUSTOMERS.COUNTRY_ID) 

 
--Задача 4-6. 
--  Да се изведат общите собствени имена на клиенти и служители.

	SELECT FNAME FROM CUSTOMERS
	INTERSECT
	SELECT FNAME FROM EMPLOYEES
 
----------------------------------EXCEPT---------------------------------------------------
/*връща редовете, върнати от първата заявка, които не се срещат измежду редове от втората.
условия:
    -Броят на колоните във двете заявки трябва да бъде еднакъв;
    -Колоните трябва да бъдат от съвместими типове от данни. */
 
--Пример 4-8.
--  Изведи id на държавите, в които има клиенти и в същото време няма отдели на фирмата.
 
	SELECT COUNTRY_ID FROM CUSTOMERS
	EXCEPT
	SELECT COUNTRY_ID FROM DEPARTMENTS

	SELECT DISTINCT COUNTRY_ID FROM CUSTOMERS
	WHERE COUNTRY_ID NOT IN(SELECT COUNTRY_ID FROM DEPARTMENTS)

	SELECT DISTINCT COUNTRY_ID FROM CUSTOMERS
	WHERE COUNTRY_ID <> ALL(SELECT COUNTRY_ID FROM DEPARTMENTS)
 
	SELECT DISTINCT COUNTRY_ID FROM CUSTOMERS
	WHERE NOT EXISTS(SELECT * FROM DEPARTMENTS WHERE DEPARTMENTS.DEPARTMENT_ID = CUSTOMERS.COUNTRY_ID)

/*4.5.1. Задачи
Задача 4-7. 
    Да се изведат собствени имена на клиенти, които не се срещат сред тези на служители.*/
 
	SELECT TRIM (FNAME) FROM CUSTOMERS --WHERE FNAME LIKE '%САНДЪР%'
	EXCEPT
	SELECT TRIM (FNAME) FROM EMPLOYEES --WHERE FNAME LIKE '%САНДЪР%'
	
 
-------------------------------------------------------------------------------------------
------------------------------------ JOIN -------------------------------------------------
--JOIN се използва за извличане на данни от две или повече таблици, като редовете им се
--комбинират чрез логическа връзка между таблиците, която може да бъде във FROM или WHERE.
--Обикновено тази връзка е първичен/външен ключ, но не задължително.
 
 
 
-------------------------------------INNER JOIN или просто JOIN-----------------------------
--Извеждат редовете от две/повече таблици, които имат съвпадащи стойности в колоните,
--посочени в условието за сравнение.
 
--Пример 4-10. 
--  Да се изведат държавите и регионите, в които се намират.

	SELECT * FROM COUNTRIES  --29
	SELECT * FROM REGIONS    --6
	SELECT * FROM COUNTRIES JOIN REGIONS ON COUNTRIES.REGION_ID = REGIONS.REGION_ID

	--1 INNER JOIN
	--2 OUTER JOIN
	  --2.1 RIGHT
	  --2.2 LEFT
	  --2.3 FULL
	--3 CROSS JOIN
	
--Пример 4-11.
--  Изведи имена на клиенти, имена на държавите от които са, и имена на регионите на държавите.
 
	SELECT CUSTOMERS.FNAME + '' + CUSTOMERS.LNAME AS Клиент,
	COUNTRIES.NAME AS [Име на държава],
	REGIONS.NAME AS [Име на регион]
	FROM CUSTOMERS JOIN COUNTRIES ON CUSTOMERS.COUNTRY_ID = COUNTRIES.COUNTRY_ID
				   JOIN REGIONS ON COUNTRIES.REGION_ID = REGIONS.REGION_ID


--------------------------------Homework----------------------------------------------------
--Изведи идентификаторите на всички продукти, които не са поръчвани по поне 2 начина
--P.S. без да използваш OUTER JOIN

	--1.
	SELECT PRODUCT_ID FROM PRODUCTS
	EXCEPT
	SELECT PRODUCT_ID FROM ORDER_ITEMS
	
	--2.
	SELECT DISTINCT PRODUCT_ID, NAME
	FROM PRODUCTS
	WHERE PRODUCT_ID NOT IN (SELECT PRODUCT_ID FROM ORDER_ITEMS)

	--3. OUTER JOIN
	SELECT * FROM PRODUCTS P 
	LEFT JOIN ORDER_ITEMS OI
	ON P.PRODUCT_ID = OI.PRODUCT_ID
	WHERE OI.PRODUCT_ID IS NULL
	



-----------------------------------------------------------------------------------------
-------------------------------Видове OUTER JOIN-----------------------------------------
-----------------------------------------------------------------------------------------
 
--Пример 4-12. 
--  Да се изведат регионите и държавите, които се намират в тях. Резултатният
--  набор да включва и регионите, в които няма въведени държави.

	SELECT * FROM REGIONS
	SELECT * FROM COUNTRIES
 
	SELECT * FROM REGIONS R LEFT JOIN COUNTRIES C
	ON C.REGION_ID = R.REGION_ID

	SELECT * FROM COUNTRIES C RIGHT JOIN REGIONS R
	ON C.REGION_ID = R.REGION_ID
 
--Пример 4-13. 
--  Да се изведат държавите и регионите, в които се намират. 
--  Резултатния набор да включва държавите, за които няма въведен регион.
 
	SELECT * FROM REGIONS
	SELECT * FROM COUNTRIES
 
	SELECT * FROM REGIONS R RIGHT JOIN COUNTRIES C
	ON C.REGION_ID = R.REGION_ID

	SELECT * FROM COUNTRIES C LEFT JOIN REGIONS R
	ON C.REGION_ID = R.REGION_ID

 
/*Пример 4-14.
    Да се изведат държавите и регионите, в които се намират. 
    Резултатния набор да включва държавите, за които няма въведен регион и регионите, 
    за които няма въведени държави.*/

	SELECT * FROM COUNTRIES C FULL JOIN REGIONS R
	ON R.REGION_ID = C.REGION_ID
 
 	SELECT FNAME, LNAME 
	FROM CUSTOMERS C JOIN ORDER_ITEMS O
	ON C.CUSTOMER_ID = O.QUANTITY
	ORDER BY QUANTITY ASC
 
-----------------------------------------------------------------------------------------
/*----------------------------4.6.6. Други JOIN вариации---------------------------------
-----------------------------------------------------------------------------------------
 
Пример 4-15. 
    Да се изведат държавите и регионите, в които се намират.*/

	SELECT * FROM REGIONS R JOIN COUNTRIES C
	ON C.REGION_ID = R.REGION_ID
 
/*Пример 4-16.
    Да се изведат отделите, в които има назначени служители.*/
 
	SELECT NAME FROM DEPARTMENTS
	WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM EMPLOYEES)
 
--Пример 4-17.
--  Да се изведат имената на клиентите, които все още не са правили поръчки.
 
	SELECT FNAME, LNAME FROM CUSTOMERS C
	WHERE NOT EXISTS (SELECT * FROM ORDERS O WHERE O.CUSTOMER_ID = C.CUSTOMER_ID)

--Пример 4-18. 
--  Да се изведат комбинациите от всички региони и държави, сортирани по име на държава.
 
	SELECT * FROM REGIONS CROSS JOIN COUNTRIES
	SELECT * FROM REGIONS, COUNTRIES
 
--4.6.7. Задачи 
 
--Задача 4-8. 
--  Извлечи идентификатори, дати на поръчките и имена на служители, които са ги обработили.
 
	SELECT O.ORDER_ID, O.ORDER_DATE, CONCAT (E.FNAME, ' ', E.LNAME) AS СЛУЖИТЕЛ 
	FROM EMPLOYEES E JOIN  ORDERS O 
	ON E.EMPLOYEE_ID = O.EMPLOYEE_ID

--Задача 4-9. --HW
--  Да се изведат имената на всички клиенти и id на поръчките им. 
--  В резултатния набор да участват и клиентите, които все още не са правили поръчки.
 
	SELECT FNAME, LNAME, ORDER_ID 
	FROM CUSTOMERS C LEFT JOIN ORDERS O
	ON C.CUSTOMER_ID = O.CUSTOMER_ID


--Задача 4-11. --HW
--  Да се изведат имената на всички клиенти, които са от държави в регион „Западна Европа“

	SELECT FNAME, LNAME
	FROM CUSTOMERS CU 
	JOIN COUNTRIES CO
	ON CU.COUNTRY_ID = CO.COUNTRY_ID 
	JOIN REGIONS R
	ON CO.REGION_ID = R.REGION_ID
	WHERE R.REGION_ID = '5'

-----------------------------------------------------------------------------------------
---------------------------------4.7.1. TOP ---------------------------------------------
--  TOP връща първите N реда в неопределен ред, за желаната подредба използваме ORDER BY!
-----------------------------------------------------------------------------------------
 
-- Пример 4-19. 
-- 7-те продукта с най-ниска цена.

	SELECT TOP 7 * FROM PRODUCTS
	ORDER BY PRICE
 
--Задача за домашна: --HW
-- Имена, заплата и длъжността на служителите, които работят в отдел 80 и не са обработвали поръчки до момента;

	SELECT COUNT (O.ORDER_ID) AS [ORDERS], E.FNAME, E.LNAME, E.SALARY, E.DEPARTMENT_ID
	FROM EMPLOYEES E
	LEFT JOIN ORDERS O
	ON E.EMPLOYEE_ID = O.EMPLOYEE_ID
	GROUP BY E.FNAME, E.LNAME, E.SALARY, E.DEPARTMENT_ID
	ORDER BY 1



--  Задача 1. 
-- Наименуванията на длъжностите с минимална заплата > 5000.  
-- Сортирай резултатния набор по мин. заплата низходящо.

	SELECT JOB_TITLE, MIN_SALARY
	FROM JOBS
	WHERE (MIN_SALARY > 5000)
	ORDER BY MIN_SALARY DESC
 
--  Задача 2. 
-- Имената на регионите, както и колко държави има в тях.
 
	SELECT R.NAME, COUNT (COUNTRY_ID) FROM REGIONS R JOIN COUNTRIES C
	ON C.REGION_ID = R.REGION_ID
	GROUP BY R.NAME

--  Задача 3. 
-- Извлечи имената и броя поръчки, които са изпълнили служителите, като резултатният 
-- набор да включва всички служители и тези,които все още не са изпълнявали поръчки. 
-- Сортирай по броя на поръчките във възходящ ред.
 
	SELECT FNAME, LNAME, COUNT (ORDER_ID) AS [ORDER_COUNT] FROM EMPLOYEES E LEFT JOIN ORDERS O
	ON E.EMPLOYEE_ID = O.EMPLOYEE_ID
	GROUP BY E.FNAME, E.LNAME
	ORDER BY 3 
 
 
-----------------------------------------------------------------------------------------
--------------------------------- Задачи:  ----------------------------------------------
-----------------------------------------------------------------------------------------
 
    --Зад 0.4
    --Клиентите, които са поръчвали през 2000 година

	SELECT C.FNAME, C.LNAME, O.ORDER_ID, YEAR(ORDER_DATE) AS [YEAR]
	FROM CUSTOMERS C JOIN ORDERS O
	ON C.CUSTOMER_ID = O.CUSTOMER_ID
	WHERE YEAR(ORDER_DATE) = 2000 
 
    --ЗАД 0.5
    --Служителите, които са обработили повече от 5 поръчки
 
	SELECT E.FNAME, E.LNAME, E.EMPLOYEE_ID, COUNT(O.ORDER_ID) AS [ORDERS]
	FROM EMPLOYEES E JOIN ORDERS O
	ON E.EMPLOYEE_ID = O.EMPLOYEE_ID
	GROUP BY E.FNAME, E.LNAME, E.EMPLOYEE_ID
	HAVING COUNT(O.ORDER_ID) > 5
	
 
-----------------------------------------------------------------------------------------
---------------------------------4.7.2. OFFSET и FETCH ----------------------------------
-----------------------------------------------------------------------------------------
 
    /* Пример 4-21. 
   петимата служители, започвайки от 10-ти ред, подредени по дата на постъпване. 
   Първата заявка ще покаже всички за демонстрация, втората ще извърши подбора.
    */

	SELECT * 
	FROM EMPLOYEES
	ORDER BY HIRE_DATE
	OFFSET 9 ROWS
	FETCH NEXT 5 ROWS ONLY


 
 
    /* 4.7.3. Задачи 
   Задача 4-12. 
   вторите 10 най-добре платени служители (подредени по заплата низходящо).
    */

	SELECT * 
	FROM EMPLOYEES
	ORDER BY SALARY DESC
	OFFSET 10 ROWS
	FETCH NEXT 10 ROWS ONLY
	

 
    /* Задача 4-13. --HW
   Да се изведат име, фамилия и пол на клиентите, направили последните 5 поръчки.
    */

	SELECT FNAME, LNAME, GENDER
	FROM CUSTOMERS C JOIN ORDERS O
	ON C.CUSTOMER_ID = O.CUSTOMER_ID
	ORDER BY ORDER_DATE DESC
	OFFSET 0 ROWS
	FETCH NEXT 5 ROWS ONLY

----------------------------------------------------------------------------------------
-----------------------------Изгледи = Views--------------------------------------------
-----------------------------Създаване на изгледи---------------------------------------
 
    --Пример 5-1. 
    --Да се създаде изглед, който съдържа име и фамилия на клиентите, както и
    --номер и дата на поръчките, които те са направили.

	CREATE VIEW MY_FIRST_VIEW 
	AS
	SELECT C.FNAME, + ' ' + C.LNAME AS КЛИЕНТИ,
		O.ORDER_ID, 
		O.ORDER_DATE
	FROM CUSTOMERS C JOIN ORDERS O 
	ON C.CUSTOMER_ID = O.CUSTOMER_ID

	SELECT * FROM MY_FIRST_VIEW
 
-----------------------------Промяна на изгледи-----------------------------------------
    --Пример 5-2. 
    --Да се модифицира горният изглед така, че да съдържа и колона с името на
    --съответния служител, обработил поръчката.

	ALTER VIEW MY_FIRST_VIEW 
	AS
	SELECT C.FNAME, + ' ' + C.LNAME AS КЛИЕНТИ,
		E.FNAME, + ' ' + E.LNAME AS СЛУЖИТЕЛИ,
		O.ORDER_DATE,
		O.ORDER_DATE
	FROM CUSTOMERS C 
	JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID
	JOIN EMPLOYEES E ON E.EMPLOYEE_ID = O.EMPLOYEE_ID

	SELECT * FROM MY_FIRST_VIEW
 
    --Пример 5-3
    -- Да се модифицира горния изглед така, че да съдържа само поръчките,
    --обработени от служител с идентификатор = 167.

	ALTER VIEW MY_FIRST_VIEW 
	AS
	SELECT C.FNAME, + ' ' + C.LNAME AS КЛИЕНТИ,
		E.FNAME, + ' ' + E.LNAME AS СЛУЖИТЕЛИ,
		O.ORDER_DATE,
		O.ORDER_DATE
	FROM CUSTOMERS C 
	JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID
	JOIN EMPLOYEES E ON E.EMPLOYEE_ID = O.EMPLOYEE_ID
	WHERE E.EMPLOYEE_ID = 167
	ORDER BY ORDER_ID
	OFFSET 0 ROWS

	SELECT * FROM MY_FIRST_VIEW
	ORDER BY 1

 
----------------------------------------------------------------------------------------
-----------------------------------HOMEWORK---------------------------------------------
----------------------------------------------------------------------------------------
 
    --ЗАД 0.6
    --Да се създаде изглед, съдържащ информация за служителите, 
    --които са и мениджъри и по колко починени имат.
        
		ALTER VIEW BOSS_EMPLOYEES_COUNT
		AS
		SELECT E1.EMPLOYEE_ID, E1.FNAME, E1.LNAME, COUNT(E2.MANAGER_ID) ПОДЧИНЕНИ 
		FROM EMPLOYEES E1 JOIN EMPLOYEES E2
		ON E1.EMPLOYEE_ID = E2.MANAGER_ID
		GROUP BY E1.EMPLOYEE_ID, E1.FNAME, E1.LNAME
		ORDER BY 4 DESC


    --ЗАД 0.7
    --Да се създаде изглед, съдържащ информация за отделите, в които не работят 
    --никакви служители.

	CREATE VIEW DEPT_WITHOUT_EMPLOYEES
	AS
	SELECT D.* 
	FROM DEPARTMENTS D LEFT JOIN EMPLOYEES E
	ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
	WHERE E.DEPARTMENT_ID IS NULL


	 --Пример 5-4. 
    --Да се създаде изглед, съдържащ име и фамилия на служител и общата сума на
    --поръчките, които той е обработил.

	CREATE VIEW EMPLOYEE_TOTAL
	AS
	SELECT E.FNAME, E.LNAME, SUM(UNIT_PRICE * QUANTITY) TOTAL 
	FROM EMPLOYEES E 
	JOIN ORDERS O
	ON E.EMPLOYEE_ID = O.EMPLOYEE_ID
	JOIN ORDER_ITEMS OI
	ON OI.ORDER_ID = O.ORDER_ID
	GROUP BY E.FNAME, E.LNAME, E.EMPLOYEE_ID

 
    --Пример 5-5. 
    --Да се създаде изглед, който съдържа имена, отдел и заплата на 5-мата
    --служители с най-висока заплата. 
 
	SELECT TOP 5 FNAME, LNAME, DEPARTMENT_ID, SALARY
	FROM EMPLOYEES
	ORDER BY SALARY DESC 


    --------------------------------------------------------------------------
    ------------------5.4.Манипулиране на данни чрез изглед ------------------
    --------------------------------------------------------------------------
    --Пример 5-6.1
    --Създай изглед базиран на JOIN между таблиците COUNTRIES и CUSTOMERS

	CREATE VIEW COUNTRIES_CUSTOMER
	AS
	SELECT CO.COUNTRY_ID AS COUNTRY_COUNTRY_ID, CO.NAME, CO.REGION_ID,
		   CU.CUSTOMER_ID, CU.FNAME, CU.LNAME, CU.GENDER, 
		   CU.COUNTRY_ID AS CUSTOMERS_COUNTRY_ID, CU.EMAIL
	FROM CUSTOMERS CU JOIN COUNTRIES CO
	ON CU.COUNTRY_ID = CO.COUNTRY_ID
	
	SELECT * FROM COUNTRIES_CUSTOMER
 
 
    -----------------5.4.1. Добавяне на данни чрез изглед---------------------
 
    --Пример 5-6.2 
    --Да се добави нов запис в таблицата CUSTOMERS през изгледа от Пр. 5-6.1.
 
	INSERT INTO COUNTRIES_CUSTOMER(CUSTOMER_ID, FNAME, LNAME, GENDER, CUSTOMERS_COUNTRY_ID, EMAIL)
	VALUES (10, 'Мира', 'Тодорова', 'F', 'BG', 'miramira@gmail.com')

	SELECT * FROM COUNTRIES_CUSTOMER
	WHERE CUSTOMER_ID = 10
 
 
    -------------------5.4.2. Променяне на данни през изглед------------------
    
    ---Пример 5-7.
    -- Да се промени фамилията на клиент с идентификатор 10.
 
	UPDATE COUNTRIES_CUSTOMER
	SET LNAME = 'Лукова'
	WHERE CUSTOMER_ID = 10
 
 
    -----------------5.4.3. Изтриване на данни през изглед -------------------    
    --Пример 5-8. 
    --Да се изтрие клиент с идентификатор 10.
 
	DELETE FROM COUNTRIES_CUSTOMER
	WHERE CUSTOMER_ID = 10
	
 
    ----------------5.5.Задачи------------------------------------------------
    
 
    --Задача 5-1. 
    --Да се създаде изглед, който съдържа имената на продуктите и общо поръчано
    --количество от продукт.

	CREATE VIEW PRODUCTS_QUANTITY
	AS
	SELECT P.NAME, COUNT(QUANTITY) AS [КОЛИЧЕСТВО]
	FROM PRODUCTS P JOIN ORDER_ITEMS OI
	ON P.PRODUCT_ID = OI.PRODUCT_ID
	GROUP BY P.NAME, P.PRODUCT_ID
	ORDER BY 2 DESC
	OFFSET 0 ROWS

	SELECT * FROM PRODUCTS_QUANTITY
 
	-------------------------------------------------------------------------------------
	-------------------------------   HOMEWORK   ----------------------------------------
	-------------------------------------------------------------------------------------
 
    --Задача 5-2. 
    --Да се създаде изглед, който съдържа десетимата клиенти с най-голям брой
    --поръчки. Ако последният клиент има равен брой поръчки с други клиенти, 
    --те също да участват в изгледа.

	CREATE VIEW CUSTOMER_QUANTITY
	AS
	SELECT TOP 10 WITH TIES C.FNAME, C.LNAME, COUNT(ORDER_ID) AS [Брой поръчки]
	FROM CUSTOMERS C JOIN ORDERS O
	ON C.CUSTOMER_ID = O.CUSTOMER_ID
	GROUP BY C.FNAME, C.LNAME
	ORDER BY 3 DESC

	SELECT * FROM CUSTOMER_QUANTITY

	--Задача 0.4*
	--Да се създаде изглед с имената на държавите с повече от 5 клиента от тях.

	CREATE VIEW CUSTOMERS_COUNT
	AS
	SELECT CO.NAME, COUNT(CU.COUNTRY_ID) AS Клиенти
	FROM COUNTRIES CO JOIN CUSTOMERS CU
	ON CO.COUNTRY_ID = CU.COUNTRY_ID
	GROUP BY CO.NAME
	HAVING COUNT(CU.COUNTRY_ID) > 5

	SELECT * FROM CUSTOMERS_COUNT



	 --------------------------------------------------------------------------------
    -------------------------------- ТРАНЗАКЦИИ ------------------------------------
    --------------------------------------------------------------------------------
    --6.4.Примери
 
    --Пример 6-1. 
    --Да се създаде транзакция,

	BEGIN TRAN TRAN1

	--1. която добавя нов клиент

	INSERT INTO CUSTOMERS(CUSTOMER_ID, COUNTRY_ID, FNAME, LNAME, ADDRESS, EMAIL, GENDER)
	VALUES(1001, 'BG', 'Мария', 'Илиева', 'гр. Пловдив, бул. В. Априлов', 'mmi@gmail.com', 'F')
	IF @@ERROR <>0 ROLLBACK

	--2. и създава поръчка за него, 

	INSERT INTO ORDERS(CUSTOMER_ID, ORDER_ID, ORDER_DATE, EMPLOYEE_ID, SHIP_ADDRESS)
	VALUES(1001, 1, GETDATE(), 112, 'гр. Пловдив, бул. Марица' )
	IF @@ERROR <>0 ROLLBACK

    --3. 4. включваща два продукта.

	INSERT INTO ORDER_ITEMS(ORDER_ID, PRODUCT_ID, QUANTITY, UNIT_PRICE)
	VALUES(1, 1773, 2, 108)
	IF @@ERROR <>0 ROLLBACK

	INSERT INTO ORDER_ITEMS(ORDER_ID, PRODUCT_ID, QUANTITY, UNIT_PRICE)
	VALUES(1, 1737, 5, 200)
	IF @@ERROR <>0 ROLLBACK

	COMMIT TRAN TRAN1



	BEGIN TRAN TRAN1
	SET XACT_ABORT ON

	--1. която добавя нов клиент

	INSERT INTO CUSTOMERS(CUSTOMER_ID, COUNTRY_ID, FNAME, LNAME, ADDRESS, EMAIL, GENDER)
	VALUES(1002, 'BG', 'Мария', 'Илиева', 'гр. Пловдив, бул. В. Априлов', 'mmi@gmail.com', 'F')

	--2. и създава поръчка за него, 

	INSERT INTO ORDERS(CUSTOMER_ID, ORDER_ID, ORDER_DATE, EMPLOYEE_ID, SHIP_ADDRESS)
	VALUES(1001, 1, GETDATE(), 112, 'гр. Пловдив, бул. Марица')

    --3. 4. включваща два продукта.

	INSERT INTO ORDER_ITEMS(ORDER_ID, PRODUCT_ID, QUANTITY, UNIT_PRICE)
	VALUES(1, 1773, 2, 108)

	INSERT INTO ORDER_ITEMS(ORDER_ID, PRODUCT_ID, QUANTITY, UNIT_PRICE)
	VALUES(1, 1737, 5, 200)

	COMMIT TRAN TRAN1
 
    /*Пример 6-2. 
    Транзакция, която променя фамилията на клиент с идентификатор = 1001, 
    след което отхвърля направените промени.*/

	BEGIN TRAN TRAN2

	-- OPER1
	SELECT C.LNAME FROM CUSTOMERS C
	WHERE C.CUSTOMER_ID = 1001

	-- OPER2
	UPDATE CUSTOMERS
	SET LNAME = 'Георгиева'
	WHERE CUSTOMER_ID = 1001

	-- OPER3
	SELECT C.LNAME FROM CUSTOMERS C
	WHERE C.CUSTOMER_ID = 1001

	ROLLBACK TRAN TRAN2

	-- OPER4
	SELECT C.LNAME FROM CUSTOMERS C
	WHERE C.CUSTOMER_ID = 1001

 
    /*Пример 6-3.
    Транзакция, която въвежда нов клиент, поставя точка на запис,
    въвежда поръчка, след което отхвърля промените до точката на запис, т.е.
    отхвърля се само поръчката.*/

	BEGIN TRAN TRAN3

	INSERT INTO CUSTOMERS(CUSTOMER_ID, COUNTRY_ID, FNAME, LNAME, ADDRESS, EMAIL, GENDER)
	VALUES(1003, 'BG', 'Мартин', 'Илиев', 'гр. Пловдив, бул. В. Априлов', 'mmii@gmail.com', 'M')

	SAVE TRAN POINT1
		
	INSERT INTO ORDERS(CUSTOMER_ID, ORDER_ID, ORDER_DATE, EMPLOYEE_ID, SHIP_ADDRESS)
	VALUES(1003, 2, GETDATE(), 112, 'гр. Пловдив, бул. Марица')

	ROLLBACK TRAN POINT1
	COMMIT TRAN TRAN3

 
    /*Задача 6-1. 
    Транзакция, която има за цел да изтрие отдел „Мениджмънт“ 90,
    като преди това прехвърли всички служители от него в отдел „Администрация“ 10.*/

	BEGIN TRAN TRAN4 

	UPDATE EMPLOYEES 
	SET DEPARTMENT_ID = 10
	WHERE DEPARTMENT_ID = 90

	DELETE FROM DEPARTMENTS
	WHERE DEPARTMENT_ID = 90

	COMMIT TRAN TRAN4

    -------------------------------------------------------------------------------------
    ---------------------------------- ПРОЦЕДУРИ ----------------------------------------
    -------------------------------------------------------------------------------------
 
    --Пример 7-2. 
    --Да се създаде процедура, която за подадена като входен параметър идентификатор на 
    --поръчка извежда имена на служител, който я е обработил, както и общата й стойност.


	CREATE PROC EMP_ORDS @ORDERS INT
	AS
	SELECT FNAME, LNAME, O.ORDER_ID, SUM(OI.UNIT_PRICE * OI.QUANTITY) AS TOTAL 
	FROM EMPLOYEES E 
	JOIN ORDERS O 
	ON E.EMPLOYEE_ID = O.EMPLOYEE_ID
	JOIN ORDER_ITEMS OI
	ON OI.ORDER_ID = O.ORDER_ID
	WHERE @ORDERS = O.ORDER_ID
	GROUP BY FNAME, LNAME, O.ORDER_ID

	EXEC EMP_ORDS @ORDERS = 2444

 
    -------------------------------------------------------------------------------------
    ---------------------------------- ФУНКЦИИ ------------------------------------------
    -----1.--Скаларни -------------------------------------------------------------------
 
    --Пример 7-4. 
    --Да се създаде функция, връщаща като скаларна стойност текст, съдържащ името на 
    --отдел (подаден като параметър) и обща стойност на заплатите в него.
 
    -----2.-- Функции, връщащи резултатен набор------------------------------------------
 
    --Пример 7-5.
    --Да се създаде функция, връщаща като резултат служителите с техните длъжности.
	
	CREATE FUNCTION EMPLO_JOBS() RETURNS TABLE
	AS
	RETURN
	SELECT FNAME, LNAME, JOB_TITLE 
	FROM EMPLOYEES E JOIN JOBS J
	ON E.JOB_ID = J.JOB_ID
	ORDER BY FNAME

	SELECT * FROM DBO.EMPLO_JOBS()

 
    -------------------------------------------------------------------------------------
    ----------------------------------- КУРСОРИ -----------------------------------------
    -------------------------------------------------------------------------------------
 
    /*Пример 8-1.
    Да се създаде курсор, който демонстрира прочитане на данни ред по ред от 
    курсор. Резултатният набор за целта ще съдържа всички клиенти от Германия. 
    Стъпките от жизнения цикъл са обозначени в коментари.*/
 
    -------------------------------------------------------------------------------------
    ----------------------------- Тригери -----------------------------------------------
    -------------------------------------------------------------------------------------
    /*Задача 9-1. 
    Да се създаде тригер, който при всяка промяна на фамилия на клиент
    записва ред в нова таблица CUSTOMERS_HIST с атрибути:
    • идентификатор на клиент;
    • стара фамилия;
    • нова фамилия.*/




 
    --Задача 0.5* --HW
    --Да се създаде транзакция, която променя фамилията на служител с 
    --идентификатор 103 на 'Гочева', променя фамилията на служител с 
    --идентификатор 114 на 'Петрова', както и фамилията на служител с 
    --идентификатор 118 на 'Маринова'. 
    --Нека след това извлече в резултат имe и фамилия само за горепосочените 
    --променени служители. Като промените от транзакцията останат постоянни.
 

 	BEGIN TRAN TRAN4

	UPDATE EMPLOYEES
	SET LNAME = 'Гочева'
	WHERE EMPLOYEE_ID = 103

	UPDATE EMPLOYEES
	SET LNAME = 'Петрова'
	WHERE EMPLOYEE_ID = 114

	UPDATE EMPLOYEES
	SET LNAME = 'Маринова'
	WHERE EMPLOYEE_ID = 118

	COMMIT TRAN TRAN4

	SELECT E.FNAME, E.LNAME FROM EMPLOYEES E
	WHERE E.EMPLOYEE_ID IN (103, 114, 118)


	 /*Задача 6-2. --HW
    Транзакция, която изтрива продукт 1726 - първо го изтрива от всички поръчки 
    после от таблицата с продукти, и накрая отхвърля направените промени.*/

 	BEGIN TRAN TRAN5

	DELETE FROM ORDERS
	WHERE ORDER_ID = 1726

	DELETE FROM PRODUCTS
	WHERE PRODUCT_ID = 1726

	ROLLBACK TRAN TRAN5




































	-------------------  Задачи за препитване и самопрепитване --------------------------
        --ЗАД 1.
        --Изведи клиентите, които са поръчали само веднъж сортирани по малко име във възходящ ред.

		SELECT C.FNAME, C.LNAME, COUNT(O.ORDER_ID) AS [ORDERS]
		FROM CUSTOMERS C JOIN ORDERS O
		ON C.CUSTOMER_ID = O.CUSTOMER_ID
		GROUP BY C.FNAME, C.LNAME 
		HAVING COUNT(O.ORDER_ID) = 1
		ORDER BY 2
 
        --ЗАД 2.
        --Изведи минималната заплата на длъжностите, в които има назначени повече от 10 служителя.

		SELECT J.JOB_TITLE ,J.MIN_SALARY, COUNT(E.EMPLOYEE_ID) AS [EMPLOYEES]
		FROM JOBS J JOIN EMPLOYEES E
		ON J.JOB_ID = E.JOB_ID
		GROUP BY J.JOB_TITLE ,J.MIN_SALARY 
		HAVING COUNT(E.EMPLOYEE_ID) > 10
		
        --ЗАД 3.
        --Изведи длъжностите, на които няма назначени служители.

		SELECT J.JOB_ID, J.JOB_TITLE, COUNT (E.JOB_ID) AS [FREE_EMPLOYEES]
		FROM EMPLOYEES E RIGHT JOIN JOBS J
		ON E.JOB_ID = J.JOB_ID
		GROUP BY J.JOB_ID, J.JOB_TITLE
		HAVING COUNT (E.JOB_ID) = 0

        --ЗАД 4.
        --В кой град се намира отдела, чийто служители получават най-голяма средна заплата.

		SELECT TOP 1 D.CITY, E.DEPARTMENT_ID, AVG(E.SALARY) AS [AVERAGE_SALARY]
		FROM DEPARTMENTS D JOIN EMPLOYEES E
		ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
		GROUP BY D.CITY, E.DEPARTMENT_ID
		ORDER BY 3 DESC
		


  -----------------------------------------------------------------------------------------
  ----------------------------------ПРЕПИТКА 3---------------------------------------------
  -----------------------------------------------------------------------------------------
 
    --ЗАДАЧА 3.1
    --Създай изглед с име, фамилия, телефон и наименование на длъжност на служителите, 
    --които работят в отдел 100.

	CREATE VIEW EMPLOYEES_DEPART_100
	AS
	SELECT FNAME, LNAME, PHONE, J.JOB_ID
	FROM EMPLOYEES E JOIN JOBS J
	ON E.JOB_ID = J.JOB_ID
	WHERE DEPARTMENT_ID = 100
 
	SELECT * FROM EMPLOYEES_DEPART_100
 
    --ЗАДАЧА 3.2
    --Модифицирай горния изглед като конкатенираш в една колона име и фамилия на служител,
    --и добавиш колони заплата на служителя и идентификатор на мениджъра му.

	ALTER VIEW EMPLOYEES_DEPART_100
	AS
	SELECT FNAME + ' ' + LNAME AS ИМЕНА, 
		   PHONE, 
		   JOB_ID, 
		   SALARY, 
		   MANAGER_ID
	FROM EMPLOYEES
	WHERE DEPARTMENT_ID = 100

	SELECT * FROM EMPLOYEES_DEPART_100
 
    --ЗАДАЧА 3.3
    --Създай изглед върху изгледа от ЗАДАЧА 3.2 като в резултатния набор включиш само
    --колоните: имена на служителя и идентификатор на мениджъра му.

	CREATE VIEW EMP_DEPARTMENT
	AS
	SELECT ИМЕНА, MANAGER_ID
	FROM EMPLOYEES_DEPART_100
 
	SELECT * FROM EMP_DEPARTMENT
 
    --ЗАДАЧА 3.4
    --Създай изглед с имената на регионите и броя на държавите в тях.

	CREATE VIEW COUNTRIES_COUNT
	AS
	SELECT R.NAME, 
		   COUNT(C.REGION_ID) AS [БРОЙ ДЪРЖАВИ]
	FROM REGIONS R JOIN COUNTRIES C
	ON R.REGION_ID = C.REGION_ID
	GROUP BY R.NAME

	SELECT * FROM COUNTRIES_COUNT



	-- Примерно контролно по БД

	-- 1. Създаване на обектите от схемата. 

	CREATE TABLE PIZZAS 
	(
		PIZZA_ID INT NOT NULL PRIMARY KEY,
		PIZZA_TYPE VARCHAR(20) NOT NULL
	)


	CREATE TABLE CLIENTS 
	(
		CLIENT_ID INT NOT NULL PRIMARY KEY,
		NAME VARCHAR(30) NOT NULL,
		PHONE VARCHAR(10) NOT NULL
	)

	CREATE TABLE PIZZA_ORDERS
	(
		PIZZA_ID INT NOT NULL,
		CLIENT_ID INT NOT NULL,
		QUIANTITY INT NOT NULL,
		SIZE CHAR (1) NOT NULL CHECK (SIZE IN('S','B')),
		DATETIME DATETIME NOT NULL
	)


	ALTER TABLE PIZZA_ORDERS
	ADD CONSTRAINT FK_PIZZA_ID FOREIGN KEY (PIZZA_ID) REFERENCES PIZZAS(PIZZA_ID);

	ALTER TABLE PIZZA_ORDERS
	ADD CONSTRAINT FK_CLIENT_ID FOREIGN KEY (CLIENT_ID) REFERENCES CLIENTS(CLIENT_ID);


	-- 2. Добавяне на атрибут PRICE от тип decimal(5,2) за цена в таблица PIZZA_ORDERS с ограничение на 
	-- стойностите само положителни числа.

	ALTER TABLE PIZZA_ORDERS
	ADD PRICE DECIMAL(5,2) NOT NULL
	CHECK (PRICE > 0)

	-- 3. Изтрий атрибут PHONE от таблица CLIENTS.

	ALTER TABLE CLIENTS
	DROP COLUMN PHONE

	-- 4. Добавяне по един запис с произволни данни във всяка таблица. (или повече)

	INSERT INTO PIZZAS (PIZZA_ID, PIZZA_TYPE)
	VALUES(1, 'kaprichoza'),
		  (2, 'margarita'),  
		  (3, '4-madji')


	INSERT INTO CLIENTS (CLIENT_ID, NAME)
	VALUES(100, 'Ivan'), 
		  (101, 'Petar'),
		  (102, 'Georgi')


	INSERT INTO PIZZA_ORDERS (PIZZA_ID, CLIENT_ID, QUIANTITY, SIZE, DATETIME, PRICE)
	VALUES(1, 100, 2, 'S', GETDATE(), 10), 
		  (1, 101, 1, 'B', CONVERT(DATETIME, '02-03-2022', 105), 3),
		  (2, 101, 2, 'S', CONVERT(DATETIME, '01-03-2022', 105), 2),
		  (3, 102, 1, 'B', CONVERT(DATETIME, '01-03-2022', 105), 10)


	-- 5. Промени количеството поръчана пица на 5 и размера на малка за 
	-- първият въведен идентификатор на пица

	UPDATE PIZZA_ORDERS
	SET QUIANTITY = 5, SIZE = 'S'
	WHERE PIZZA_ID = 1

	-- 6. Вече не се предлага пица с последният идентификатор, който сте попълнили – изтрийте я.

	DELETE FROM PIZZA_ORDERS
	WHERE PIZZA_ID = 5

	DELETE FROM PIZZAS
	WHERE PIZZA_ID = 5

	-- 7. Изведи от името на кои клиенти и кога са направени поръчки на малки пици. 
	-- Подреди ги по име на клиент в низходящ ред.	SELECT C.NAME, PO.DATETIME, PO.SIZE	FROM CLIENTS C JOIN PIZZA_ORDERS PO	ON C.CLIENT_ID = PO.CLIENT_ID	WHERE PO.SIZE = 'S'	ORDER BY C.NAME DESC
	-- 8. Добави нов клиент, без да добавяш поръчка за него.

	INSERT INTO CLIENTS (CLIENT_ID, NAME)
	VALUES(105, 'Nikolai')

	-- 9. Изведи имената на клиентите и колко пъти са поръчвали пица. 
	-- В резултатния набор да се покажат и клиентите без поръчка.

	SELECT C.NAME, COUNT(PO.PIZZA_ID) AS ORDERED_PIZZAS	FROM CLIENTS C LEFT JOIN PIZZA_ORDERS PO	ON C.CLIENT_ID = PO.CLIENT_ID	GROUP BY C.NAME	-- 10. Изведи типа и броя на поръчвани пици. Само ако са поръчвани в повече от една поръчки.
	SELECT P.PIZZA_TYPE, COUNT(PO.PIZZA_ID) AS PIZZA_COUNT	FROM PIZZAS P JOIN PIZZA_ORDERS PO	ON P.PIZZA_ID = PO.PIZZA_ID	GROUP BY P.PIZZA_TYPE, P.PIZZA_ID
	HAVING COUNT (PO.PIZZA_ID) > 1

	-- 11. Създай изглед за типа на пиците и сумарната им стойност в поръчка

	CREATE VIEW TOTAL_PIZZA
	AS
	SELECT P.PIZZA_TYPE, SUM(PO.QUIANTITY * PRICE) AS TOTAL	FROM PIZZAS P JOIN PIZZA_ORDERS PO	ON P.PIZZA_ID = PO.PIZZA_ID	GROUP BY P.PIZZA_TYPE, PO.PIZZA_ID

	SELECT * FROM TOTAL_PIZZA



	-- 1. Създаване на обектите от схемата. 

	CREATE TABLE FLOWERS 
	(
		FLOWER_ID INT NOT NULL PRIMARY KEY,
		FLOWER_TYPE VARCHAR(20) NOT NULL
	)


	CREATE TABLE PEOPLE 
	(
		PERSON_ID INT NOT NULL PRIMARY KEY,
		NAME VARCHAR(30) NOT NULL,
	)

	CREATE TABLE PEOPLE_FLOWERS
	(
		FLOWER_ID INT NOT NULL,
		PERSON_ID INT NOT NULL,
		UNIT_PRICE DECIMAL(6,2) NOT NULL
	)


	ALTER TABLE PEOPLE_FLOWERS
	ADD CONSTRAINT FK_FLOWER_ID FOREIGN KEY (FLOWER_ID) REFERENCES FLOWERS(FLOWER_ID);

	ALTER TABLE PEOPLE_FLOWERS
	ADD CONSTRAINT FK_PERSON_ID FOREIGN KEY (PERSON_ID) REFERENCES PEOPLE(PERSON_ID);


	-- 2. Добавяне на атрибут QUANTITY за количество, съдържащ данни от целочислен тип и ОГРАНИЧЕНИЕ
    -- на възможните стойности САМО ПОЛОЖИТЕЛНИ ЧИСЛА в PEOPLE_FLOWERS.

	ALTER TABLE PEOPLE_FLOWERS
	ADD QUANTITY INT NOT NULL
	CHECK (QUANTITY > 0)

	-- 3. Добавяне по един запис с произволни данни във всяка таблица. (повече)


	INSERT INTO FLOWERS(FLOWER_ID, FLOWER_TYPE)
	VALUES(1, 'roza'),
		  (2, 'lale'),  
		  (3, 'minzuhar'),
		  (4, 'kokiche')


	INSERT INTO PEOPLE(PERSON_ID, NAME)
	VALUES(100, 'Ivana'), 
		  (101, 'Maria'),
		  (102, 'Aleksandra')


	INSERT INTO PEOPLE_FLOWERS(FLOWER_ID, PERSON_ID, UNIT_PRICE, QUANTITY)
	VALUES(1, 100, 5, 4), 
		  (1, 100, 4, 3),
		  (2, 101, 2, 6),
		  (3, 102, 3, 1),
		  (3, 102, 3, 1)


	-- 4. Вече не се предлага цветето с първия добавен идентификатор - изтрий го.
	
	DELETE FROM PEOPLE_FLOWERS
	WHERE FLOWER_ID = 1

	DELETE FROM FLOWERS
	WHERE FLOWER_ID = 1

	-- 5. Извличане на типа на цветята и идентификаторите на купувачите им, подредени по типа на
	-- цветята в низходящ ред.

	SELECT F.FLOWER_TYPE, PF.PERSON_ID 
	FROM FLOWERS F JOIN PEOPLE_FLOWERS PF
	ON F.FLOWER_ID = PF.FLOWER_ID	
	ORDER BY F.FLOWER_TYPE DESC

	-- 6. Извличане на типа на цветята и колко пъти е продадено дадено цвете. В резултатния набор
	-- да участват и цветя, които все ОЩЕ НЕ са закупени.

	SELECT F.FLOWER_TYPE, COUNT(PF.FLOWER_ID) AS FLOWER_SELLS	FROM FLOWERS F LEFT JOIN PEOPLE_FLOWERS PF	ON F.FLOWER_ID = PF.FLOWER_ID	GROUP BY F.FLOWER_TYPE, F.FLOWER_ID

	-- 7. Създаване на ИЗГЛЕД, който съдържа типа на продадените цветя и сумарната им стойност.
	-- Изведи само тези цветя, чиито сумарна стойност е над 10.

	CREATE VIEW TOTAL_FLOWERS
	AS
	SELECT F.FLOWER_TYPE, COUNT(PF.UNIT_PRICE) AS TOTAL
	FROM FLOWERS F JOIN PEOPLE_FLOWERS PF
	ON F.FLOWER_ID = PF.FLOWER_ID
	GROUP BY F.FLOWER_TYPE, F.FLOWER_ID
	HAVING COUNT(PF.UNIT_PRICE) > 10

	SELECT * FROM TOTAL_FLOWERS




	











CREATE TABLE Buildingb (
    building_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(20) NOT NULL,
    address VARCHAR(50) NOT NULL,
	height VARCHAR(50) NOT NULL
);


CREATE TABLE Roomrr (
    room_id INT PRIMARY KEY IDENTITY(1,1),
	type VARCHAR(50) NOT NULL,
	size VARCHAR(50) NOT NULL,
	color VARCHAR(50) NOT NULL,

);



	SELECT b.name, r.type, r.size, r.color
	FROM Buildingb B JOIN Roomr R
	ON B.building_id = R.room_id



	

	
INSERT INTO Buildingb (name,address,height)
VALUES('Apple', '7000,Cupertino', '200')


INSERT INTO Roomr(type,size,color)
VALUES('Amazon', '200x200', 'white')


	

CREATE TABLE Levelll (
    levels_id INT PRIMARY KEY IDENTITY(1,1),
    building_name INT NOT NULL,
    room_type INT NOT NULL,
	price decimal(10,2) NOT NULL,
);


ALTER TABLE Pricee
ADD CONSTRAINT FK_Building FOREIGN KEY (building_name) REFERENCES Buildingbb(building_id);

ALTER TABLE Pricee
ADD CONSTRAINT FK_Room FOREIGN KEY (room_type) REFERENCES Roomrr(room_id);

INSERT INTO Building (building_name,address)
VALUES('ACME Headquaters','3950 North 1st Street CA 95134'),
      ('ACME Sales','5000 North 1st Street CA 95134');


INSERT INTO Room(room_name,building_no)
VALUES('Amazon',3),
      ('War Room',3),
      ('Office of CEO',3),
      ('Marketing',3),
      ('Showroom',4);


INSERT INTO Level(levelsN,building_no)
VALUES('222',3),
      ('War Room',4),
      ('Office of CEO',4),
      ('Marketing',4),
      ('Showroom',4);



DELETE FROM Level 
WHERE levels_no = 1;


DELETE FROM Building 
WHERE building_no = 1;


SELECT building_name, levelsN
FROM Building, Level
WHERE
Building.building_no = Level.building_no;
