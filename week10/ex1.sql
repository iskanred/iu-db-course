

---------------------------------------------- Page 1 ---------------------------------------------

drop table if exists accounts;
create table if not exists accounts(
    id serial primary key ,
    name text ,
    credit integer default 0,
    currency text default 'rub'
);

insert into accounts(name, credit) values
    ('account1', 1000),
    ('account2', 1000),
    ('account3', 1000);

-- Sends 'amount' of money from account with 'from_id'-id ato account with
--  'to_id'-id. If operation has succeed returns true, if the first account
--  has not enough money returns false.
create or replace function sendMoney(from_id integer, to_id integer, amount integer)
returns boolean as $$
declare
    from_money integer ;
begin

select credit into from_money
from accounts
where id = from_id;

if not from_money >= amount then
    return false ;
end if;

update accounts set credit = credit - amount
where id = from_id;

update accounts set credit = credit + amount
where id = to_id;

return true;

end; $$ language plpgsql ;


begin; -- transaction T1
    savepoint T1;
    select sendMoney(1, 3, 500) ;
    select credit from accounts;
    rollback to T1;
commit;
begin; -- transaction T2
    savepoint T2;
    select sendMoney(2, 1, 700) ;
    select credit from accounts;
    rollback to T2;
commit;
begin; -- transaction T3
    savepoint T3;
    select sendMoney(2, 3, 100) ;
    select credit from accounts;
    rollback to T3;
commit;

select credit from accounts;




---------------------------------------------- Page 2 ---------------------------------------------

alter table accounts add column if not exists bank_name text;
update accounts set bank_name = 'SberBank' where id in (1, 3);
update accounts set bank_name = 'Tinkoff'  where id = 2;
insert into accounts (id, name) values (4, 'account4'); -- add fee record

-- The same as previous but with taking into account fees
create or replace function sendMoneyWithFee(from_id integer, to_id integer, amount integer, fee_id integer)
    returns boolean as $$
declare
    from_money integer ;
    different_banks boolean ;
    fee integer default 0 ;
begin

-- Check if accounts have different banks
select b.bank1 != b.bank2 into different_banks
from (select a1.bank_name as bank1, a2.bank_name as bank2
      from accounts as a1, accounts as a2
      where a1.id = from_id and a2.id = to_id) as b;

-- Add fee to amount if accounts have different banks
if different_banks then
    select 30 into fee ;
end if;

select credit into from_money
from accounts
where id = from_id;

if not from_money >= amount + fee then
    return false ;
end if;

update accounts set credit = credit - amount - fee
where id = from_id;

update accounts set credit = credit + amount + fee
where id = to_id;

update accounts set credit = credit + fee
where id = fee_id ;

return true;

end; $$ language plpgsql ;


begin; -- transaction T1
    savepoint T1;
    select sendMoneyWithFee(1, 3, 500, 4) ;
    select sum(credit) from accounts;
    rollback to T1;
commit;
begin; -- transaction T2
    savepoint T2;
    select sendMoneyWithFee(2, 1, 700, 4) ;
    select sum(credit) from accounts;
    rollback to T2;
commit;
begin; -- transaction T3
    savepoint T3;
    select sendMoneyWithFee(2, 3, 100, 4) ;
    select sum(credit) from accounts;
    rollback to T3;
commit;

select sum(credit) from accounts;




---------------------------------------------- Page 3 ---------------------------------------------

drop table if exists ledger ;
create table if not exists ledger(
    transaction_id serial primary key ,
    from_id integer ,
    to_id integer ,
    fee integer ,
    amount integer ,
    transaction_date_time timestamp default now()
);

-- The same as previous but with saving transaction info to ledger table
create or replace function sendMoneyWithFeeAndLedger(from_id integer, to_id integer, amount integer, fee_id integer)
    returns boolean as $$
declare
    from_money integer ;
    different_banks boolean ;
    fee integer default 0 ;
begin

-- Check if accounts have different banks
select b.bank1 != b.bank2 into different_banks
from (select a1.bank_name as bank1, a2.bank_name as bank2
      from accounts as a1, accounts as a2
      where a1.id = from_id and a2.id = to_id) as b;

-- Add fee to amount if accounts have different banks
if different_banks then
    select 30 into fee ;
end if;

select credit into from_money
from accounts
where id = from_id;

if not from_money >= amount + fee then
    return false ;
end if;

update accounts set credit = credit - amount - fee
where id = from_id;

update accounts set credit = credit + amount + fee
where id = to_id;

update accounts set credit = credit + fee
where id = fee_id ;

insert into ledger (from_id, to_id, fee, amount) values
    (from_id, to_id, fee, amount) ;

return true;

end; $$ language plpgsql ;


begin; -- transaction T1
    savepoint T1;
    select sendMoneyWithFeeAndLedger(1, 3, 500, 4) ;
    select * from ledger ;
    rollback to T1;
    commit;
begin; -- transaction T2
    savepoint T2;
    select sendMoneyWithFeeAndLedger(2, 1, 700, 4) ;
    select * from ledger ;
    rollback to T2;
    commit;
begin; -- transaction T3
    savepoint T3;
    select sendMoneyWithFeeAndLedger(2, 3, 100, 4) ;
    select * from ledger ;
    rollback to T3;
    commit;

select * from ledger ;