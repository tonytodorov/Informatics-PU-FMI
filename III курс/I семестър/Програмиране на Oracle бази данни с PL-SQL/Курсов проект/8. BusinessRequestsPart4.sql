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

-- ADD BANK_TITLE COLUMN
alter table bank_account
add bank_title VARCHAR2(100);

-- 3
update bank_account
set bank_title = IBAN||currency
where bank_account_id in (1,2,3,4);