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
VALUES('100', '���� ������', '089527342')

--2)
INSERT INTO STUDENTS
VALUES('101', '���� ������', '089527342', NULL)

--3)
INSERT INTO STUDENTS
VALUES('102', '����� ������', '089382342', 'F'), 
      ('103', '���� ������', '089527342', 'F'),
	  ('104', '������ ��������', '089527342', DEFAULT),
	  ('105', '���� ��������', NULL, 'F')


SELECT * FROM STUDENTS
	  
--UPDATE
UPDATE STUDENTS
SET NAME = NAME + '-�������'
WHERE F_NUM = '105'

UPDATE STUDENTS
SET NAME = NAME + '-�������'
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
VALUES ('������� ������')

SELECT * FROM REGIONS


INSERT INTO COUNTRIES (COUNTRY_ID, NAME, REGION_ID)
VALUES ('BG', '��������', 1)

SELECT * FROM COUNTRIES

--SELECT * FROM REGIONS JOIN COUNTRIES ON REGIONS.REGION_ID = COUNTRIES.REGION_ID

INSERT INTO CUSTOMERS (CUSTOMER_ID, COUNTRY_ID, FNAME, LNAME, ADDRESS, EMAIL, GENDER)
VALUES (1001, 'BG', '�����', '������', '���. "��������" 100, ��. �������', 'mm@abv.bg', 'F')

SELECT * FROM CUSTOMERS

INSERT INTO JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
VALUES ('SA_REP', '��������� ������������', 9000, 10000)

SELECT * FROM JOBS

INSERT INTO DEPARTMENTS (DEPARTMENT_ID, NAME, COUNTRY_ID, CITY, STATE, ADDRESS, POSTAL_CODE)
VALUES (80, '��������', 'BG', '�������', '�������', '���. ������ 10', '4000')

SELECT * FROM DEPARTMENTS

INSERT INTO EMPLOYEES (EMPLOYEE_ID, FNAME, LNAME, EMAIL, PHONE, HIRE_DATE, SALARY, JOB_ID, DEPARTMENT_ID)
VALUES (1501, '�����', '������', 'peter@gmail.com', '0897 724 3242', CONVERT(DATE, '19-01-2022', 105), 9000, 'SA_REP', 80)

SELECT * FROM EMPLOYEES

INSERT INTO PRODUCTS (PRODUCT_ID, NAME, PRICE, DESCR)
VALUES (20001, 'FLASH ADATA', 30, 'ADATA 2GB')

SELECT * FROM PRODUCTS

INSERT INTO ORDERS (ORDER_ID, ORDER_DATE, CUSTOMER_ID, EMPLOYEE_ID, SHIP_ADDRESS)
VALUES (1, CONVERT(DATETIME, '20-01-2022 10:00', 105), 1001, 1501, '��. �������, ���. ������ 105')

SELECT * FROM ORDERS

INSERT INTO ORDER_ITEMS (ORDER_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY)
VALUES (1, 20001, 29.98, 20)

SELECT * FROM ORDER_ITEMS


--����: 
    --������� �� ��������� �� �������� � ����� �������������:

	UPDATE EMPLOYEES
	SET SALARY = 9500
	WHERE EMPLOYEE_ID = 1501
	
	SELECT * FROM EMPLOYEES

--����: 
    --��������� � ��������� -  ������ ���� � �� ��������� ORDERS:
	SELECT * FROM ORDERS
	SELECT * FROM ORDER_ITEMS

	-- ON DELETE CASCADE (��� ���� ��������� �� ��������)
	DELETE FROM ORDERS 
	WHERE ORDER_ID = 1
 
/* ������:
������ 3-1. 
    �� �� ������� ������ ������ �� ������ ������� � ������ �� �����, ���� ����� ��
    �� ������� ������� ���� ��������� �� inserts_mssql.sql �����. */
 
	DELETE FROM PRODUCTS
	DELETE FROM EMPLOYEES
	DELETE FROM DEPARTMENTS
	DELETE FROM JOBS
	DELETE FROM CUSTOMERS
	DELETE FROM COUNTRIES
	DELETE FROM REGIONS
 
/*������ 3-2. 
    �� �� ������� ������������ � 2 ���� � �� �� ������ ���������� ���� � 5% ��
    ������� � ������������� 2254 � ������� � ������������� 2354.*/
 
	SELECT *FROM ORDER_ITEMS
	WHERE PRODUCT_ID = 2254 AND ORDER_ID = 2354
	
	UPDATE ORDER_ITEMS
	SET UNIT_PRICE *= 0.95, QUANTITY += 2 
	WHERE PRODUCT_ID = 2254 AND ORDER_ID = 2354

--������ 3-3.
    --�� �� ������ �������� � ������������� 183.
 
	DELETE FROM EMPLOYEES
	WHERE EMPLOYEE_ID = 183


-------------------------------------------------------------------------------------------
--������ 4-1. -- �.�
    --�� �� ������� �������, ������ �� ����������� � ��������� �� ������ ���������.

	SELECT FNAME, LNAME, HIRE_DATE, SALARY
	FROM EMPLOYEES
 
/*������ 4-2. -- �.�
    �� �� ������� ������ ����� �� ����������, � ���� ��-������ �� 2000. ����������
    ���� ���� �������� �� ���� �� ������� ���������.*/
 
	SELECT * FROM PRODUCTS 
	WHERE PRICE > 2000
	ORDER BY PRICE ASC

--������ 4-3.
    --�� �� ������ ���� �� ������ ���������.
	--AGG: COUNT(*), COUNT(COLUMN), SUM(), MAX(), MIN(), AVG() 

	SELECT COUNT (EMPLOYEE_ID) AS [���� �� ������ ���������]
	FROM EMPLOYEES

--������ 4-4. -- �.�
    --�� �� ������ ���� ���������, ��������� �� ������, � ����� �������.

	SELECT COUNT (EMPLOYEE_ID), DEPARTMENT_ID FROM EMPLOYEES
	GROUP BY DEPARTMENT_ID
 
-------------------------------------------------------------------------------------------
--4.2.1. ������
--������ 4-1. -- �.�
    --�� �� ������� �������, ��������� � ���������������� �� ����������� ��
    --�����������, �������� � ������ 50 � 80. ���������� �� � �������� �� ������� �� �������� ��� �������� ���.
	
	SELECT FNAME, LNAME, SALARY, JOB_ID, DEPARTMENT_ID
	FROM EMPLOYEES
	WHERE DEPARTMENT_ID = 50 OR DEPARTMENT_ID = 80
	ORDER BY LNAME ASC

	
 
--������ 4-2. 
    --�� �� ������� ������ ���� �� ��������� � ���� ��������� � ����� 60.

	SELECT SUM(SALARY) AS [���� �� ���������], 
	       COUNT(EMPLOYEE_ID) AS [���� ��������� � ����� 60]
	FROM EMPLOYEES 
	WHERE DEPARTMENT_ID = 60
 
--������ 4-3. 
    --�� ������ ������� �� �� ������� ������������� �� ������� � ���� �������� ��
    --���������. ���������� �� � �������� �� �������� �� ��������� � �������� ���.
 
	SELECT ORDER_ID, SUM(UNIT_PRICE * QUANTITY) AS TOTAL
	FROM ORDER_ITEMS
	GROUP BY ORDER_ID
	ORDER BY TOTAL DESC


--DESC/ASC - ��������/�������� ���



--������ � BETWEEN, NOT BETWEEN
	SELECT * FROM PRODUCTS
	WHERE PRICE NOT BETWEEN 1 AND 1000
 ------------------------------------------------------
 
--������������� ��� ��������� � IN, NOT IN.
	SELECT * FROM CUSTOMERS
	WHERE COUNTRY_ID in ('BG', 'DE')
 ------------------------------------------------------
--������� �� ���������� ��������� � IS [NOT] NULL.
 
 /*���� ��� �������� NULL � ������ ����. ���� � ����� �� ��������. ���������� �� NULL � �������� �� 0 ��� ��������.  
��� column � ������� � ��������� �� ������� null ��������� ������ �� �������� ��� ����� ��� �� ������������� �����, ��� �� �������� �������� � ���. ������ ������ �� ���� �������� � NULL ��������. 
�� �. �������� �� �� ������� ��������� �� NULL � ��������� �� ��������� =, <, <>. ������ ��� ���������� ����������� IS NULL � IS NOT NULL.
*/
	SELECT * FROM EMPLOYEES
	WHERE MANAGER_ID is not null
 
	SELECT * FROM EMPLOYEES
	WHERE MANAGER_ID is  null
  ------------------------------------------------------
/*������� ������� �� ������� �� ���������� � AND ���/� OR.
 
����������� �� ����������� ��������� � 
1). NOT
2). AND 
3). OR
������� �������� ����������.
*/
 
	SELECT * FROM Customers
	WHERE COUNTRY_ID='BG' AND (GENDER='F' OR LNAME='������')
 
---Wildcards [more info: https://www.w3schools.com/sql/sql_wildcards.asp ]
	SELECT * FROM Customers
	WHERE ADDRESS LIKE '%, �����%'




--------------------------------Homework----------------------------------------------------
--������ 4-1. 
    --�� �� ������� �������, ������ �� ����������� � ��������� �� ������ ���������.
 
/*������ 4-2. 
    �� �� ������� ������ ����� �� ����������, � ���� ��-������ �� 2000. ����������
    ���� ���� �������� �� ���� �� ������� ���������.*/
 
--������ 4-4. 
    --�� �� ������ ���� ���������, ��������� �� ������, � ����� �������.
 
-------------------------------------------------------------------------------------------
--4.2.1. ������
--������ 4-1. 
    --�� �� ������� �������, ��������� � ���������������� �� ����������� ��
    --�����������, �������� � ������ 50 � 80. ���������� �� � �������� �� ������� �� �������� ��� �������� ���.
 
 
-------------------------------------------------------------------------------------------
-------------------------------------Set operators-----------------------------------------
---------------------------------------UNION ----------------------------------------------
/*  ������������ ������, ����� �� ����������, ������ �� ��������� �� �������� �������:
        -����� ������ � ��������� UNION ������ �� ��� ������� ���� ������;
        -�������� ������ �� ���� ���������� ������ �� �����;
        -� ����� ����� ���� �� ��������� ���� ���� ������ ORDER BY ������, 
        ��������� ���������� ��������. 
*/
 
--������ 4-5. 
    --�� �� ������� ���������������� �� ���������, � ����� ��� ������� ��� ������ �� �������.

	SELECT COUNTRY_ID FROM CUSTOMERS
	UNION
	SELECT COUNTRY_ID FROM DEPARTMENTS

 
--������ 4-6. 
    --�� �� ������� ���������������� �� ���������, � ����� ��� ������� ��� ������ �� �������. 
    --���� � ����������� ����� �������� � ����������� �� ������.

	SELECT COUNTRY_ID FROM CUSTOMERS
	UNION ALL
	SELECT COUNTRY_ID FROM DEPARTMENTS
 
 
/*
4.3.1. ������
������ 4-4. 
    �� �� ������� ������ ����� ����� �� ������� � ��������� � ������������
    ����������, ��������� � �������� ��� �� ���. */
 
	SELECT FNAME FROM CUSTOMERS
	UNION ALL
	SELECT FNAME FROM EMPLOYEES
	ORDER BY 1 DESC
	

/*������ 4-5.
    �� �� ������� ��� � ������� �� ������� � ��������� ��� ����������, � ����
    ����� ������ �� ��������� �� �� �������� �����, ��������� ���� �������
    (<�������������>)�, �� ����������� � ��������� (<�������������>)�. */
 
	SELECT FNAME, LNAME, '������ ('+ COUNTRY_ID +')' FROM CUSTOMERS
	UNION
	SELECT FNAME, LNAME, '�������� ('+ CAST (DEPARTMENT_ID AS VARCHAR)+')' FROM EMPLOYEES
	ORDER BY 2 DESC
 
----------------------------------INTERSECT(�������)---------------------------------------
/*��������� ������� ������ �� ����� ���������� ������ ������, ��� ���������.
�������:
     -����� �� �������� ��� ������ ������ ������ �� ���� �������;
     -�������� ������ �� ����� �� ���������� ������ �� �����.
 
������ 4-7. 
    �� �� ������� id �� ���������, � ����� ��� ������� � ������ �� ������� ������������.
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

 
--������ 4-6. 
--  �� �� ������� ������ ��������� ����� �� ������� � ���������.

	SELECT FNAME FROM CUSTOMERS
	INTERSECT
	SELECT FNAME FROM EMPLOYEES
 
----------------------------------EXCEPT---------------------------------------------------
/*����� ��������, ������� �� ������� ������, ����� �� �� ������ ������� ������ �� �������.
�������:
    -����� �� �������� ��� ����� ������ ������ �� ���� �������;
    -�������� ������ �� ����� �� ���������� ������ �� �����. */
 
--������ 4-8.
--  ������ id �� ���������, � ����� ��� ������� � � ������ ����� ���� ������ �� �������.
 
	SELECT COUNTRY_ID FROM CUSTOMERS
	EXCEPT
	SELECT COUNTRY_ID FROM DEPARTMENTS

	SELECT DISTINCT COUNTRY_ID FROM CUSTOMERS
	WHERE COUNTRY_ID NOT IN(SELECT COUNTRY_ID FROM DEPARTMENTS)

	SELECT DISTINCT COUNTRY_ID FROM CUSTOMERS
	WHERE COUNTRY_ID <> ALL(SELECT COUNTRY_ID FROM DEPARTMENTS)
 
	SELECT DISTINCT COUNTRY_ID FROM CUSTOMERS
	WHERE NOT EXISTS(SELECT * FROM DEPARTMENTS WHERE DEPARTMENTS.DEPARTMENT_ID = CUSTOMERS.COUNTRY_ID)

/*4.5.1. ������
������ 4-7. 
    �� �� ������� ��������� ����� �� �������, ����� �� �� ������ ���� ���� �� ���������.*/
 
	SELECT TRIM (FNAME) FROM CUSTOMERS --WHERE FNAME LIKE '%������%'
	EXCEPT
	SELECT TRIM (FNAME) FROM EMPLOYEES --WHERE FNAME LIKE '%������%'
	
 
-------------------------------------------------------------------------------------------
------------------------------------ JOIN -------------------------------------------------
--JOIN �� �������� �� ��������� �� ����� �� ��� ��� ������ �������, ���� �������� �� ��
--���������� ���� ��������� ������ ����� ���������, ����� ���� �� ���� ��� FROM ��� WHERE.
--���������� ���� ������ � ��������/������ ����, �� �� ������������.
 
 
 
-------------------------------------INNER JOIN ��� ������ JOIN-----------------------------
--�������� �������� �� ���/������ �������, ����� ���� ��������� ��������� � ��������,
--�������� � ��������� �� ���������.
 
--������ 4-10. 
--  �� �� ������� ��������� � ���������, � ����� �� �������.

	SELECT * FROM COUNTRIES  --29
	SELECT * FROM REGIONS    --6
	SELECT * FROM COUNTRIES JOIN REGIONS ON COUNTRIES.REGION_ID = REGIONS.REGION_ID

	--1 INNER JOIN
	--2 OUTER JOIN
	  --2.1 RIGHT
	  --2.2 LEFT
	  --2.3 FULL
	--3 CROSS JOIN
	
--������ 4-11.
--  ������ ����� �� �������, ����� �� ��������� �� ����� ��, � ����� �� ��������� �� ���������.
 
	SELECT CUSTOMERS.FNAME + '' + CUSTOMERS.LNAME AS ������,
	COUNTRIES.NAME AS [��� �� �������],
	REGIONS.NAME AS [��� �� ������]
	FROM CUSTOMERS JOIN COUNTRIES ON CUSTOMERS.COUNTRY_ID = COUNTRIES.COUNTRY_ID
				   JOIN REGIONS ON COUNTRIES.REGION_ID = REGIONS.REGION_ID


--------------------------------Homework----------------------------------------------------
--������ ���������������� �� ������ ��������, ����� �� �� ��������� �� ���� 2 ������
--P.S. ��� �� ��������� OUTER JOIN

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
-------------------------------������ OUTER JOIN-----------------------------------------
-----------------------------------------------------------------------------------------
 
--������ 4-12. 
--  �� �� ������� ��������� � ���������, ����� �� ������� � ���. ������������
--  ����� �� ������� � ���������, � ����� ���� �������� �������.

	SELECT * FROM REGIONS
	SELECT * FROM COUNTRIES
 
	SELECT * FROM REGIONS R LEFT JOIN COUNTRIES C
	ON C.REGION_ID = R.REGION_ID

	SELECT * FROM COUNTRIES C RIGHT JOIN REGIONS R
	ON C.REGION_ID = R.REGION_ID
 
--������ 4-13. 
--  �� �� ������� ��������� � ���������, � ����� �� �������. 
--  ����������� ����� �� ������� ���������, �� ����� ���� ������� ������.
 
	SELECT * FROM REGIONS
	SELECT * FROM COUNTRIES
 
	SELECT * FROM REGIONS R RIGHT JOIN COUNTRIES C
	ON C.REGION_ID = R.REGION_ID

	SELECT * FROM COUNTRIES C LEFT JOIN REGIONS R
	ON C.REGION_ID = R.REGION_ID

 
/*������ 4-14.
    �� �� ������� ��������� � ���������, � ����� �� �������. 
    ����������� ����� �� ������� ���������, �� ����� ���� ������� ������ � ���������, 
    �� ����� ���� �������� �������.*/

	SELECT * FROM COUNTRIES C FULL JOIN REGIONS R
	ON R.REGION_ID = C.REGION_ID
 
 	SELECT FNAME, LNAME 
	FROM CUSTOMERS C JOIN ORDER_ITEMS O
	ON C.CUSTOMER_ID = O.QUANTITY
	ORDER BY QUANTITY ASC
 
-----------------------------------------------------------------------------------------
/*----------------------------4.6.6. ����� JOIN ��������---------------------------------
-----------------------------------------------------------------------------------------
 
������ 4-15. 
    �� �� ������� ��������� � ���������, � ����� �� �������.*/

	SELECT * FROM REGIONS R JOIN COUNTRIES C
	ON C.REGION_ID = R.REGION_ID
 
/*������ 4-16.
    �� �� ������� ��������, � ����� ��� ��������� ���������.*/
 
	SELECT NAME FROM DEPARTMENTS
	WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM EMPLOYEES)
 
--������ 4-17.
--  �� �� ������� ������� �� ���������, ����� ��� ��� �� �� ������� �������.
 
	SELECT FNAME, LNAME FROM CUSTOMERS C
	WHERE NOT EXISTS (SELECT * FROM ORDERS O WHERE O.CUSTOMER_ID = C.CUSTOMER_ID)

--������ 4-18. 
--  �� �� ������� ������������ �� ������ ������� � �������, ��������� �� ��� �� �������.
 
	SELECT * FROM REGIONS CROSS JOIN COUNTRIES
	SELECT * FROM REGIONS, COUNTRIES
 
--4.6.7. ������ 
 
--������ 4-8. 
--  ������� ��������������, ���� �� ��������� � ����� �� ���������, ����� �� �� ����������.
 
	SELECT O.ORDER_ID, O.ORDER_DATE, CONCAT (E.FNAME, ' ', E.LNAME) AS �������� 
	FROM EMPLOYEES E JOIN  ORDERS O 
	ON E.EMPLOYEE_ID = O.EMPLOYEE_ID

--������ 4-9. --HW
--  �� �� ������� ������� �� ������ ������� � id �� ��������� ��. 
--  � ����������� ����� �� �������� � ���������, ����� ��� ��� �� �� ������� �������.
 
	SELECT FNAME, LNAME, ORDER_ID 
	FROM CUSTOMERS C LEFT JOIN ORDERS O
	ON C.CUSTOMER_ID = O.CUSTOMER_ID


--������ 4-11. --HW
--  �� �� ������� ������� �� ������ �������, ����� �� �� ������� � ������ �������� �������

	SELECT FNAME, LNAME
	FROM CUSTOMERS CU 
	JOIN COUNTRIES CO
	ON CU.COUNTRY_ID = CO.COUNTRY_ID 
	JOIN REGIONS R
	ON CO.REGION_ID = R.REGION_ID
	WHERE R.REGION_ID = '5'

-----------------------------------------------------------------------------------------
---------------------------------4.7.1. TOP ---------------------------------------------
--  TOP ����� ������� N ���� � ����������� ���, �� �������� �������� ���������� ORDER BY!
-----------------------------------------------------------------------------------------
 
-- ������ 4-19. 
-- 7-�� �������� � ���-����� ����.

	SELECT TOP 7 * FROM PRODUCTS
	ORDER BY PRICE
 
--������ �� �������: --HW
-- �����, ������� � ���������� �� �����������, ����� ������� � ����� 80 � �� �� ����������� ������� �� �������;

	SELECT COUNT (O.ORDER_ID) AS [ORDERS], E.FNAME, E.LNAME, E.SALARY, E.DEPARTMENT_ID
	FROM EMPLOYEES E
	LEFT JOIN ORDERS O
	ON E.EMPLOYEE_ID = O.EMPLOYEE_ID
	GROUP BY E.FNAME, E.LNAME, E.SALARY, E.DEPARTMENT_ID
	ORDER BY 1



--  ������ 1. 
-- �������������� �� ����������� � ��������� ������� > 5000.  
-- �������� ����������� ����� �� ���. ������� ���������.

	SELECT JOB_TITLE, MIN_SALARY
	FROM JOBS
	WHERE (MIN_SALARY > 5000)
	ORDER BY MIN_SALARY DESC
 
--  ������ 2. 
-- ������� �� ���������, ����� � ����� ������� ��� � ���.
 
	SELECT R.NAME, COUNT (COUNTRY_ID) FROM REGIONS R JOIN COUNTRIES C
	ON C.REGION_ID = R.REGION_ID
	GROUP BY R.NAME

--  ������ 3. 
-- ������� ������� � ���� �������, ����� �� ��������� �����������, ���� ������������ 
-- ����� �� ������� ������ ��������� � ����,����� ��� ��� �� �� ����������� �������. 
-- �������� �� ���� �� ��������� ��� �������� ���.
 
	SELECT FNAME, LNAME, COUNT (ORDER_ID) AS [ORDER_COUNT] FROM EMPLOYEES E LEFT JOIN ORDERS O
	ON E.EMPLOYEE_ID = O.EMPLOYEE_ID
	GROUP BY E.FNAME, E.LNAME
	ORDER BY 3 
 
 
-----------------------------------------------------------------------------------------
--------------------------------- ������:  ----------------------------------------------
-----------------------------------------------------------------------------------------
 
    --��� 0.4
    --���������, ����� �� ��������� ���� 2000 ������

	SELECT C.FNAME, C.LNAME, O.ORDER_ID, YEAR(ORDER_DATE) AS [YEAR]
	FROM CUSTOMERS C JOIN ORDERS O
	ON C.CUSTOMER_ID = O.CUSTOMER_ID
	WHERE YEAR(ORDER_DATE) = 2000 
 
    --��� 0.5
    --�����������, ����� �� ���������� ������ �� 5 �������
 
	SELECT E.FNAME, E.LNAME, E.EMPLOYEE_ID, COUNT(O.ORDER_ID) AS [ORDERS]
	FROM EMPLOYEES E JOIN ORDERS O
	ON E.EMPLOYEE_ID = O.EMPLOYEE_ID
	GROUP BY E.FNAME, E.LNAME, E.EMPLOYEE_ID
	HAVING COUNT(O.ORDER_ID) > 5
	
 
-----------------------------------------------------------------------------------------
---------------------------------4.7.2. OFFSET � FETCH ----------------------------------
-----------------------------------------------------------------------------------------
 
    /* ������ 4-21. 
   �������� ���������, ���������� �� 10-�� ���, ��������� �� ���� �� ����������. 
   ������� ������ �� ������ ������ �� ������������, ������� �� ������� �������.
    */

	SELECT * 
	FROM EMPLOYEES
	ORDER BY HIRE_DATE
	OFFSET 9 ROWS
	FETCH NEXT 5 ROWS ONLY


 
 
    /* 4.7.3. ������ 
   ������ 4-12. 
   ������� 10 ���-����� ������� ��������� (��������� �� ������� ���������).
    */

	SELECT * 
	FROM EMPLOYEES
	ORDER BY SALARY DESC
	OFFSET 10 ROWS
	FETCH NEXT 10 ROWS ONLY
	

 
    /* ������ 4-13. --HW
   �� �� ������� ���, ������� � ��� �� ���������, ��������� ���������� 5 �������.
    */

	SELECT FNAME, LNAME, GENDER
	FROM CUSTOMERS C JOIN ORDERS O
	ON C.CUSTOMER_ID = O.CUSTOMER_ID
	ORDER BY ORDER_DATE DESC
	OFFSET 0 ROWS
	FETCH NEXT 5 ROWS ONLY

----------------------------------------------------------------------------------------
-----------------------------������� = Views--------------------------------------------
-----------------------------��������� �� �������---------------------------------------
 
    --������ 5-1. 
    --�� �� ������� ������, ����� ������� ��� � ������� �� ���������, ����� �
    --����� � ���� �� ���������, ����� �� �� ���������.

	CREATE VIEW MY_FIRST_VIEW 
	AS
	SELECT C.FNAME, + ' ' + C.LNAME AS �������,
		O.ORDER_ID, 
		O.ORDER_DATE
	FROM CUSTOMERS C JOIN ORDERS O 
	ON C.CUSTOMER_ID = O.CUSTOMER_ID

	SELECT * FROM MY_FIRST_VIEW
 
-----------------------------������� �� �������-----------------------------------------
    --������ 5-2. 
    --�� �� ���������� ������� ������ ����, �� �� ������� � ������ � ����� ��
    --���������� ��������, ��������� ���������.

	ALTER VIEW MY_FIRST_VIEW 
	AS
	SELECT C.FNAME, + ' ' + C.LNAME AS �������,
		E.FNAME, + ' ' + E.LNAME AS ���������,
		O.ORDER_DATE,
		O.ORDER_DATE
	FROM CUSTOMERS C 
	JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID
	JOIN EMPLOYEES E ON E.EMPLOYEE_ID = O.EMPLOYEE_ID

	SELECT * FROM MY_FIRST_VIEW
 
    --������ 5-3
    -- �� �� ���������� ������ ������ ����, �� �� ������� ���� ���������,
    --���������� �� �������� � ������������� = 167.

	ALTER VIEW MY_FIRST_VIEW 
	AS
	SELECT C.FNAME, + ' ' + C.LNAME AS �������,
		E.FNAME, + ' ' + E.LNAME AS ���������,
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
 
    --��� 0.6
    --�� �� ������� ������, �������� ���������� �� �����������, 
    --����� �� � ��������� � �� ����� �������� ����.
        
		ALTER VIEW BOSS_EMPLOYEES_COUNT
		AS
		SELECT E1.EMPLOYEE_ID, E1.FNAME, E1.LNAME, COUNT(E2.MANAGER_ID) ��������� 
		FROM EMPLOYEES E1 JOIN EMPLOYEES E2
		ON E1.EMPLOYEE_ID = E2.MANAGER_ID
		GROUP BY E1.EMPLOYEE_ID, E1.FNAME, E1.LNAME
		ORDER BY 4 DESC


    --��� 0.7
    --�� �� ������� ������, �������� ���������� �� ��������, � ����� �� ������� 
    --������� ���������.

	CREATE VIEW DEPT_WITHOUT_EMPLOYEES
	AS
	SELECT D.* 
	FROM DEPARTMENTS D LEFT JOIN EMPLOYEES E
	ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
	WHERE E.DEPARTMENT_ID IS NULL


	 --������ 5-4. 
    --�� �� ������� ������, �������� ��� � ������� �� �������� � ������ ���� ��
    --���������, ����� ��� � ���������.

	CREATE VIEW EMPLOYEE_TOTAL
	AS
	SELECT E.FNAME, E.LNAME, SUM(UNIT_PRICE * QUANTITY) TOTAL 
	FROM EMPLOYEES E 
	JOIN ORDERS O
	ON E.EMPLOYEE_ID = O.EMPLOYEE_ID
	JOIN ORDER_ITEMS OI
	ON OI.ORDER_ID = O.ORDER_ID
	GROUP BY E.FNAME, E.LNAME, E.EMPLOYEE_ID

 
    --������ 5-5. 
    --�� �� ������� ������, ����� ������� �����, ����� � ������� �� 5-����
    --��������� � ���-������ �������. 
 
	SELECT TOP 5 FNAME, LNAME, DEPARTMENT_ID, SALARY
	FROM EMPLOYEES
	ORDER BY SALARY DESC 


    --------------------------------------------------------------------------
    ------------------5.4.������������ �� ����� ���� ������ ------------------
    --------------------------------------------------------------------------
    --������ 5-6.1
    --������ ������ ������� �� JOIN ����� ��������� COUNTRIES � CUSTOMERS

	CREATE VIEW COUNTRIES_CUSTOMER
	AS
	SELECT CO.COUNTRY_ID AS COUNTRY_COUNTRY_ID, CO.NAME, CO.REGION_ID,
		   CU.CUSTOMER_ID, CU.FNAME, CU.LNAME, CU.GENDER, 
		   CU.COUNTRY_ID AS CUSTOMERS_COUNTRY_ID, CU.EMAIL
	FROM CUSTOMERS CU JOIN COUNTRIES CO
	ON CU.COUNTRY_ID = CO.COUNTRY_ID
	
	SELECT * FROM COUNTRIES_CUSTOMER
 
 
    -----------------5.4.1. �������� �� ����� ���� ������---------------------
 
    --������ 5-6.2 
    --�� �� ������ ��� ����� � ��������� CUSTOMERS ���� ������� �� ��. 5-6.1.
 
	INSERT INTO COUNTRIES_CUSTOMER(CUSTOMER_ID, FNAME, LNAME, GENDER, CUSTOMERS_COUNTRY_ID, EMAIL)
	VALUES (10, '����', '��������', 'F', 'BG', 'miramira@gmail.com')

	SELECT * FROM COUNTRIES_CUSTOMER
	WHERE CUSTOMER_ID = 10
 
 
    -------------------5.4.2. ��������� �� ����� ���� ������------------------
    
    ---������ 5-7.
    -- �� �� ������� ��������� �� ������ � ������������� 10.
 
	UPDATE COUNTRIES_CUSTOMER
	SET LNAME = '������'
	WHERE CUSTOMER_ID = 10
 
 
    -----------------5.4.3. ��������� �� ����� ���� ������ -------------------    
    --������ 5-8. 
    --�� �� ������ ������ � ������������� 10.
 
	DELETE FROM COUNTRIES_CUSTOMER
	WHERE CUSTOMER_ID = 10
	
 
    ----------------5.5.������------------------------------------------------
    
 
    --������ 5-1. 
    --�� �� ������� ������, ����� ������� ������� �� ���������� � ���� ��������
    --���������� �� �������.

	CREATE VIEW PRODUCTS_QUANTITY
	AS
	SELECT P.NAME, COUNT(QUANTITY) AS [����������]
	FROM PRODUCTS P JOIN ORDER_ITEMS OI
	ON P.PRODUCT_ID = OI.PRODUCT_ID
	GROUP BY P.NAME, P.PRODUCT_ID
	ORDER BY 2 DESC
	OFFSET 0 ROWS

	SELECT * FROM PRODUCTS_QUANTITY
 
	-------------------------------------------------------------------------------------
	-------------------------------   HOMEWORK   ----------------------------------------
	-------------------------------------------------------------------------------------
 
    --������ 5-2. 
    --�� �� ������� ������, ����� ������� ���������� ������� � ���-����� ����
    --�������. ��� ���������� ������ ��� ����� ���� ������� � ����� �������, 
    --�� ���� �� �������� � �������.

	CREATE VIEW CUSTOMER_QUANTITY
	AS
	SELECT TOP 10 WITH TIES C.FNAME, C.LNAME, COUNT(ORDER_ID) AS [���� �������]
	FROM CUSTOMERS C JOIN ORDERS O
	ON C.CUSTOMER_ID = O.CUSTOMER_ID
	GROUP BY C.FNAME, C.LNAME
	ORDER BY 3 DESC

	SELECT * FROM CUSTOMER_QUANTITY

	--������ 0.4*
	--�� �� ������� ������ � ������� �� ��������� � ������ �� 5 ������� �� ���.

	CREATE VIEW CUSTOMERS_COUNT
	AS
	SELECT CO.NAME, COUNT(CU.COUNTRY_ID) AS �������
	FROM COUNTRIES CO JOIN CUSTOMERS CU
	ON CO.COUNTRY_ID = CU.COUNTRY_ID
	GROUP BY CO.NAME
	HAVING COUNT(CU.COUNTRY_ID) > 5

	SELECT * FROM CUSTOMERS_COUNT



	 --------------------------------------------------------------------------------
    -------------------------------- ���������� ------------------------------------
    --------------------------------------------------------------------------------
    --6.4.�������
 
    --������ 6-1. 
    --�� �� ������� ����������,

	BEGIN TRAN TRAN1

	--1. ����� ������ ��� ������

	INSERT INTO CUSTOMERS(CUSTOMER_ID, COUNTRY_ID, FNAME, LNAME, ADDRESS, EMAIL, GENDER)
	VALUES(1001, 'BG', '�����', '������', '��. �������, ���. �. �������', 'mmi@gmail.com', 'F')
	IF @@ERROR <>0 ROLLBACK

	--2. � ������� ������� �� ����, 

	INSERT INTO ORDERS(CUSTOMER_ID, ORDER_ID, ORDER_DATE, EMPLOYEE_ID, SHIP_ADDRESS)
	VALUES(1001, 1, GETDATE(), 112, '��. �������, ���. ������' )
	IF @@ERROR <>0 ROLLBACK

    --3. 4. ��������� ��� ��������.

	INSERT INTO ORDER_ITEMS(ORDER_ID, PRODUCT_ID, QUANTITY, UNIT_PRICE)
	VALUES(1, 1773, 2, 108)
	IF @@ERROR <>0 ROLLBACK

	INSERT INTO ORDER_ITEMS(ORDER_ID, PRODUCT_ID, QUANTITY, UNIT_PRICE)
	VALUES(1, 1737, 5, 200)
	IF @@ERROR <>0 ROLLBACK

	COMMIT TRAN TRAN1



	BEGIN TRAN TRAN1
	SET XACT_ABORT ON

	--1. ����� ������ ��� ������

	INSERT INTO CUSTOMERS(CUSTOMER_ID, COUNTRY_ID, FNAME, LNAME, ADDRESS, EMAIL, GENDER)
	VALUES(1002, 'BG', '�����', '������', '��. �������, ���. �. �������', 'mmi@gmail.com', 'F')

	--2. � ������� ������� �� ����, 

	INSERT INTO ORDERS(CUSTOMER_ID, ORDER_ID, ORDER_DATE, EMPLOYEE_ID, SHIP_ADDRESS)
	VALUES(1001, 1, GETDATE(), 112, '��. �������, ���. ������')

    --3. 4. ��������� ��� ��������.

	INSERT INTO ORDER_ITEMS(ORDER_ID, PRODUCT_ID, QUANTITY, UNIT_PRICE)
	VALUES(1, 1773, 2, 108)

	INSERT INTO ORDER_ITEMS(ORDER_ID, PRODUCT_ID, QUANTITY, UNIT_PRICE)
	VALUES(1, 1737, 5, 200)

	COMMIT TRAN TRAN1
 
    /*������ 6-2. 
    ����������, ����� ������� ��������� �� ������ � ������������� = 1001, 
    ���� ����� �������� ����������� �������.*/

	BEGIN TRAN TRAN2

	-- OPER1
	SELECT C.LNAME FROM CUSTOMERS C
	WHERE C.CUSTOMER_ID = 1001

	-- OPER2
	UPDATE CUSTOMERS
	SET LNAME = '���������'
	WHERE CUSTOMER_ID = 1001

	-- OPER3
	SELECT C.LNAME FROM CUSTOMERS C
	WHERE C.CUSTOMER_ID = 1001

	ROLLBACK TRAN TRAN2

	-- OPER4
	SELECT C.LNAME FROM CUSTOMERS C
	WHERE C.CUSTOMER_ID = 1001

 
    /*������ 6-3.
    ����������, ����� ������� ��� ������, ������� ����� �� �����,
    ������� �������, ���� ����� �������� ��������� �� ������� �� �����, �.�.
    �������� �� ���� ���������.*/

	BEGIN TRAN TRAN3

	INSERT INTO CUSTOMERS(CUSTOMER_ID, COUNTRY_ID, FNAME, LNAME, ADDRESS, EMAIL, GENDER)
	VALUES(1003, 'BG', '������', '�����', '��. �������, ���. �. �������', 'mmii@gmail.com', 'M')

	SAVE TRAN POINT1
		
	INSERT INTO ORDERS(CUSTOMER_ID, ORDER_ID, ORDER_DATE, EMPLOYEE_ID, SHIP_ADDRESS)
	VALUES(1003, 2, GETDATE(), 112, '��. �������, ���. ������')

	ROLLBACK TRAN POINT1
	COMMIT TRAN TRAN3

 
    /*������ 6-1. 
    ����������, ����� ��� �� ��� �� ������ ����� ����������� 90,
    ���� ����� ���� ��������� ������ ��������� �� ���� � ����� ��������������� 10.*/

	BEGIN TRAN TRAN4 

	UPDATE EMPLOYEES 
	SET DEPARTMENT_ID = 10
	WHERE DEPARTMENT_ID = 90

	DELETE FROM DEPARTMENTS
	WHERE DEPARTMENT_ID = 90

	COMMIT TRAN TRAN4

    -------------------------------------------------------------------------------------
    ---------------------------------- ��������� ----------------------------------------
    -------------------------------------------------------------------------------------
 
    --������ 7-2. 
    --�� �� ������� ���������, ����� �� �������� ���� ������ ��������� ������������� �� 
    --������� ������� ����� �� ��������, ����� � � ���������, ����� � ������ � ��������.


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
    ---------------------------------- ������� ------------------------------------------
    -----1.--�������� -------------------------------------------------------------------
 
    --������ 7-4. 
    --�� �� ������� �������, ������� ���� �������� �������� �����, �������� ����� �� 
    --����� (������� ���� ���������) � ���� �������� �� ��������� � ����.
 
    -----2.-- �������, ������� ���������� �����------------------------------------------
 
    --������ 7-5.
    --�� �� ������� �������, ������� ���� �������� ����������� � ������� ���������.
	
	CREATE FUNCTION EMPLO_JOBS() RETURNS TABLE
	AS
	RETURN
	SELECT FNAME, LNAME, JOB_TITLE 
	FROM EMPLOYEES E JOIN JOBS J
	ON E.JOB_ID = J.JOB_ID
	ORDER BY FNAME

	SELECT * FROM DBO.EMPLO_JOBS()

 
    -------------------------------------------------------------------------------------
    ----------------------------------- ������� -----------------------------------------
    -------------------------------------------------------------------------------------
 
    /*������ 8-1.
    �� �� ������� ������, ����� ����������� ��������� �� ����� ��� �� ��� �� 
    ������. ������������ ����� �� ����� �� ������� ������ ������� �� ��������. 
    �������� �� �������� ����� �� ���������� � ���������.*/
 
    -------------------------------------------------------------------------------------
    ----------------------------- ������� -----------------------------------------------
    -------------------------------------------------------------------------------------
    /*������ 9-1. 
    �� �� ������� ������, ����� ��� ����� ������� �� ������� �� ������
    ������� ��� � ���� ������� CUSTOMERS_HIST � ��������:
    � ������������� �� ������;
    � ����� �������;
    � ���� �������.*/




 
    --������ 0.5* --HW
    --�� �� ������� ����������, ����� ������� ��������� �� �������� � 
    --������������� 103 �� '������', ������� ��������� �� �������� � 
    --������������� 114 �� '�������', ����� � ��������� �� �������� � 
    --������������� 118 �� '��������'. 
    --���� ���� ���� ������� � �������� ��e � ������� ���� �� �������������� 
    --��������� ���������. ���� ��������� �� ������������ ������� ���������.
 

 	BEGIN TRAN TRAN4

	UPDATE EMPLOYEES
	SET LNAME = '������'
	WHERE EMPLOYEE_ID = 103

	UPDATE EMPLOYEES
	SET LNAME = '�������'
	WHERE EMPLOYEE_ID = 114

	UPDATE EMPLOYEES
	SET LNAME = '��������'
	WHERE EMPLOYEE_ID = 118

	COMMIT TRAN TRAN4

	SELECT E.FNAME, E.LNAME FROM EMPLOYEES E
	WHERE E.EMPLOYEE_ID IN (103, 114, 118)


	 /*������ 6-2. --HW
    ����������, ����� ������� ������� 1726 - ����� �� ������� �� ������ ������� 
    ����� �� ��������� � ��������, � ������ �������� ����������� �������.*/

 	BEGIN TRAN TRAN5

	DELETE FROM ORDERS
	WHERE ORDER_ID = 1726

	DELETE FROM PRODUCTS
	WHERE PRODUCT_ID = 1726

	ROLLBACK TRAN TRAN5




































	-------------------  ������ �� ���������� � �������������� --------------------------
        --��� 1.
        --������ ���������, ����� �� �������� ���� ������ ��������� �� ����� ��� ��� �������� ���.

		SELECT C.FNAME, C.LNAME, COUNT(O.ORDER_ID) AS [ORDERS]
		FROM CUSTOMERS C JOIN ORDERS O
		ON C.CUSTOMER_ID = O.CUSTOMER_ID
		GROUP BY C.FNAME, C.LNAME 
		HAVING COUNT(O.ORDER_ID) = 1
		ORDER BY 2
 
        --��� 2.
        --������ ����������� ������� �� �����������, � ����� ��� ��������� ������ �� 10 ���������.

		SELECT J.JOB_TITLE ,J.MIN_SALARY, COUNT(E.EMPLOYEE_ID) AS [EMPLOYEES]
		FROM JOBS J JOIN EMPLOYEES E
		ON J.JOB_ID = E.JOB_ID
		GROUP BY J.JOB_TITLE ,J.MIN_SALARY 
		HAVING COUNT(E.EMPLOYEE_ID) > 10
		
        --��� 3.
        --������ �����������, �� ����� ���� ��������� ���������.

		SELECT J.JOB_ID, J.JOB_TITLE, COUNT (E.JOB_ID) AS [FREE_EMPLOYEES]
		FROM EMPLOYEES E RIGHT JOIN JOBS J
		ON E.JOB_ID = J.JOB_ID
		GROUP BY J.JOB_ID, J.JOB_TITLE
		HAVING COUNT (E.JOB_ID) = 0

        --��� 4.
        --� ��� ���� �� ������ ������, ����� ��������� ��������� ���-������ ������ �������.

		SELECT TOP 1 D.CITY, E.DEPARTMENT_ID, AVG(E.SALARY) AS [AVERAGE_SALARY]
		FROM DEPARTMENTS D JOIN EMPLOYEES E
		ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
		GROUP BY D.CITY, E.DEPARTMENT_ID
		ORDER BY 3 DESC
		


  -----------------------------------------------------------------------------------------
  ----------------------------------�������� 3---------------------------------------------
  -----------------------------------------------------------------------------------------
 
    --������ 3.1
    --������ ������ � ���, �������, ������� � ������������ �� �������� �� �����������, 
    --����� ������� � ����� 100.

	CREATE VIEW EMPLOYEES_DEPART_100
	AS
	SELECT FNAME, LNAME, PHONE, J.JOB_ID
	FROM EMPLOYEES E JOIN JOBS J
	ON E.JOB_ID = J.JOB_ID
	WHERE DEPARTMENT_ID = 100
 
	SELECT * FROM EMPLOYEES_DEPART_100
 
    --������ 3.2
    --����������� ������ ������ ���� ������������ � ���� ������ ��� � ������� �� ��������,
    --� ������� ������ ������� �� ��������� � ������������� �� ��������� ��.

	ALTER VIEW EMPLOYEES_DEPART_100
	AS
	SELECT FNAME + ' ' + LNAME AS �����, 
		   PHONE, 
		   JOB_ID, 
		   SALARY, 
		   MANAGER_ID
	FROM EMPLOYEES
	WHERE DEPARTMENT_ID = 100

	SELECT * FROM EMPLOYEES_DEPART_100
 
    --������ 3.3
    --������ ������ ����� ������� �� ������ 3.2 ���� � ����������� ����� ������� ����
    --��������: ����� �� ��������� � ������������� �� ��������� ��.

	CREATE VIEW EMP_DEPARTMENT
	AS
	SELECT �����, MANAGER_ID
	FROM EMPLOYEES_DEPART_100
 
	SELECT * FROM EMP_DEPARTMENT
 
    --������ 3.4
    --������ ������ � ������� �� ��������� � ���� �� ��������� � ���.

	CREATE VIEW COUNTRIES_COUNT
	AS
	SELECT R.NAME, 
		   COUNT(C.REGION_ID) AS [���� �������]
	FROM REGIONS R JOIN COUNTRIES C
	ON R.REGION_ID = C.REGION_ID
	GROUP BY R.NAME

	SELECT * FROM COUNTRIES_COUNT



	-- �������� ��������� �� ��

	-- 1. ��������� �� �������� �� �������. 

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


	-- 2. �������� �� ������� PRICE �� ��� decimal(5,2) �� ���� � ������� PIZZA_ORDERS � ����������� �� 
	-- ����������� ���� ����������� �����.

	ALTER TABLE PIZZA_ORDERS
	ADD PRICE DECIMAL(5,2) NOT NULL
	CHECK (PRICE > 0)

	-- 3. ������ ������� PHONE �� ������� CLIENTS.

	ALTER TABLE CLIENTS
	DROP COLUMN PHONE

	-- 4. �������� �� ���� ����� � ���������� ����� ��� ����� �������. (��� ������)

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


	-- 5. ������� ������������ �������� ���� �� 5 � ������� �� ����� �� 
	-- ������� ������� ������������� �� ����

	UPDATE PIZZA_ORDERS
	SET QUIANTITY = 5, SIZE = 'S'
	WHERE PIZZA_ID = 1

	-- 6. ���� �� �� �������� ���� � ���������� �������������, ����� ��� ��������� � �������� �.

	DELETE FROM PIZZA_ORDERS
	WHERE PIZZA_ID = 5

	DELETE FROM PIZZAS
	WHERE PIZZA_ID = 5

	-- 7. ������ �� ����� �� ��� ������� � ���� �� ��������� ������� �� ����� ����. 
	-- ������� �� �� ��� �� ������ � �������� ���.	SELECT C.NAME, PO.DATETIME, PO.SIZE	FROM CLIENTS C JOIN PIZZA_ORDERS PO	ON C.CLIENT_ID = PO.CLIENT_ID	WHERE PO.SIZE = 'S'	ORDER BY C.NAME DESC
	-- 8. ������ ��� ������, ��� �� ������� ������� �� ����.

	INSERT INTO CLIENTS (CLIENT_ID, NAME)
	VALUES(105, 'Nikolai')

	-- 9. ������ ������� �� ��������� � ����� ���� �� ��������� ����. 
	-- � ����������� ����� �� �� ������� � ��������� ��� �������.

	SELECT C.NAME, COUNT(PO.PIZZA_ID) AS ORDERED_PIZZAS	FROM CLIENTS C LEFT JOIN PIZZA_ORDERS PO	ON C.CLIENT_ID = PO.CLIENT_ID	GROUP BY C.NAME	-- 10. ������ ���� � ���� �� ��������� ����. ���� ��� �� ��������� � ������ �� ���� �������.
	SELECT P.PIZZA_TYPE, COUNT(PO.PIZZA_ID) AS PIZZA_COUNT	FROM PIZZAS P JOIN PIZZA_ORDERS PO	ON P.PIZZA_ID = PO.PIZZA_ID	GROUP BY P.PIZZA_TYPE, P.PIZZA_ID
	HAVING COUNT (PO.PIZZA_ID) > 1

	-- 11. ������ ������ �� ���� �� ������ � ��������� �� �������� � �������

	CREATE VIEW TOTAL_PIZZA
	AS
	SELECT P.PIZZA_TYPE, SUM(PO.QUIANTITY * PRICE) AS TOTAL	FROM PIZZAS P JOIN PIZZA_ORDERS PO	ON P.PIZZA_ID = PO.PIZZA_ID	GROUP BY P.PIZZA_TYPE, PO.PIZZA_ID

	SELECT * FROM TOTAL_PIZZA



	-- 1. ��������� �� �������� �� �������. 

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


	-- 2. �������� �� ������� QUANTITY �� ����������, �������� ����� �� ���������� ��� � �����������
    -- �� ���������� ��������� ���� ����������� ����� � PEOPLE_FLOWERS.

	ALTER TABLE PEOPLE_FLOWERS
	ADD QUANTITY INT NOT NULL
	CHECK (QUANTITY > 0)

	-- 3. �������� �� ���� ����� � ���������� ����� ��� ����� �������. (������)


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


	-- 4. ���� �� �� �������� ������� � ������ ������� ������������� - ������ ��.
	
	DELETE FROM PEOPLE_FLOWERS
	WHERE FLOWER_ID = 1

	DELETE FROM FLOWERS
	WHERE FLOWER_ID = 1

	-- 5. ��������� �� ���� �� ������� � ���������������� �� ���������� ��, ��������� �� ���� ��
	-- ������� � �������� ���.

	SELECT F.FLOWER_TYPE, PF.PERSON_ID 
	FROM FLOWERS F JOIN PEOPLE_FLOWERS PF
	ON F.FLOWER_ID = PF.FLOWER_ID	
	ORDER BY F.FLOWER_TYPE DESC

	-- 6. ��������� �� ���� �� ������� � ����� ���� � ��������� ������ �����. � ����������� �����
	-- �� �������� � �����, ����� ��� ��� �� �� ��������.

	SELECT F.FLOWER_TYPE, COUNT(PF.FLOWER_ID) AS FLOWER_SELLS	FROM FLOWERS F LEFT JOIN PEOPLE_FLOWERS PF	ON F.FLOWER_ID = PF.FLOWER_ID	GROUP BY F.FLOWER_TYPE, F.FLOWER_ID

	-- 7. ��������� �� ������, ����� ������� ���� �� ����������� ����� � ��������� �� ��������.
	-- ������ ���� ���� �����, ����� ������� �������� � ��� 10.

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
