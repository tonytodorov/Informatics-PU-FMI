create table bank_account
( bank_account_id NUMBER PRIMARY KEY,
  IBAN VARCHAR2(22),
  amount_of_money NUMBER,
  currency VARCHAR2(3) DEFAULT 'BGN'
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
values (1,'BG64UNCR70004449361467', 10000, 'BGN');

insert into bank_account (bank_account_id, IBAN, amount_of_money, currency)
values (2,'BG85STSA93006356124641', 12000, 'USD');

insert into bank_account (bank_account_id, IBAN, amount_of_money, currency)
values (3,'BG79RZBB91555538816893', 18000, 'BGN');

insert into bank_account (bank_account_id, IBAN, amount_of_money, currency)
values (4,'BG40TTBB94005998736619', 0, 'EUR');

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
