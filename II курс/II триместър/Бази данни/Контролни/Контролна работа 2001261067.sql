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
	SELECT F.FLOWER_TYPE, SUM(PF.UNIT_PRICE * QUANTITY) AS TOTAL
	FROM FLOWERS F JOIN PEOPLE_FLOWERS PF
	ON F.FLOWER_ID = PF.FLOWER_ID
	WHERE PF.UNIT_PRICE * QUANTITY > 10
	GROUP BY F.FLOWER_TYPE, F.FLOWER_ID

	SELECT * FROM TOTAL_FLOWERS

